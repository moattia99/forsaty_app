// lib/models/post_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String userId;
  final String content;
  final DateTime createdAt;
  final List<String> likes;
  final List<CommentModel> comments;

  PostModel({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.likes,
    required this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'likes': likes,
      'comments': comments.map((c) => c.toMap()).toList(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      content: map['content'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      likes: List<String>.from(map['likes'] ?? []),
      comments: (map['comments'] as List? ?? []).map((c) => CommentModel.fromMap(c as Map<String, dynamic>)).toList(),
    );
  }
}

class CommentModel {
  final String userId;
  final String text;
  final DateTime createdAt;

  CommentModel({
    required this.userId,
    required this.text,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userId: map['userId'] ?? '',
      text: map['text'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
