import 'package:choco_bliss_mobile/app/modules/home/views/controls.dart';
import 'package:choco_bliss_mobile/app/modules/orders/views/orders_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/Models/order.dart';

class HomeController extends GetxController {
  RxInt index = 0.obs;


  RxList<Widget> views = <Widget>[
    const Controls(),
    const OrdersView(),
  ].obs;



}
