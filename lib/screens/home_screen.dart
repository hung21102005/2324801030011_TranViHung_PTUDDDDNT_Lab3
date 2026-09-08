import 'package:flutter/material.dart';

import '../models/post.dart';
import '../models/user.dart';
import 'post_detail_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const User _alex = User(
    id: 'u1',
    name: 'Tran Vi Hung',
    username: 'tranvihung',
    avatar: 'assets/avatar.jpg',
    bio: 'Software Engineering Student',
    followers: 120,
    following: 80,
  );

  static const User _minh = User(
    id: 'u2',
    name: 'Minh Tran',
    username: 'minhtran',
    avatar: '',
    bio: 'Flutter Developer',
    followers: 85,
    following: 40,
  );

  static const User _anna = User(
    id: 'u3',
    name: 'Anna',
    username: 'annak',
    avatar: '',
    bio: 'CS Student',
    followers: 64,
    following: 30,
  );

  late final List<Post> _posts = [
    const Post(
      id: 'p1',
      user: _alex,
      content:
          'Beautiful day for a walk! 🌸 The cherry blossoms right outside University Hall are in full bloom today.',
      image:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuALy_h2qXaZLOv0eluHLcB1sSUtkyoKc4PoWbwcdx10U61AyNVuAMNMBVXsU_FEDO-Wrazke-LJxJrpODGgTe42MXEPh_RWpfEQk5Z1fJn6v7lfkFt5HmSdNN_UQ_KgJW7z4BJeBF27s5o2KTPeZtYxL1vlb3yjNh2S-I9sGoF-sywwiE1Za2PBd4DogM0xAW9bqQjC19n81JUHkz0PUJT_sJkel8oq605ojyhDBk73AzaAemWRo0hz',
      likes: 120,
      comments: 18,
    ),
    const Post(
      id: 'p2',
      user: _minh,
      content:
          'Working on my Flutter project today. Clean architecture + state management feeling super solid! 💻✨',
      image:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA_f3Xap0TBmAWACuVipukIHcDq7mUiEUj_mThCnMmwDSyvWaWD6QJi5S9Pa7GBBDwv5n7aNiTh7tIHevDrAmWeqfZD3IVVAOzNy4Up92ZF902Bl6o-JPJ9UaJY1F7piNvEHkbovvEqiLf_61GkvtsHkvuvigUHA1Nv0IJ_WM7N5QfDEarTmh14_-3pbItHw4nZNI3aWAlSVk8Daah3bJVJbYTs8dM2aSGh7eOsjyMX0Uc_i9DHefZz',
      likes: 85,
      comments: 12,
    ),
    const Post(
      id: 'p3',
      user: _anna,
      content:
          'Coffee and coding ☕\nAt Student Union Café • Testing local state persistence',
      image: '',
      likes: 64,
      comments: 8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
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
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(user: _alex),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 16,
                backgroundImage: _alex.avatarProvider,
                backgroundColor: const Color(0xFFE2E8F8),
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _posts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final post = _posts[index];
          return _buildPostCard(context, post);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Thực hành Named Route
          final newPost = await Navigator.pushNamed(context, '/create-post');

          // Nhận kết quả từ CreatePostScreen và cập nhật UI
          if (newPost != null && newPost is Post) {
            setState(() {
              _posts.insert(0, newPost);
            });
          }
        },
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Create Post'),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, Post post) {
    return Card(
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(post: post),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Avatar, Tên, Username
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF8455EF),
                    backgroundImage: post.user.avatarProvider,
                    child: post.user.avatar.isEmpty
                        ? Text(
                            post.user.name.substring(0, 2).toUpperCase(),
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
                                fontSize: 16,
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
                        Text(
                          '@${post.user.username} • 10 min ago',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF777587),
                          ),
                        ),
                      ],
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
                        setState(() {
                          _posts.remove(post);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã xóa bài viết'),
                            duration: Duration(seconds: 1),
                          ),
                        );
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
                      Row(
                        children: [
                          const Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: Color(0xFF777587),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${post.likes}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Color(0xFF464555),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      // Comment
                      Row(
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
                      const SizedBox(width: 20),
                      // Share
                      const Icon(
                        Icons.share_outlined,
                        size: 20,
                        color: Color(0xFF777587),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.bookmark_border,
                    size: 20,
                    color: Color(0xFF777587),
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
