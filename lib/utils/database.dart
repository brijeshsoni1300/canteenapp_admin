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

  final CollectionReference active_orders =
      FirebaseFirestore.instance.collection('active_orders');

  //Stream for active orders START
  Stream<List<Order>> getActiveOrders(){
    return active_orders.snapshots().map(_listOfActiveOrderOfUser);
  }

  List<Order> _listOfActiveOrderOfUser(QuerySnapshot snapshot){
    return snapshot.docs.map((e) {
      Map<String, dynamic> map = e.data() as Map<String, dynamic>;
      Order or = Order.fromJson(map);
      return or;
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

   acceptOrder(String id){
       active_orders.doc(id).update({"status" : "REQ_ACCEPTED"});
  }


  rejectOrder(String id){
    active_orders.doc(id).update({"status" : "CANCELLED"});
  }

  orderIsPrepared(String id){
    active_orders.doc(id).update({"status": "READY"});
  }

  orderIsDelivered(String id){
    active_orders.doc(id).update({"status": "DELIVERED"});
  }

}
