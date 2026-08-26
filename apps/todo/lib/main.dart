import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_package/presentation/pages/todo_page.dart';
import 'package:todo_package/todo_package.dart';

void main() {
  final dataSource = TodoLocalDataSourceImpl();

  final repository = TodoRepositoryImpl(dataSource);

  final getTodos = GetTodos(repository);
  final addTodo = AddTodo(repository);
  final updateTodo = UpdateTodo(repository);
  final deleteTodo = DeleteTodo(repository);

  runApp(
    BlocProvider(
      create: (_) => TodoBloc(
        getTodos: getTodos,
        addTodo: addTodo,
        updateTodo: updateTodo,
        deleteTodo: deleteTodo,
      ),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const TodoPage(),
    );
  }
}