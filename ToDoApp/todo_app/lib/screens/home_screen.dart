import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Widgets/custom_appbar.dart';
import 'package:todo_app/Widgets/headers.dart';
import 'package:todo_app/const/custom_colors.dart';
import 'package:todo_app/const/custom_text_styles.dart';
import 'package:todo_app/data/dbHelper.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/add_todo.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {
  DbHelper dbHelper = DbHelper();
  List<ToDo>? todos;
  int toDosCount = 0;
  int _selectedIndex = 0;

  @override
  Widget build(Object context) {
    dbHelper.createDb().then((value) => null);

    if (todos == null) {
      todos = <ToDo>[];
      getToDos();
    }

    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: _customBottomNavigationBar,
      floatingActionButton: _customFabButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: CustomColors.backgroundColor,
      body: IndexedStack(index: _selectedIndex, children: <Widget>[
        Column(
          children: <Widget>[
            CustomAppBar.customAppBar,
            Headers.allToDosText,
            _toDosItem(false),
          ],
        ),
        _toDosItem(true),
      ]),
    ));
  }

  Widget get _customBottomNavigationBar => BottomNavigationBar(
        iconSize: 30,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notification_important_sharp),
              label: 'Important')
        ],
        selectedItemColor: CustomColors.customRed,
        backgroundColor: CustomColors.mainColor,
        unselectedItemColor: CustomColors.backgroundColor,
        currentIndex: _selectedIndex,
        onTap: selectedTab,
      );
  void selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget get _customFabButton => FloatingActionButton.extended(
        label: Text(
          "Add ToDo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          navigateToAdd();
        },
        backgroundColor: CustomColors.customRed,
        icon: Icon(
          Icons.add,
          color: CustomColors.backgroundColor,
          size: 30,
        ),
      );

  Widget _toDosItem(bool isJustImportant) {
    if (isJustImportant) {
      return SafeArea(
        child: Column(
          children: [
            CustomAppBar.customAppBar,
            Headers.impToDosText,
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: todos!.length,
                itemBuilder: (BuildContext context, int position) {
                  if (todos![position].isImportant!) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: todos![position].isImportant!
                                ? Colors.red[300]
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5)),
                        height: 100,
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: InkWell(
                              child: Icon(
                                todos![position].isDone!
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 25,
                                color: todos![position].isDone!
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              onTap: () {
                                setState(() {
                                  todos![position].isDone =
                                      !todos![position].isDone!;
                                });
                              },
                            ),
                            title: Text(
                              todos![position].title!,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: todos![position].isImportant!
                                      ? CustomColors.customRed
                                      : CustomColors.mainColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: todos![position].isDone!
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                            subtitle: Text(
                              todos![position].explanation!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: todos![position].isDone!
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                            trailing: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: CustomColors.customRed,
                                  borderRadius: BorderRadius.circular(5)),
                              child: IconButton(
                                  onPressed: () {
                                    deleteToDo(todos![position].id!);
                                    getToDos();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center();
                  }
                }),
          ],
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: toDosCount,
            itemBuilder: (BuildContext context, int position) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 5),
                child: Container(
                  decoration: BoxDecoration(
                      color: todos![position].isImportant!
                          ? Colors.red[300]
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  height: 100,
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      leading: InkWell(
                        child: Icon(
                          todos![position].isDone!
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          size: 25,
                          color: todos![position].isDone!
                              ? Colors.green
                              : Colors.grey,
                        ),
                        onTap: () {
                          setState(() {
                            todos![position].isDone = !todos![position].isDone!;
                          });
                        },
                      ),
                      title: Text(
                        todos![position].title!,
                        style: TextStyle(
                            fontSize: 18,
                            color: todos![position].isImportant!
                                ? CustomColors.customRed
                                : CustomColors.mainColor,
                            fontWeight: FontWeight.bold,
                            decoration: todos![position].isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      subtitle: Text(
                        todos![position].explanation!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: todos![position].isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      trailing: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: CustomColors.customRed,
                            borderRadius: BorderRadius.circular(5)),
                        child: IconButton(
                            onPressed: () {
                              deleteToDo(todos![position].id!);
                              getToDos();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20,
                            )),
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    }
  }

  void getToDos() {
    var dbFuture = dbHelper.createDb();
    dbFuture.then((result) {
      var toDosFuture = dbHelper.getToDos();
      toDosFuture.then((data) {
        List<ToDo> toDosData = <ToDo>[];
        var toDosDataCount = data.length;
        for (int i = 0; i < toDosDataCount; i++) {
          toDosData.add(ToDo.fromObject(data[i]));
        }
        setState(() {
          todos = toDosData;
          toDosCount = toDosDataCount;
        });
      });
    });
  }

  void deleteToDo(int id) async {
    int sonuc;

    sonuc = await dbHelper.delete(id);
    if (sonuc != 0) {
      AlertDialog alertDialog = new AlertDialog(
        title: Text("Well Done!"),
        content: Text("Successfully deleted."),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }

  void navigateToAdd() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddToDoScreen()));
    if (result != null) {
      if (result) {
        getToDos();
      }
    }
  }
}
