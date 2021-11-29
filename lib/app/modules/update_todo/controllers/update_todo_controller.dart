import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_sqflite/app/modules/database/todo_database.dart';
import 'package:todo_sqflite/app/modules/home/controllers/home_controller.dart';
import 'package:todo_sqflite/app/modules/models/todo.dart';

class UpdateTodoController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final isComplete = false.obs;
  late int? todoId;

  late DateTime createdAt;
  late DateTime? updatedAt;

  HomeController homeController = Get.find<HomeController>();

  Future<void> updateTodo() async {
    final todo = await TodoDatabase.instance.getTodo(todoId!);
    final updatedTodo = await TodoDatabase.instance.updateTodo(
      Todo(
        title: titleController.text,
        description: descriptionController.text,
        isComplete: isComplete.value,
        createdAt: todo.createdAt,
        updatedAt: DateTime.now(),
      ),
      todoId!,
    );
    print("updated todo id : ${updatedTodo.id}");
    homeController.todos[homeController.todos.indexWhere(
      (todo) => todo.id == todoId!,
    )] = updatedTodo;

    titleController.clear();
    descriptionController.clear();
  }

  Future deleteTodo(int todoId) async {
    await TodoDatabase.instance.deleteTodo(todoId);
    homeController.todos.removeWhere((todo) => todo.id == todoId);
  }

  final count = 0.obs;
  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.onInit();
  }
}
