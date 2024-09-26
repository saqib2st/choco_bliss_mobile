import 'package:choco_bliss_mobile/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'saqib.amin2323@gmail.com',
        password: 'Fineo1234.!',
      );
      // Navigate to the next screen if successful
    } catch (e) {
      print('Error during sign-in: $e');
      // Handle errors, e.g., show a message to the user
    }
  }




  void nextPage(){
    Future.delayed(const Duration(seconds: 2)).then((_){
      Get.offNamed(Routes.home);
    });
  }

  @override
  void onInit() {
    signIn();
    nextPage();
    super.onInit();
  }
}
