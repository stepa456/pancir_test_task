import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import 'comments_screen.dart';
import 'models/list_posts_model.dart';
import 'repositories/posts_repository.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<ListPostModel>? posts;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPostsAndComments();
  }

  Future<void> fetchPostsAndComments() async {
    try {
      final postsRepository = PostsRepository();
      final fetchedPosts = await postsRepository.getPosts();
      setState(() {
        posts = fetchedPosts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToCommentsScreen(
      BuildContext context, String postTitle, List<String> comments) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CommentsScreen(postTitle: postTitle, comments: comments),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Посты'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (BuildContext context, int index) {
                final post = posts![index];
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: badges.Badge(
                      badgeContent: Text(
                        post.comments.length.toString(),
                      ),
                      child: ListTile(
                        title: Text(post.name),
                        subtitle: Text(post.description),
                        onTap: () => navigateToCommentsScreen(
                            context, post.name, post.comments),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
