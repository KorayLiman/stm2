import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stm2/models/todomodel.dart';
import 'package:stm2/providers/allproviders.dart';

class TodoListItem extends ConsumerStatefulWidget {
  TodoListItem({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoListItemState();
}

class _TodoListItemState extends ConsumerState<TodoListItem> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;
  bool HasFocus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CurrentTodoItem = ref.watch(CurrentTodoProvider);

    return Focus(
      onFocusChange: (value) {
        if (!value) {
          setState(() {
            HasFocus = false;
            _focusNode.requestFocus();
          });
          ref.read(TodoListProvider.notifier).Edit(
              id: CurrentTodoItem.id,
              NewDefinition: _textEditingController.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            HasFocus = true;
            _textEditingController.text = CurrentTodoItem.definition;
          });
        },
        title: HasFocus
            ? TextField(
                focusNode: _focusNode,
                controller: _textEditingController,
              )
            : Text(CurrentTodoItem.definition),
        leading: Checkbox(
          value: CurrentTodoItem.isCompleted,
          onChanged: (value) {
            ref.read(TodoListProvider.notifier).Toggle(CurrentTodoItem.id);
          },
        ),
      ),
    );
  }
}
