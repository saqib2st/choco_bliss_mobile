import 'package:get/get.dart';

import '../controllers/controls_controller.dart';

class ControlsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControlsController>(
      () => ControlsController(),
    );
  }
}
