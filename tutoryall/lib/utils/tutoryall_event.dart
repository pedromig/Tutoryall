import 'package:flutter/material.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class TutoryallEvent {
  String eventID;
  String name;
  String description;
  DateTime date;
  TimeOfDay time;
  String location;
  int lotation;
  String creatorID;
  TutoryallUser creator;
  List<String> listGoingIDs;
  List<TutoryallUser> listGoing = [];
  List<String> tags;

  TutoryallEvent(
      String eventID,
      String name,
      String description,
      DateTime date,
      TimeOfDay time,
      String creatorID,
      List<String> listGoingIDs,
      String location,
      int lotation,
      List<String> tags) {
    this.eventID = eventID;
    this.name = name;
    this.description = description;
    this.date = date;
    this.time = time;
    this.creatorID = creatorID;
    this.listGoingIDs = listGoingIDs;
    this.location = location;
    this.lotation = lotation;
    this.tags = tags;
  }

  Map toJson() {
    return {
      "id": this.eventID,
      "name": this.name,
      "description": this.description,
      "date": {
        "day": this.date.day,
        "month": this.date.month,
        "year": this.date.year,
      },
      "time": {
        "hour": this.time.hour,
        "minute": this.time.minute,
      },
      "creatorID": this.creatorID,
      "listGoingIDs": this.listGoingIDs,
      "location": this.location,
      "lotation": this.lotation,
      "tags": this.tags,
    };
  }
}
