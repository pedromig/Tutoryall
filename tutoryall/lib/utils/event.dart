import 'package:flutter/material.dart';
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
  TutoryallUser creator;
  List<TutoryallUser> listGoing;

  Event(this.name, this.description, this.date, this.time, this.image,
      this.creator, this.listGoing, this.location, this.rating, this.lotation);
}
