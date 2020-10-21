import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/screens/ShoppingCart.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/providers/cartProvider.dart';
class ProductInfo extends StatefulWidget {
  static String route="ProductInfoScreen";
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _counter=1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute
        .of(context)
        .settings
        .arguments;
    List<Product> cartProducts=CounterProvider.of(context).cartProducts;
    return Hero(
      tag: product.productId,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(KmainColor),
          actions: <Widget>[
            IconButton(
              onPressed: (){
                Navigator.pushNamed(context, ShoppingCard.route);
              },
              icon: Icon(Icons.shopping_cart, color: Color(KsecondaryColor),),
              tooltip: 'Add to cart',
            ),
          ],
          title: Text("Product Data", style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
          ),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(KsecondaryColor),),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(product.imgLocation),
                        fit: BoxFit.fill,
                      )
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Color(KmainColor).withOpacity(.2),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*.4,
                    decoration: BoxDecoration(
                      color: Color(KmainColor).withOpacity(.7),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${product.name}',style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text('${product.price} \$',style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text('${product.description}',style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left:50,right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.add,color: Color(KsecondaryColor),size: 40,),
                                onPressed: (){
                                  if(_counter<10){
                                    setState(() {
                                      _counter++;
                                    });
                                  }
                                },
                              ),
                              CircleAvatar(
                                backgroundColor: Color(KsecondaryColor),
                                radius: 30,
                                child: Text('${_counter}',style: TextStyle(
                                    fontSize: 30,
                                    color: Color(KmainColor),
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                              IconButton(
                                icon: Icon(Icons.remove ,color: Color(KsecondaryColor),size: 40,),
                                onPressed: (){
                                  if(_counter>0){
                                    setState(() {
                                      _counter--;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child:Builder(
                    builder: (BuildContext context){
                      BuildContext rootContext = context;
                      return GestureDetector(
                        onTap: (){
                            product.counter=_counter;
                            cartProducts.add(product);
                          Scaffold.of(rootContext).showSnackBar(SnackBar(
                            content: Text('ADDED TO CART'),
                          ));
                          print(cartProducts.length);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*.09,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.9),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('ADD TO CART',style: TextStyle(
                                  fontSize: 30,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Color(KmainColor)
                              ),),
                              Icon(Icons.add_shopping_cart,color: Color(KmainColor),size: 35,),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      ),
    );
  }
}