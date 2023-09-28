import 'package:get/get.dart';
import 'package:cash_world/controllers/expense_controller.dart';
import '../../page/expense_page.dart';
import 'package:cash_world/controllers/income_controller.dart';
import '../../page/income_page.dart';
import 'package:cash_world/controllers/detail_cash_flow_controller.dart';
import '../../page/detail_cash_flow_page.dart';
import 'package:cash_world/controllers/home_controller.dart';
import '../../page/home_page.dart';
import 'package:cash_world/controllers/login_controller.dart';
import '../../page/login_page.dart';
import 'package:cash_world/controllers/setting_controller.dart';
import '../../page/setting_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_INCOME,
      page: () => AddIncomeView(),
      binding: AddIncomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EXPENSE,
      page: () => AddExpenseView(),
      binding: AddExpenseBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_CASH_FLOW,
      page: () => DetailCashFlowView(),
      binding: DetailCashFlowBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
  ];
}
