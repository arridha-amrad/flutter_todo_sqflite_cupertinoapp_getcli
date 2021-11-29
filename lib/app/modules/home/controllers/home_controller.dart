import 'package:get/get.dart';
import 'package:todo_sqflite/app/modules/database/todo_database.dart';
import 'package:todo_sqflite/app/modules/models/todo.dart';

class HomeController extends GetxController {
  final todos = <Todo>[].obs;

  Future<void> getTodos() async {
    final todoFromDB = await TodoDatabase.instance.getTodos();
    todos.addAll(todoFromDB);
  }

  @override
  void onInit() {
    getTodos();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
