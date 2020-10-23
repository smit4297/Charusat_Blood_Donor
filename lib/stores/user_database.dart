import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charusat_blood_donor/models/user_model.dart';

class UserDatabase {
  final String uid;
  UserDatabase({this.uid});

  final firestoreInstance = Firestore.instance;

  Future setUserData(String name, String gender, String email, String birthDate,
      String bloodGroup, String city, String disease, String token) async {
    return await firestoreInstance
        .collection("users")
        .document(uid)
        .updateData({
      "name": name,
      "birthDate": birthDate,
      "email": email,
      "bloodGroup": bloodGroup,
      "city": city,
      "disease": disease,
      "token": token,
    });
  }

  //Users list from snapshot
  List<User> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
          name: doc.data['name'] ?? '',
          bloodGroup: doc.data['bloodGroup'] ?? '',
          email: doc.data['email'] ?? '',
          city: doc.data['city'] ?? '',
          disease: doc.data['disease'] ?? '',
          token: doc.data['token'] ?? '',
          birthDate: doc.data['birthDate'] ?? '');
    }).toList();
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        uid: uid,
        name: snapshot.data['name'],
        birthDate: snapshot.data['birthDate'],
        email: snapshot.data['email'],
        bloodGroup: snapshot.data['bloodGroup'],
        city: snapshot.data['city'],
        token: snapshot.data['token'],
        disease: snapshot.data['disease']);
  }

  //get Users List stream
  Stream<List<User>> get users {
    return firestoreInstance
        .collection("users")
        .snapshots()
        .map(_usersListFromSnapshot);
  }

  // get user doc stream
  Stream<User> get userData {
    return firestoreInstance
        .collection("users")
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
