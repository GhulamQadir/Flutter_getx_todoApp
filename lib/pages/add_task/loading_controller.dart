import 'package:get/get.dart';

class LoadingVariable extends GetxController {
  var loading = 0.obs;

  updatefunction(var condition) {
    loading = condition;
    update();
  }
}
