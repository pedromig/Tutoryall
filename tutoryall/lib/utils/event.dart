import 'package:flutter/material.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class Event {
  String name;
  String description;
  DateTime date;
  TimeOfDay time;
  Image image;
  String location;
  double rating;
  int lotation;
  String creatorID;
  TutoryallUser creator;
  List<String> listGoingIDs;
  List<TutoryallUser> listGoing = [];
  List<String> tags;

  Event(
      String name,
      String description,
      DateTime date,
      TimeOfDay time,
      Image image,
      String creatorID,
      List<String> listGoingIDs,
      String location,
      double rating,
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
    this.rating = rating;
    this.lotation = lotation;
    this.tags = tags;
  }
}
