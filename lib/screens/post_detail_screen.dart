import 'package:flutter/material.dart';

import '../models/post.dart';
import 'profile_screen.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late Post _currentPost;
  late List<Map<String, String>> _comments;
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _currentPost = widget.post;
    _comments = [
      {
        'username': 'sarah_c',
        'avatar':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuB_GNiVKnpp9QIrAtq2mqZkqHZd6Ca-GkFLkWEtdPS7o2P9fIe3p4KQcASkezPmvYM34AZTcHtY9dXJwh1Of9rWSUBSLfHMClmMpZLUvoSAbQYiDelsxnfzXKayKjswPTLU1e0x3-iod-k9oBDCt7qct_RnFhE4Bobys90U1FP0mTWgtRoYtKKyGbADtp1eSV446S819tOXXxOpVofDRT5mqndUXpBFUmTYmOggq4Y6QP0R1YL4Yrt5',
        'text': 'Looks amazing!',
        'time': '8m ago',
      },
      {
        'username': 'david_dev',
        'avatar':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuA2uHT8fP9Ul7y9RfZomrh9pFeVNVzkdssmv07zQpIoTiyL43jzv5sKLV4MD2XsEIWnh7HiHEfmIdAT0F-KXqz3FDwZkqNTBmM5Y45BkO_lpdab2k7mCBC_5rIvIYouaJCUxUyAXQczyt7i1zMnzt1fRUBqqLKoamFmw02OAWlGXcWu-oJW_DDTSoLqyKVWVEYU542NMU3nGsjW2lBzhLi4Qhz1cQex9safSnOJ3he4XsX9TOZqPB76',
        'text': 'Great photo!',
        'time': '5m ago',
      },
      {
        'username': 'emily_r',
        'avatar':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBulK6Re7qbpwM-3XtlR84hYz_Gclf8j7noPISDGDXd9okGtUGjwTuoqSdUcBVe03BrPmtYGPU9QrYAYRHYljvLshrX6g9tGioxF9Rm12TnXRyr1OW01khzpvc-W3I9WGGd4_jT3wKBDce1LP9lDIXV7Aey-Z6PX7zWZyd4d6mZaRTxGY4pWzhAbyt2r1NWfNVkfdsGspJ_FbP0JNjpVmhl8uzzqJYfeu1ARWiC3gc4mDaybqnDB8qr',
        'text': 'I love this place.',
        'time': '1m ago',
      },
    ];
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _comments.insert(0, {
        'username': 'tranvihung',
        'avatar': 'assets/avatar.jpg',
        'text': text,
        'time': 'Just now',
      });
      _currentPost = _currentPost.copyWith(comments: _comments.length);
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, _currentPost);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9FF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF151C27)),
            onPressed: () {
              Navigator.pop(context, _currentPost);
            },
          ),
          title: const Text(
            'Post Detail',
            style: TextStyle(
              color: Color(0xFF151C27),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none,
                  color: Color(0xFF464555)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Hiện tại bạn không có thông báo mới.'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thẻ chi tiết bài viết
                Card(
                  elevation: 0.5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thông tin tác giả
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileScreen(user: _currentPost.user),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: const Color(0xFF8455EF),
                                      backgroundImage:
                                          _currentPost.user.avatarProvider,
                                      child: _currentPost.user.avatar.isEmpty
                                          ? Text(
                                              _currentPost.user.name
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  _currentPost.user.name,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Color(0xFF151C27),
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
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
                                            '@${_currentPost.user.username} • 10 min ago',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF777587),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_horiz,
                                  color: Color(0xFF777587)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onSelected: (value) {
                                if (value == 'share') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Đã sao chép liên kết bài viết của ${_currentPost.user.name}!'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                } else if (value == 'report') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Cảm ơn bạn đã báo cáo. Chúng tôi sẽ xem xét bài viết này.'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'share',
                                  child: Row(
                                    children: [
                                      Icon(Icons.share_outlined,
                                          size: 20, color: Color(0xFF464555)),
                                      SizedBox(width: 8),
                                      Text('Share Post'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'report',
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag_outlined,
                                          size: 20, color: Colors.redAccent),
                                      SizedBox(width: 8),
                                      Text(
                                        'Report Post',
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Nội dung bài viết
                        Text(
                          _currentPost.content,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.4,
                            color: Color(0xFF151C27),
                          ),
                        ),

                        // Ảnh đính kèm (nếu có)
                        if (_currentPost.image.isNotEmpty) ...[
                          const SizedBox(height: 14),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              _currentPost.image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 220,
                                color: const Color(0xFFE2E8F8),
                                child: const Center(
                                  child: Icon(Icons.image,
                                      size: 48, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ],

                        const SizedBox(height: 14),

                        // Lượt thích & bình luận
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    setState(() {
                                      final isLiked = !_currentPost.isLiked;
                                      _currentPost = _currentPost.copyWith(
                                        isLiked: isLiked,
                                        likes: isLiked
                                            ? _currentPost.likes + 1
                                            : (_currentPost.likes > 0
                                                ? _currentPost.likes - 1
                                                : 0),
                                      );
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    child: Row(
                                      children: [
                                        Icon(
                                          _currentPost.isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 20,
                                          color: _currentPost.isLiked
                                              ? const Color(0xFF8F0055)
                                              : const Color(0xFF777587),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '${_currentPost.likes}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: _currentPost.isLiked
                                                ? const Color(0xFF8F0055)
                                                : const Color(0xFF464555),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    _commentFocusNode.requestFocus();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.chat_bubble_outline,
                                          size: 20,
                                          color: Color(0xFF3525CD),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '${_currentPost.comments}',
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
                                            'Đã sao chép liên kết bài viết của ${_currentPost.user.name}!'),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                _currentPost.isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                size: 20,
                                color: _currentPost.isBookmarked
                                    ? const Color(0xFF3525CD)
                                    : const Color(0xFF777587),
                              ),
                              onPressed: () {
                                final isBookmarked = !_currentPost.isBookmarked;
                                setState(() {
                                  _currentPost = _currentPost.copyWith(
                                      isBookmarked: isBookmarked);
                                });
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

                const SizedBox(height: 20),

                // Tiêu đề phần Comments
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Comments',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF151C27),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2DFFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_comments.length}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F0069),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Most Recent',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF777587),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Danh sách bình luận
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _comments.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final comment = _comments[index];
                    final avatarUrl = comment['avatar']!;
                    final isNetwork = avatarUrl.startsWith('http');
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: isNetwork
                              ? NetworkImage(avatarUrl)
                              : AssetImage(avatarUrl) as ImageProvider,
                          backgroundColor: const Color(0xFFE2E8F8),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F3FF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '@${comment['username']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Color(0xFF151C27),
                                      ),
                                    ),
                                    Text(
                                      comment['time']!,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF777587),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  comment['text']!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF151C27),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                  backgroundColor: Color(0xFFE2E8F8),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F3FF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _commentController,
                      focusNode: _commentFocusNode,
                      decoration: const InputDecoration(
                        hintText: 'Add a polite comment...',
                        hintStyle:
                            TextStyle(fontSize: 13, color: Color(0xFF777587)),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      onSubmitted: (_) => _addComment(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFF3525CD),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_upward,
                        size: 18, color: Colors.white),
                    onPressed: _addComment,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
