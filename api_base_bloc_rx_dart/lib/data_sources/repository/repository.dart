import 'package:api_base/data_sources/api_services.dart';
import 'package:api_base/views/video_list/video_model.dart';

class Repository {
  final ApiServices _apiServices = ApiServices();
  Future<List<VideoModel>> fetchAllVideos() => _apiServices.fetchVideoList();

}