import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:cash_world/routes/app_pages.dart';
import 'package:cash_world/utils/app_color.dart';
import 'package:cash_world/widgets/custom_input.dart';

import '../controllers/setting_controller.dart';

// ignore: must_be_immutable
class SettingView extends GetView<SettingController> {
  late double mWidth;
  late double mHeight;

  SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height / 1.2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('Pengaturan'),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: mHeight / 7,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 40),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            // Tentang aplikasi
            Image.asset(
              "assets/images/logo.png",
              width: mWidth / 3,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About this app",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text("Aplikasi ini dibuat oleh:"),
                Text("Nama\t\t\t\t : Ichsani Nikken Rahmawati"),
                Text("NIM\t\t\t\t\t\t\t : 2141764011"),
                Text("Tanggal\t: 23 September 2023"),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: mHeight,
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form ganti password
              const Text(
                'Ganti Password',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => CustomInput(
                  controller: controller.passC,
                  label: "Password Saat Ini",
                  hint: "Masukkan password anda saat ini",
                  obsecureText: controller.obsecureText.value,
                  suffixIcon: IconButton(
                    icon: (controller.obsecureText != false)
                        ? SvgPicture.asset('assets/icons/show.svg')
                        : SvgPicture.asset('assets/icons/hide.svg'),
                    onPressed: () {
                      controller.obsecureText.value =
                          !(controller.obsecureText.value);
                    },
                  ),
                ),
              ),
              Obx(
                () => CustomInput(
                  controller: controller.passNewC,
                  label: "Password Baru",
                  hint: "Masukkan password baru anda",
                  obsecureText: controller.obsecureTextNew.value,
                  suffixIcon: IconButton(
                    icon: (controller.obsecureTextNew != false)
                        ? SvgPicture.asset('assets/icons/show.svg')
                        : SvgPicture.asset('assets/icons/hide.svg'),
                    onPressed: () {
                      controller.obsecureTextNew.value =
                          !(controller.obsecureTextNew.value);
                    },
                  ),
                ),
              ),
              Obx(
                () => Container(
                  // Tombol simpan
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.changePassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      primary: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      (controller.isLoading.isFalse) ? 'Simpan' : 'Loading...',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                // Tombol kembali
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    primary: AppColor.dark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Kembali',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                // Tombol logout
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    primary: AppColor.outRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
