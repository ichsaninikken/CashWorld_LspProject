import 'package:get/get.dart';
import 'package:cash_world/widgets/cashflow.dart';
import 'package:cash_world/database/database_helper.dart';

class DetailCashFlowController extends GetxController {
  final dbHelper = DatabaseHelper.instance;
  RxList<CashFlow> cashflows = RxList<CashFlow>();

  @override
  void onInit() {
    super.onInit();
    loadCashflows();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadCashflows() async {
    final cashflowList = await dbHelper.getCashflows();
    cashflows.assignAll(cashflowList);
  }
}

class DetailCashFlowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCashFlowController>(
      () => DetailCashFlowController(),
    );
  }
}