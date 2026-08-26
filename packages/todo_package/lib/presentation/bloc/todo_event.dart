import '../../domain/entities/todo.dart';

sealed class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;

  AddTodoEvent(this.title);
}

class ToggleTodoEvent extends TodoEvent {
  final Todo todo;

  ToggleTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  final int id;

  DeleteTodoEvent(this.id);
}