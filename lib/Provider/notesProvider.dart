import 'package:flutter/material.dart';
import 'package:remainder_app/Database/database.dart';
import 'package:remainder_app/Database/taskModel.dart';

class TaskProvider with ChangeNotifier {
  late DatabaseHelper db;
  TaskProvider({required this.db});
  List<rModel> data = [];
  bool _isupdate = false;
  set isUpdate(value) => _isupdate = value;
  get isUpdate => _isupdate;
  var taskController = TextEditingController();
  String remainderTime = "${TimeOfDay.now().minute.toString()}";

  void facthData() async {
    data = await db.facthNotes();
    notifyListeners();
  }

  void updateFalse() {
    _isupdate = false;
  }

  createTask(int index) async {
    if (taskController.text.isNotEmpty) {
      if (_isupdate == false) {
        db.createNote(await rModel(
            modelId: 0,
            modelReTime: 34,
            modelTitle: taskController.text.toString()));
        taskController.clear();
      } else if (_isupdate == true) {
        db.update(await rModel(
            modelId: data[index].modelId,
            modelReTime: 34,
            modelTitle: taskController.text.toString()));
        taskController.clear();
      }
      facthData();
      notifyListeners();
    }
  }

  void updatetextfield(index) {
    taskController.text = data[index].modelTitle.toString();
  }

  void delete(int index) async {
    db.delet(data[index].modelId);
    facthData();
    notifyListeners();
  }
}
