import 'package:flutter/material.dart';

class CommentsScreen extends StatelessWidget {
  final String postTitle;
  final List<String> comments;

  const CommentsScreen({
    super.key,
    required this.postTitle,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Комментарии'),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(
                  'https://hsbi.hse.ru/upload/career/professions/2018/itproject3.jpg'),
              title: Text(postTitle),
              subtitle: Text(comments[index]),
            ),
          );
        },
      ),
    );
  }
}
