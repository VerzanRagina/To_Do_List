import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.green, // Set primary color to green
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor:
            Color.fromARGB(255, 226, 166, 237), // Light Purple Background
      ),
      home: TodoListPage(),
    );
  }
}

class Todo {
  final String id;
  final String title;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    this.completed = false,
  });
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> _todos = [];
  final _titleController = TextEditingController();

  void _addTodo() {
    final newTodo = Todo(
      id: _generateId(),
      title: _titleController.text,
    );
    setState(() {
      _todos.add(newTodo);
      _titleController.clear();
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos.remove(todo);
    });
  }

  void _toggleCompleted(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  String _generateId() {
    return DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    _todos.sort((a, b) {
      // Move completed todos to the end
      if (a.completed && !b.completed) {
        return 1;
      } else if (!a.completed && b.completed) {
        return -1;
      } else {
        return 0;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor:
            Color.fromARGB(255, 108, 4, 80), // Set the background color to grey
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Enter task title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Colors.green), // Set button color to green
            ),
            child: const Text('Add Todo'),
            onPressed: _addTodo,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return TodoWidget(
                  todo: todo,
                  onDelete: () {
                    _deleteTodo(todo);
                  },
                  onToggleCompleted: () {
                    _toggleCompleted(todo);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
  final Todo todo;
  final VoidCallback onDelete;
  final VoidCallback onToggleCompleted;

  TodoWidget({
    required this.todo,
    required this.onDelete,
    required this.onToggleCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      leading: Checkbox(
        value: todo.completed,
        onChanged: (value) {
          onToggleCompleted();
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          onDelete();
        },
      ),
    );
  }
}
