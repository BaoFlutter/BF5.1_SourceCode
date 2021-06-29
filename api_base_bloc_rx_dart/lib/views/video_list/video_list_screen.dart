
import 'package:api_base/blocs/video_list_bloc.dart';
import 'package:api_base/data_sources/api_services.dart';
import 'package:api_base/providers/video_list_model.dart';
import 'package:api_base/resources/strings.dart';
import 'package:api_base/views/detail_video/detail_video.dart';
import 'package:api_base/views/other_video_list/other_video_list.dart';
import 'package:api_base/views/video_list/video_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(VIDEO_LIST),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Get.to(OtherVideoListScreen());
          }, icon: Icon(Icons.add_to_photos))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<List<VideoModel>>(
            stream: videoListBloc.allVideo,
            builder: (context, snapshot){
              if((snapshot.hasError)||(!snapshot.hasData))
                return Center(
                  child: CircularProgressIndicator(),
                );
              List<VideoModel> videoList = snapshot.data!;

              context.read<VideoListModel>().videoList = videoList;

              print("Độ dài" + videoList.length.toString());
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: videoList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.network(videoList[index].url_photo!, fit: BoxFit.cover,),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onTap: (){
                        var route = MaterialPageRoute(builder: (context) => DetailVideo(videoModel: videoList[index],));
                        Navigator.push(context, route);
                      },
                    );
                  });
            }),
      ),


    );
  }
}

/*
class VideoListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(VIDEO_LIST),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Get.to(OtherVideoListScreen());
          }, icon: Icon(Icons.add_to_photos))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<VideoModel>>(
            future: ApiServices().fetchVideoList(),
            builder: (context, snapshot){
              if((snapshot.hasError)||(!snapshot.hasData))
                return Center(
                  child: CircularProgressIndicator(),
                );
              List<VideoModel> videoList = snapshot.data!;

              context.read<VideoListModel>().videoList = videoList;

              print("Độ dài" + videoList.length.toString());
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: videoList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.network(videoList[index].url_photo!, fit: BoxFit.cover,),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onTap: (){
                        var route = MaterialPageRoute(builder: (context) => DetailVideo(videoModel: videoList[index],));
                        Navigator.push(context, route);
                      },
                    );
                  });
            }),
      ),


    );
  }
}

 */
