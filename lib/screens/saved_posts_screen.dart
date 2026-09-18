import 'package:flutter/material.dart';

import '../models/post.dart';
import 'post_detail_screen.dart';

class SavedPostsScreen extends StatelessWidget {
  final List<Post> posts;
  final Function(Post) onPostUpdated;
  final VoidCallback onExplore;
  final VoidCallback onOpenDrawer;

  const SavedPostsScreen({
    super.key,
    required this.posts,
    required this.onPostUpdated,
    required this.onExplore,
    required this.onOpenDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final savedPosts = posts.where((p) => p.isBookmarked).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF151C27)),
          onPressed: onOpenDrawer,
          tooltip: 'Open Drawer',
        ),
        title: const Text(
          'Saved Posts',
          style: TextStyle(
            color: Color(0xFF151C27),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${savedPosts.length} saved',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3525CD),
              ),
            ),
          ),
        ],
      ),
      body: savedPosts.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0F3FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bookmark_border,
                        size: 40,
                        color: Color(0xFF3525CD),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Chưa có bài viết nào được lưu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF151C27),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Hãy bấm vào biểu tượng bookmark trên các bài viết thú vị để xem lại tại đây sau này.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF777587),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: onExplore,
                      icon: const Icon(Icons.explore_outlined, size: 18),
                      label: const Text('Khám phá bài viết'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3525CD),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: savedPosts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final post = savedPosts[index];
                return _buildSavedCard(context, post);
              },
            ),
    );
  }

  Widget _buildSavedCard(BuildContext context, Post post) {
    return Card(
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE2E8F8)),
      ),
      child: InkWell(
        onTap: () async {
          final updated = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(post: post),
            ),
          );
          if (updated != null && updated is Post) {
            onPostUpdated(updated);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: post.user.avatarProvider,
                    backgroundColor: const Color(0xFFE2E8F8),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.user.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF151C27),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '@${post.user.username} • ${post.categoryTag}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF777587),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.bookmark,
                      color: Color(0xFF3525CD),
                      size: 22,
                    ),
                    onPressed: () {
                      final updated = post.copyWith(isBookmarked: false);
                      onPostUpdated(updated);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã bỏ lưu bài viết.'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    tooltip: 'Remove bookmark',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                post.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF464555),
                  height: 1.4,
                ),
              ),
              if (post.image.isNotEmpty) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    post.image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 80,
                      color: const Color(0xFFE2E8F8),
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
