import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cash_world/controllers/home_controller.dart';
import 'package:cash_world/routes/app_pages.dart';
import 'package:cash_world/utils/app_color.dart';
import 'package:cash_world/database/database_helper.dart';

class AddExpenseController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController dateC = TextEditingController();
  TextEditingController nominalC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

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

  Future<void> resetForm() async {
    dateC.text = "01-01-2021";
    nominalC.clear();
    descriptionC.clear();
  }

  Future<void> addExpense() async {
    final date = dateC.text;
    final nominalWithRp = nominalC.text;
    final numericText = nominalWithRp.replaceAll("Rp ", "").replaceAll(".", "");
    final nominal = int.tryParse(numericText);
    final description = descriptionC.text;
    const status = "expense"; 

    final cashflow = {
      'user_id': box.read('user_id'),
      'date': date,
      'nominal': nominal,
      'description': description,
      'status': status, 
    };

    final id = await dbHelper.insertCashflow(cashflow);

    if (id != null) {
      final HomeController homeController = Get.put(HomeController());
      homeController.reInitialize();
      Get.offNamed(Routes.HOME);
      Get.snackbar(
        'Berhasil',
        'Data pengeluaran berhasil disimpan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.primaryColor,
        colorText: Colors.white,
      );
    } else {
      // apabila gagal menyimpan data
      Get.snackbar(
        'Error',
        'Gagal menyimpan data pengeluaran',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.secondary,
        colorText: Colors.white,
      );
    }
  }
}

class AddExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddExpenseController>(
      () => AddExpenseController(),
    );
  }
}
