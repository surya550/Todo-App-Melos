import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<TodoBloc>().add(
          LoadTodos(),
        );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TodoError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return const Center(
                child: Text('No Todos'),
              );
            }

            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];

                return ListTile(
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (_) {
                      context.read<TodoBloc>().add(
                            ToggleTodoEvent(todo),
                          );
                    },
                  ),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.completed
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<TodoBloc>().add(
                            DeleteTodoEvent(todo.id),
                          );
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    controller.clear();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter todo',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final title = controller.text.trim();

                if (title.isEmpty) {
                  return;
                }

                context.read<TodoBloc>().add(
                      AddTodoEvent(title),
                    );

                Navigator.pop(dialogContext);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}