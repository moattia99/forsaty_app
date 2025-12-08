import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController controller = TextEditingController();
  final PostService postService = PostService();

  void addPost() async {
    if (controller.text.trim().isEmpty) return;

    final post = Post(
      id: const Uuid().v4(),
      userId: "anonymous", // Replace with Firebase Auth user ID if needed
      content: controller.text.trim(),
      imageUrl: "",
      createdAt: DateTime.now(),
    );

    await postService.addPost(post);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 5,
              decoration: const InputDecoration(hintText: "Write your post..."),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: addPost, child: const Text("Publish")),
          ],
        ),
      ),
    );
  }
}
