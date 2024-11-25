import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/models.dart';

class TransportRepository {
  final CollectionReference _transportCollection =
      FirebaseFirestore.instance.collection('Transports');

  Future<List<Transporte>> getTransportsForUser(String userId) async {
    QuerySnapshot querySnapshot =
        await _transportCollection.where('user_id', isEqualTo: userId).get();
        return querySnapshot.docs.map((snapshot){
          String transportId = snapshot.id;
          Map<String,dynamic> transportData = snapshot.data() as Map<String,dynamic>;

          return Transporte.fromJson({...transportData,'id':transportId});
        }).toList();
  }

  Future<Transporte> addTransportForUser(Transporte transportData) async {
    try{
      DocumentReference documentReference = await _transportCollection.add(transportData.toJson());
      return transportData.copyWith(id:documentReference.id);
    }catch(_){
      print(_);
      return transportData;
    }
  }

  Future<bool> updateTransport(Transporte updatedTransport) async {
        try{
    await _transportCollection.doc(updatedTransport.id).update(updatedTransport.toJson());
    return true;
        }catch(_){
          print(_);
          return false;
        }
  }

  Future<bool> deleteTransport(String transportId) async {
    try {
      await _transportCollection.doc(transportId).delete();
      return true;
    } catch (_) {
      print(_);
      return false;
    }
  }

  String getTransportIdFromDocument(DocumentSnapshot snapshot) { // i cannot remember for the life of me why this is here, considering deleting it since it literally has 0 uses anywhere
    return snapshot.id;
  }

  Future<List<Transporte>> fetchAllTransports() async {
    try{
      QuerySnapshot querySnapshot = await _transportCollection.get();

      return querySnapshot.docs.map((snapshot){
        String transportId = snapshot.id;
        Map<String,dynamic> transportData = snapshot.data() as Map<String,dynamic>;
        return Transporte.fromJson({...transportData,'id':transportId});
      }).toList();
    }catch(_){
      print(_.toString());
      throw _;
    }
  }
}
