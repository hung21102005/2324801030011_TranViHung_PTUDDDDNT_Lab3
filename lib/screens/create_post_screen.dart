import 'package:flutter/material.dart';

import '../models/post.dart';
import '../models/user.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _contentController = TextEditingController();
  String? _selectedImage;

  static const User _currentUser = User(
    id: 'u1',
    name: 'Tran Vi Hung',
    username: 'tranvihung',
    avatar: 'assets/avatar.jpg',
    bio: 'Software Engineering Student',
    followers: 120,
    following: 80,
  );

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _submitPost() {
    final text = _contentController.text.trim();
    if (text.isEmpty && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập nội dung bài viết!')),
      );
      return;
    }

    // Tạo đối tượng Post mới
    final newPost = Post(
      id: 'p_${DateTime.now().millisecondsSinceEpoch}',
      user: _currentUser,
      content: text.isNotEmpty ? text : 'Chia sẻ khoảnh khắc mới!',
      image: _selectedImage ?? '',
      likes: 0,
      comments: 0,
    );

    // Trả newPost về HomeScreen
    Navigator.pop(context, newPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF151C27)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create Post',
          style: TextStyle(
            color: Color(0xFF151C27),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin người đăng
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFFE2E8F8),
                  backgroundImage: _currentUser.avatarProvider,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentUser.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF151C27),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.public, size: 12, color: Color(0xFF3525CD)),
                          SizedBox(width: 4),
                          Text(
                            'Public',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3525CD),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Khung soạn thảo bài viết
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _contentController,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF151C27),
                    ),
                    decoration: const InputDecoration(
                      hintText: "What's on your mind? Write something...",
                      hintStyle: TextStyle(color: Color(0xFF777587)),
                      border: InputBorder.none,
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      ActionChip(
                        label: const Text('#StudySprint'),
                        onPressed: () {
                          _contentController.text += ' #StudySprint';
                        },
                      ),
                      const SizedBox(width: 8),
                      ActionChip(
                        label: const Text('#CampusLife'),
                        onPressed: () {
                          _contentController.text += ' #CampusLife';
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Phần đính kèm hình ảnh (Mockup)
            const Text(
              'Media Attachment',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF464555),
              ),
            ),
            const SizedBox(height: 8),

            GestureDetector(
              onTap: () {
                setState(() {
                  if (_selectedImage == null) {
                    // Gán một ảnh mẫu khi click
                    _selectedImage =
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuA_f3Xap0TBmAWACuVipukIHcDq7mUiEUj_mThCnMmwDSyvWaWD6QJi5S9Pa7GBBDwv5n7aNiTh7tIHevDrAmWeqfZD3IVVAOzNy4Up92ZF902Bl6o-JPJ9UaJY1F7piNvEHkbovvEqiLf_61GkvtsHkvuvigUHA1Nv0IJ_WM7N5QfDEarTmh14_-3pbItHw4nZNI3aWAlSVk8Daah3bJVJbYTs8dM2aSGh7eOsjyMX0Uc_i9DHefZz';
                  } else {
                    _selectedImage = null;
                  }
                });
              },
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F3FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFC7C4D8)),
                ),
                child: _selectedImage != null
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.black54,
                              child: IconButton(
                                icon: const Icon(Icons.close,
                                    size: 16, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _selectedImage = null;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate_outlined,
                              size: 40, color: Color(0xFF3525CD)),
                          SizedBox(height: 8),
                          Text(
                            'Add Image',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF151C27),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tap to attach photo (Mockup)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF777587),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Nút bấm Post
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _submitPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3525CD),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.send),
                label: const Text(
                  'Post',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Nút Cancel
            SizedBox(
              width: double.infinity,
              height: 44,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel & Discard',
                  style: TextStyle(color: Color(0xFF777587)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
