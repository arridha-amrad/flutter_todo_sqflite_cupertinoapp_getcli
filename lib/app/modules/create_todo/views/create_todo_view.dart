import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_todo_controller.dart';

class CreateTodoView extends GetView<CreateTodoController> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('CreateTodoView'),
        previousPageTitle: "Home",
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _saveTodo(controller),
          child: const Text("Save"),
        ),
      ),
      child: SafeArea(
        child: Column(children: [
          CupertinoTextField(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            controller: controller.titleController,
            placeholder: "todo title...",
          ),
          Expanded(
              child: CupertinoTextField(
            expands: true,
            minLines: null,
            maxLines: null,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            controller: controller.descriptionController,
            textAlignVertical: TextAlignVertical.top,
            placeholder: "todo description...",
          ))
        ]),
      ),
    );
  }

  Future _saveTodo(CreateTodoController controller) async {
    await controller.createTodo();
    Get.back();
  }
}
