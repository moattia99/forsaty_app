import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create Post
  Future<void> createPost(PostModel post) async {
    await _db.collection('posts').doc(post.id).set(post.toMap());
  }

  // Read All Posts
  Stream<List<PostModel>> getPosts() {
    return _db
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PostModel.fromMap(doc.data()))
          .toList();
    });
  }

  // Like
  Future<void> likePost(String postId, String userId) async {
    await _db.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayUnion([userId]),
    });
  }

  // Unlike
  Future<void> unlikePost(String postId, String userId) async {
    await _db.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayRemove([userId]),
    });
  }

  // Add Comment
  Future<void> addComment(String postId, CommentModel comment) async {
    await _db.collection('posts').doc(postId).update({
      'comments': FieldValue.arrayUnion([comment.toMap()])
    });
  }
}
