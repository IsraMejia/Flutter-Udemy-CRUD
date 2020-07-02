
bool esNumero(String s){
  if (s.isEmpty){
    return false;
  }
  final n = num.tryParse(s) ; //Si se puede o no ser numerico
  
  return (n == null) ? false : true;
}