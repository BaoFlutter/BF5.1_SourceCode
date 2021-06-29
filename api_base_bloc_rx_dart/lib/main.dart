import 'package:api_base/data_sources/api_services.dart';
import 'package:api_base/providers/video_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'views/home_screen/home_screen.dart';
import 'views/video_list/video_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => VideoListModel()),
    ],
    child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen()
    ),
    );
    /*
    return FutureProvider<List<VideoModel>>(
        create: (_)=> ApiServices().fetchVideoList(),
        initialData: [],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen()
      ),

    );
     */

  }
}

