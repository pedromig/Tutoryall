import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'tutoryall_user.dart';
import 'event.dart';

class Database {
  String contents;
  String jsonPath;

  Database() {
    this.jsonPath = "assets/database/data.json";
  }

  TutoryallUser makeUserObj(dynamic dynamicUser) {
    return TutoryallUser(
        dynamicUser["id"] as String,
        dynamicUser["name"] as String,
        dynamicUser["age"] as int,
        dynamicUser["contact"] as String,
        dynamicUser["bio"] as String,
        dynamicUser["image"] as Image,
        List.from(dynamicUser["createdEventsIDs"]),
        List.from(dynamicUser["goingEventsIDs"]));
  }

  Event makeEventObj(dynamic dynamicEvent) {
    return Event(
        dynamicEvent["name"] as String,
        dynamicEvent["description"] as String,
        DateTime(
            dynamicEvent["date"]["year"] as int,
            dynamicEvent["date"]["month"] as int,
            dynamicEvent["date"]["day"] as int),
        TimeOfDay(
            hour: dynamicEvent["time"]["hour"] as int,
            minute: dynamicEvent["time"]["minute"] as int),
        dynamicEvent["image"] as Image,
        dynamicEvent["creatorID"] as String,
        List.from(dynamicEvent["listGoingIDs"]),
        dynamicEvent["location"] as String,
        dynamicEvent["rating"] as double,
        dynamicEvent["lotation"] as int,
        List.from(dynamicEvent["tags"]));
  }

  Future<String> getJson() {
    return rootBundle.loadString(jsonPath);
  }

  dynamic _fetch() async {
    return jsonDecode(await getJson());
  }

  dynamic _getUserList() async {
    return (await _fetch())["users"];
  }

  Future<List<TutoryallUser>> getUserList() async {
    Map users = await _getUserList();
    List<TutoryallUser> builtUsers = [];
    for (final key in users.keys) {
      dynamic dynamicUser = users[key];
      builtUsers.add(makeUserObj(dynamicUser));
    }
    return builtUsers;
  }

  Future<TutoryallUser> getUser(String userID) async {
    dynamic dynamicUser = (await _getUserList())[userID];
    return makeUserObj(dynamicUser);
  }

  dynamic _getEventList() async {
    return (await _fetch())["events"];
  }

  Future<List<Event>> getEventList() async {
    Map events = await _getEventList();
    List<Event> builtEvents = [];
    for (final key in events.keys) {
      dynamic dynamicEvent = events[key];
      builtEvents.add(makeEventObj(dynamicEvent));
    }
    return builtEvents;
  }

  Future<Event> getEvent(String eventID) async {
    dynamic dynamicEvent = (await _getEventList())[eventID];
    return makeEventObj(dynamicEvent);
  }

  void newUser(FirebaseAuth user) async {
    String id = user.currentUser.uid;
    String name = user.currentUser.displayName;
    String contact = user.currentUser.email;
    TutoryallUser newTutoryallUser =
        TutoryallUser(id, name, 0, contact, "My bio", null, [], []);
    // print(newTutoryallUser.toJson());
    dynamic data = await _fetch();
    data["users"][id] = newTutoryallUser;
  }
}
