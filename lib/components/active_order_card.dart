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

  _ActiveOrderCardState(data) {
    this.data = data;
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
