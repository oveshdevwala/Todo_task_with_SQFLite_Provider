import 'package:remainder_app/Database/database.dart';

class rModel {
  //variable

  int modelId;
  String modelTitle;
  int modelReTime;

  //cunstrutur
  rModel(
      {required this.modelId,
      required this.modelReTime,
      required this.modelTitle});

  // fromMap

  factory rModel.fromMap(Map<String, dynamic> map) {
    return rModel(
        modelId: map[DatabaseHelper.colId],
        modelReTime: map[DatabaseHelper.colRmTime],
        modelTitle: map[DatabaseHelper.colTitle]);
  }
  //toMap
  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.colRmTime: modelReTime,
      DatabaseHelper.colTitle: modelTitle
    };
  }
}
