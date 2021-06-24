import 'package:flutter/material.dart';

class UserInformationModel with ChangeNotifier{

  String userName = "Chưa cập nhật";
  String phoneNumber = "Chưa cập nhật" ;
  String iconUrl = "";


  updateInformation({userName, phoneNumber})
  {
    this.userName = userName;
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }

}