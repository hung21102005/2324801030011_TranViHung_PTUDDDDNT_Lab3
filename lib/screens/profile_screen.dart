import 'package:flutter/material.dart';

import '../models/post.dart';
import '../models/user.dart';
import 'post_detail_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;
  bool _isFollowing = false;
  bool _isGridView = true;

  late final List<Post> _userPosts;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _userPosts = [
      Post(
        id: 'user_p1',
        user: _user,
        content:
            'Beautiful day for a walk! 🌸 The cherry blossoms right outside University Hall are in full bloom today.',
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuALy_h2qXaZLOv0eluHLcB1sSUtkyoKc4PoWbwcdx10U61AyNVuAMNMBVXsU_FEDO-Wrazke-LJxJrpODGgTe42MXEPh_RWpfEQk5Z1fJn6v7lfkFt5HmSdNN_UQ_KgJW7z4BJeBF27s5o2KTPeZtYxL1vlb3yjNh2S-I9sGoF-sywwiE1Za2PBd4DogM0xAW9bqQjC19n81JUHkz0PUJT_sJkel8oq605ojyhDBk73AzaAemWRo0hz',
        likes: 42,
        comments: 6,
      ),
      Post(
        id: 'user_p2',
        user: _user,
        content:
            'Late night coding session 💻 Working on Flutter state management and navigation!',
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuA_f3Xap0TBmAWACuVipukIHcDq7mUiEUj_mThCnMmwDSyvWaWD6QJi5S9Pa7GBBDwv5n7aNiTh7tIHevDrAmWeqfZD3IVVAOzNy4Up92ZF902Bl6o-JPJ9UaJY1F7piNvEHkbovvEqiLf_61GkvtsHkvuvigUHA1Nv0IJ_WM7N5QfDEarTmh14_-3pbItHw4nZNI3aWAlSVk8Daah3bJVJbYTs8dM2aSGh7eOsjyMX0Uc_i9DHefZz',
        likes: 28,
        comments: 4,
      ),
    ];
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _user.name);
    final bioController = TextEditingController(text: _user.bio);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF151C27),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(
                labelText: 'Bio / Major',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _user = _user.copyWith(
                      name: nameController.text.trim(),
                      bio: bioController.text.trim(),
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đã cập nhật thông tin cá nhân thành công!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3525CD),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã sao chép liên kết hồ sơ của @${_user.username}!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = _user.username == 'tranvihung';

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF151C27)),
          onPressed: () {
            // Quay lại màn hình trước đó
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profile',
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
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Avatar lớn
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: const Color(0xFFE2E8F8),
                    backgroundImage: _user.avatarProvider,
                    child: _user.avatar.isEmpty
                        ? Text(
                            _user.name.substring(0, 2).toUpperCase(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3525CD),
                            ),
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF3525CD),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.school,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Tên & Username
            Text(
              _user.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF151C27),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '@${_user.username}',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF777587),
              ),
            ),

            // Bio badge
            if (_user.bio.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.terminal,
                        size: 16, color: Color(0xFF3525CD)),
                    const SizedBox(width: 6),
                    Text(
                      _user.bio,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3525CD),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Dải thống kê (Posts, Followers, Following)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('Posts', '${_userPosts.length + 13}'),
                  _buildDivider(),
                  _buildStatItem('Followers', '${_user.followers}'),
                  _buildDivider(),
                  _buildStatItem('Following', '${_user.following}'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Hàng nút tương tác: [Edit Profile / Follow] + [Share]
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isCurrentUser
                        ? _showEditProfileDialog
                        : () {
                            setState(() {
                              _isFollowing = !_isFollowing;
                              _user = _user.copyWith(
                                followers: _isFollowing
                                    ? _user.followers + 1
                                    : (_user.followers > 0
                                        ? _user.followers - 1
                                        : 0),
                              );
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_isFollowing
                                    ? 'Đã theo dõi @${_user.username}'
                                    : 'Đã hủy theo dõi @${_user.username}'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCurrentUser || !_isFollowing
                          ? const Color(0xFF3525CD)
                          : const Color(0xFFE2E8F8),
                      foregroundColor: isCurrentUser || !_isFollowing
                          ? Colors.white
                          : const Color(0xFF3525CD),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: Icon(
                      isCurrentUser
                          ? Icons.edit_outlined
                          : (_isFollowing
                              ? Icons.check
                              : Icons.person_add_outlined),
                      size: 18,
                    ),
                    label: Text(
                      isCurrentUser
                          ? 'Edit Profile'
                          : (_isFollowing ? 'Following' : 'Follow'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.share_outlined,
                        color: Color(0xFF3525CD), size: 20),
                    onPressed: _shareProfile,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Bio thông tin chi tiết
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F3FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_outline,
                      color: Color(0xFF3525CD), size: 22),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Senior Project in progress',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF151C27),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Building accessible mobile apps & campus tools with Flutter and Tailwind. Coffee lover!',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF464555),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Tiêu đề Posts + Toggle View
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Posts',
                      style: TextStyle(
                        fontSize: 18,
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
                        '${_userPosts.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F0069),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.grid_view,
                        size: 20,
                        color: _isGridView
                            ? const Color(0xFF3525CD)
                            : const Color(0xFF777587),
                      ),
                      onPressed: () {
                        setState(() {
                          _isGridView = true;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.view_list_outlined,
                        size: 20,
                        color: !_isGridView
                            ? const Color(0xFF3525CD)
                            : const Color(0xFF777587),
                      ),
                      onPressed: () {
                        setState(() {
                          _isGridView = false;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Hiển thị danh sách / lưới bài viết
            _isGridView
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: _userPosts.length,
                    itemBuilder: (context, index) {
                      return _buildGridPost(_userPosts[index]);
                    },
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _userPosts.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final post = _userPosts[index];
                      return Card(
                        elevation: 0.5,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostDetailScreen(post: post),
                              ),
                            );
                            if (updated != null && updated is Post) {
                              setState(() {
                                _userPosts[index] = updated;
                              });
                            }
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              post.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 50,
                                height: 50,
                                color: const Color(0xFFE2E8F8),
                                child: const Icon(Icons.image,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                          title: Text(
                            post.content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              const Icon(Icons.favorite,
                                  size: 14, color: Color(0xFF8F0055)),
                              const SizedBox(width: 4),
                              Text('${post.likes}'),
                              const SizedBox(width: 12),
                              const Icon(Icons.chat_bubble_outline,
                                  size: 14, color: Color(0xFF777587)),
                              const SizedBox(width: 4),
                              Text('${post.comments}'),
                            ],
                          ),
                          trailing: const Icon(Icons.chevron_right, size: 20),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label: $value'),
            duration: const Duration(milliseconds: 800),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF151C27),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF777587),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: const Color(0xFFE2E8F8),
    );
  }

  Widget _buildGridPost(Post post) {
    return Container(
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
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          final updated = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(post: post),
            ),
          );
          if (updated != null && updated is Post) {
            setState(() {
              final index = _userPosts.indexWhere((p) => p.id == updated.id);
              if (index != -1) {
                _userPosts[index] = updated;
              }
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    post.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFE2E8F8),
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite,
                              size: 12, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            '${post.likes}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF151C27),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '2d ago',
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
    );
  }
}
