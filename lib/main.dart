import 'package:ecommerce/providers/cartProvider.dart';
import 'package:ecommerce/providers/modelHudProvider.dart';
import 'package:ecommerce/screens/AddProduct.dart';
import 'package:ecommerce/screens/AdminHome.dart';
import 'package:ecommerce/screens/EditProduct.dart';
import 'package:ecommerce/screens/Home.dart';
import 'package:ecommerce/screens/Login.dart';
import 'package:ecommerce/screens/ProductInfo.dart';
import 'package:ecommerce/screens/ShoppingCart.dart';
import 'package:ecommerce/screens/SignUp.dart';
import 'package:ecommerce/screens/UpdateProduct.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
bool USE_FIRESTORE_EMULATOR = false;
Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  return runApp(CounterProvider(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-Commerce",
      initialRoute: Login.route,
      routes: {
        Login.route:(context)=>ChangeNotifierProvider(create: (context)=>ModelHud(),child: Login(),),
        SignUp.route:(context)=>ChangeNotifierProvider(create:(context)=>ModelHud(), child:SignUp()),
        Home.route:(context)=>Home(),
        AdminHome.route:(context)=>AdminHome(),
        AddProduct.route:(context)=>AddProduct(),
        EditProductScreen.route:(context)=>EditProductScreen(),
        UpdateProduct.route:(context)=>UpdateProduct(),
        ProductInfo.route:(context)=>ProductInfo(),
        ShoppingCard.route:(context)=>ShoppingCard(),
      },
    ),
  ));
}
