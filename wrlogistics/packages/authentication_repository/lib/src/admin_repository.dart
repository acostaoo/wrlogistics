import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRepository {
  final CollectionReference _adminCollection =
      FirebaseFirestore.instance.collection('Admins');

  Future<bool> isAdmin(String uid) async {
    try {
      final querySnapshot =
          await _adminCollection.where('uid', isEqualTo: uid).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {print(error);
      return false;
    }
  }
}