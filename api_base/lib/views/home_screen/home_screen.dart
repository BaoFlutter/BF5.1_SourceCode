import 'package:api_base/resources/strings.dart';
import 'package:api_base/views/video_list/video_list_screen.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HOME_SCREEN),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text(LOAD_VIDEOS),
            onPressed: (){
              var route = MaterialPageRoute(builder: (context) => VideoListScreen());
              Navigator.push(context, route);
            },
          ),

        ),
      ),
    );
  }
}
