import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/todomodel.dart';

class TodoListNotifier extends StateNotifier<List<TodoModel>> {
  TodoListNotifier([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void AddTodo(String definition) {
    var AddedTodo = state = [
      ...state,
      TodoModel(id: const Uuid().v4(), definition: definition)
    ];
  }

  void Toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              definition: todo.definition,
              isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }

  void Edit({required String id, required String NewDefinition}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              definition: NewDefinition,
              isCompleted: todo.isCompleted)
        else
          todo
    ];
  }

  void Remove(TodoModel todotobedeleted) {
    state = state.where((element) => element.id != todotobedeleted.id).toList();
  }

  int UnCompletedTodoCount() {
    return state.where((element) => !element.isCompleted).toList().length;
  }
}
