import 'package:ecommerce/components/textFeild.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/services/store.dart';

class AddProduct extends StatefulWidget {
  static String route="AddProductScreen";
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> _formState=GlobalKey<FormState>();
  String _name,_price,_category,_description,_imgLocation;
  Store _store=Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(KsecondaryColor),
      body: Form(
        key: _formState,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                      'Add Product',
                    style: TextStyle(
                      color: Color(KmainColor),
                      fontSize: 40,
                      fontWeight:FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.add_circle,color: Color(KmainColor),size: 40,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(hint: "Product Name",onClick: (val){
                _name=val;
              },),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(hint: "Product Price",onClick: (val){
                _price=val;
              },),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(hint: "Product Description",onClick: (val){
                _description=val;
              },),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(hint: "Product Image Location",onClick: (val){
                _imgLocation=val;
              },),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(hint: "Product Category",onClick: (val){
                _category=val;
              },),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30,left: 120,right: 120),
              child: GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height*.09,
                  child: Center(child: Text('Add',style: TextStyle(
                    color: Color(KsecondaryColor),
                    fontSize: 30,
                    fontStyle: FontStyle.italic
                  ),)),
                  decoration: BoxDecoration(
                    color: Color(KmainColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onTap: (){
                  if(_formState.currentState.validate()){
                    _formState.currentState.save();
                    _store.addProduct(Product(
                      name: _name,
                      price: _price,
                      description: _description,
                      category:_category,
                      imgLocation: _imgLocation
                    ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
