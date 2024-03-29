import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cash_world/widgets/cash_flow_widget.dart';
import 'package:cash_world/utils/app_color.dart';

import '../controllers/detail_cash_flow_controller.dart';

// ignore: must_be_immutable
class DetailCashFlowView extends GetView<DetailCashFlowController> {
  late double mWidth;
  late double mHeight;

  DetailCashFlowView({super.key});
  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height / 1.2;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: const Text('Detail Cash Flow'),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () async {
              Get.back();
            },
            child: const Text(
              'Kembali',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              elevation: 0,
              primary: AppColor.dark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: mHeight,
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.cashflows.length >
                          0) // Pengecekan apabila cashflows tidak kosong
                        ...controller.cashflows.map((cashflow) {
                          if (cashflow.status == "income") {
                            // Menampilkan hanya status income
                            return CashFlowWidget(
                              status_income: true,
                              nominal: cashflow.nominal,
                              description: cashflow.description,
                              date: cashflow.date,
                            );
                          } else if (cashflow.status == "expense") {
                            // Menampilkan hanya status expense
                            return CashFlowWidget(
                              status_income: false,
                              nominal: cashflow.nominal,
                              description: cashflow.description,
                              date: cashflow.date,
                            );
                          }
                          return Container(); 
                        }).toList()
                      else
                      // Tampilan apabila cashflows kosong
                        Container(
                          child: const Center(
                            child: Text('Data Cashflow masih kosong'),
                          ),
                        ), 
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
