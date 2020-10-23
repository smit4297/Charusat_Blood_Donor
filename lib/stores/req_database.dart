import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charusat_blood_donor/models/request_model.dart';
import 'package:flutter/material.dart';

class ReqDatabase{

  final firestoreInstance = Firestore.instance;

  Future addRequest(String reqNo,String bloodGrp, String quantity, String isUrgent, String currentDate, String currentTime) async{
    return await firestoreInstance.collection("requests").document().setData(
        {
          "reqNo" : reqNo,
          "bloodGrp" : bloodGrp,
          "quantity" : quantity ,
          "isUrgent" : isUrgent,
          "currentDate": currentDate,
          "currentTime": currentTime,
        },merge: true,);
  }

  //Users list from snapshot
  List<RequestModel> _requestsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return RequestModel(
          reqNo: doc.data['reqNo'],
          bloodGrp: doc.data['bloodGrp'] ?? 'A+ve',
          quantity: doc.data['quantity'] ?? '1',
          isUrgent: doc.data['isUrgent'] ?? 'No',
          currentDate: doc.data['currentDate'] ?? DateTime.now().toString(),
          currentTime: doc.data['currentTime'] ?? TimeOfDay.now().toString(),
      );
    }).toList();
  }

  //get requests List stream
  Stream<List<RequestModel>> get requests {
    return firestoreInstance.collection("requests").snapshots()
        .map(_requestsListFromSnapshot);
  }

  Future<int> countDocuments() async {
    QuerySnapshot _myDoc = await Firestore.instance.collection('requests').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    //print(_myDocCount.length);  // Count of Documents in Collection
    return _myDocCount.length;
  }
}