import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails{
  late String uid;
  late String name;
  late String email;
  late String username;
  UserDetails(this.uid);
  Future<void> fetchUserDetails()async{
    try {
      DocumentSnapshot userDoc= await FirebaseFirestore.instance.collection('Users').doc(uid).get() as DocumentSnapshot<Object?>;
      if(userDoc.exists){
        name= userDoc['name'];
        email= userDoc['email'];
        username= userDoc['username'];
      }
      else{
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch user details: $e');
    }
  }
}