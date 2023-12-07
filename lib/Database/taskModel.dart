import 'package:remainder_app/Database/database.dart';

class rModel {
  //variable

  int modelId;
  int modelReTime;
  String modelTitle;
  int modelCompleted;

  //cunstrutur
  rModel(
      {
        required this.modelCompleted,
        required this.modelId,
      required this.modelReTime,
      required this.modelTitle});

  // fromMap

  factory rModel.fromMap(Map<String, dynamic> map) {
    return rModel(
      modelCompleted: map[DatabaseHelper.colCompleted],
        modelId: map[DatabaseHelper.colId],
        modelReTime: map[DatabaseHelper.colRmTime],
        modelTitle: map[DatabaseHelper.colTitle]);
  }
  //toMap
  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.colCompleted: modelCompleted,
      DatabaseHelper.colRmTime: modelReTime,
      DatabaseHelper.colTitle: modelTitle
    };
  }
}
