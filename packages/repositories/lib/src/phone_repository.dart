import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PhoneRepository{
  //diseño del json, se crea el documento nombrado
  //como la id del usuario, el documento contiene número de teléfono. 

  final FakeFirebaseFirestore _firestore = FakeFirebaseFirestore();

  Future<void> storePhoneNumber({required String phoneNumber, required String uid}) async {
    try {
      await _firestore.collection('phones').doc(uid).set({
        'phoneNumber': phoneNumber,
      });
    } catch (_) {
      print(_.toString());
    }
  }

  Future<String> getPhoneNumber({required String uid}) async {
    try {
      final DocumentSnapshot documentSnapshot = await _firestore.collection('phones').doc(uid).get();
      if (documentSnapshot.exists) {
        return documentSnapshot['phoneNumber'] as String;
      } else {
        return '';
      }
    } catch (_) {
      print(_.toString());
      return '';
    }
  }
}