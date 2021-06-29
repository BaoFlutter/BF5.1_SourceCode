import 'package:api_base/data_sources/repository/repository.dart';
import 'package:api_base/views/video_list/video_model.dart';
import 'package:rxdart/rxdart.dart';

class VideoListBloc {

  final _repository = Repository();
  final videoListSubject = PublishSubject<List<VideoModel>>();

  fetchVideoListFromDataLayer() async
  {
    List<VideoModel> videoList = await _repository.fetchAllVideos();
    videoListSubject.sink.add(videoList);
  }

  Stream<List<VideoModel>> get allVideo => videoListSubject.stream;

  dispose(){
    videoListSubject.close();
  }



}