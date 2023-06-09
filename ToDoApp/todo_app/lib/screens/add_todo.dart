import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/const/custom_colors.dart';
import 'package:todo_app/data/dbHelper.dart';
import 'package:todo_app/models/todo.dart';

class AddToDoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddToDoScreen();
  }
}

class _AddToDoScreen extends State {
  DbHelper dbHelper = new DbHelper();

  TextEditingController newTitle = new TextEditingController();
  TextEditingController newExplanation = new TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: CustomColors.mainColor,
                      ),
                    ),
                    _customWidthBox,
                    Text(
                      "Add ToDo",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.mainColor),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: newTitle,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              _customHeightBox,
              TextField(
                controller: newExplanation,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Explanation',
                  hintText: 'Explanation',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              _customHeightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      isChecked
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      size: 35,
                      color: isChecked ? CustomColors.customRed : Colors.grey,
                    ),
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                  ),
                  Text(
                    'IMPORTANT',
                    style: TextStyle(
                        color: isChecked ? CustomColors.customRed : Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration:
                            isChecked ? null : TextDecoration.lineThrough),
                  ),
                  _customWidthBox,
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.customRed,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        add();
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _customHeightBox => SizedBox(
        height: 25,
      );

  Widget get _customWidthBox => SizedBox(
        width: 25,
      );

  void add() async {
    int result = await dbHelper.add(ToDo(
        title: newTitle.text,
        explanation: newExplanation.text,
        isImportant: isChecked));

    if (result != 0) {
      Navigator.pop(context, true);
      AlertDialog alertDialog = new AlertDialog(
        title: Text("Adding New ToDo"),
        content: Text("Successfully Added."),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }
}
