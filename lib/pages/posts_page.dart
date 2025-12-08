import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class PostsPage extends StatelessWidget {
  final PostService postService = PostService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: StreamBuilder<List<Post>>(
        stream: postService.streamPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No posts yet"));
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final p = posts[index];
              return ListTile(
                title: Text(p.content),
                subtitle: Text(p.createdAt.toLocal().toString()),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_post');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
