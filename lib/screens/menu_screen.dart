import 'package:canteenapp_admin/components/menu_item_card.dart';
import 'package:canteenapp_admin/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Container(
      child: Column(
        children: [
          Obx(
            () => ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: cartController.cartItems.value.length,
                itemBuilder: (context, index) {
                  return cartController.cartItems[index].quantity != 0
                      ? MenuItem(data: cartController.cartItems[index].toJson())
                      : Container();
                }),
          ),
        ],
      ),
    );
  }
}