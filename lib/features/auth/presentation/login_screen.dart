import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

/// Login Ekranı - Mockup'a birebir uygun
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    // TODO: Firebase Auth entegrasyonu
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() => _isLoading = false);
    
    if (mounted) {
      context.goNamed('home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.08),
                
                // Floating hearts decoration
                _buildFloatingHearts(),
                
                SizedBox(height: size.height * 0.02),
                
                // Logo ve Başlık
                _buildHeader(),
                
                SizedBox(height: size.height * 0.06),
                
                // Login Form
                _buildLoginForm(),
                
                SizedBox(height: size.height * 0.04),
                
                // Login Button
                _buildLoginButton(),
                
                SizedBox(height: size.height * 0.03),
                
                // Kayıt Ol linki
                _buildSignupLink(),
                
                SizedBox(height: size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingHearts() {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Positioned(
            left: 40,
            child: Text(
              '💕',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            right: 60,
            top: 10,
            child: Text(
              '💕',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Başlık
        Text(
          AppStrings.welcome,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        
        // Alt başlık
        Text(
          AppStrings.loginSubtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardPink,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Email Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppColors.textOnPink),
              decoration: InputDecoration(
                hintText: AppStrings.email,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.errorInvalidEmail;
                }
                if (!value.contains('@')) {
                  return AppStrings.errorInvalidEmail;
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Password Field
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              style: TextStyle(color: AppColors.textOnPink),
              decoration: InputDecoration(
                hintText: AppStrings.password,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword 
                      ? Icons.visibility_off_outlined 
                      : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.errorWeakPassword;
                }
                if (value.length < 6) {
                  return AppStrings.errorWeakPassword;
                }
                return null;
              },
            ),
            
            const SizedBox(height: 8),
            
            // Şifremi Unuttum
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Şifre sıfırlama
                },
                child: Text(
                  AppStrings.forgotPassword,
                  style: TextStyle(
                    color: AppColors.textOnPink.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        child: _isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.textOnPink,
              ),
            )
          : const Text(AppStrings.login),
      ),
    );
  }

  Widget _buildSignupLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.noAccount,
          style: TextStyle(color: AppColors.textPrimary),
        ),
        TextButton(
          onPressed: () => context.goNamed('signup'),
          child: const Text(AppStrings.signup),
        ),
      ],
    );
  }
}
