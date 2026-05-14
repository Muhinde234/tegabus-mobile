import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/requests/login_request.dart';
import 'package:mobile/screens/auth/forgot_password_screen.dart';
import 'package:mobile/screens/auth/register_screen.dart';
import 'package:mobile/screens/layout.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final loginState = ref.watch(loginNotifierProvider);

    ref.listen(loginNotifierProvider, (_, curr) {
      if (curr.isSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Layout()),
        );
      } else if (curr.isError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(curr.error.toString()),
          backgroundColor: DColors.danger6,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // ── Logo ──
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: DColors.primaryGradient,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: DColors.primary.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset('assets/logo.png', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('TegaBus',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: context.colors.primary)),
                ],
              ),
              const SizedBox(height: 40),

              // ── Heading ──
              Text(l.welcomeBack,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w900)),
              const SizedBox(height: 6),
              Text(l.signInSubtitle,
                  style:
                      TextStyle(color: context.colors.neutral4, fontSize: 15)),
              const SizedBox(height: 36),

              // ── Form ──
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: l.emailAddress,
                        prefixIcon: const Icon(Iconsax.sms, size: 20),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return l.enterEmail;
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordCtrl,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        hintText: l.passwordLabel,
                        prefixIcon: const Icon(Iconsax.lock, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure ? Iconsax.eye_slash : Iconsax.eye,
                            size: 20,
                          ),
                          onPressed: () =>
                              setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return l.enterPassword;
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ForgotPasswordScreen()),
                        ),
                        child: Text(
                          l.forgotPassword,
                          style: const TextStyle(
                              color: DColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── Sign In button ──
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: DColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: DColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: loginState.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(loginNotifierProvider.notifier).login(
                                  LoginRequest(
                                    email: _emailCtrl.text.trim(),
                                    password: _passwordCtrl.text,
                                  ),
                                );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: loginState.isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text(l.signInButton,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                ),
              ),

              const SizedBox(height: 28),

              // ── Divider ──
              Row(
                children: [
                  const Expanded(child: Divider(color: DColors.neutral2)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('or',
                        style: TextStyle(
                            color: context.colors.neutral4,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                  ),
                  const Expanded(child: Divider(color: DColors.neutral2)),
                ],
              ),

              const SizedBox(height: 28),

              // ── Social login ──
              _SocialButton(
                icon: Icons.g_mobiledata,
                label: 'Continue with Google',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _SocialButton(
                icon: Icons.apple,
                label: 'Continue with Apple',
                onTap: () {},
              ),

              const SizedBox(height: 32),

              // ── Register link ──
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l.dontHaveAccount,
                      style: TextStyle(color: context.colors.neutral4)),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterScreen()),
                    ),
                    child: Text(
                      l.registerLink,
                      style: const TextStyle(
                          color: DColors.primary,
                          fontWeight: FontWeight.w700),
                    ),
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

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: DColors.neutral2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: DColors.neutral6),
            const SizedBox(width: 10),
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: DColors.neutral6)),
          ],
        ),
      ),
    );
  }
}
