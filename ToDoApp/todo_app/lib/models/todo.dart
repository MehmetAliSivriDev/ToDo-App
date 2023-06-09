import 'package:flutter/cupertino.dart';

class ToDo {
  int? id;
  String? title;
  String? explanation;
  bool? isImportant;
  bool? isDone;

  ToDo(
      {this.id,
      required this.title,
      required this.explanation,
      required this.isImportant,
      this.isDone = false});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["title"] = title;
    map["explanation"] = explanation;
    map["isImportant"] = isImportant! ? 1 : 0;
    map["isDone"] = isDone! ? 1 : 0;

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  ToDo.fromObject(dynamic o) {
    this.id = o["id"];
    this.title = o["title"];
    this.explanation = o["explanation"];
    this.isImportant = o["isImportant"] == 1;
    this.isDone = o["isDone"] == 1;
  }
}
