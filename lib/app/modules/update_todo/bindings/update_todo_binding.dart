import 'package:get/get.dart';

import '../controllers/update_todo_controller.dart';

class UpdateTodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateTodoController>(
      () => UpdateTodoController(),
    );
  }
}
