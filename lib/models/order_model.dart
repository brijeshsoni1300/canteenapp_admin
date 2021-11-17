import 'package:cloud_firestore/cloud_firestore.dart';


class OrderList {
  String? userName;
  List<Order>? order;

  OrderList({this.userName, this.order});

  OrderList.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    if (json['Order'] != null) {
      order =  <Order>[];
      json['Order'].forEach((v) {
        order!.add( Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    if (this.order != null) {
      data['Order'] = this.order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  List<Item>? items;
  Timestamp? timestamp;
  String? status;

  Order({this.items, this.timestamp, this.status});

  Order.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(new Item.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    // print("items: [${items.toString()}],status: $status");
    return "items: [${items.toString()}],status: $status";
  }
}

class Item {
  String? itemName;
  int? quantity;

  Item({this.itemName, this.quantity});

  Item.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['quantity'] = this.quantity;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    // print("{item_name:${itemName},quantity: $quantity}");
    return "{item_name:${itemName},quantity: $quantity}";
  }
}
