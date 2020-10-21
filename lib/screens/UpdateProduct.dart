import 'package:ecommerce/components/textFeild.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class UpdateProduct extends StatefulWidget {
  static String route="UpdateProductScreen";
  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  GlobalKey<FormState> _formState=GlobalKey<FormState>();
  String _name,_price,_category,_description,_imgLocation;
  Store _store=Store();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return  Scaffold(
      backgroundColor: Color(KsecondaryColor),
      body: Form(
        key: _formState,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(hint: "Product Name",onClick: (val){
                _name=val;
              },),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(hint: "Product Price",onClick: (val){
                _price=val;
              },),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(hint: "Product Description",onClick: (val){
                _description=val;
              },),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(hint: "Product Image Location",onClick: (val){
                _imgLocation=val;
              },),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(hint: "Product Category",onClick: (val){
                _category=val;
              },),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height*.09,
                  child: Center(child: Text('Update',style: TextStyle(
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
                    _store.updateProduct(product.productId, ({
                      pName:_name,
                      pPrice:_price,
                      pCategory:_category,
                      pDescription:_description,
                      pImgLocation:_imgLocation
                    }));
                    Navigator.pop(context);
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
