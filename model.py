"""Models and database functions for clothes db."""

from flask_sqlalchemy import SQLAlchemy

# Here's where we create the idea of our database. We're getting this through
# the Flask-SQLAlchemy library. On db, we can find the `session`
# object, where we do most of our interactions (like committing, etc.)

db = SQLAlchemy()


################################ORM########################################


class Users (db.Model):
    """User details"""

    __tablename__ = "users"

    username = db.Column(db.String(30), primary_key=True)
    password = db.Column(db.String(64), nullable=False)
    fname = db.Column(db.String(50), nullable=False)
    lname = db.Column(db.String(50), nullable=False)
    bday = db.Column(db.DateTime, nullable=True)
    zipcode = db.Column(db.String(10), nullable=True)

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<User username=%s name=%s %s>" % (self.username, self.fname, self.lname)


class Articles(db.Model):
    """Article of clothing inside user's closet."""

    __tablename__ = "articles"

    clothing_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    username = db.Column(db.String(30), db.ForeignKey('users.username'), nullable=False)
    category_id = db.Column(db.String(30), db.ForeignKey('category.category_id'), nullable=False)
    description = db.Column(db.String(400), nullable=False)
    url = db.Column(db.String(200), nullable=False)

    clk = db.relationship("ClothingKeyword", backref="articles") 

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Article Of Clothing=%s description=%s>" % (self.clothing_id, self.description)


class Category(db.Model):
    """Catgeory of clothing."""

    __tablename__ = "category"

    category_id = db.Column(db.String(30), primary_key=True)

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Category=%s>" % (self.category_id)

class Keyword(db.Model):
    """Keyword associated with clothing"""

    __tablename__ = "keyword"

    keyword_id = db.Column(db.String(30), primary_key=True)

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Keyword=%s>" % (self.keyword_id)


class ClothingKeyword(db.Model):
    """Keywords associated with article of clothing."""

    __tablename__ = "clothing_keyword"

    clothingkeyword_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    keyword_id = db.Column(db.String(64), db.ForeignKey('keyword.keyword_id'), nullable=False)
    clothing_id = db.Column(db.Integer, db.ForeignKey('articles.clothing_id'), nullable=False)

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Category= %s, Keyword=%s>" % (self.category_id, self.keyword_id)



##############################################################################
# Helper functions

def init_app():
    # So that we can use Flask-SQLAlchemy, we'll make a Flask app.
    from flask import Flask
    app = Flask(__name__)

    connect_to_db(app)
    print "Connected to DB."


def connect_to_db(app):
    """Connect the database to our Flask app."""

    # Configure to use our database.
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgres:///clothes'
    app.config['SQLALCHEMY_ECHO'] = False
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    # As a convenience, if we run this module interactively, it will leave
    # you in a state of being able to work with the database directly.

    # So that we can use Flask-SQLAlchemy, we'll make a Flask app.
    from flask import Flask

    app = Flask(__name__)

    connect_to_db(app)
    print "Connected to DB."
