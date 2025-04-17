import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_expense_tracker/theme/app_theme.dart';

enum ForgotPasswordStage {
  enterEmail,
  emailEntered,
  verifyCode,
  resetPassword,
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordStage _currentStage = ForgotPasswordStage.enterEmail;
  final TextEditingController _emailController = TextEditingController();
  final List<TextEditingController> _codeControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _codeFocusNodes = List.generate(
    4,
    (_) => FocusNode(),
  );
  
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  // ignore: unused_field
  String? _maskedEmail;

  @override
  void initState() {
    super.initState();
    // Add listener to email controller to update UI when text changes
    _emailController.addListener(_handleEmailChange);
    
    // Debug print initial state
    print('ForgotPasswordScreen initialized');
  }

  void _handleEmailChange() {
    // Debug print to see when text changes
    print('Email changed: ${_emailController.text}');
    print('Email empty: ${_emailController.text.isEmpty}');
    
    // Force rebuild of UI to update button state
    setState(() {});
  }

  @override
  void dispose() {
    // Remove the listener before disposing
    _emailController.removeListener(_handleEmailChange);
    _emailController.dispose();
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var node in _codeFocusNodes) {
      node.dispose();
    }
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _moveToNextStage() {
    print('Moving to next stage from: $_currentStage');
    setState(() {
      if (_currentStage == ForgotPasswordStage.enterEmail) {
        _currentStage = ForgotPasswordStage.emailEntered;
        // Mask the email for display
        String email = _emailController.text;
        int atIndex = email.indexOf('@');
        if (atIndex > 1) {
          String username = email.substring(0, atIndex);
          String domain = email.substring(atIndex);
          _maskedEmail = '${username[0]}${username.substring(1).replaceAll(RegExp('.'), '*')}$domain';
        } else {
          _maskedEmail = email; // Fallback if email format is invalid
        }
        print('Masked email: $_maskedEmail');
      } else if (_currentStage == ForgotPasswordStage.emailEntered) {
        _currentStage = ForgotPasswordStage.verifyCode;
      } else if (_currentStage == ForgotPasswordStage.verifyCode) {
        _currentStage = ForgotPasswordStage.resetPassword;
      }
      print('Moved to stage: $_currentStage');
    });
  }

  void _goBack() {
    print('Going back from stage: $_currentStage');
    setState(() {
      if (_currentStage == ForgotPasswordStage.emailEntered) {
        _currentStage = ForgotPasswordStage.enterEmail;
      } else if (_currentStage == ForgotPasswordStage.verifyCode) {
        _currentStage = ForgotPasswordStage.emailEntered;
      } else if (_currentStage == ForgotPasswordStage.resetPassword) {
        _currentStage = ForgotPasswordStage.verifyCode;
      } else {
        Navigator.of(context).pop();
      }
      print('Now at stage: $_currentStage');
    });
  }

  void _handleCodeInput(String value, int index) {
    print('Code input at index $index: $value');
    if (value.isNotEmpty) {
      if (index < 3) {
        _codeFocusNodes[index + 1].requestFocus();
      } else {
        // Last digit entered
        _codeFocusNodes[index].unfocus();
        // Check if all fields have been filled
        bool allFilled = _codeControllers.every((controller) => controller.text.isNotEmpty);
        print('All code fields filled: $allFilled');
        if (allFilled) {
          // Delay a bit to show filled state before proceeding
          Future.delayed(const Duration(milliseconds: 300), () {
            _moveToNextStage();
          });
        }
      }
    }
  }

  bool _isValidPassword() {
    bool isValid = _passwordController.text.length >= 8 && 
                  _passwordController.text == _confirmPasswordController.text;
    print('Password valid: $isValid (length: ${_passwordController.text.length}, match: ${_passwordController.text == _confirmPasswordController.text})');
    return isValid;
  }

