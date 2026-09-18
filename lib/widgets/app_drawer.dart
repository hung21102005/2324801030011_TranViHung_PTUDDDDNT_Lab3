import 'package:flutter/material.dart';

import '../models/user.dart';

class AppDrawer extends StatelessWidget {
  final User user;
  final int selectedIndex;
  final int savedCount;
  final ValueChanged<int> onSelectTab;
  final VoidCallback onOpenProfile;

  const AppDrawer({
    super.key,
    required this.user,
    required this.selectedIndex,
    required this.savedCount,
    required this.onSelectTab,
    required this.onOpenProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 315,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drawer Top Header
          _buildDrawerHeader(context),

          // Menu navigation items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12, bottom: 8),
                  child: Text(
                    'MAIN MENU',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ),

                // Home Feed (Tab 0)
                _buildMenuItem(
                  context: context,
                  icon: Icons.home,
                  filledIcon: Icons.home,
                  title: 'Home Feed',
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    Navigator.pop(context);
                    onSelectTab(0);
                  },
                ),

                // Categories & Topics (Tab 1)
                _buildMenuItem(
                  context: context,
                  icon: Icons.category_outlined,
                  filledIcon: Icons.category,
                  title: 'Categories & Topics',
                  badge: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3525CD),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '6',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  isSelected: selectedIndex == 1,
                  onTap: () {
                    Navigator.pop(context);
                    onSelectTab(1);
                  },
                ),

                // Saved Posts (Tab 2)
                _buildMenuItem(
                  context: context,
                  icon: Icons.bookmark_border,
                  filledIcon: Icons.bookmark,
                  title: 'Saved Posts',
                  badge: Text(
                    '$savedCount',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF777587),
                    ),
                  ),
                  isSelected: selectedIndex == 2,
                  onTap: () {
                    Navigator.pop(context);
                    onSelectTab(2);
                  },
                ),

                // My Profile (Tab 3)
                _buildMenuItem(
                  context: context,
                  icon: Icons.person_outline,
                  filledIcon: Icons.person,
                  title: 'My Profile',
                  isSelected: selectedIndex == 3,
                  onTap: () {
                    Navigator.pop(context);
                    onOpenProfile();
                  },
                ),

                // Settings
                _buildMenuItem(
                  context: context,
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  isSelected: false,
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tính năng Cài đặt đang phát triển.'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                // Flutter Practice Navigation Info Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F3FF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F8)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.flutter_dash,
                              size: 16, color: Color(0xFF3525CD)),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Flutter Drawer Contract',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3525CD),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Use Scaffold.drawer & Navigator to switch routes and pass data smoothly.',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF464555),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Drawer Footer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFFAFAFC),
              border: Border(
                top: BorderSide(color: Color(0xFFF0F0F0)),
              ),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () => _showLogoutDialog(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: const Row(
                      children: [
                        Icon(Icons.logout, size: 20, color: Colors.red),
                        SizedBox(width: 12),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Socially v1.0.4 • Lab 4',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F8),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'FLUTTER',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF464555),
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
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF0F3FF),
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F8)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close button at top right
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 18,
                  color: Color(0xFF464555),
                ),
              ),
            ),
          ),

          // Avatar with gradient ring and school badge
          Stack(
            children: [
              Container(
                width: 72,
                height: 72,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF3525CD), Color(0xFF818CF8)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: CircleAvatar(
                  radius: 34,
                  backgroundColor: const Color(0xFFE2E8F8),
                  backgroundImage: user.avatarProvider,
                  child: user.avatar.isEmpty
                      ? Text(
                          user.name.substring(0, 2).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3525CD),
                          ),
                        )
                      : null,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3525CD),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child:
                      const Icon(Icons.school, size: 12, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Name and verified icon
          Row(
            children: [
              Flexible(
                child: Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF151C27),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.verified,
                size: 17,
                color: Color(0xFF3525CD),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            '@${user.username}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF777587),
            ),
          ),
          const SizedBox(height: 10),

          // Pill tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F8)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.code, size: 13, color: Color(0xFF3525CD)),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    user.bio.isNotEmpty
                        ? user.bio
                        : 'Software Engineering Student',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3525CD),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Stats row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F8)),
            ),
            child: Row(
              children: [
                Expanded(child: _buildStatItem('15', 'Posts')),
                _buildVerticalDivider(),
                Expanded(child: _buildStatItem('${user.followers}', 'Followers')),
                _buildVerticalDivider(),
                Expanded(child: _buildStatItem('${user.following}', 'Following')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF151C27),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF777587),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 20,
      color: const Color(0xFFE2E8F8),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    IconData? filledIcon,
    required String title,
    Widget? badge,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final effectiveIcon = isSelected && filledIcon != null ? filledIcon : icon;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: isSelected ? const Color(0xFFF0F3FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            child: Row(
              children: [
                Icon(
                  effectiveIcon,
                  size: 22,
                  color: isSelected
                      ? const Color(0xFF3525CD)
                      : const Color(0xFF777587),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF3525CD)
                          : const Color(0xFF151C27),
                    ),
                  ),
                ),
                ?badge,
                if (isSelected && badge == null)
                  Container(
                    width: 5,
                    height: 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3525CD),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất khỏi Socially?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã đăng xuất thành công.'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }
}
