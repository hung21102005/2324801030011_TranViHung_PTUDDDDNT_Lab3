import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'post_detail_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Post> posts;
  final User currentUser;
  final Function(Post) onPostUpdated;
  final Function(int) onPostDeleted;
  final Function(Post) onCreatePost;
  final VoidCallback onOpenDrawer;
  final VoidCallback onOpenProfile;

  const HomeScreen({
    super.key,
    required this.posts,
    required this.currentUser,
    required this.onPostUpdated,
    required this.onPostDeleted,
    required this.onCreatePost,
    required this.onOpenDrawer,
    required this.onOpenProfile,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    // Filter posts by selected category chip
    final displayPosts = _selectedCategory == 'All'
        ? widget.posts
        : widget.posts
            .where((p) =>
                p.categoryTag.toLowerCase() == _selectedCategory.toLowerCase())
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF151C27)),
          onPressed: widget.onOpenDrawer,
          tooltip: 'Open Drawer',
        ),
        title: const Text(
          'Socially',
          style: TextStyle(
            color: Color(0xFF151C27),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF464555)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Hiện tại bạn không có thông báo mới.'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: widget.onOpenProfile,
              child: CircleAvatar(
                radius: 16,
                backgroundImage: widget.currentUser.avatarProvider,
                backgroundColor: const Color(0xFFE2E8F8),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Quick Filter Chips
          _buildCategoryFilterRow(),

          // Feed List
          Expanded(
            child: displayPosts.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.feed_outlined,
                              size: 48, color: Color(0xFF777587)),
                          const SizedBox(height: 12),
                          Text(
                            'Chưa có bài viết cho $_selectedCategory',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF151C27),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedCategory = 'All';
                              });
                            },
                            child: const Text('Xem tất cả bài viết'),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: displayPosts.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return _buildPostCard(context, displayPosts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilterRow() {
    final categories = [
      'All',
      ...CategoryItem.defaultCategories.map((c) => c.tag),
    ];

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF0F0F0)),
        ),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = _selectedCategory == cat;

          return ChoiceChip(
            label: Text(cat),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  _selectedCategory = cat;
                });
              }
            },
            selectedColor: const Color(0xFF3525CD),
            backgroundColor: const Color(0xFFF0F3FF),
            labelStyle: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF464555),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? const Color(0xFF3525CD)
                    : const Color(0xFFE2E8F8),
              ),
            ),
            showCheckmark: false,
          );
        },
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, Post post) {
    return Card(
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE2E8F8)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          final updatedPost = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(post: post),
            ),
          );
          if (updatedPost != null && updatedPost is Post) {
            widget.onPostUpdated(updatedPost);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Avatar, Tên, Category Tag, More Menu
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(user: post.user),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xFF8455EF),
                            backgroundImage: post.user.avatarProvider,
                            child: post.user.avatar.isEmpty
                                ? Text(
                                    post.user.name
                                        .substring(0, 2)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      post.user.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color(0xFF151C27),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.verified,
                                      size: 16,
                                      color: Color(0xFF3525CD),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '@${post.user.username} • 10m',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF777587),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF0F3FF),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        post.categoryTag,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF3525CD),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon:
                        const Icon(Icons.more_horiz, color: Color(0xFF777587)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onSelected: (value) {
                      if (value == 'delete') {
                        final index =
                            widget.posts.indexWhere((p) => p.id == post.id);
                        if (index != -1) {
                          widget.onPostDeleted(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Đã xóa bài viết'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline,
                                color: Colors.red, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Delete Post',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Nội dung bài post
              Text(
                post.content,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Color(0xFF151C27),
                ),
              ),

              // Hình ảnh bài post (nếu có)
              if (post.image.isNotEmpty) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    post.image,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: const Color(0xFFE2E8F8),
                      child: const Center(
                        child: Icon(Icons.image, size: 48, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 12),

              // Thao tác: Likes, Comments, Share, Bookmark
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Like
                      InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          final isLiked = !post.isLiked;
                          final updated = post.copyWith(
                            isLiked: isLiked,
                            likes: isLiked
                                ? post.likes + 1
                                : (post.likes > 0 ? post.likes - 1 : 0),
                          );
                          widget.onPostUpdated(updated);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: Row(
                            children: [
                              Icon(
                                post.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 20,
                                color: post.isLiked
                                    ? const Color(0xFF8F0055)
                                    : const Color(0xFF777587),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${post.likes}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: post.isLiked
                                      ? const Color(0xFF8F0055)
                                      : const Color(0xFF464555),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Comment
                      InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () async {
                          final updatedPost = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostDetailScreen(post: post),
                            ),
                          );
                          if (updatedPost != null && updatedPost is Post) {
                            widget.onPostUpdated(updatedPost);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.chat_bubble_outline,
                                size: 20,
                                color: Color(0xFF777587),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${post.comments}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Color(0xFF464555),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Share
                      IconButton(
                        icon: const Icon(
                          Icons.share_outlined,
                          size: 20,
                          color: Color(0xFF777587),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Đã sao chép liên kết bài viết của ${post.user.name}!'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      post.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 20,
                      color: post.isBookmarked
                          ? const Color(0xFF3525CD)
                          : const Color(0xFF777587),
                    ),
                    onPressed: () {
                      final isBookmarked = !post.isBookmarked;
                      final updated =
                          post.copyWith(isBookmarked: isBookmarked);
                      widget.onPostUpdated(updated);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isBookmarked
                              ? 'Đã lưu bài viết vào mục Đã lưu'
                              : 'Đã bỏ lưu bài viết'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
