import 'package:canteenapp_admin/components/active_order_card.dart';
import 'package:canteenapp_admin/components/menu_item_card.dart';
import 'package:canteenapp_admin/controllers/active_order_controller.dart';
import 'package:canteenapp_admin/controllers/cart_controller.dart';
import 'package:canteenapp_admin/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveOrder extends StatelessWidget {
  const ActiveOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ActiveOrderController activeOrderController = Get.find();
    print("ActiveOrderController: ${activeOrderController.listOfOrderList.value}");
    return  Container(
        child: Column(
          children: [
            Obx(() => ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: activeOrderController.listOfOrderList.value.length,
                itemBuilder: (context, index) {
                  return
                      ActiveOrderCard(data: activeOrderController.listOfOrderList[index].toJson());
                })),
          ],
        ),
    );
  }
}
