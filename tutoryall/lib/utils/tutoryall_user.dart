import 'package:flutter/widgets.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';

class TutoryallUser {
  String name;
  int age;
  double rating;
  String id;
  String contact;
  String bio;
  List<String> createdEventsIDs;
  List<String> goingEventsIDs;
  List<TutoryallEvent> createdEvents = [];
  List<TutoryallEvent> goingEvents = [];
  Image image;

  TutoryallUser(
      String id,
      String name,
      int age,
      String contact,
      String bio,
      double rating,
      Image image,
      List<String> createdEventsIDs,
      List<String> goingEventsIDs) {
    this.id = id;
    this.name = name;
    this.age = age;
    this.contact = contact;
    this.bio = bio;
    this.rating = rating;
    this.image = image;
    this.createdEventsIDs = createdEventsIDs;
    this.goingEventsIDs = goingEventsIDs;
  }

  void addCreatedEvent(TutoryallEvent event) {
    this.createdEvents.add(event);
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.age} }';
  }

  Map toJson() {
    return {
      this.id: {
        "id": this.id,
        "name": this.name,
        "age": this.age,
        "contact": this.contact,
        "bio": this.bio,
        "image": null,
        "createdEventsIDs": this.createdEventsIDs,
        "goingEventsIDs": this.goingEventsIDs
      }
    };
  }
}
