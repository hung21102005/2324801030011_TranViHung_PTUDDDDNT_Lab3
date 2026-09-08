import 'package:flutter/material.dart';

import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF151C27)),
          onPressed: () {
            // Quay lại màn hình trước đó (PostDetailScreen)
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
            onPressed: () {},
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
                    backgroundImage: user.avatarProvider,
                    child: user.avatar.isEmpty
                        ? Text(
                            user.name.substring(0, 2).toUpperCase(),
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
              user.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF151C27),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '@${user.username}',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF777587),
              ),
            ),

            // Bio badge
            if (user.bio.isNotEmpty) ...[
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
                      user.bio,
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
                  _buildStatItem('Posts', '15'),
                  _buildDivider(),
                  _buildStatItem('Followers', '${user.followers}'),
                  _buildDivider(),
                  _buildStatItem('Following', '${user.following}'),
                ],
              ),
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

            // Tiêu đề Posts
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Posts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF151C27),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Lưới bài viết mock (2 cột)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.82,
              children: [
                _buildGridPost(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuALy_h2qXaZLOv0eluHLcB1sSUtkyoKc4PoWbwcdx10U61AyNVuAMNMBVXsU_FEDO-Wrazke-LJxJrpODGgTe42MXEPh_RWpfEQk5Z1fJn6v7lfkFt5HmSdNN_UQ_KgJW7z4BJeBF27s5o2KTPeZtYxL1vlb3yjNh2S-I9sGoF-sywwiE1Za2PBd4DogM0xAW9bqQjC19n81JUHkz0PUJT_sJkel8oq605ojyhDBk73AzaAemWRo0hz',
                  'Beautiful day for a walk! 🌸',
                  '42',
                  '2d ago',
                ),
                _buildGridPost(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuA_f3Xap0TBmAWACuVipukIHcDq7mUiEUj_mThCnMmwDSyvWaWD6QJi5S9Pa7GBBDwv5n7aNiTh7tIHevDrAmWeqfZD3IVVAOzNy4Up92ZF902Bl6o-JPJ9UaJY1F7piNvEHkbovvEqiLf_61GkvtsHkvuvigUHA1Nv0IJ_WM7N5QfDEarTmh14_-3pbItHw4nZNI3aWAlSVk8Daah3bJVJbYTs8dM2aSGh7eOsjyMX0Uc_i9DHefZz',
                  'Late night coding session 💻',
                  '28',
                  '5d ago',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
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
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: const Color(0xFFE2E8F8),
    );
  }

  Widget _buildGridPost(
      String imageUrl, String title, String likes, String time) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  imageUrl,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                          likes,
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
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF151C27),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF777587),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
