import 'user.dart';

class Post {
  final String id;
  final User user;
  final String content;
  final String image;
  final int likes;
  final int comments;
  final bool isLiked;
  final bool isBookmarked;
  final String categoryTag;

  const Post({
    required this.id,
    required this.user,
    required this.content,
    required this.image,
    required this.likes,
    required this.comments,
    this.isLiked = false,
    this.isBookmarked = false,
    this.categoryTag = '#CampusLife',
  });

  Post copyWith({
    String? id,
    User? user,
    String? content,
    String? image,
    int? likes,
    int? comments,
    bool? isLiked,
    bool? isBookmarked,
    String? categoryTag,
  }) {
    return Post(
      id: id ?? this.id,
      user: user ?? this.user,
      content: content ?? this.content,
      image: image ?? this.image,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      categoryTag: categoryTag ?? this.categoryTag,
    );
  }
}
