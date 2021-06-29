import 'package:api_base/resources/strings.dart';
import 'package:flutter/material.dart';

import '../video_list/video_model.dart';
/*
class DetailVideo extends StatelessWidget {
  final VideoModel? videoModel;

  const DetailVideo({Key? key, @required this.videoModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DETAIL_VIDEO),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            imageWidget(videoModel!),
          ],
        )
      ),
    );
  }

  Widget imageWidget(VideoModel videoModel)
  {
    return Container(
      child: Image.network(videoModel.url_photo!, fit: BoxFit.cover,),
    );
  }
}

 */
class DetailVideo extends StatefulWidget {
  final VideoModel? videoModel;

  const DetailVideo({Key? key, @required this.videoModel}) : super(key: key);
  @override
  _DetailVideoState createState() => _DetailVideoState();
}

class _DetailVideoState extends State<DetailVideo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DETAIL_VIDEO),
        centerTitle: true,
      ),
      body: Container(
          child: Column(
            children: [
              imageWidget(widget.videoModel!),
            ],
          )
      ),
    );
  }

  Widget imageWidget(VideoModel videoModel)
  {
    return Container(
      child: Image.network(videoModel.url_photo!, fit: BoxFit.cover,),
    );
  }
}
