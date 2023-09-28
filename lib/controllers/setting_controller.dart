import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cash_world/routes/app_pages.dart';
import 'package:cash_world/utils/app_color.dart';
import 'package:cash_world/database/database_helper.dart';
import 'package:cash_world/utils/hash_password.dart';

class SettingController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  RxBool obsecureTextNew = true.obs;
  TextEditingController passC = TextEditingController();
  TextEditingController passNewC = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  final box = GetStorage();

  @override
  void onInit() {
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

  Future<void> changePassword() async {
    String currentPassword = passC.text;
    String newPassword = passNewC.text;
    final db = await dbHelper.database;

    // Mendpatkan password sesuai username
    final List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [box.read('user_id')],
    );

    if (users.isNotEmpty) {
      final storedPassword = users[0]['password'] as String;

      // Cek password
      if (checkPassword(currentPassword, storedPassword)) {
        final hashedPassword = HashPassword(newPassword);

        // Update password ke database
        await db.update(
          'users',
          {'password': hashedPassword},
          where: 'id = ?',
          whereArgs: [box.read('user_id')],
        );

        passC.clear();
        passNewC.clear();

        Get.snackbar(
          'Berhasil',
          'Password berhasil diperbarui',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
        );
      }
    } else {
      // Password saat ini tidak cocok
      Get.snackbar(
        'Error',
        'Gagal memperbarui password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.secondary,
        colorText: Colors.white,
      );
    }
  }

  bool checkPassword(String inputPassword, String storedPassword) {
    final hashedInputPassword = HashPassword(inputPassword);
    return hashedInputPassword == storedPassword;
  }

  Future<void> logout() async {
    box.remove("user_id");
    box.remove("username");
    Get.offNamed(Routes.LOGIN);
  }
}
class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
  }
}