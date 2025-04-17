import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_expense_tracker/theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController(text: 'mohammed');
  final TextEditingController _nickNameController = TextEditingController(text: 'Moh');
  final TextEditingController _emailController = TextEditingController(text: 'youremail@domain.com');
  final TextEditingController _phoneController = TextEditingController(text: '123-456-7890');
  final TextEditingController _addressController = TextEditingController(text: 'KFUPM');
  String _selectedCountry = 'Saudi';
  String _selectedGender = 'Male';
  String _profileImagePath = ''; // For actual implementation, store path to profile image

  @override
  void dispose() {
    _fullNameController.dispose();
    _nickNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    // Implement save profile logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Profile updated successfully',
          style: AppTheme.textSmall(color: Colors.white),
        ),
        backgroundColor: AppTheme.success,
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Edit profile',
          style: AppTheme.displaySmall(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppTheme.spaceL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Form fields
                _buildProfileFormField('Full name', _fullNameController),
                SizedBox(height: AppTheme.spaceM),
                
                _buildProfileFormField('Nick name', _nickNameController),
                SizedBox(height: AppTheme.spaceM),
                
                _buildProfileFormField('Label', _emailController),
                SizedBox(height: AppTheme.spaceM),
                
                // Phone field with flag
                _buildPhoneField(),
                SizedBox(height: AppTheme.spaceM),
                
                // Country and gender row
                Row(
                  children: [
                    Expanded(child: _buildDropdownField('Country', _selectedCountry, ['Saudi', 'UAE', 'USA', 'UK'])),
                    SizedBox(width: AppTheme.spaceM),
                    Expanded(child: _buildDropdownField('Gender', _selectedGender, ['Male', 'Female', 'Other'])),
                  ],
                ),
                SizedBox(height: AppTheme.spaceM),
                
                _buildProfileFormField('Address', _addressController),
                SizedBox(height: AppTheme.spaceXL),
                
                // Submit button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      ),
                    ),
                    child: const Text('SUBMIT'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileFormField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightBackground,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceM, vertical: AppTheme.spaceS),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            labelStyle: AppTheme.textSmall(color: Colors.grey),
          ),
          style: AppTheme.textMedium(),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightBackground,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceM, vertical: AppTheme.spaceS),
        child: Row(
          children: [
            // US Flag placeholder
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/KSA_flag.png', // You would need this asset in your project
                    width: 24,
                    height: 16,
                    fit: BoxFit.cover,
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.grey.shade600, size: 20),
                ],
              ),
            ),
            SizedBox(width: AppTheme.spaceS),
            Expanded(
              child: TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  border: InputBorder.none,
                  labelStyle: AppTheme.textSmall(color: Colors.grey),
                ),
                style: AppTheme.textMedium(),
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> options) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightBackground,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceM, vertical: AppTheme.spaceS),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTheme.textSmall(color: Colors.grey),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: options.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      if (label == 'Country') {
                        _selectedCountry = newValue;
                      } else if (label == 'Gender') {
                        _selectedGender = newValue;
                      }
                    });
                  }
                },
                style: AppTheme.textMedium(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// This is how you would create a profile view screen based on the first image
class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Blue header with profile image
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Blue background with wave
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Row(
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
                  ],
                ),
              ),
              // Bottom white wave shape
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              // Profile image
              Positioned(
                bottom: -20,
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(Icons.person, color: Colors.white, size: 60),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.edit, color: Colors.black, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 30),
          
          // Profile info
          Text(
            'Mohammed kh',
            style: AppTheme.displaySmallBold(),
          ),
          SizedBox(height: AppTheme.spaceXS),
          Text(
            'youremail@domain.com | +966 1234 567 89',
            style: AppTheme.textSmall(color: AppTheme.secondaryColor),
          ),
          
          SizedBox(height: AppTheme.spaceL),
          
          // Menu options
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceL),
            child: Column(
              children: [
                _buildMenuOption(
                  context,
                  Icons.person_outline,
                  'Edit profile information',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfileScreen()),
                  ),
                ),
                _buildDivider(),
                _buildMenuOption(context, Icons.notifications_outlined, 'Notifications', trailingText: 'ON'),
                _buildDivider(),
                _buildMenuOption(context, Icons.language, 'Language', trailingText: 'English'),
                _buildDivider(),
                SizedBox(height: AppTheme.spaceM),
                _buildMenuOption(context, Icons.lock_outline, 'Password'),
                _buildDivider(),
                _buildMenuOption(context, Icons.calculate_outlined, 'Calculate Zakat'),
                _buildDivider(),
                SizedBox(height: AppTheme.spaceM),
                _buildMenuOption(context, Icons.help_outline, 'Help & Support'),
                _buildDivider(),
                _buildMenuOption(context, Icons.message_outlined, 'Contact us'),
                _buildDivider(),
                _buildMenuOption(context, Icons.privacy_tip_outlined, 'Privacy policy'),
                _buildDivider(),
              ],
            ),
          ),
          
          const Spacer(),
          
          // Bottom navigation
          Container(
            padding: EdgeInsets.symmetric(vertical: AppTheme.spaceM),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavBarItem(Icons.home_outlined, isSelected: true),
                _buildNavBarItem(Icons.wallet_outlined),
                _buildNavBarItem(Icons.grid_3x3),
                _buildNavBarItem(Icons.history),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMenuOption(
    BuildContext context, 
    IconData icon, 
    String text, 
    {String? trailingText, VoidCallback? onTap}
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppTheme.spaceM),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(width: AppTheme.spaceM),
            Expanded(
              child: Text(
                text,
                style: AppTheme.textMedium(),
              ),
            ),
            if (trailingText != null)
              Text(
                trailingText,
                style: AppTheme.textMedium(color: AppTheme.primaryColor),
              ),
            if (trailingText == null)
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 0.5);
  }
  
  Widget _buildNavBarItem(IconData icon, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: isSelected ? AppTheme.primaryColor : Colors.grey,
      ),
    );
  }
}