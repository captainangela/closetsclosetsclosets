"""Closet App"""

from jinja2 import StrictUndefined

from flask import Flask, render_template, request, flash, redirect, session, jsonify

from flask_debugtoolbar import DebugToolbarExtension

from sqlalchemy import exc

from model import connect_to_db, Users, Articles, Category, Keyword, ClothingKeyword, Favorites, History, db

import hashlib, random

# import pyowm


categories = 'tops bottoms dresses jackets accessories shoes'.split()
keywords = ['Urban Hike','Dinner','Brunch','Workout','Concert','Girls Night Out',
            'Hiking','Casual Date','Stay At Home','Beach','Picnic','Date Night','Pool', 'Work']

app = Flask(__name__)

# Required to use Flask sessions and the debug toolbar
app.secret_key = "mynameisangelahaha"

app.jinja_env.undefined = StrictUndefined

# def get_weather():
#     """Get weather."""
#     # owm = pyowm.OWM('bad06f5e17057b9e7b8ad4bbee71b22e')

#     user = Users.query.get(session["username"])
#     zipcode = user.zipcode

#     #get weather for zipcode entered -- should this be in an outside function?
#     observation = owm.weather_at_place(zipcode)
#     weather = observation.get_weather()
#     temp = weather.get_temperature('fahrenheit')
#     status = weather._status
    
#     return temp, status


def get_chart_data():
    """Get clothes data."""

    closet = {
        category: [Articles.query.filter(Articles.category_id==category, 
                                        Articles.username==session['username']).count(), {}]
        for category in categories}

    for category in closet:
        for keyword in keywords:
            clks = ClothingKeyword.query.filter(ClothingKeyword.keyword_id==keyword).all()
            clks = [clk.articles.category_id for clk in clks if clk.articles.category_id==category]
            closet[category][1][keyword] = len(clks)

    return closet


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
    try:
        db.session.add(new_user)
        db.session.commit()
    except exc.IntegrityError:
        db.session.rollback()
        flash("Sorry, that user name is taken. Please choose another.")
        return redirect("/register")
    else:

        return redirect("/")


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

    session['username'] = user.username
    # session["temp"] = get_weather()[0]["temp"]
    # session["status"] = get_weather()[1]

    return redirect("/users")


@app.route('/logout')
def logout():
    """Log out."""

    del session["username"]
    return redirect("/")


@app.route("/users")
def user_detail():
    """Show info about user."""
    #import pdb; pdb.set_trace()

    username = session['username']

    user = Users.query.get(username)

    return render_template("user.html", user=user)


@app.route("/add_clothes")
def add_clothes_form():
    """Add clothes to database."""
    
    return render_template('add-clothes.html')


@app.route('/add_clothes', methods=['POST'])
def add_clothes():
    """Process registration."""

    category_id = request.form["category"]
    description = request.form["description"]
    url = request.form["url"]

    #create new article of clothing in closets
    new_clothing = Articles(username=session['username'], category_id=category_id, 
                            description=description, url=url)

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

    activities = ["urban hike", "dinner", "brunch", "workout", "concert", "girls night out",
                  "hiking", "casual date", "stay at home", "beach", "picnic", "date night", "pool"] 

    select_string = "<select name='activity'><option value='' disabled selected>Choose one</option>" 
    for activity in activities:
        select_string = select_string + "<option value='%s'>%s</option><br>" % (activity, activity)
    select_string = select_string + "</select>"

    return render_template("outfit_details.html", select_string=select_string)


@app.route("/outfit_generated", methods=['POST'])
def get_random_outfit():
    # owm = pyowm.OWM('bad06f5e17057b9e7b8ad4bbee71b22e')

    zipcode = request.form["zipcode"]
    activity = request.form["activity"]

    #get weather for zipcode entered -- should this be in an outside function?
    observation = owm.weather_at_place(zipcode)
    # weather = observation.get_weather()
    # temp = weather.get_temperature('fahrenheit')
  
    clothing_dictionary = {}
    for category in categories:
        cat = db.session.query(Articles).join(ClothingKeyword).filter(ClothingKeyword.keyword_id==activity,
                                                                  Articles.category_id==category).all()
        if cat == []:
            clothing_dictionary[category] = None
        else:
            clothing_dictionary[category] = random.choice(cat).url
        
    #need to figure out how to separate dresses and tops

    return render_template("outfit.html", temp=temp['temp'], top=clothing_dictionary['tops'], bottom=clothing_dictionary['bottoms'], 
                           jacket=clothing_dictionary['jackets'], accessory=clothing_dictionary['accessories'],
                           shoe=clothing_dictionary['shoes'], activity=activity)


