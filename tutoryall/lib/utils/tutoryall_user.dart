import 'package:flutter/widgets.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';

class TutoryallUser {
  String name;
  int age;
  String location;
  double rating;
  String id;
  String contact;
  String bio;
  List<String> favUsersIDs;
  List<String> createdEventsIDs;
  List<String> goingEventsIDs;
  List<TutoryallEvent> createdEvents = [];
  List<TutoryallEvent> goingEvents = [];
  String image;

  TutoryallUser(
      String id,
      String name,
      String location,
      int age,
      String contact,
      String bio,
      double rating,
      String image,
      List<String> favUsersIDs,
      List<String> createdEventsIDs,
      List<String> goingEventsIDs) {
    this.id = id;
    this.name = name;
    this.location = location;
    this.age = age;
    this.contact = contact;
    this.bio = bio;
    this.rating = rating;
    this.image = image;
    this.favUsersIDs = favUsersIDs;
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
      "id": this.id,
      "name": this.name,
      "location": this.location,
      "age": this.age,
      "contact": this.contact,
      "bio": this.bio,
      "image": null,
      "favUsersIDs": this.favUsersIDs,
      "createdEventsIDs": this.createdEventsIDs,
      "goingEventsIDs": this.goingEventsIDs
    };
  }
}
