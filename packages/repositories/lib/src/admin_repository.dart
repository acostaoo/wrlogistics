//igual que el otro repositorio, las vistas
//estarán expuestas así que no hay necesidad.
class AdminRepository{
  Future<bool> isAdmin(String uid) async{
    if (uid=='4321'){
      return true;
    }else{
      return false;
    }
  }
}