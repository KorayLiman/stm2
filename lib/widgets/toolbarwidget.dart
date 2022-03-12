import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stm2/providers/allproviders.dart';

class ToolbarWidget extends ConsumerWidget {
   ToolbarWidget({Key? key}) : super(key: key);
  var CurrentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filt) {
    if (CurrentFilter == filt) {
      return Colors.orange;
    } else {
      return Colors.black12;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uncompletedtodocount = ref.watch(UnCompletedTodoCount);
    CurrentFilter = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          uncompletedtodocount == 0
              ? "All Tasks Completed"
              : uncompletedtodocount.toString() + " tasks uncompleted",
          overflow: TextOverflow.ellipsis,
        )),
        Tooltip(
          message: "All tasks",
          child: TextButton(style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.all)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.all;
              },
              child: const Text("All")),
        ),
        Tooltip(
          message: "Active tasks",
          child: TextButton(style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.active)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.active;
              },
              child: const Text("Active")),
        ),
        Tooltip(
          message: "Completed tasks",
          child: TextButton(style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.completed)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state =
                    TodoListFilter.completed;
              },
              child: const Text("Completed")),
        )
      ],
    );
  }
}
