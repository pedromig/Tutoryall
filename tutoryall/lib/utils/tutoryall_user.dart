import 'package:flutter/widgets.dart';
import 'package:tutoryall/utils/event.dart';

class TutoryallUser {
  String name;
  int age;
  String contact;
  String bio;
  List<Event> createdEvents;
  List<Event> goingEvents;
  List<String> tags;
  Image image;

  TutoryallUser(
      this.name, this.tags, this.age, this.contact, this.bio, this.image);

  void addCreatedEvent(Event event) {
    this.createdEvents.add(event);
  }
}
