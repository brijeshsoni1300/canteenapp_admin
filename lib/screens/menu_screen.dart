import 'package:canteenapp_admin/components/menu_item_card.dart';
import 'package:canteenapp_admin/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print("inside menuscreen::");
    final CartController cartController = Get.find();

    List<Widget> MenuItemBuilder(){
      var list = <Widget>[];
      for (var item in cartController.cartItems.value) {
        list.add(MenuItem(data: item.toJson()));
      }
      return list;
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.redAccent,
        title: Center(
        child:Text(
          "Canteen",
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: Color.fromRGBO(62, 68, 98, 1),
          ),textAlign: TextAlign.left,
        ),      ),),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Obx (()=>ListView(
              children: MenuItemBuilder(),
            ),),
      )

    );
  }
}




