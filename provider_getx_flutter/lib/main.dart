import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_getx_flutter/providers/user_information_provider/user_information_model.dart';

import 'views/home_screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserInformationModel()),
    ],
      child:GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      )

    );
  }
}
