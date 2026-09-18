import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/post.dart';
import 'post_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Post> posts;
  final Function(Post) onPostUpdated;
  final VoidCallback onOpenDrawer;

  const CategoriesScreen({
    super.key,
    required this.posts,
    required this.onPostUpdated,
    required this.onOpenDrawer,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _selectedCategoryTag = '#CampusLife';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = CategoryItem.defaultCategories;
    final selectedCategory = categories.firstWhere(
      (c) => c.tag == _selectedCategoryTag,
      orElse: () => categories[2], // default Campus Life
    );

    // Filter posts by selected category and optional search text
    final filteredPosts = widget.posts.where((post) {
      final matchesCategory = _selectedCategoryTag.isEmpty ||
          post.categoryTag.toLowerCase() == _selectedCategoryTag.toLowerCase();
      final matchesSearch = _searchQuery.isEmpty ||
          post.content.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          post.user.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

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
          'Explore Categories',
          style: TextStyle(
            color: Color(0xFF151C27),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF464555)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sử dụng thanh tìm kiếm bên dưới.'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          Stack(
            alignment: Alignment.center,
            children: [
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
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. Search & Filter Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F8)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.trim();
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF777587)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tune, color: Color(0xFF777587)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bộ lọc nâng cao đang được cập nhật.'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  hintText: 'Search topics, tags or posts...',
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9E9E9E),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Section Title: All Categories (6)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ALL CATEGORIES (6)',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: Color(0xFF777587),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      // Toggle: if filter is on, show all or reset to default
                      _selectedCategoryTag =
                          _selectedCategoryTag.isEmpty ? '#CampusLife' : '';
                    });
                  },
                  child: Text(
                    _selectedCategoryTag.isEmpty ? 'Filter on' : 'View all',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3525CD),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 3. 2-column Grid of Category Cards
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.35,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = _selectedCategoryTag == category.tag;

                return _buildCategoryCard(category, isSelected);
              },
            ),
            const SizedBox(height: 20),

            // 4. Content Section below ("Trending in #[Category]")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 18,
                      color: selectedCategory.accentColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _selectedCategoryTag.isNotEmpty
                          ? 'Trending in '
                          : 'All Posts',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF151C27),
                      ),
                    ),
                    if (_selectedCategoryTag.isNotEmpty)
                      Text(
                        selectedCategory.tag,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: selectedCategory.accentColor,
                        ),
                      ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _selectedCategoryTag.isNotEmpty
                        ? 'Filter active'
                        : 'Showing all',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF464555),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Posts list filtered by category
            if (filteredPosts.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F8)),
                ),
                child: Column(
                  children: [
                    Text(
                      selectedCategory.emoji,
                      style: const TextStyle(fontSize: 36),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Chưa có bài viết trong chủ đề ${selectedCategory.tag}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF151C27),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Hãy là người đầu tiên chia sẻ về chủ đề này!',
                      style: TextStyle(fontSize: 12, color: Color(0xFF777587)),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/create-post');
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Tạo bài viết'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3525CD),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredPosts.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildMiniPostCard(context, filteredPosts[index]);
                },
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(CategoryItem category, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedCategoryTag == category.tag) {
            _selectedCategoryTag = ''; // toggle off
          } else {
            _selectedCategoryTag = category.tag;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? category.accentColor : const Color(0xFFE2E8F8),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? category.accentColor.withValues(alpha: 0.12)
                  : Colors.black12,
              blurRadius: isSelected ? 8 : 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Decorative top-right circle
            Positioned(
              top: -10,
              right: -10,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: category.bgColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: category.bgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          category.emoji,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      if (isSelected)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: category.accentColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    category.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF151C27),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: category.bgColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          category.tag,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: category.accentColor,
                          ),
                        ),
                      ),
                      Text(
                        '${category.postCount} posts',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF777587),
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
    );
  }

  Widget _buildMiniPostCard(BuildContext context, Post post) {
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
            widget.onPostUpdated(updated);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundImage: post.user.avatarProvider,
                          backgroundColor: const Color(0xFFE2E8F8),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.user.name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF151C27),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Text(
                                '10 min ago',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF777587),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F3FF),
                      borderRadius: BorderRadius.circular(12),
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
              const SizedBox(height: 8),

              // Content text
              Text(
                post.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF464555),
                  height: 1.4,
                ),
              ),

              // Image (if any)
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

              const SizedBox(height: 8),
              const Divider(height: 1, color: Color(0xFFF0F0F0)),
              const SizedBox(height: 6),

              // Action buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Like button
                      InkWell(
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
                              horizontal: 4, vertical: 2),
                          child: Row(
                            children: [
                              Icon(
                                post.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 16,
                                color: post.isLiked
                                    ? const Color(0xFF8F0055)
                                    : const Color(0xFF777587),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${post.likes}',
                                style: TextStyle(
                                  fontSize: 11,
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
                      // Comment button
                      Row(
                        children: [
                          const Icon(Icons.chat_bubble_outline,
                              size: 16, color: Color(0xFF777587)),
                          const SizedBox(width: 4),
                          Text(
                            '${post.comments}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF464555),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      post.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 18,
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
