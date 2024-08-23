import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? username;
  final String? email;
  final String? id;

  UserModel({
    this.username,
    this.email,
    this.id,
  });

  static UserModel fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      username: snapshot['username'],
      email: snapshot['email'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      //"id": id,
    };
  }
}

class Utils {
  static Future<DocumentSnapshot> fetchUserData(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('users').doc(userId);
    final docSnap = await docRef.get();
    return docSnap;
  }
}
