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

  // String remainderTime = "${TimeOfDay.now().minute.toString()}";
//  dynamic  _selectedTime = TimeOfDay.now().minute;
//   set selectedTime(value) => value;
//   get selectedTime => _selectedTime;
  int _mSelectedIndex = 0;
  void set mSelectedIndex(value) => _mSelectedIndex = value;
  int get mSelectedIndex => _mSelectedIndex;

  // void onselectindex(index) {
  //   _mSelectedIndex = index;
  //   if (index == 0) {
  //     facthData();
  //   } else {
  //     facthCompleted();
  //   }
  //   notifyListeners();
  // }

  Future<void> facthData() async {
    data = await db.facthNotes(0);
    notifyListeners();
  }

  void facthCompleted() async {
    data = await db.facthNotes(1);
    notifyListeners();
  }

  void facthPending() async {
    data = await db.facthNotes(2);
    notifyListeners();
  }

  void updateFalse() {
    _isupdate = false;
    notifyListeners();
  }

  // var _selectedpage = false;

  // set selectedpage(value) => _selectedpage = value;
  // get selectedpage => _selectedpage;
  int _completed = 0;
  set completed(value) => _completed = value;
  get completed => _completed;
  completedChacker(index) {
    var checker = data[index].modelCompleted;
    if (checker == 0) {
      _completed = 1;
    } else {
      _completed = 0;
    }
    db.completedUpdate(data[index].modelId, _completed);
    if (mSelectedIndex == 1) {
      facthCompleted();
    } else {
      facthPending();
    }
    notifyListeners();
  }

  createTask(int index) async {
    if (taskController.text.isNotEmpty) {
      db.createNote(await rModel(
          modelCompleted: 0,
          modelId: 0,
          modelReTime: 00,
          modelTitle: taskController.text.toString()));
      taskController.clear();
      facthData();
      notifyListeners();
    }
  }

  updatetask(index) async {
    db.update(await rModel(
      modelCompleted: data[index].modelCompleted,
      modelId: data[index].modelId,
      modelReTime: 00,
      modelTitle: taskController.text.toString(),
    ));
    taskController.clear();
    if (mSelectedIndex == 1) {
      facthCompleted();
    } else if (mSelectedIndex == 2) {
      facthPending();
    }
    notifyListeners();
  }

  void updatetextfield(index) {
    taskController.text = data[index].modelTitle.toString();
    notifyListeners();
  }

  void delete(int index) async {
    db.delet(data[index].modelId);
    facthData();
    notifyListeners();
  }
}
