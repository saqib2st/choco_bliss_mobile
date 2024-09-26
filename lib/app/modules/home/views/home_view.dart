import 'package:choco_bliss_mobile/app/data/color_const.dart';
import 'package:choco_bliss_mobile/app/modules/controls/controllers/controls_controller.dart';
import 'package:choco_bliss_mobile/app/modules/orders/controllers/orders_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: true,
      ),
      body: Obx(()=>controller.views[controller.index.value]),

      bottomNavigationBar: Obx(()=>BottomNavigationBar(
        elevation: 10,
        enableFeedback: true,
        fixedColor:const Color(0xff6A351D) ,
        unselectedItemColor:AppColors.unselectedTab,
        onTap: (index){
          controller.index.value = index;
          if(index == 1 ){
            if (!Get.isRegistered<OrdersController>()) {
              Get.put<OrdersController>(OrdersController());
            }
          }else if(index == 0 ){
            if (!Get.isRegistered<ControlsController>()) {
              Get.put<ControlsController>(ControlsController());
            }
          }
        },
        currentIndex: controller.index.value,
        items: const [
          BottomNavigationBarItem(
              label: 'Controls',
              icon: Icon(Icons.settings_accessibility)),
          BottomNavigationBarItem(
              label: 'Orders',
              icon: Icon(Icons.shopping_cart)),
        ],
      ))
    );
  }
}
