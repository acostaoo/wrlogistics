// ignore_for_file: unnecessary_cast

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/transporte.dart';
class TransportRepository {
  final FakeFirebaseFirestore _firestore = FakeFirebaseFirestore();

  Future<List<Transporte>> getTransportsForUser(String userId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('Transports').where('user_id', isEqualTo: userId).get();

    return querySnapshot.docs.map((snapshot) {
      String transportId = snapshot.id;
      Map<String, dynamic> transportData = snapshot.data() as Map<String, dynamic>;

      return Transporte.fromJson({...transportData, 'id': transportId});
    }).toList();
  }

  Future<Transporte> addTransportForUser(Transporte transportData) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await _firestore.collection('Transports').add(transportData.toJson());
      return transportData.copyWith(id: documentReference.id);
    } catch (_) {
      print(_);
      return transportData;
    }
  }

  Future<bool> updateTransport(Transporte updatedTransport) async {
    try {
      await _firestore.collection('Transports').doc(updatedTransport.id).update(updatedTransport.toJson());
      return true;
    } catch (_) {
      print(_);
      return false;
    }
  }

  Future<bool> deleteTransport(String transportId) async {
    try {
      await _firestore.collection('Transports').doc(transportId).delete();
      return true;
    } catch (_) {
      print(_);
      return false;
    }
  }

  String getTransportIdFromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.id;
  }

  Future<List<Transporte>> fetchAllTransports() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.collection('Transports').get();

      return querySnapshot.docs.map((snapshot) {
        String transportId = snapshot.id;
        Map<String, dynamic> transportData = snapshot.data() as Map<String, dynamic>;
        return Transporte.fromJson({...transportData, 'id': transportId});
      }).toList();
    } catch (_) {
      print(_.toString());
      throw _;
    }
  }
}
