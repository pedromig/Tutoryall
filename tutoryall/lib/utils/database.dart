import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'tutoryall_user.dart';
import 'tutoryall_event.dart';

class Database {
  String contents;
  String jsonPath = "assets/database/data.json";

  Database();

  TutoryallUser makeUserObj(dynamic dynamicUser) {
    return TutoryallUser(
        dynamicUser["id"] as String,
        dynamicUser["name"] as String,
        dynamicUser["age"] as int,
        dynamicUser["contact"] as String,
        dynamicUser["bio"] as String,
        List.from(dynamicUser["ratings"].values).length == 0
            ? 0
            : List.from(dynamicUser["ratings"].values).fold(
                    0, (previousValue, element) => previousValue + element) /
                List.from(dynamicUser["ratings"].values).length,
        dynamicUser["image"] as Image,
        List.from(dynamicUser["createdEventsIDs"]),
        List.from(dynamicUser["goingEventsIDs"]));
  }

  TutoryallEvent makeEventObj(dynamic dynamicEvent) {
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
        dynamicEvent["image"] as Image,
        dynamicEvent["creatorID"] as String,
        List.from(dynamicEvent["listGoingIDs"]),
        dynamicEvent["location"] as String,
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

  Future<List<TutoryallEvent>> getEventList() async {
    Map events = await _getEventList();
    List<TutoryallEvent> builtEvents = [];
    for (final key in events.keys) {
      dynamic dynamicEvent = events[key];
      builtEvents.add(makeEventObj(dynamicEvent));
    }
    return builtEvents;
  }

  Future<TutoryallEvent> getEvent(String eventID) async {
    dynamic dynamicEvent = (await _getEventList())[eventID];
    return makeEventObj(dynamicEvent);
  }
}
