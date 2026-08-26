import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();

  Future<void> addTodo(TodoModel todo);

  Future<void> updateTodo(TodoModel todo);

  Future<void> deleteTodo(int id);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final List<TodoModel> _todos = [];

  @override
  Future<List<TodoModel>> getTodos() async {
    return List.unmodifiable(_todos);
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    _todos.add(todo);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final index = _todos.indexWhere(
      (item) => item.id == todo.id,
    );

    if (index != -1) {
      _todos[index] = todo;
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    _todos.removeWhere(
      (todo) => todo.id == id,
    );
  }
}