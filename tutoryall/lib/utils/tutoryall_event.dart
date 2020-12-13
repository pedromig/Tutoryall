import 'package:flutter/material.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class TutoryallEvent {
  String name;
  String description;
  DateTime date;
  TimeOfDay time;
  Image image;
  String location;
  int lotation;
  String creatorID;
  TutoryallUser creator;
  List<String> listGoingIDs;
  List<TutoryallUser> listGoing = [];
  List<String> tags;

  TutoryallEvent(
      String name,
      String description,
      DateTime date,
      TimeOfDay time,
      Image image,
      String creatorID,
      List<String> listGoingIDs,
      String location,
      int lotation,
      List<String> tags) {
    this.name = name;
    this.description = description;
    this.date = date;
    this.time = time;
    this.image = image;
    this.creatorID = creatorID;
    this.listGoingIDs = listGoingIDs;
    this.location = location;
    this.lotation = lotation;
    this.tags = tags;
  }
}
