import 'package:choco_bliss_mobile/app/modules/controls/controllers/controls_controller.dart';
import 'package:choco_bliss_mobile/app/modules/orders/views/orders_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controls/views/controls_view.dart';

class HomeController extends GetxController {
  RxInt index = 0.obs;


  RxList<Widget> views = <Widget>[
    const ControlsView(),
    const OrdersView(),
  ].obs;


  @override
  void onInit() {
    if (!Get.isRegistered<ControlsController>()) {
      Get.put<ControlsController>(ControlsController());
    }
    super.onInit();
  }



}
