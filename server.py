"""Closet App"""

from jinja2 import StrictUndefined

from flask import Flask, render_template, request, flash, redirect, session
from flask_debugtoolbar import DebugToolbarExtension

from model import connect_to_db, db, Users, Articles, Category, Keyword, ClothingKeyword

import hashlib, pyowm


app = Flask(__name__)

# Required to use Flask sessions and the debug toolbar
app.secret_key = "mynameisangelahaha"

# Normally, if you use an undefined variable in Jinja2, it fails silently.
# This is horrible. Fix this so that, instead, it raises an error.
app.jinja_env.undefined = StrictUndefined


@app.route('/')
def index():
    """Homepage."""
    if session.get('username') is None:
        return render_template("homepage.html")
    else:
        return redirect('/users')


@app.route('/register', methods=['GET'])
def register_form():
    """Show form for user signup."""

    return render_template("register-form.html")


@app.route('/register', methods=['POST'])
def register_process():
    """Process registration."""

    # Get form variables
    username = request.form["username"]
    pword = request.form["password"]
    fname = request.form["fname"].title()
    lname = request.form["lname"].title()
    bday = request.form["bday"]
    zipcode = request.form["zipcode"]

    salt = "angela"
    hash = hashlib.md5( salt + pword ).hexdigest()

    new_user = Users(username=username, password=hash, fname=fname, 
                     lname=lname, bday=bday, zipcode=zipcode)

    db.session.add(new_user)
    db.session.commit()

    flash("User %s added." % username)
    return redirect("/login")


@app.route('/login', methods=['GET'])
def login_form():
    """Show login form."""

    return render_template("login-form.html")


@app.route('/login', methods=['POST'])
def login_process():
    """Process login."""

    # Get form variables
    username = request.form["username"]
    pword = request.form["password"]

    salt = "angela"
    hash = hashlib.md5( salt + pword ).hexdigest()

    user = Users.query.filter_by(username=username).first()

    if not user:
        flash("No such user")
        return redirect("/login")

    if user.password != hash:
        flash("Incorrect password")
        return redirect("/login")

    session["username"] = user.username

    flash("Logged in")
    return redirect("/users")


@app.route('/logout')
def logout():
    """Log out."""

    del session["username"]
    flash("Logged Out.")
    return redirect("/")


@app.route("/users")
def user_detail():
    """Show info about user."""
    #import pdb; pdb.set_trace()

    username = session['username']
    #print session
    user = Users.query.get(username)
    
    return render_template("user.html", user=user)


@app.route("/add-clothes")
def add_clothes_form():
    """Add clothes to database."""
    
    return render_template('add-clothes.html')


@app.route('/add-clothes', methods=['POST'])
def add_clothes():
    """Process registration."""

    # Get form variables
    category_id = request.form["category"]
    description = request.form["description"]
    url = request.form["url"]

    #import pdb; pdb.set_trace()

    #create new article of clothing in closets
    new_clothing = Articles(username=session['username'], category_id=category_id, description=description, url=url)

    #adds article of clothing to database
    db.session.add(new_clothing)
    db.session.commit()

    keywords = request.form.getlist("keyword")

    for keyword in keywords:
        new_association = ClothingKeyword(clothing_id=new_clothing.clothing_id, keyword_id=keyword)
    
        db.session.add(new_association)
    
    db.session.commit()

 
    return redirect("/users")


@app.route("/outfit")
def enter_outfit_details():
    """Generate a random outfit."""

    #enter zipcode for weather - if colder than 65, yes to jacket
    #choose an activity to do
    #group by keywords
    #choose a top and bottom
    #option of choosing shoes and accessories
    #javascript dependent menus

    #add suggestions for clothes on the web that you can buy

    return render_template("outfit_details.html")


@app.route("/outfit_generated", methods=['POST'])
def get_random_outfit():
    owm = pyowm.OWM('bad06f5e17057b9e7b8ad4bbee71b22e')

    zipcode = request.form["zipcode"]
    activity = request.form["activity"]

    observation = owm.weather_at_place(zipcode)
    weather = observation.get_weather()
    temp = weather.get_temperature('fahrenheit')

    return render_template("outfit.html", temp=temp['temp'])


@app.route("/closet")
def show_closet():
    """Show's user what items they have in their closet."""

    #sorts by category 
    #make list and iterate and append to dictionary
    #pass dictionary in

    # categories = 'tops bottoms dresses'.split() #make global list
    # clothes = {
    #     category: Articles.query.filter(Articles.category_id==category).all()
    #     for category in categories
    # }
    # return render_template("closet.html", **clothes)

    tops = Articles.query.filter(Articles.category_id=='tops').all()
    bottoms = Articles.query.filter(Articles.category_id=='bottoms').all()
    dresses = Articles.query.filter(Articles.category_id=='dresses').all()
    jackets = Articles.query.filter(Articles.category_id=='jackets').all()
    lounge = Articles.query.filter(Articles.category_id=='lounge').all()
    swim = Articles.query.filter(Articles.category_id=='swim').all()
    active = Articles.query.filter(Articles.category_id=='active').all()
    accessories = Articles.query.filter(Articles.category_id=='accessories').all()
    shoes = Articles.query.filter(Articles.category_id=='shoes').all()

    return render_template("closet.html", tops=tops, bottoms=bottoms, dresses=dresses,
                                          jackets=jackets, lounge=lounge, swim=swim,
                                          active=active, accessories=accessories, shoes=shoes)
    #have a view that sorts by keywords


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension
    app.debug = True

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")
