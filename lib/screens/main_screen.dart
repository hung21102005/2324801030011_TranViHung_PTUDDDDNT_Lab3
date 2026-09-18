import 'package:flutter/material.dart';

import '../models/post.dart';
import '../models/user.dart';
import '../widgets/app_drawer.dart';
import 'categories_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'saved_posts_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const User currentUser = User(
    id: 'u1',
    name: 'Tran Vi Hung',
    username: 'tranvihung',
    avatar: 'assets/avatar.jpg',
    bio: 'Software Engineering Student',
    followers: 120,
    following: 80,
  );

  static const User minhUser = User(
    id: 'u2',
    name: 'Minh Tran',
    username: 'minhtran',
    avatar: '',
    bio: 'Flutter Developer',
    followers: 85,
    following: 40,
  );

  static const User annaUser = User(
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
      user: currentUser,
      content:
          'Beautiful day for a walk! 🌸 The cherry blossoms right outside University Hall are in full bloom today.',
      image:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuALy_h2qXaZLOv0eluHLcB1sSUtkyoKc4PoWbwcdx10U61AyNVuAMNMBVXsU_FEDO-Wrazke-LJxJrpODGgTe42MXEPh_RWpfEQk5Z1fJn6v7lfkFt5HmSdNN_UQ_KgJW7z4BJeBF27s5o2KTPeZtYxL1vlb3yjNh2S-I9sGoF-sywwiE1Za2PBd4DogM0xAW9bqQjC19n81JUHkz0PUJT_sJkel8oq605ojyhDBk73AzaAemWRo0hz',
      likes: 120,
      comments: 18,
      isLiked: false,
      isBookmarked: true,
      categoryTag: '#CampusLife',
    ),
    const Post(
      id: 'p2',
      user: minhUser,
      content:
          'Working on my Flutter project today. Clean architecture + state management feeling super solid! 💻✨',
      image:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA_f3Xap0TBmAWACuVipukIHcDq7mUiEUj_mThCnMmwDSyvWaWD6QJi5S9Pa7GBBDwv5n7aNiTh7tIHevDrAmWeqfZD3IVVAOzNy4Up92ZF902Bl6o-JPJ9UaJY1F7piNvEHkbovvEqiLf_61GkvtsHkvuvigUHA1Nv0IJ_WM7N5QfDEarTmh14_-3pbItHw4nZNI3aWAlSVk8Daah3bJVJbYTs8dM2aSGh7eOsjyMX0Uc_i9DHefZz',
      likes: 85,
      comments: 12,
      isLiked: true,
      isBookmarked: false,
      categoryTag: '#Tech',
    ),
    const Post(
      id: 'p3',
      user: annaUser,
      content:
          'Coffee and coding ☕\nAt Student Union Café • Testing local state persistence and navigation.',
      image: '',
      likes: 64,
      comments: 8,
      isLiked: false,
      isBookmarked: false,
      categoryTag: '#StudySprint',
    ),
  ];

  void _updatePost(Post updated) {
    setState(() {
      final index = _posts.indexWhere((p) => p.id == updated.id);
      if (index != -1) {
        _posts[index] = updated;
      }
    });
  }

  void _deletePost(int index) {
    setState(() {
      _posts.removeAt(index);
    });
  }

  void _addPost(Post newPost) {
    setState(() {
      _posts.insert(0, newPost);
    });
  }

  @override
  Widget build(BuildContext context) {
    final savedCount = _posts.where((p) => p.isBookmarked).length;

    final screens = [
      // Tab 0: Feed (Home)
      HomeScreen(
        posts: _posts,
        currentUser: currentUser,
        onPostUpdated: _updatePost,
        onPostDeleted: _deletePost,
        onCreatePost: _addPost,
        onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
        onOpenProfile: () => setState(() => _currentIndex = 3),
      ),

      // Tab 1: Categories
      CategoriesScreen(
        posts: _posts,
        onPostUpdated: _updatePost,
        onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
      ),

      // Tab 2: Saved Posts
      SavedPostsScreen(
        posts: _posts,
        onPostUpdated: _updatePost,
        onExplore: () => setState(() => _currentIndex = 1),
        onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
      ),

      // Tab 3: Profile
      const ProfileScreen(user: currentUser),
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        user: currentUser,
        selectedIndex: _currentIndex,
        savedCount: savedCount,
        onSelectTab: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onOpenProfile: () {
          setState(() {
            _currentIndex = 3;
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () async {
                final newPost =
                    await Navigator.pushNamed(context, '/create-post');
                if (newPost != null && newPost is Post) {
                  _addPost(newPost);
                }
              },
              backgroundColor: const Color(0xFF3525CD),
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('Create Post'),
            )
          : null,
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFF0F0F0)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Feed',
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.category_outlined,
                activeIcon: Icons.category,
                label: 'Categories',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.bookmark_border,
                activeIcon: Icons.bookmark,
                label: 'Saved',
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F3FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  activeIcon,
                  size: 22,
                  color: const Color(0xFF3525CD),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Icon(
                  icon,
                  size: 22,
                  color: const Color(0xFF777587),
                ),
              ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF3525CD)
                    : const Color(0xFF777587),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
