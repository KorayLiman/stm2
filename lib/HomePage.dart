import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stm2/models/todomodel.dart';
import 'package:stm2/providers/allproviders.dart';
import 'package:stm2/widgets/futureproviderexample.dart';
import 'package:stm2/widgets/titlewidget.dart';
import 'package:stm2/widgets/todolistitemwidget.dart';
import 'package:stm2/widgets/toolbarwidget.dart';
import 'package:uuid/uuid.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);
  final TodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var AllTodos = ref.watch(FilteredTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            controller: TodoController,
            decoration: const InputDecoration(
              label: Text("What are you going to do today?"),
            ),
            onSubmitted: (value) {
              ref.read(TodoListProvider.notifier).AddTodo(value);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ToolbarWidget(),
          AllTodos.length == 0 ? Text("No Tasks") : SizedBox(),
          for (int i = 0; i < AllTodos.length; i++)
            Dismissible(
              child: ProviderScope(
                child: TodoListItem(),
                overrides: [CurrentTodoProvider.overrideWithValue(AllTodos[i])],
              ),
              key: ValueKey(AllTodos[i].id),
              onDismissed: (direction) {
                ref.read(TodoListProvider.notifier).Remove(AllTodos[i]);
              },
            ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FutureProviderExample(),
                    ));
              },
              child: const Text("Future Provider"))
        ],
      ),
    );
  }
}
