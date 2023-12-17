import 'package:get/get.dart';

class CustomTabController extends GetxController {
  // RxString tab = "storage".obs;
  String tab = "storage";
  void changeTab(String newTab) {
    tab = newTab;
    update();
  }
}
