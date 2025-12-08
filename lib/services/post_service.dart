import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class PostService {
  final CollectionReference postsRef =
      FirebaseFirestore.instance.collection("posts");

  Future<void> addPost(Post post) async {
    await postsRef.doc(post.id).set(post.toMap());
  }

  Future<List<Post>> getPosts() async {
    final snapshot = await postsRef.orderBy("createdAt", descending: true).get();
    return snapshot.docs
        .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<Post>> streamPosts() {
    return postsRef
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
