import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:firebase_core/firebase_core.dart';

class Store{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  addProduct(Product product){
    _firestore.collection(KcollectionPath).add({
      pName:product.name,
      pPrice:product.price,
      pDescription:product.description,
      pCategory:product.category,
      pImgLocation:product.imgLocation,
    });
  }
  Stream<QuerySnapshot> loadProducts(){
    return _firestore.collection(KcollectionPath).snapshots();
  }
  deleteProduct(productId){
    _firestore.collection(KcollectionPath).doc(productId).delete();
  }
  updateProduct(productId,data){
    _firestore.collection(KcollectionPath).doc(productId).update(data);
  }
}