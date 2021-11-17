import 'package:canteenapp_admin/models/fooditem_model.dart';
import 'package:canteenapp_admin/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final CollectionReference food_items =
      FirebaseFirestore.instance.collection('food_items');

  //stream for menu item START
  Stream<List<FoodItem>> get menuItemsList {
    return food_items.snapshots().map(_menuitemListFromSnapshot);
  }

  List<FoodItem> _menuitemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      print("doc: $doc");
      FoodItem fi = FoodItem(
        imgUrl: doc['imgUrl'],
        itemName: doc['item_name'],
        itemPrice: doc['item_price'],
        quantity: 0,
        isAvail: doc['is_avail'],
        id: doc.id,
      );
      return fi;
    }).toList();
  }

  //stream for menu item END

  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  //Stream for active orders START

  Stream<List<OrderList>> get listOfOrderList {
    return orders.snapshots().map(_ListofOrderListFromSnapshot);
  }

  List<OrderList> _ListofOrderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      CollectionReference colRef = FirebaseFirestore.instance
          .collection('/orders/${doc.id}/active_orders');
      Future<QuerySnapshot> orderOfUser = FirebaseFirestore.instance
          .collection('/orders/${doc.id}/active_orders')
          .get()
          ;
     Future< List<Order>> orderlist =  orderOfUser.then((value) {
        debugPrint("value: ${value.docs.map((e) => e.data())}");
        return value.docs.map((doc) {
          Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
          Order or = Order.fromJson(map);
          return or;
        }).toList();
      }) ;
      // List<Order> orlist = colRef.parameters

      OrderList orderList = OrderList(
        userName: doc['user_name'],
        order: orderlist,
      );
      debugPrint("orderList: ${orderList.toString()}");
      return orderList;
    }).toList();
  }

  //Stream for active orders END

  Future<void> updateAvailability(FoodItem item) {
    if (item.isAvail!) {
      return food_items.doc(item.id).update({"is_avail": false});
    } else {
      return food_items.doc(item.id).update({"is_avail": true});
    }
  }
}
