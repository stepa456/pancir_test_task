import 'package:dio/dio.dart';
import 'package:pancir_application_1/core/models/list_posts_model.dart';

import '../api_exception.dart';

class PostsRepository {
  Future<List<ListPostModel>> getPosts() async {
    try {
      final postsResponse =
          await Dio().get('https://jsonplaceholder.typicode.com/posts');
      final commentsResponse =
          await Dio().get('https://jsonplaceholder.typicode.com/comments');

      switch (postsResponse.statusCode) {
        case 200:
          final postsData = postsResponse.data as List<dynamic>;

          switch (commentsResponse.statusCode) {
            case 200:
              final commentsData = commentsResponse.data as List<dynamic>;
              final postsList = postsData.map((post) {
                final postId = post['id'];
                final postComments = commentsData
                    .where((comment) => comment['postId'] == postId)
                    .toList();

                return ListPostModel(
                  name: post['title'],
                  description: post['body'],
                  comments: postComments
                      .map<String>((comment) => comment['body'])
                      .toList(),
                );
              }).toList();
              return postsList;

            case 404:
              throw PageNotFoundException().message;

            default:
              throw UnknownServerException().message;
          }

        case 404:
          throw PageNotFoundException().message;

        default:
          throw UnknownServerException().message;
      }
    } on DioException catch (_) {
      throw TimeOutException().message;
    }
  }
}
