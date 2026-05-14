import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/requests/sign_up_request.dart';
import 'package:mobile/screens/auth/login_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _nationalityCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  String _phone = '';
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _nationalityCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final signUpState = ref.watch(signUpNotifierProvider);

    ref.listen(signUpNotifierProvider, (_, curr) {
      if (curr.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l.accountCreated),
          backgroundColor: DColors.success6,
          duration: const Duration(seconds: 4),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else if (curr.isError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(curr.error.toString()),
          backgroundColor: DColors.danger6,
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
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: DColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/logo.png', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('TegaBus',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: context.colors.primary)),
                ],
              ),
              const SizedBox(height: 28),
              Text(l.createAccount,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text(l.registerSubtitle,
                  style:
                      TextStyle(color: context.colors.neutral4, fontSize: 15)),
              const SizedBox(height: 28),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameCtrl,
                            decoration:
                                InputDecoration(hintText: l.firstName),
                            validator: (v) => (v == null || v.isEmpty)
                                ? l.required
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameCtrl,
                            decoration:
                                InputDecoration(hintText: l.lastName),
                            validator: (v) => (v == null || v.isEmpty)
                                ? l.required
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _nationalityCtrl,
                      decoration:
                          InputDecoration(hintText: l.nationalityLabel),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? l.required : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          InputDecoration(hintText: l.emailAddress),
                      validator: (v) {
                        if (v == null || v.isEmpty) return l.required;
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(v)) {
                          return l.invalidEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        hintText: l.phoneNumberLabel,
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: DColors.surfaceVariant,
                      ),
                      initialCountryCode: 'RW',
                      onChanged: (p) =>
                          setState(() => _phone = p.completeNumber),
                      validator: (p) =>
                          (p == null || p.completeNumber.isEmpty)
                              ? l.required
                              : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _passwordCtrl,
                      obscureText: _obscurePass,
                      decoration: InputDecoration(
                        hintText: l.passwordLabel,
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePass
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                          onPressed: () =>
                              setState(() => _obscurePass = !_obscurePass),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return l.required;
                        if (!RegExp(
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$')
                            .hasMatch(v)) {
                          return l.passwordRequirements;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _confirmCtrl,
                      obscureText: _obscureConfirm,
                      decoration: InputDecoration(
                        hintText: l.confirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirm
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                          onPressed: () => setState(
                              () => _obscureConfirm = !_obscureConfirm),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return l.required;
                        if (v != _passwordCtrl.text) {
                          return l.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              ElevatedButton(
                onPressed: signUpState.isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(signUpNotifierProvider.notifier)
                              .signUp(SignUpRequest(
                                firstName: _firstNameCtrl.text.trim(),
                                lastName: _lastNameCtrl.text.trim(),
                                email: _emailCtrl.text.trim(),
                                password: _passwordCtrl.text,
                                phoneNumber: _phone,
                                nationality: _nationalityCtrl.text.trim(),
                              ));
                        }
                      },
                child: signUpState.isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text(l.createAccountButton),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l.alreadyHaveAccount,
                      style: TextStyle(color: context.colors.neutral4)),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const LoginScreen()),
                    ),
                    child: Text(l.signInLink,
                        style: const TextStyle(
                            color: DColors.primary,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
