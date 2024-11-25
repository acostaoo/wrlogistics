part of 'authentication_repository.dart';

class PhoneRepository {
  FirebaseFirestore firestore =FirebaseFirestore.instance;

Future<void> storePhoneNumber({required String phoneNumber,required String uid}) async {
  try{
  await firestore.collection('phones').doc(uid).set({
    'phoneNumber':phoneNumber,
  });
  }catch(_){
    print(_.toString());
  }
}
Future<String> getPhoneNumber({required String uid}) async{
  try{
    DocumentSnapshot documentSnapshot = await firestore.collection('phones').doc(uid).get();
    if (documentSnapshot.exists){
      return documentSnapshot['phoneNumber'] as String;
    }else{return '';}
  }catch (_){
    print(_.toString());return '';
  }
}
}
