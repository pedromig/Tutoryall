import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'tutoryall_user.dart';
import 'tutoryall_event.dart';

import 'dart:async';
import 'dart:io';

class Database {
  static final FirebaseDatabase fb = FirebaseDatabase.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static TutoryallUser makeUserObj(Map dynamicUser) {
    return TutoryallUser(
        dynamicUser["id"] as String,
        dynamicUser["name"] as String,
        dynamicUser["location"] as String,
        dynamicUser["age"] as int,
        dynamicUser["contact"] as String,
        dynamicUser["bio"] as String,
        (dynamicUser["ratings"] == null)
            ? 0
            : (List.from(dynamicUser["ratings"].values).fold(
                    0, (previousValue, element) => previousValue + element) /
                List.from(dynamicUser["ratings"].values).length),
        (dynamicUser["image"] == null) ? null : dynamicUser["image"] as String,
        (dynamicUser["favUsersIDs"] == null)
            ? []
            : List.from(dynamicUser["favUsersIDs"]),
        (dynamicUser["createdEventsIDs"] == null)
            ? []
            : List.from(dynamicUser["createdEventsIDs"]),
        (dynamicUser["goingEventsIDs"] == null)
            ? []
            : List.from(dynamicUser["goingEventsIDs"]));
  }

  static TutoryallEvent makeEventObj(Map dynamicEvent) {
    return TutoryallEvent(
        dynamicEvent["name"] as String,
        dynamicEvent["description"] as String,
        DateTime(
            dynamicEvent["date"]["year"] as int,
            dynamicEvent["date"]["month"] as int,
            dynamicEvent["date"]["day"] as int),
        TimeOfDay(
            hour: dynamicEvent["time"]["hour"] as int,
            minute: dynamicEvent["time"]["minute"] as int),
        dynamicEvent["image"] == null ? null : dynamicEvent["image"] as Image,
        dynamicEvent["creatorID"] as String,
        dynamicEvent["listGoingIDs"] == null
            ? []
            : List.from(dynamicEvent["listGoingIDs"]),
        dynamicEvent["location"] as String,
        dynamicEvent["lotation"] as int,
        dynamicEvent["tags"] == null ? [] : List.from(dynamicEvent["tags"]));
  }

  static Future<List<TutoryallUser>> getUserList() async {
    DataSnapshot parent = await fb.reference().child("users").once();
    Map users = parent.value;
    List<TutoryallUser> builtUsers = [];
    for (final key in users.keys) {
      Map dynamicUser = users[key];
      builtUsers.add(makeUserObj(dynamicUser));
    }
    return builtUsers;
  }

  static Future<TutoryallUser> getUser(String userID) async {
    DataSnapshot parent =
        await fb.reference().child("users").child(userID).once();
    Map map = parent.value;
    return makeUserObj(map);
  }

  static User authenticatedUser() {
    return auth.currentUser;
  }

  static Future<String> getUserDisplayName() async {
    return auth.currentUser.displayName;
  }

  static void newUser(TutoryallUser user) {
    fb.reference().child("users").child(user.id).set(user.toJson());
  }

  static Future<void> updateUser(String uid, String key, dynamic value) async {
    await fb.reference().child("user").child(uid).child(key).set(value);
  }

  static Future<List<TutoryallEvent>> getEventList() async {
    DataSnapshot parent = await fb.reference().child("events").once();
    Map events = parent.value;
    List<TutoryallEvent> builtEvents = [];
    for (final key in events.keys) {
      Map dynamicEvent = events[key];
      builtEvents.add(makeEventObj(dynamicEvent));
    }
    return builtEvents;
  }

  static Future<TutoryallEvent> getEvent(String eventID) async {
    DataSnapshot parent =
        await fb.reference().child("events").child(eventID).once();
    Map map = parent.value;
    return makeEventObj(map);
  }

  static Future<ImageProvider<Object>> getUserProfilePicture(String uid) async {
    Reference uri = storage.ref().child("${uid}_profile");
    String url = await uri.getDownloadURL().catchError((value) {
      return value.code;
    }).whenComplete(() => null);
    return url == "object-not-found"
        ? AssetImage("assets/images/default_user.png")
        : NetworkImage(url);
  }

  static Future<ImageProvider<Object>> getUserBackgroundImage(
      String uid) async {
    Reference uri = storage.ref().child("${uid}_background");

    String url = await uri.getDownloadURL().catchError((value) {
      return value.code;
    }).whenComplete(() => null);

    return url == "object-not-found"
        ? AssetImage("assets/images/cover_pic.png")
        : NetworkImage(url);
  }

  static Future<UserCredential> signIn(String _email, String _password) async {
    return auth.signInWithEmailAndPassword(email: _email, password: _password);
  }

  static Future<UserCredential> register(
      String _email, String _password) async {
    return auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
  }

  static Future<void> recoverPassword(String _email) async {
    return await auth.sendPasswordResetEmail(email: _email);
  }

  static Future<void> updateProfileImage(File image) async {
    User user = Database.authenticatedUser();
    String uid = user.uid;

    await storage.ref().child("${uid}_profile").putFile(image);
  }

  static Future<void> updateBackGroundImage(File image) async {
    String uid = Database.authenticatedUser().uid;

    await storage.ref().child("${uid}_background").putFile(image);
  }
}