  void _resetPassword() {
    print('Resetting password');
    if (_isValidPassword()) {
      // Show success dialog
      print('Password validation successful, showing success dialog');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success', style: AppTheme.displaySmallBold()),
          content: Text(
            'Your password has been reset successfully.',
            style: AppTheme.textMedium(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Return to login screen
              },
              child: Text('Login', style: AppTheme.textMedium(color: AppTheme.primaryColor)),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
        ),
      );
    } else {
      // Show error message
      print('Password validation failed, showing error snackbar');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _passwordController.text != _confirmPasswordController.text
                ? 'Passwords do not match'
                : 'Password must be at least 8 characters',
            style: AppTheme.textSmall(color: Colors.white),
          ),
          backgroundColor: AppTheme.danger,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _resendEmail() {
    // Resend verification email logic
    print('Resending verification email to: ${_emailController.text}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Verification code has been resent to ${_emailController.text}',
          style: AppTheme.textSmall(color: Colors.white),
        ),
        backgroundColor: AppTheme.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Building ForgotPasswordScreen, current stage: $_currentStage');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: _goBack,
        ),
        title: Text(
          'Registration - Forget Password - ${_getStageIndex()}',
          style: AppTheme.textSmall(color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                _getHeaderText(),
                style: AppTheme.displayMediumBold(),
              ),
              SizedBox(height: AppTheme.spaceM),
              
              // Instruction text
              Text(
                _getInstructionText(),
                style: AppTheme.textMedium(color: AppTheme.secondaryColor),
              ),
              SizedBox(height: AppTheme.spaceXL),
              
              // Content based on current stage
              _buildStageContent(),
              
              const Spacer(),
              
              // Bottom action
              _buildBottomAction(),
            ],
          ),
        ),
      ),
    );
  }
  
  String _getStageIndex() {
    switch (_currentStage) {
      case ForgotPasswordStage.enterEmail:
        return '1';
      case ForgotPasswordStage.emailEntered:
        return '1';
      case ForgotPasswordStage.verifyCode:
        return '2';
      case ForgotPasswordStage.resetPassword:
        return '3';
    }
  }
  
  String _getHeaderText() {
    switch (_currentStage) {
      case ForgotPasswordStage.enterEmail:
      case ForgotPasswordStage.emailEntered:
        return 'Forgot password';
      case ForgotPasswordStage.verifyCode:
        return 'Check your email';
      case ForgotPasswordStage.resetPassword:
        return 'Reset password';
    }
  }
  
  String _getInstructionText() {
    switch (_currentStage) {
      case ForgotPasswordStage.enterEmail:
      case ForgotPasswordStage.emailEntered:
        return 'Please enter your email to reset the password';
      case ForgotPasswordStage.verifyCode:
        return 'We sent a reset link to ${_emailController.text}\nenter 4 digit code that mentioned in the email';
      case ForgotPasswordStage.resetPassword:
        return 'Create a new password for your account';
    }
  }

  Widget _buildStageContent() {
    print('Building stage content for stage: $_currentStage');
    switch (_currentStage) {
      case ForgotPasswordStage.enterEmail:
        return _buildEmailInputStage();
      case ForgotPasswordStage.emailEntered:
        return _buildEmailConfirmationStage();
      case ForgotPasswordStage.verifyCode:
        return _buildVerificationCodeStage();
      case ForgotPasswordStage.resetPassword:
        return _buildResetPasswordStage();
    }
  }
  
  Widget _buildEmailInputStage() {
    // Debug print to see the current value when building
    print('Building email input stage, email: ${_emailController.text}');
    print('Email field empty: ${_emailController.text.isEmpty}');
    
    return Column(
      children: [
        // Email input field
        Container(
          decoration: BoxDecoration(
            color: AppTheme.lightBackground,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceM),
            child: Row(
              children: [
                Icon(Icons.email_outlined, color: AppTheme.primaryColor),
                SizedBox(width: AppTheme.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Email',
                          style: AppTheme.textSmall(color: AppTheme.secondaryColor),
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: AppTheme.textMedium(),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          // Additional debug print when text changes
                          print('TextField onChanged: $value');
                          // Force rebuild of UI
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppTheme.spaceXL),
        
        // Reset button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _emailController.text.isEmpty 
                ? null 
                : () {
                    print('Reset button pressed, email: ${_emailController.text}');
                    _moveToNextStage();
                  },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                bool isDisabled = states.contains(WidgetState.disabled);
                print('Button disabled: $isDisabled');
                if (isDisabled) {
                  return AppTheme.primaryColor.withOpacity(0.5);
                }
                return const Color(0xFF99C0FF); // Light blue from image
              }),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
              ),
            ),
            child: const Text('Reset Password'),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailConfirmationStage() {
    print('Building email confirmation stage');
    return Column(
      children: [
        // Email display field
        Container(
          decoration: BoxDecoration(
            color: AppTheme.lightBackground,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceM),
            child: Row(
              children: [
                Icon(Icons.email_outlined, color: AppTheme.primaryColor),
                SizedBox(width: AppTheme.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Email',
                          style: AppTheme.textSmall(color: AppTheme.secondaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          _emailController.text,
                          style: AppTheme.textMedium(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppTheme.spaceXL),
        
        // Reset button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              print('Email confirmation stage - Reset button pressed');
              _moveToNextStage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
            ),
            child: const Text('Reset Password'),
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationCodeStage() {
    print('Building verification code stage');
    return Column(
      children: [
        // Verification code fields
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) => SizedBox(
              width: 60,
              height: 60,
              child: TextFormField(
                controller: _codeControllers[index],
                focusNode: _codeFocusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    borderSide: BorderSide(color: AppTheme.secondaryColor.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    borderSide: BorderSide(color: AppTheme.primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: AppTheme.displayMedium(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) => _handleCodeInput(value, index),
              ),
            ),
          ),
        ),
        SizedBox(height: AppTheme.spaceXL),
        
        // Verify button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _isCodeComplete() ? () {
              print('Verify code button pressed');
              _moveToNextStage();
            } : null,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                bool isDisabled = states.contains(WidgetState.disabled);
                print('Verify code button disabled: $isDisabled');
                if (isDisabled) {
                  return AppTheme.primaryColor.withOpacity(0.5);
                }
                return const Color(0xFF99C0FF);
              }),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
              ),
            ),
            child: const Text('Verify Code'),
          ),
        ),
      ],
    );
  }
  
  bool _isCodeComplete() {
    bool isComplete = _codeControllers.every((controller) => controller.text.isNotEmpty);
    print('Code complete: $isComplete');
    return isComplete;
  }

  Widget _buildResetPasswordStage() {
    print('Building reset password stage');
    return Column(
      children: [
        // New Password field
        Container(
          decoration: BoxDecoration(
            color: AppTheme.lightBackground,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceM),
            child: Row(
              children: [
                Icon(Icons.lock_outline, color: AppTheme.primaryColor),
                SizedBox(width: AppTheme.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'New Password',
                          style: AppTheme.textSmall(color: AppTheme.secondaryColor),
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter new password',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: AppTheme.secondaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        style: AppTheme.textMedium(),
                        onChanged: (value) {
                          print('New password changed: $value');
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppTheme.spaceM),
        
        // Confirm Password field
        Container(
          decoration: BoxDecoration(
            color: AppTheme.lightBackground,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceM),
            child: Row(
              children: [
                Icon(Icons.lock_outline, color: AppTheme.primaryColor),
                SizedBox(width: AppTheme.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Confirm Password',
                          style: AppTheme.textSmall(color: AppTheme.secondaryColor),
                        ),
                      ),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          hintText: 'Confirm your password',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                              color: AppTheme.secondaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        style: AppTheme.textMedium(),
                        onChanged: (value) {
                          print('Confirm password changed: $value');
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppTheme.spaceXL),
        
        // Password requirements
        Container(
          padding: EdgeInsets.all(AppTheme.spaceM),
          decoration: BoxDecoration(
            color: AppTheme.lightBackground,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password must:',
                style: AppTheme.textSmall(color: AppTheme.secondaryColor),
              ),
              SizedBox(height: AppTheme.spaceS),
              _buildRequirementRow(
                'Be at least 8 characters',
                _passwordController.text.length >= 8,
              ),
              SizedBox(height: AppTheme.spaceXS),
              _buildRequirementRow(
                'Passwords match',
                _passwordController.text.isNotEmpty && 
                _passwordController.text == _confirmPasswordController.text,
              ),
            ],
          ),
        ),
        SizedBox(height: AppTheme.spaceXL),
        
        // Reset button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _isValidPassword() ? () {
              print('Final reset password button pressed');
              _resetPassword();
            } : null,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                bool isDisabled = states.contains(WidgetState.disabled);
                print('Reset password button disabled: $isDisabled');
                if (isDisabled) {
                  return AppTheme.primaryColor.withOpacity(0.5);
                }
                return AppTheme.primaryColor;
              }),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
              ),
            ),
            child: const Text('Reset Password'),
          ),
        ),
      ],
    );
  }
  
  Widget _buildRequirementRow(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle_outlined,
          color: isMet ? AppTheme.accentGreen : AppTheme.secondaryColor,
          size: 16,
        ),
        SizedBox(width: AppTheme.spaceXS),
        Text(
          text,
          style: AppTheme.textSmall(
            color: isMet ? AppTheme.accentGreen : AppTheme.secondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction() {
    print('Building bottom action for stage: $_currentStage');
    if (_currentStage == ForgotPasswordStage.verifyCode) {
      return Center(
        child: Column(
          children: [
            Text("Haven't got the email yet?", style: AppTheme.textMedium()),
            TextButton(
              onPressed: _resendEmail,
              child: Text(
                'Resend email',
                style: AppTheme.textMedium(color: AppTheme.primaryColor),
              ),
            ),
          ],
        ),
      );
    } else if (_currentStage != ForgotPasswordStage.resetPassword) {
      return Center(
        child: Column(
          children: [
            Text("Don't have an account?", style: AppTheme.textMedium()),
            TextButton(
              onPressed: null, // Disabled as per requirement
              child: Text(
                'Create Account',
                style: AppTheme.textMedium(color: AppTheme.primaryColor),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink(); // No bottom action for reset password stage
    }
  }
}