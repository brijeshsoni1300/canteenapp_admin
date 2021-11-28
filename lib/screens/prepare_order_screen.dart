import 'package:canteenapp_admin/components/active_order_card.dart';
import 'package:canteenapp_admin/components/menu_item_card.dart';
import 'package:canteenapp_admin/controllers/active_order_controller.dart';
import 'package:canteenapp_admin/controllers/cart_controller.dart';
import 'package:canteenapp_admin/screens/menu_screen.dart';
import 'package:canteenapp_admin/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrepareOrder extends StatelessWidget {
  const PrepareOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ActiveOrderController activeOrderController = Get.find();
    print("activeordercontroller: ${activeOrderController}");
    return Container(
        child: Obx(() => ListView.builder(
            itemCount: activeOrderController.listOfOrderList.value.length,
            itemBuilder: (context, index) {
              return activeOrderController.listOfOrderList[index].status ==
                      'PAID'
                  ? HistoryCard(
                      data:
                          activeOrderController.listOfOrderList[index].toJson())
                  : Container();
            })));
  }
}

class HistoryCard extends StatelessWidget {
  Map<String, dynamic>? data;

  HistoryCard({Key? key, Map<String, dynamic>? this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseService dbs = DatabaseService();
    Size size = MediaQuery.of(context).size;

    List<Widget> printItem() {
      var list = <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Item",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Text(
              "Quantity",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        )
      ];
      for (var item in data!["items"]) {
        list.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${item["item_name"]}"),
            Text("${item["quantity"]} "),
          ],
        ));
      }
      return list;
    }

    print("data: ${data.toString()}");
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
        child: Container(
          child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "${data!["user_name"]}",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Text(
                            "${data!["order_id"]}",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          )
                        ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: printItem(),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            //TODO: ACCEPT ORDER
                            dbs.orderIsPrepared(data!["order_id"]);
                            dbs.sendPushMessage(data!["fcmtoken"]);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Order mill Prepared",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.thumb_up)
                            ],
                          ),
                        ),
                      )),
                ],
              )),
        ));
  }
}
