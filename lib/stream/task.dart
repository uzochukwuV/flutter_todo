import 'dart:async';

import 'package:flutter_todo/model/task.dart';

class TaskStreamController {
  static TaskStreamController? _task;
  TaskStreamController._() {
    stream.listen((event) {
      taskModelList = event;
      print(event);
    });
    Future.delayed(Duration(seconds: 3)).then((value) {
      sink.add([
        TaskModel(2, 'description', 'title', 'category', DateTime.now(), 30,
            DateTime.now()),
        TaskModel(2, 'description', 'title', 'category', DateTime.now(), 89,
            DateTime.now()),
      ]);
    });
  }

  static TaskStreamController get instance =>
      _task ??= TaskStreamController._();

  final StreamController<List<TaskModel>> streamController =
      StreamController<List<TaskModel>>.broadcast();

  Stream<List<TaskModel>> get stream => streamController.stream;
  StreamSink get sink => streamController.sink;

  late List<TaskModel> taskModelList;

  // TaskStreamController() {
  //   stream.listen((event) {
  //     taskModelList = event;
  //     print(event);
  //   });
  //   Future.delayed(Duration(seconds: 3)).then((value) {
  //     sink.add([
  //       TaskModel(2, 'description', 'title'),
  //       TaskModel(2, 'description', 'title'),
  //       TaskModel(2, 'description', 'title'),
  //       TaskModel(2, 'description', 'title')
  //     ]);
  //   });
  // }

  void addTask(TaskModel taskModel) {
    taskModel.id = taskModelList.length + 1;
    taskModelList.add(taskModel);
    sink.add(taskModelList);
  }

  void deleteTask(TaskModel taskModel) {
    taskModelList.removeWhere((element) => element == taskModel);
    sink.add(taskModelList);
  }

  void updateTask(TaskModel taskModel, Map<String, dynamic> options) {
    var taskToUpdate =
        taskModelList.firstWhere((element) => element == taskModel);
  }
}
