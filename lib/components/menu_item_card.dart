import 'package:canteenapp_admin/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatefulWidget {
  Map<String, dynamic>? data;

  MenuItem({Key? key, Map<String, dynamic>? this.data}) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState(data);
}

class _MenuItemState extends State<MenuItem> {
  var data;

  _MenuItemState(data) {
    this.data = data;
  }

  @override
  void initState() {
    print("${data['item_name']} cnt as of now is : ${data['quantity']}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                    color: Colors.amber,
                    height:100,
                    width: 100,
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network("${data["imgUrl"]}"))),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Text("${data["item_name"]}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Color.fromRGBO(62, 68, 98, 1))),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text('Rs. ${data["item_price"]}',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color.fromRGBO(126, 126, 126, 1))),
                            SizedBox(
                              height: 5,
                            ),

                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Align(
                              alignment: Alignment(1.0, 0.4),
                              child: Switch(
                                value: data['is_avail'],
                                onChanged: (val) {
                                  print("val : $val");
                                  data['is_avail'] = val;
                                  cartController.changeAvailability(data);
                                },
                              )
                            // RaisedButton(
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(7),
                            //   ),
                            //   color: Color.fromRGBO(232, 76, 79, 1),
                            //   onPressed: () {
                            //     setState(() {
                            //
                            //
                            //       // cnt += 1;
                            //       // data["quantity"] = cnt;
                            //       // print("${data['item_name']} cnt as of now is : ${data['quantity']}");
                            //       // // print("cnt of ${data['item_name']}: $cnt" );
                            //       //   data["quantity"] = cnt;
                            //       //   cartController.increament(data);
                            //
                            //     });
                            //   },
                            //   child: Text(
                            //     "+  Add",
                            //     style: TextStyle(
                            //         color: Colors.white, fontSize: 18),
                            //   ),
                            // ),
                          ),
                        )
                      ],
                    ))
              ],
            )));
  }
}
