import 'package:canteenapp_admin/models/order_model.dart';
import 'package:canteenapp_admin/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ActiveOrderController extends GetxController {
  var listOfOrderList = <OrderList>[].obs;
  DatabaseService dbs = DatabaseService();

  void onInit() {
    listOfOrderList.bindStream(dbs.listOfOrderList);
    debugPrint(" listOfOrderList: ${listOfOrderList.value}");
    super.onInit();
  }
}