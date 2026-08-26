import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/update_todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
  }) : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(
    LoadTodos event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());

    try {
      final todos = await getTodos();

      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onAddTodo(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      final todo = Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: event.title,
        completed: false,
      );

      await addTodo(todo);

      add(LoadTodos());
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onToggleTodo(
    ToggleTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      final todo = event.todo.copyWith(
        completed: !event.todo.completed,
      );

      await updateTodo(todo);

      add(LoadTodos());
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onDeleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      await deleteTodo(event.id);

      add(LoadTodos());
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }
}