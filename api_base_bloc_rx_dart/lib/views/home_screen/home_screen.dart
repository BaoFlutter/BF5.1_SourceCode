import 'package:api_base/blocs/video_list_bloc.dart';
import 'package:api_base/resources/strings.dart';
import 'package:api_base/views/other_video_list/other_video_list.dart';
import 'package:api_base/views/video_list/video_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final videoListBloc = VideoListBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoListBloc.fetchVideoListFromDataLayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoListBloc.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StreamProvider(
        create: (_)=> videoListBloc.allVideo,
        initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title: Text(HOME_SCREEN),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: ElevatedButton(
              child: Text(LOAD_VIDEOS),
              onPressed: (){
                /*
                var route = MaterialPageRoute(builder: (context) => VideoListScreen());
                Navigator.push(context, route);

                 */
                Get.to(OtherVideoListScreen());
              },
            ),

          ),
        ),
      ),

    );
  }
}

/*
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

 */
