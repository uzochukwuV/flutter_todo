import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task.dart';
import 'package:flutter_todo/stream/task.dart';

class TaskProgressCard extends StatefulWidget {
  final TaskModel model;
  const TaskProgressCard({Key? key, required this.model}) : super(key: key);

  @override
  _TaskProgressCardState createState() => _TaskProgressCardState();
}

class _TaskProgressCardState extends State<TaskProgressCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final TaskStreamController controller = TaskStreamController.instance;

  @override
  void initState() {
    super.initState();
    double last = widget.model.percentageDone / 100;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    );
    _animation = Tween<double>(begin: 0, end: last).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  String? _selectedItem;
  var _items = [
    DropdownMenuItem<String>(
      value: 'delete',
      child: Text('item'),
    )
  ];
  @override
  Widget build(BuildContext context) {
    var startDate = widget.model.startDate.toIso8601String().substring(2, 10);
    var endDate =
        widget.model.expectedEndDate.toIso8601String().substring(2, 10);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                widget.model.category,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: Colors.black54,
                ),
              ),
              Spacer(),
              DropdownButton<String>(
                  icon: Icon(Icons.more_horiz, color: Colors.black),
                  onChanged: (String? newValue) {
                    if (newValue == 'delete') {
                      print('deleting');
                      controller.deleteTask(widget.model);
                    }
                  },
                  items: _items),
            ],
          ),
          Text(
            widget.model.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            widget.model.description,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w100,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _animation.value,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                borderRadius: BorderRadius.circular(10),
              );
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '$startDate - $endDate',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w100,
                ),
              ),
              Spacer(),
              Text(
                widget.model.percentageDone.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
