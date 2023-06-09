import 'package:flutter/cupertino.dart';
import 'package:todo_app/const/custom_text_styles.dart';

class CustomAppBar extends Widget {
  static Widget get customAppBar => Container(
        alignment: Alignment.center,
        height: 70,
        child: Text("ToDo App", style: CustomTextStyles.appBarText),
      );

  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }
}
