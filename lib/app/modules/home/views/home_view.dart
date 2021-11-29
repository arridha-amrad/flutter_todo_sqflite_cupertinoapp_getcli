import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_sqflite/app/modules/create_todo/controllers/create_todo_controller.dart';
import 'package:todo_sqflite/app/modules/create_todo/views/create_todo_view.dart';
import 'package:todo_sqflite/app/modules/models/todo.dart';
import 'package:todo_sqflite/app/modules/update_todo/controllers/update_todo_controller.dart';
import 'package:todo_sqflite/app/modules/update_todo/views/update_todo_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final CreateTodoController createTodoController =
      Get.put(CreateTodoController());
  final UpdateTodoController updateTodoController =
      Get.put(UpdateTodoController());
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            largeTitle: const Text("Todos"),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text("Create"),
              onPressed: () => Get.to(() => CreateTodoView()),
            ),
          )
        ],
        body: Obx(() {
          return ListView.separated(
            itemBuilder: (context, index) {
              final todo = controller.todos[index];
              return GestureDetector(
                onTap: () => _goToTodoUpdateView(todo),
                onLongPress: () => _showDeleteDialog(context, todo.id!),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          todo.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            decoration: todo.isComplete
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_right,
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              thickness: 2,
            ),
            itemCount: controller.todos.length,
          );
        }),
      ),
    );
  }

  void _goToTodoUpdateView(Todo todo) {
    updateTodoController.todoId = todo.id!;
    updateTodoController.descriptionController.text = todo.description;
    updateTodoController.titleController.text = todo.title;
    updateTodoController.isComplete.value = todo.isComplete;
    updateTodoController.createdAt = todo.createdAt;
    updateTodoController.updatedAt = todo.updatedAt;
    Get.to(() => UpdateTodoView());
  }

  void _showDeleteDialog(BuildContext context, int todoId) {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("Delete Todo"),
              content: const Text(
                "Do you want to continue to delete this todo?",
              ),
              actions: [
                CupertinoButton(
                  child: const Text("Cancel"),
                  onPressed: () => Get.back(),
                ),
                CupertinoButton(
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: CupertinoColors.systemRed),
                    ),
                    onPressed: () async {
                      await updateTodoController.deleteTodo(todoId);
                      Get.back();
                    })
              ],
            ));
  }
}
