import 'package:api_base/views/video_list/video_model.dart';
import 'package:flutter/material.dart';

class VideoListModel with ChangeNotifier {

  List<VideoModel> videoList = [];

  updateVideoList(videoList)
  {
    this.videoList = videoList;
    notifyListeners();
  }

}
