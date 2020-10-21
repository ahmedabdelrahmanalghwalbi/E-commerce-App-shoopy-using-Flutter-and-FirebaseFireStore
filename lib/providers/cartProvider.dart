import 'package:ecommerce/models/productModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CounterProvider extends InheritedWidget{
  List<Product> cartProducts=[];
  Widget child;
  CounterProvider({this.child});
  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return !listEquals(oldWidget.cartProducts, cartProducts);
  }
  static CounterProvider of(BuildContext context)=>context.dependOnInheritedWidgetOfExactType();

}