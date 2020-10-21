import 'package:ecommerce/screens/AddProduct.dart';
import 'package:ecommerce/screens/EditProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
class AdminHome extends StatefulWidget {
  static String route="AdminHomeScreen";
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(KmainColor),
        title: Text('Admin Panel',style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          color: Color(KsecondaryColor),
        ),),
      ),
      backgroundColor: Color(KsecondaryColor),
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                  child:Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(KmainColor),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/images/admin/add.ico'),
                        ),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, AddProduct.route);
                  },
                ),
            ),
           Expanded(
             child: GestureDetector(
               child:Padding(
                 padding: const EdgeInsets.all(20),
                 child: Container(
                   width: MediaQuery.of(context).size.width,
                   decoration: BoxDecoration(
                     color: Color(KmainColor),
                     borderRadius: BorderRadius.circular(20),
                     image: DecorationImage(
                       image: AssetImage('assets/images/admin/edit1.png',),
                       fit: BoxFit.fill
                     ),
                   ),
                 ),
               ),
               onTap: (){
                 Navigator.pushNamed(context, EditProductScreen.route);
               },
             ),
           ),
          ],
        ),
      ),
    );
  }
}
