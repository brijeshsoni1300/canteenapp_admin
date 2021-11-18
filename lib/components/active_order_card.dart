import 'package:canteenapp_admin/models/order_model.dart';
import 'package:flutter/material.dart';

class ActiveOrderCard extends StatefulWidget {
  Map<String, dynamic>? data;

  ActiveOrderCard({Key? key, Map<String, dynamic>? this.data})
      : super(key: key);

  @override
  _ActiveOrderCardState createState() => _ActiveOrderCardState(data);
}

class _ActiveOrderCardState extends State<ActiveOrderCard> {
  var data;
  Order? order;

  _ActiveOrderCardState(data) {
    this.data = data;
    order = Order.fromJson(data as Map<String, dynamic>);
    print("type of data['item']is: ${data['items'].runtimeType}");
    print("order: ${order}");
    print("data: ${data.toString()}");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Text("Name: ${data['user_name']}"),
             SizedBox(
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data['items'].length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Text("${data['items'][index]['item_name']}"),
                      );
                    }),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Accept Order"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Reject Order"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
