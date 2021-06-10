import 'xe.dart';

class XeOto extends Xe{

  XeOto({brand, name}):super(brand: brand, name: name );

  useFunction()
  {
    super.chuyenCho();
  }

  @override
  chuyenCho() {
    // TODO: implement chuyenCho
    print("Xe cho nhan vien");
    //return super.chuyenCho();
  }





}