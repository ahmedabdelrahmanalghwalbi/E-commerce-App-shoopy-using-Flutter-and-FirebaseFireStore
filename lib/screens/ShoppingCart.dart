import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/providers/cartProvider.dart';
import 'package:ecommerce/screens/ProductInfo.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ShoppingCard extends StatefulWidget {
  static String route="ShoppingCardScreen";
  @override
  _ShoppingCardState createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {
  @override
  Widget build(BuildContext context) {
    List<Product>products=CounterProvider.of(context).cartProducts;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Icon(Icons.person_outline,color: Color(KsecondaryColor),),
        ],
        centerTitle: true,
        title: Text('My Cart',style: TextStyle(
          color: Color(KsecondaryColor),
        ),),
        backgroundColor: Color(KmainColor),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Color(KsecondaryColor),),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
          itemCount: products.length,
        itemBuilder: (context,index){
            var totalPrice=int.parse(products[index].price) *products[index].counter;
            return GestureDetector(
              onTapUp: (tetails){
                double dx=tetails.globalPosition.dx;
                double dy=tetails.globalPosition.dy;
                showMenu(context: context,
                    position: RelativeRect.fromLTRB(dx, dy, MediaQuery.of(context).size.width - dx, MediaQuery.of(context).size.height - dy),
                    items: [
                      PopupMenuItem(
                        child: RaisedButton(
                          child: Text("Edit"),
                          onPressed: (){
                            Navigator.pushNamed(context, ProductInfo.route,arguments: products[index]);
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child:RaisedButton(
                          child: Text('Delete'),
                          onPressed: (){
                            setState(() {
                              products.remove(products[index]);
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ]
                );
              },
              child: Card(
                child: ListTile(
                  title: Text('${products[index].name}'),
                  subtitle:Text('${products[index].description}'),
                  leading: CircleAvatar(
                    child:Image.asset(products[index].imgLocation),
                  ),
                  trailing: Text('total price : ${totalPrice.toString()}'),
                ),
              ),
            );
        },
      ),
    );
  }
}
