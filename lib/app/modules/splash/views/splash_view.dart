import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      backgroundColor:  Color(0xffF7BEC3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choco Bliss',
              style: TextStyle(fontSize: 55,color: Color(0xff6a351d),fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Sweet and Delicious',
              style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
