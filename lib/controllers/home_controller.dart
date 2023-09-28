import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:cash_world/widgets/cashflow.dart';
import 'package:cash_world/database/database_helper.dart';
import 'package:cash_world/utils/extract_month.dart';

class HomeController extends GetxController {
  final dbHelper = DatabaseHelper.instance;
  RxList<CashFlow> cashflows = RxList<CashFlow>();

  // Inisialisasi data totalIncome dan totalExpense
  RxList<FlSpot> incomeSpots = RxList<FlSpot>();
  RxList<FlSpot> expenseSpots = RxList<FlSpot>();

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

  void reInitialize() {
    onInit();
  }

  // Mengisi data totalIncome dan totalExpense dari cashflow
  void fillSpotsFromCashflows(List<CashFlow> cashflows) {
    // Bersihkan list sebelum mengisi ulang
    incomeSpots.clear();
    expenseSpots.clear();

    // Mengelompokkan nilai berdasarkan tanggal
    final incomeMap = <double, double>{};
    final expenseMap = <double, double>{};
    
    for (final cashflow in cashflows) {
      final date = cashflow.date; 
      final nominal = cashflow.nominal.toDouble(); 

      // Tentukan apakah ini income atau expense berdasarkan status
      if (cashflow.status == 'income') {
        if (incomeMap.containsKey(extractMonth(date))) {
          // Apabila tanggal sudah ada, tambahkan nominal ke nilai yang sudah ada
          incomeMap[extractMonth(date)] =
              (incomeMap[extractMonth(date)] ?? 0) + nominal;
        } else {
          // Apabila tanggal belum ada, tambahkan sebagai kunci baru
          incomeMap[extractMonth(date)] = nominal;
        }
      } else if (cashflow.status == 'expense') {
        if (expenseMap.containsKey(extractMonth(date))) {
          // Apabila tanggal sudah ada, tambahkan nominal ke nilai yang sudah ada
          expenseMap[extractMonth(date)] =
              (expenseMap[extractMonth(date)] ?? 0) + nominal;
        } else {
          // Apabila tanggal belum ada, tambahkan sebagai kunci baru
          expenseMap[extractMonth(date)] = nominal;
        }
      }
    }

    // Konversi map menjadi daftar FlSpot
    incomeSpots.addAll(
        incomeMap.entries.map((entry) => FlSpot(entry.key, entry.value)));
    expenseSpots.addAll(
        expenseMap.entries.map((entry) => FlSpot(entry.key, entry.value)));

    print(incomeSpots);
    print(expenseSpots);
  }

  void loadCashflows() async {
    final cashflowList = await dbHelper.getCashflows();
    cashflows.assignAll(cashflowList);

    fillSpotsFromCashflows(cashflowList);
    update();
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}