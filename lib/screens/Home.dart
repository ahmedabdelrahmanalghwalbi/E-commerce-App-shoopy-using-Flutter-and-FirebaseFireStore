import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/screens/ProductInfo.dart';
import 'package:ecommerce/screens/ShoppingCart.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String route="HomeScreen";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _tabIndex=0;
  Store _store=Store();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, ShoppingCard.route);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart,size: 30,color: Color(KsecondaryColor),),
              ),
            ),
          ],
          automaticallyImplyLeading: false,
          title: Text("PRODUCTS",style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(KsecondaryColor),
          ),),
          backgroundColor: Color(KmainColor),
          bottom: TabBar(
            indicatorWeight: 5,
            onTap: (val){
              setState(() {
                _tabIndex=val;
              });
            },
            labelColor: Color(KsecondaryColor),
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(KsecondaryColor),
              fontStyle: FontStyle.italic,
            ),
            indicatorColor: Color(KsecondaryColor),
            tabs: <Widget>[
              Text('Jackets'),
              Text('Mobiles'),
              Text('Shirts'),
              Text('Tvs'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            getProducatsWithCategory('jackets'),
            getProducatsWithCategory('mobiles'),
            getProducatsWithCategory('shirts'),
            getProducatsWithCategory('tvs'),
          ],
        ),
      ),
    );
  }

  Widget getProducatsWithCategory(String category) {
    return StreamBuilder(
      stream: _store.loadProducts(),
      builder: (context,snapshot){
        if(snapshot.hasData ){
          List<Product> products=[];
          snapshot.data.documents.map((document){
            if(document[pCategory]==category){
             return products.add(Product(
                price: document.get(pPrice),
                name: document.get(pName),
                category: document.get(pCategory),
                imgLocation: document.get(pImgLocation),
                description: document.get(pDescription),
                productId: document.documentID,
              ));
            }
          }).toList();
          return  GridView.builder(
            itemCount: products.length,
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context,index){
                return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: GridTile(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, ProductInfo.route,arguments: products[index]);
                      },
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Hero(
                                tag: products[index].productId,
                                child: Image(
                                  image:AssetImage(products[index].imgLocation),
                                  fit: BoxFit.fill,
                                ),
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
                                            padding: const EdgeInsets.only(left: 5,top: 5),
                                            child: Text('${products[index].name}',style:TextStyle(
                                                color: Color(KsecondaryColor),
                                                fontWeight: FontWeight.bold,
                                              fontSize: 20
                                            ),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20,top: 5),
                                            child: Text('${products[index].price}',style:TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5,top: 5),
                                            child: Text('${products[index].category}',style:TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20,top: 5),
                                            child: Text('${products[index].description}',style:TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              fontSize: 16
                                            ),),
                                          ),
                                        ],
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
    );
  }
}
