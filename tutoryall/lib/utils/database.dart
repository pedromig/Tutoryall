import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'tutoryall_user.dart';
import 'tutoryall_event.dart';

class Database {
  static final FirebaseDatabase fb = FirebaseDatabase.instance;

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
      (dynamicUser["image"] == null) ? null : dynamicUser["image"] as Image,
       (dynamicUser["favUsersIDs"] == null)
            ? []
            : List.from(dynamicUser["favUsersIDs"]),
        (dynamicUser["createdEventsIDs"] == null)
            ? []
            : List.from(dynamicUser["createdEventsIDs"]),
        (dynamicUser["goingEventsIDs"] == null)
            ? []
            : List.from(dynamicUser["goingEventsIDs"])
        );
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
        dynamicEvent["listGoingIDs"] == null ? [] : List.from(dynamicEvent["listGoingIDs"]),
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

  static void newUser(TutoryallUser user) {
    fb.reference().child("users").child(user.id).set(user.toJson());
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
}