@app.route('/get_random_article/<activity>/<category>')
def get_another_random(activity, category):
    """Get's more random articles of clothing so user can scroll through outfit."""

    article = random.choice(db.session.query(Articles).join(ClothingKeyword).filter(ClothingKeyword.keyword_id==activity, 
                                                                      Articles.category_id==category).all())

    return article.url


@app.route("/closet")
def show_closet():
    """Show's user what items they have in their closet."""

    #want: sorts by keywords 

    #dictionary of categories and the articles of clothing associated with them
    closet = {
        category: Articles.query.filter(Articles.category_id==category, 
                                        Articles.username==session['username']).all()
        for category in categories
    }

    return render_template("closet.html", **closet)


@app.route("/get-chart-data.json")
def getting_chart_data():

    chart_data = get_chart_data()

    return jsonify(chart_data)


@app.route("/delete_clothes", methods=['POST'])
def delete_clothes():
    """"Deletes clothes from user's closet"""
    
    article_id = request.form["del_id"]
    print(article_id)

    delete_clothing_article = Articles.query.get(article_id)
    print(delete_clothing_article)
    delete_clothing_keywords = ClothingKeyword.query.filter(ClothingKeyword.clothing_id==article_id).all()

    print(delete_clothing_keywords)

    for item in delete_clothing_keywords:
        print(item)
        db.session.delete(item)

    db.session.delete(delete_clothing_article)
    print("deleted clothing")
    db.session.commit()

    return "success!"


@app.route("/add_favorites", methods=['POST'])
def get_favorite_outfits():
    """Allows users to favorite outfits."""

    #can't have repeats in favorites

    urls = request.get_json()
  
    top_url = urls['top']
    bottom_url = urls['bottom']
    activity = urls['activity']

    top_object = Articles.query.filter(Articles.url==top_url).one()
    bottom_object = Articles.query.filter(Articles.url==bottom_url).one()

    new_favorite = Favorites(keyword_id=activity, username=session['username'],
                             top_id=top_object.clothing_id, bottom_id=bottom_object.clothing_id)

    db.session.add(new_favorite)
    db.session.commit()

    return "success!"


@app.route("/favorites")
def show_favorites():
    """Show's user's favorited outfits"""
    favorite = {
        keyword: Favorites.query.filter(Favorites.keyword_id==keyword, 
                                        Favorites.username==session['username']).all()
        for keyword in keywords
    }

    # for k, v in favorite.iteritems():
    #     print(k, v)

    return render_template("favorites.html", keys=favorite.keys(), favorite=favorite)
    

@app.route("/add_history", methods=['POST'])
def get_past_outfits():
    """Show outfits that users chose to wear that day."""

    check = request.get_json()
  
    top_check = check['top']
    bottom_check = check['bottom']
    activity_check = check['activity']

    top_obj = Articles.query.filter(Articles.url==top_check).one()
    bottom_obj = Articles.query.filter(Articles.url==bottom_check).one()

    new_history = History(keyword_id=activity_check, username=session['username'],
                             top_id=top_obj.clothing_id, bottom_id=bottom_obj.clothing_id)

    db.session.add(new_history)
    db.session.commit()

    return "success!"


@app.route("/past_outfits")
def show_past_outfits():
    """Show user's past outfits on the calendar"""

    #make fake data for history of outfits so that prior dates have shit

    return render_template("past_outfits.html")


@app.route('/get_past_outfit/')
def get_past_outfit():

    date_worn = request.args.get('date')
    outfit = History.query.filter(History.date_worn==date_worn).first()

    print(date_worn)

    if outfit:
        return outfit.hist_bottom.url + " " + outfit.hist_top.url 
    else:
        return "no past outfit"


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension

    app.debug = True

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")


