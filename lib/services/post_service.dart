// lib/services/post_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';

class PostService {
  final CollectionReference postsRef =
      FirebaseFirestore.instance.collection('posts');

  Future<void> addPost(PostModel post) async {
    await postsRef.doc(post.id).set(post.toMap());
  }

  Future<List<PostModel>> getPosts() async {
    final snapshot = await postsRef.orderBy('createdAt', descending: true).get();
    return snapshot.docs
        .map((doc) => PostModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<PostModel>> streamPosts() {
    return postsRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => PostModel.fromMap(d.data() as Map<String, dynamic>)).toList());
  }

  Future<void> likePost(String postId, String userId) async {
    await postsRef.doc(postId).update({
      'likes': FieldValue.arrayUnion([userId]),
    });
  }

  Future<void> unlikePost(String postId, String userId) async {
    await postsRef.doc(postId).update({
      'likes': FieldValue.arrayRemove([userId]),
    });
  }

  Future<void> addComment(String postId, CommentModel comment) async {
    await postsRef.doc(postId).update({
      'comments': FieldValue.arrayUnion([comment.toMap()]),
    });
  }
}
