import 'package:flutter/cupertino.dart';

class Headers extends Widget {
  static Widget get allToDosText => Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
        child: Row(
          children: [
            Text(
              "All ToDos",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      );

  static Widget get impToDosText => Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
        child: Row(
          children: [
            Text(
              "Important ToDos",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      );

  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }
}
