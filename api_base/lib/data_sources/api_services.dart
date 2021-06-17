import 'dart:convert';

import 'package:api_base/data_sources/api_urls.dart';
import 'package:api_base/resources/strings.dart';
import 'package:api_base/resources/utils/logs.dart';
import 'package:api_base/views/video_list/video_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class ApiServices {
  // fetch (get) Video List

  Future<List<VideoModel>> fetchVideoList() async {
    List<VideoModel> videoList = [];
    var fullVideosUrl = ApiUrls().VIDEOS_URL;
    var response ;
    try{
      response = await http.get(fullVideosUrl);
    }
    catch(e)
    {
      print(e.toString());
    }
    var body = json.jsonDecode(response.body);
    Log().printJson(json: body);
    if(body['code'] =="success"){
      List jsonList = body['list'];
      for( var jsonItem in jsonList )
        {
          VideoModel videoModel = VideoModel.fromJson(jsonItem);
          videoList.add(videoModel);
        }
    }
    else throw Exception(FAIL_VIDEO_FETCHING);
  return videoList;
  }

  // update User Information


}