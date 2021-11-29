import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/update_todo_controller.dart';

class UpdateTodoView extends GetView<UpdateTodoController> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Update Todo'),
        previousPageTitle: "Home",
        trailing: controller.isComplete.value
            ? null
            : CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _updateTodo(controller),
                child: const Text("Update"),
              ),
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
            child: CupertinoFormRow(
              padding: EdgeInsets.zero,
              child: Text(DateFormat.jm().format(controller.createdAt)),
              prefix: const Text("Created At"),
            ),
          ),
          controller.updatedAt != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12.0),
                  child: CupertinoFormRow(
                    padding: EdgeInsets.zero,
                    child: Text(DateFormat.jm().format(controller.updatedAt!)),
                    prefix: const Text("Updated At"),
                  ))
              : const SizedBox(),
          Obx(() {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
                child: CupertinoFormRow(
                    padding: EdgeInsets.zero,
                    prefix: const Text("Complete"),
                    child: CupertinoSwitch(
                      value: controller.isComplete.value,
                      onChanged: (bool? val) =>
                          _updateTodoComplete(val!, context),
                    )));
          }),
          CupertinoTextField(
            readOnly: controller.isComplete.value,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            controller: controller.titleController,
            placeholder: "todo title...",
          ),
          CupertinoTextField(
            decoration: BoxDecoration(
                border: Border.all(
              width: 0,
              color: Colors.transparent,
            )),
            readOnly: controller.isComplete.value,
            expands: true,
            minLines: null,
            maxLines: null,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            controller: controller.descriptionController,
            textAlignVertical: TextAlignVertical.top,
            placeholder: "todo description...",
          ),
        ],
      ),
    );
  }

  Future _updateTodo(UpdateTodoController controller) async {
    await controller.updateTodo();
    Get.back();
  }

  void _updateTodoComplete(bool val, BuildContext context) {
    !controller.isComplete.value
        ? showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text("Have you complete this todo?"),
                content: const Text(
                    "This process cannot be undo. If you have complete this task. Please continue"),
                actions: [
                  CupertinoButton(
                    child: const Text("Cancel"),
                    onPressed: () => Get.back(),
                  ),
                  CupertinoButton(
                      child: const Text("Continue"),
                      onPressed: () async {
                        controller.isComplete.value = true;
                        Get.back();
                        _updateTodo(controller);
                      })
                ],
              );
            },
          )
        : null;
  }
}
