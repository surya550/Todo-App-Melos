import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  Future<List<Todo>> getTodos() {
    return dataSource.getTodos();
  }

  @override
  Future<void> addTodo(Todo todo) {
    return dataSource.addTodo(
      TodoModel(
        id: todo.id,
        title: todo.title,
        completed: todo.completed,
      ),
    );
  }

  @override
  Future<void> updateTodo(Todo todo) {
    return dataSource.updateTodo(
      TodoModel(
        id: todo.id,
        title: todo.title,
        completed: todo.completed,
      ),
    );
  }

  @override
  Future<void> deleteTodo(int id) {
    return dataSource.deleteTodo(id);
  }
}