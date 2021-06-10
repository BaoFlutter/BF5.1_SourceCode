class User {

  // Thuộc tính ( biến ) & Phương thức (hàm)

  String name; // public 
  String _phoneNumber; // private 
  int id; 
  int age; 
  String _address; 

  // Phuong thuc: ham
  /*
  User(String name, String soDt, int maID, int tuoi, String diaChi)
  {
    this.name = name;
    this._phoneNumber = soDt;
    this.id = maID;
    this.age = tuoi;
    this._address = diaChi;
  }
  */
  

  User(this.id,this.name, this.age,  this._phoneNumber,  this._address);

  

  setPhoneNumber(String phoneNumber)
  {
    this._phoneNumber = phoneNumber;
  }
  /*
  getPhoneNumber()
  {
    return this._phoneNumber;
  }
  */
  getPhoneNumber() => this._phoneNumber;



  String get phoneNumber => this._phoneNumber;


  void _printPhoneNumber(){
    print (this._phoneNumber);
  }

  int getBirthYear(){
    return 2021 - this.age;
  }

  renameUser({String name})
  {
    this.name = name; 

  }









}