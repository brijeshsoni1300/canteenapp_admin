import 'dart:convert';

import 'package:canteenapp_admin/models/fooditem_model.dart';
import 'package:canteenapp_admin/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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


  /////for sending message to user

  Future<void> sendPushMessage(String _token) async {


    var headers = {
      'Authorization': 'key =AAAAZvXYWMs:APA91bHFTVKVpnWc1WrmXR5GvGAEQoQuj_klqiGcANHXv45p481j2TiLJ-i3JRazkK3y3NbhvuGFw1YG5imQqT2qTHm4P7mUQku07xVXLgGR8pDIa2VwVFdSVZ5WpbUK2W97ci0RDK-G',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "to": _token,
      "notification": {
        "title": "Order is ready",
        "body": "Pick up your order from canteen"
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }






    // print("send push message is called");
    //
    // _token = "cylqSvoxR6m2PjTxnrWdVy:APA91bGwcLkmB7imUrG0lFiTNBIIQPiihQwAGeGbiAamL-tJX8p9z0QP6Y-a9aXJXrrLwR-NSKJacoIHs5E03-ZSAWwMeZdW98QsTfk75_DTQjliZF1viaOMLqMM_WY7MSn83E3LPDdE";
    //
    // if (_token == null) {
    //   print('Unable to send FCM message, no token exists.');
    //   return;
    // }
    //
    // try {
    //   await http.post(
    //     Uri.parse('https://api.rnfirebase.io/messaging/send'),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: constructFCMPayload(_token),
    //   );
    //   print('FCM request for device sent!');
    // } catch (e) {
    //   print(e);
    // }
  }

  String constructFCMPayload(String? token) {

    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#test) was created via FCM! your order is ready',
      },
    });
  }

  // test kartik's msg
  //start

//end



}
