import 'package:canteenapp_admin/models/order_model.dart';
import 'package:canteenapp_admin/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ActiveOrderController extends GetxController {
  var listOfOrderList = <Order>[].obs;
  DatabaseService dbs = DatabaseService();

  void onInit() {
    listOfOrderList.bindStream(dbs.getActiveOrders());
    debugPrint(" listOfOrderList: ${listOfOrderList.value}");
    super.onInit();
  }
}