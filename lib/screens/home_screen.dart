import 'package:flutter/material.dart';
import 'package:tetris_test/models/task.dart';
import 'package:tetris_test/widgets/tetris_board.dart';
import 'package:tetris_test/screens/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = [];
  final GlobalKey<TetrisBoardState> _tetrisBoardKey = GlobalKey<TetrisBoardState>();
  
  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
    });
    
    // Notify the board about the new task
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_tetrisBoardKey.currentState != null) {
        _tetrisBoardKey.currentState!.addNewTask(task);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tetris Task Manager'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: TetrisBoard(
              key: _tetrisBoardKey,
              tasks: _tasks,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Task? newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );
          
          if (newTask != null) {
            _addTask(newTask);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
