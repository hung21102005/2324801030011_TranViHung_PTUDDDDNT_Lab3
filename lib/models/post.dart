import 'user.dart';

class Post {
  const Post({
    required this.id,
    required this.user,
    required this.content,
    required this.image,
    required this.likes,
    required this.comments,
  });

  final String id;
  final User user;
  final String content;
  final String image;
  final int likes;
  final int comments;
}
