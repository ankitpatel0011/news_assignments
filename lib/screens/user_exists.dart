import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkUserExists(String uid) async {
  bool userExists = false;

  try {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    userExists = userSnapshot.exists;
  } catch (e) {
    print('Error checking user existence: $e');
  }

  return userExists;
}