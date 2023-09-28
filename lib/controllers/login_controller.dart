import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cash_world/routes/app_pages.dart';
import 'package:cash_world/utils/app_color.dart';
import 'package:cash_world/database/database_helper.dart';
import 'package:cash_world/utils/hash_password.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController usernameC = TextEditingController();
  TextEditingController passC = TextEditingController();

  @override
  void onInit() {
    final hashedPassword = HashPassword('admin');
    DatabaseHelper.instance.addUser("admin", hashedPassword);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> login() async {
    final username = usernameC.text;
    final password = passC.text;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Login Gagal',
        'Masukkan username atau password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.warning,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final isLoginSuccessful =
          await DatabaseHelper.instance.login(username, password);

      if (isLoginSuccessful) {
        Get.offNamed(Routes.HOME);
        Get.snackbar(
          'Selamat Datang',
          'Ayo perhatikan detail cash flow mu',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
        );
      } else {
        // Pesan error apabila login gagal
        Get.snackbar(
          'Login Gagal',
          'Username atau password salah',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.secondary,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      // Pesan error apabila terjadi error
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.secondary,
        colorText: Colors.white,
      );
    }
  }
}
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}