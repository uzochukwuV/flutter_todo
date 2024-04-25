import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task.dart';
import 'package:flutter_todo/stream/task.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _inputTitle = TextEditingController();

  final _inputDescription = TextEditingController();

  final _inputId = TextEditingController();

  final _inputCategory = TextEditingController();

  final _inputEndDate = TextEditingController();

  final _inputPercentDone = TextEditingController();

  final TaskStreamController controller = TaskStreamController.instance;

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final padd = 12.0;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: deviceWidth,
          padding: EdgeInsets.all(padd),
          child: Wrap(
            direction: Axis.vertical,
            spacing: 20,
            children: [
              const Text(
                'Add Task',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                width: deviceWidth - 2 * padd,
                child: TextField(
                  controller: _inputTitle,
                  decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                width: deviceWidth - 2 * padd,
                child: TextField(
                  controller: _inputDescription,
                  decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                width: deviceWidth - 2 * padd,
                child: TextField(
                  controller: _inputCategory,
                  decoration: const InputDecoration(
                      labelText: 'category',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.text,
                ),
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
              ElevatedButton(
                  onPressed: () {
                    TaskModel model = TaskModel(
                        9,
                        _inputDescription.value.text,
                        _inputTitle.value.text,
                        _inputCategory.value.text,
                        _selectedDate,
                        0,
                        DateTime.now());
                    controller.addTask(model);
                    Navigator.of(context).pop();
                  },
                  child: const Text('submit'))
            ],
          )),
    );
  }
}
