class Post {
  final String id;
  final String content;
  final String userId;
  final DateTime createdAt;
  final int likesCount;

  Post({
    required this.id,
    required this.content,
    required this.userId,
    required this.createdAt,
    required this.likesCount,
  });

  factory Post.fromMap(String id, Map<String, dynamic> data) {
    return Post(
      id: id,
      content: data['content'] ?? '',
      userId: data['userId'] ?? '',
      createdAt: DateTime.parse(data['createdAt']),
      likesCount: data['likesCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'likesCount': likesCount,
    };
  }
}
