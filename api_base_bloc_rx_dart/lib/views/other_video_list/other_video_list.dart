
import 'package:api_base/data_sources/api_services.dart';
import 'package:api_base/providers/video_list_model.dart';
import 'package:api_base/resources/strings.dart';
import 'package:api_base/views/detail_video/detail_video.dart';
import 'package:api_base/views/video_list/video_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class OtherVideoListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //final videoList = Provider.of<List<VideoModel>>(context);
    final videoList = context.watch<VideoListModel>().videoList;

    return Scaffold(
      appBar: AppBar(
        title: Text(VIDEO_LIST),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: videoList==null ? waitingWidget() : videoListWidget(videoList, context)
      ),
    );
  }

  Widget waitingWidget()
  {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget videoListWidget(List<VideoModel> videoList, context)
  {
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
  }


}
