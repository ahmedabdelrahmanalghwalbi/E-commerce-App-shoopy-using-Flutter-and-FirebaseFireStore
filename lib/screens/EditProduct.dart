
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'UpdateProduct.dart';
class EditProductScreen extends StatefulWidget {
  static String route = 'EditProductScreen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  Store _store=Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(KmainColor),
        title: Text('All Products',style: TextStyle(
          color: Color(KsecondaryColor),
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic
        ),),
      ),
      backgroundColor: Color(KsecondaryColor),
      body: StreamBuilder(
            stream: _store.loadProducts(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                List<Product> products=[];
                snapshot.data.documents.map((document) => products.add(Product(
                    price: document.get(pPrice),
                    name: document.get(pName),
                    category: document.get(pCategory),
                    imgLocation: document.get(pImgLocation),
                    description: document.get(pDescription),
                    productId: document.documentID,
                ))).toList();

                    return GridView.builder(
                      itemCount: products.length,
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .8,
                        ),
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: GridTile(
                               child: Container(
                                 child: GestureDetector(
                                   onTapUp: (tetails){
                                     double dx=tetails.globalPosition.dx;
                                     double dy=tetails.globalPosition.dy;
                                     showMenu(context: context,
                                         position: RelativeRect.fromLTRB(dx, dy, MediaQuery.of(context).size.width - dx, MediaQuery.of(context).size.height - dy),
                                         items: [
                                           PopupMenuItem(
                                             child: RaisedButton(
                                               child: Text("Update"),
                                               onPressed: (){
                                                 Navigator.pushNamed(context, UpdateProduct.route,arguments: products[index]);
                                               },
                                             ),
                                           ),
                                           PopupMenuItem(
                                             child:RaisedButton(
                                               child: Text('Delete'),
                                               onPressed: (){
                                                 _store.deleteProduct(products[index].productId);
                                               },
                                             ),
                                           ),
                                         ]
                                     );
                                   },
                                   child: Stack(
                                     children: <Widget>[
                                       Positioned.fill(
                                         child: Image(
                                           image:AssetImage(products[index].imgLocation),
                                           fit: BoxFit.fill,
                                         ),
                                       ),
                                       Positioned(
                                         bottom: 0,
                                         child: Opacity(
                                           opacity: .9,
                                           child: Container(
                                             width: MediaQuery.of(context).size.width,
                                             height: MediaQuery.of(context).size.height*0.1,
                                             color: Color(KmainColor),
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: <Widget>[
                                                 Row(
                                                   children: <Widget>[
                                                     Padding(
                                                       padding: const EdgeInsets.all(3.0),
                                                       child: Text('${products[index].name}',style:TextStyle(
                                                         color: Color(KsecondaryColor),
                                                         fontWeight: FontWeight.bold,
                                                         fontSize: 20,
                                                       ),),
                                                     ),
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 15),
                                                       child: Text('${products[index].price}',style:TextStyle(
                                                           color: Colors.red,
                                                         fontWeight: FontWeight.bold,
                                                         fontSize:20 ,
                                                     ),),
                                                     ),
                                                   ],
                                                 ),
                                                 Padding(
                                                   padding: const EdgeInsets.only(top: 3,left: 3),
                                                   child: Text('${products[index].category}',style:TextStyle(
                                                     color: Colors.black,
                                                     fontWeight: FontWeight.bold,
                                                     fontSize: 20,
                                                   ),),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                            ),
                          );
                  },
                );
              }else{
               return Center(child: CircularProgressIndicator());
              }
            },
      ),
    );
  }
}
