import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stm2/models/todomodel.dart';
import 'package:stm2/providers/todolistmanager.dart';
import 'package:uuid/uuid.dart';

final TodoListProvider =
    StateNotifierProvider<TodoListNotifier, List<TodoModel>>(
  (ref) {
    return TodoListNotifier([
      TodoModel(id: const Uuid().v4(), definition: "Go to sports"),
      TodoModel(id: const Uuid().v4(), definition: "Study"),
      TodoModel(id: const Uuid().v4(), definition: "Go to shopping"),
    ]);
  },
);

final UnCompletedTodoCount = Provider<int>(
  (ref) {
    final AllTodo = ref.watch(TodoListProvider);
    final count =
        AllTodo.where((element) => element.isCompleted == false).length;
    return count;
  },
);

final CurrentTodoProvider = Provider<TodoModel>(
  (ref) {
    throw UnimplementedError();
  },
);

enum TodoListFilter { all, active, completed }
final todoListFilter = StateProvider<TodoListFilter>(
  (ref) => TodoListFilter.all,
);

final FilteredTodoList = Provider<List<TodoModel>>(
  (ref) {
    final filter = ref.watch(todoListFilter);
    final todolist = ref.watch(TodoListProvider);

    switch (filter) {
      case TodoListFilter.all:
        return todolist;
      case TodoListFilter.completed:
        return todolist
            .where((element) => element.isCompleted == true)
            .toList();
      case TodoListFilter.active:
        return todolist
            .where((element) => element.isCompleted == false)
            .toList();
    }
  },
);
