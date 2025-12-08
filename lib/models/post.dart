class Post {
  String id;
  String userId;
  String content;
  String imageUrl;
  DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      content: map['content'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
