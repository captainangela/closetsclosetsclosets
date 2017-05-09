"""dlkjflkajdf."""

from jinja2 import StrictUndefined

from flask import Flask, render_template, request, flash, redirect, session
from flask_debugtoolbar import DebugToolbarExtension

from model import connect_to_db, db, Users, ArticleOfClothing, Category, Keyword, ClothingKeyword


app = Flask(__name__)

# Required to use Flask sessions and the debug toolbar
app.secret_key = "mynameisangelahaha"

# Normally, if you use an undefined variable in Jinja2, it fails silently.
# This is horrible. Fix this so that, instead, it raises an error.
app.jinja_env.undefined = StrictUndefined


#homepage
@app.route('/')
def index():
    """Homepage."""

    return render_template("homepage.html")


#Go to the registration page
@app.route('/register', methods=['GET'])
def register_form():
    """Show form for user signup."""

    return render_template("register-form.html")


#Register for a new user
@app.route('/register', methods=['POST'])
def register_process():
    """Process registration."""

    # Get form variables
    username = request.form["username"]
    password = request.form["password"]
    fname = request.form["fname"]
    lname = request.form["lname"]
    bday = request.form["bday"]
    zipcode = request.form["zipcode"]

    new_user = Users(username=username, password=password, fname=fname, 
                     lname=lname, bday=bday, zipcode=zipcode)

    db.session.add(new_user)
    db.session.commit()

    flash("User %s added." % username)
    return redirect("/login")


#Go to login page
@app.route('/login', methods=['GET'])
def login_form():
    """Show login form."""

    return render_template("login-form.html")


#Login to profile
@app.route('/login', methods=['POST'])
def login_process():
    """Process login."""

    # Get form variables
    username = request.form["username"]
    password = request.form["password"]

    user = Users.query.filter_by(username=username).first()

    if not user:
        flash("No such user")
        return redirect("/login")

    if user.password != password:
        flash("Incorrect password")
        return redirect("/login")

    session["username"] = user.username

    flash("Logged in")
    return redirect("/users/%s" % user.username)


#Logout of user profile
@app.route('/logout')
def logout():
    """Log out."""

    del session["username"]
    flash("Logged Out.")
    return redirect("/")


@app.route("/users/<username>")
def user_detail(username):
    """Show info about user."""

    user = Users.query.get(username)
    return render_template("user.html", username=username)


@app.route("/add-clothes")
def add_clothes():
    """Add clothes to database."""

    return render_template('add-clothes.html')


#Generate a random outfit.
@app.route("/outfit")
def get_random_outfit():
    """Ge."""


    return render_template()


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension
    app.debug = True

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")
