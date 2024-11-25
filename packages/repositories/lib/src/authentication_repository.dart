// aquí iría el código de autenticación, como las rutas de 
//prueba son expuestas y la autenticación está más
//que probada, no hace falta en el ambiente de prueba.
//   import 'dart:async';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
// import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
// import 'package:repositories/repositories.dart';
class AuthenticationRepository{}
// class AuthenticationRepository{
//   final StreamController<Usuario> _userController = StreamController<Usuario>();
//   final MockFirebaseAuth _mockFirebaseAuth = MockFirebaseAuth();
//   final MockGoogleSignIn _mockGoogleSignIn = MockGoogleSignIn();

//   AuthenticationRepository() {
//     _mockFirebaseAuth.authStateChanges().listen((firebaseUser) async {
//       final user = firebaseUser == null
//           ? Usuario.empty
//           : (await AdminRepository().isAdmin(firebaseUser.uid)
//               ? firebaseUser.toAdmin
//               : firebaseUser.toUser);
//       _userController.add(user);
//     });
//   }

//   Stream<Usuario> get user => _userController.stream;

//   Future<void> LogInWithGoogle() async {
//     final signinAccount = await _mockGoogleSignIn.signIn();
//     final googleAuth = await signinAccount?.authentication;
//     final user = MockUser(
//       uid: '1234',
//       email:'usuario@gmail.com',
//       displayName: 'usuario regular'
//     );
//     final admin = MockUser(
//       uid: '4321',
//       email: 'admin@gmail.com',
//       displayName: 'usuario administrador'
//     );
    
    
//     await _mockFirebaseAuth.signInWithCredential(googleAuth);
//   }

//   Future<void> signOut() async {
//     await _mockFirebaseAuth.signOut();
//   }

//   void dispose() {
//     _userController.close();
//   }
// }
// extension on fir.User{
//   Usuario get toUser{
//     return Usuario(id: uid,email: email,nombre: displayName,phone: phoneNumber??'',userRole: UserRole.user);
//   }
//   Usuario get toAdmin{
//     return Usuario (id: uid,email: email,nombre: displayName, userRole: UserRole.admin,phone: phoneNumber??'');
//   }
// }


//     // Mock sign in with Google.
//     final googleSignIn = MockGoogleSignIn();
//     final signinAccount = await googleSignIn.signIn();
//     final googleAuth = await signinAccount.authentication;
//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     // Sign in.
//     final user = MockUser(
//       isAnonymous: false,
//       uid: 'someuid',
//       email: 'bob@somedomain.com',
//       displayName: 'Bob',
//     );
//     final auth = MockFirebaseAuth(mockUser: user);
//     final result = await auth.signInWithCredential(credential);
//     final user = await result.user;
//     print(user.displayName);
