import 'package:flutter/material.dart';
import 'package:flutter_todo/component/task.dart';
import 'package:flutter_todo/model/task.dart';
import 'package:flutter_todo/routes/addtask.dart';
import 'package:flutter_todo/stream/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Grid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final TaskStreamController controller = TaskStreamController.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Task App',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: StreamBuilder<List<TaskModel>>(
          stream: controller.stream,
          builder: (context, snapshot) {
            final items = snapshot.data;
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: items?.length,
              itemBuilder: (context, index) {
                if (items != null) {
                  return TaskProgressCard(
                    model: items[index],
                  );
                }
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddTask(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
