import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_sqflite/app/modules/database/todo_database.dart';
import 'package:todo_sqflite/app/modules/home/controllers/home_controller.dart';
import 'package:todo_sqflite/app/modules/models/todo.dart';

class CreateTodoController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final isComplete = false.obs;

  final HomeController homeController = Get.put(HomeController());

  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.onInit();
  }

  void resetTextField() {
    titleController.clear();
    descriptionController.clear();
  }

  Future createTodo() async {
    final todo = await TodoDatabase.instance.createTodo(Todo(
      title: titleController.text,
      description: descriptionController.text,
      isComplete: isComplete.value,
      createdAt: DateTime.now(),
    ));
    homeController.todos.add(todo);
    resetTextField();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
