# Description: This file contains the controller for user management, including creating, deleting, and updating users.

from flask import Flask, request, jsonify
from server.classes import profile
from flask_sqlalchemy import SQLAlchemy
from server.database import db 


#class LoginManager(db.Model):

class LoginManager:

    def signup(username, email, password):
        """
        Creates a new user profile with username, email, password.

        """
        # Check if user already exists
        # existing_user = mongo.db.User.find_one({"email": email})
        
        # Whether all the fields are filled in 
        if len(username.strip()) == 0 or len(password.strip()) == 0 or len(email.strip()) == 0:
            return jsonify({'error': 'Please fill in all the text fields'})
        
        # Username should only contain alphanumeric characters
        elif not re.match("^[a-zA-Z0-9]+$", username):
            return jsonify({'error': 'Username must contain only alphanumeric characters'})
    
        # Username should be unique
        #elif mongo.db.User.find_one({"username": username}):
        #    return jsonify({"error": "Please choose another username"})
        elif  profile.query.filter_by(email=email).first():
            return jsonify({"error": "Please choose another username"})
        
        # Username length should be between 1 and 10
        elif (not (1 <= len(username) <= 10)):
            print(len(username)) 
            return jsonify({"error": "Username should be between 1 and 10 characters"})

        # Email should be valid
        elif not("@" in email) or not(".com" in email):
            return jsonify({"error": "Email invalid"})
        
        # Email has already been registered
        #elif db.Profile.find_one({"email": email}):
        elif profile.query.filter_by(email=email).first():
            return jsonify({"error": "Email already registered"})
        
        # Password between 8 and 512 characters
        elif (not (8 <= len(password) <= 512)): 
            return jsonify({"error": "Invalid password. Your password should be between 8 and 512 characters"})

        # Password should contain only alphanumeric characters
        elif (not re.match("^[a-zA-Z0-9]+$", password)): 
            return jsonify({"error": "Invalid password. Your password should contain alphanumeric characters only"})
        
        # Password should contain at least 1 letter and digit
        elif not (re.match("(?=.*[a-zA-Z])(?=.*\d).+", password)):
            return jsonify({"error": "Invalid password. Your password should contain at least one letter and one digit"})
        
        # Password should not match the username
        elif(password.lower() == username.lower()):
            return jsonify({"error": "Invalid password. Your password should not be the same as your username"})

        # Create user object
        #new_user = user_model.User(name=name, email=email, username=username, password=None, user_profile=None, location=location)

        # Hash the password
        #hashed_pw = new_user.set_password(password)

        # Save user into the "User" collection
        #user_id = new_user.save()

        # Create user_profile object and save it
        new_profile = profile.Profile(username=username, email=email, password=password, bookings=None)

        # Create analytics object and save it
        # new_analytics = analytics_model.Analytics(user=name, user_id=user_id, avg_speed=0, total_distance=0, routes=[])
        # analytics_id = new_analytics.save()
                                    
        db.session.add(new_profile)
        db.session.commit()      

        
        return jsonify({"message": "User created successfully!", "user_id": str(user_id)}), 201

    @staticmethod
    def delete_user(user_obj_id, profile_id):
        """
        Deletes a user along with their associated profile, analytics, and gamification documents.
        
        :param user_obj_id: The ObjectId of the user in MongoDB.
        :param profile_id: The ObjectId of the user's profile in MongoDB.
        :return: A Flask response object with a JSON payload indicating success.
        """
        # Fetch the user's profile document
        profile = mongo.db.User_Profile.find_one({"_id": profile_id})
        print(profile)
        # Delete the related analytics and gamification documents
        if profile:
            print("Found Profile")
            if 'analytics' in profile:
                print("Found Analytics")
                print("Deleting Analytics")
                mongo.db.Analytics.delete_one({"_id": profile['analytics']})
            if 'gamification' in profile:
                print("Found Gamification")
                print("Deleting Gamification")
                mongo.db.Gamification.delete_one({"_id": profile['gamification']})
            # Delete the user's profile document
            print("Deleting Profile")
            mongo.db.User_Profile.delete_one({"_id": profile['_id']})
        
        # Finally, delete the user document
        print("Deleting User")
        mongo.db.User.delete_one({"_id": user_obj_id})

        return jsonify({"message": "User deleted successfully"}), 200

    @staticmethod
    def update_user(user_id, fields):
        """
        Updates the fields of a user document in MongoDB.
        
        :param user_id: The ObjectId of the user in MongoDB.
        :param fields: A dictionary containing the fields to update.
        :return: True if the update was successful, False otherwise.
        """
        user = User.find_by_id(user_id)
        if user:
            user.update_fields(fields)
            user.update(user_id)
            return True
        return False

    @staticmethod
    def check_user_password(user_id, password):
        """
        Checks if the provided password matches the stored password of the user.
        
        :param user_id: The ObjectId of the user in MongoDB.
        :param password: The password to check.
        :return: True if the password matches, False otherwise.
        """
        user = User.find_by_id(user_id)
        if user and user.check_password(password):
            return True
        return False

    @staticmethod
    def get_user_by_email(email):
        """
        Retrieves a user document from MongoDB based on their email address.
        
        :param email: The email address of the user.
        :return: The user document if found, None otherwise.
        """
        return User.find_by_email(email)

    @staticmethod
    def get_user_by_id(user_id):
        """
        Retrieves a user document from MongoDB based on their ObjectId.
        
        :param user_id: The ObjectId of the user in MongoDB.
        :return: The user document if found, None otherwise.
        """
        return User.find_by_id(user_id)


    @staticmethod
    def add_friend(email,friend_id):
        user = mongo.db.User.find_one({"email": email})
        friend = mongo.db.User.find_one({"_id": ObjectId(friend_id)})

        if not friend:
            return jsonify({"message": "Friend not found!"}), 404

        # update friend_list with the new friend
        user['friends_list'].append(friend['_id'])
        mongo.db.User.update_one({"_id": user['_id']}, {"$set": user})

        # update the friend's friend_list with the current user
        friend['friends_list'].append(user['_id'])
        mongo.db.User.update_one({"_id": friend['_id']}, {"$set": friend})

        return jsonify({"message": "Friend added successfully!"}), 200

    @staticmethod
    def remove_friend(email,friend_id):
        user = mongo.db.User.find_one({"email": email})
        friend = mongo.db.User.find_one({"_id": ObjectId(friend_id)})

        if not friend:
            return jsonify({"message": "Friend not found!"}), 404

        # remove friend from user's friend_list
        friends_list = user['friends_list']
        for f in friends_list:
            if f == friend['_id']:
                user['friends_list'].remove(f)

        # remove user from friend's friend_list
        friends_list = friend['friends_list']
        for f in friends_list:
            if f == user['_id']:
                friend['friends_list'].remove(f)

        mongo.db.User.update_one({"_id": user['_id']}, {"$set": user})
        mongo.db.User.update_one({"_id": friend['_id']}, {"$set": friend})

        return jsonify({"message": "Friend removed successfully!"}), 200