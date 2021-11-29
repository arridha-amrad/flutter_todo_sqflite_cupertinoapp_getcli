import 'package:get/get.dart';

import 'package:todo_sqflite/app/modules/create_todo/bindings/create_todo_binding.dart';
import 'package:todo_sqflite/app/modules/create_todo/views/create_todo_view.dart';
import 'package:todo_sqflite/app/modules/home/bindings/home_binding.dart';
import 'package:todo_sqflite/app/modules/home/views/home_view.dart';
import 'package:todo_sqflite/app/modules/update_todo/bindings/update_todo_binding.dart';
import 'package:todo_sqflite/app/modules/update_todo/views/update_todo_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TODO,
      page: () => CreateTodoView(),
      binding: CreateTodoBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_TODO,
      page: () => UpdateTodoView(),
      binding: UpdateTodoBinding(),
    ),
  ];
}
