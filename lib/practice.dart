
// import 'dart:io';
// void main(){
// var a = stdin.readLineSync();
// stdout.write('jdfhaues');
// print(a);
// }
// import 'dart:io';
// void main (){
//   print('welcome to raziq');
//   stdout.write('enter yotr name');
//   var a = stdin.readLineSync();
//   print('yourname,$a');
//   var box = new pehla();
// }
// class pehla {
//   pehla();
// }
import 'dart:io';
// Color.fromARGB(255, 0, 5, 43)
//  const Color.fromARGB(255, 0, 4, 34),
void main(){
  print('welcome to dart');
 var myC = myClass();
var stn = stdin.readLineSync();
 myC.pName('$stn');
 print(myC.Add());

}

class myClass{

  var num =1;
  void pName(var name){
    for(int a = 1; a <= 100;a++){

    print("$num$name");
    // print(num);
    num++;

    }
  }
  int Add(){
    int a, b;
    a=5;
    b=6;
    int sum = a+b;
  return sum;
  }
}







