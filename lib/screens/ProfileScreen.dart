// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:auto_expense_tracker/screens/EditProfileScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(context),
              const SizedBox(height: 16),
              _buildProfileCard(context),
              const SizedBox(height: 16),
              _buildAccountCard(context),
              const SizedBox(height: 16),
              _buildSupportCard(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 59, 35, 245),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                  onPressed: () {},
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.history, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 110,
          child: Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.edit, size: 20, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 220,
          child: Column(
            children: [
              const Text(
                'Mohammed kh',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'youremail@domain.com | +966 1234 567 89',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 80),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.edit_document, color: Colors.black87),
                title: const Text('Edit profile information'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.notifications_none, color: Colors.black87),
                title: const Text('Notifications'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('ON', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
                onTap: () {},
              ),
            ),
            const Divider(height: 1),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.language, color: Colors.black87),
                title: const Text('Language'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('English', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.password, color: Colors.black87),
                title: const Text('Password'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
            const Divider(height: 1),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.calculate, color: Colors.black87),
                title: const Text('Calculate Zakat'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.black87),
                title: const Text('Help & Support'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
            const Divider(height: 1),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.message_outlined, color: Colors.black87),
                title: const Text('Contact us'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
            const Divider(height: 1),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.privacy_tip_outlined, color: Colors.black87),
                title: const Text('Privacy policy'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  }


