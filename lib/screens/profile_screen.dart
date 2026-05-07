import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mobile/atoms/logout_button.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/responses/profile.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widgets/shimmers/profile_shimmer.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      backgroundColor: DColors.background,
      body: RefreshIndicator(
        color: DColors.primary,
        onRefresh: () =>
            ref.read(profileNotifierProvider.notifier).fetchProfile(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: switch (true) {
            _ when profileState.isInit || profileState.isLoading =>
              const ProfileShimmer(),
            _ when profileState.isSuccess =>
              _ProfileContent(profile: profileState.data!),
            _ => _ProfileError(
                onRetry: () => ref
                    .read(profileNotifierProvider.notifier)
                    .fetchProfile()),
          },
        ),
      ),
    );
  }
}

class _ProfileContent extends ConsumerWidget {
  final Profile profile;
  const _ProfileContent({required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final joined = DateFormat('MMMM d, y').format(profile.createdAt);
    final currentLocale = ref.watch(localeProvider).languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Gradient header ──
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(gradient: DColors.primaryGradient),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l.profileTitle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Iconsax.setting_2,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white.withValues(alpha: 0.15),
                          backgroundImage: (profile.profilePicUrl != null &&
                                  profile.profilePicUrl!.isNotEmpty)
                              ? NetworkImage(profile.profilePicUrl!)
                              : null,
                          child: (profile.profilePicUrl == null ||
                                  profile.profilePicUrl!.isEmpty)
                              ? Text(
                                  '${profile.firstName[0]}${profile.lastName[0]}'
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                )
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            gradient: DColors.goldGradient,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.edit,
                              color: Colors.white, size: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '${profile.firstName} ${profile.lastName}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(profile.email,
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      profile.role.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Content ──
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Personal Info section ──
              _SectionHeader(title: l.personalInformation, icon: Iconsax.user),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: DColors.softShadow,
                ),
                child: Column(
                  children: [
                    _InfoRow(
                        icon: Iconsax.call,
                        label: l.phoneLabel,
                        value: profile.phoneNumber),
                    const Divider(height: 1, indent: 52, color: DColors.neutral1),
                    _InfoRow(
                        icon: Iconsax.global,
                        label: l.nationalityInfo,
                        value: profile.nationality),
                    const Divider(height: 1, indent: 52, color: DColors.neutral1),
                    _InfoRow(
                        icon: Iconsax.calendar_1,
                        label: l.memberSince,
                        value: joined),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Language section ──
              _SectionHeader(title: l.languageTitle, icon: Iconsax.language_square),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: DColors.softShadow,
                ),
                child: Column(
                  children: [
                    _LanguageTile(
                      flag: '🇬🇧',
                      label: l.englishLanguage,
                      code: 'en',
                      isSelected: currentLocale == 'en',
                      ref: ref,
                      isFirst: true,
                    ),
                    const Divider(height: 1, indent: 52, color: DColors.neutral1),
                    _LanguageTile(
                      flag: '🇷🇼',
                      label: l.kinyarwandaLanguage,
                      code: 'rw',
                      isSelected: currentLocale == 'rw',
                      ref: ref,
                    ),
                    const Divider(height: 1, indent: 52, color: DColors.neutral1),
                    _LanguageTile(
                      flag: '🇫🇷',
                      label: l.frenchLanguage,
                      code: 'fr',
                      isSelected: currentLocale == 'fr',
                      ref: ref,
                      isLast: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              const LogoutButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: DColors.primary),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: DColors.neutral6)),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: DColors.primary1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: DColors.primary, size: 16),
          ),
          const SizedBox(width: 12),
          Text(label,
              style: const TextStyle(
                  color: DColors.neutral4, fontSize: 13)),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String flag;
  final String label;
  final String code;
  final bool isSelected;
  final WidgetRef ref;
  final bool isFirst;
  final bool isLast;

  const _LanguageTile({
    required this.flag,
    required this.label,
    required this.code,
    required this.isSelected,
    required this.ref,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          ref.read(localeProvider.notifier).setLocale(code),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? DColors.primary1 : Colors.transparent,
          borderRadius: BorderRadius.vertical(
            top: isFirst ? const Radius.circular(16) : Radius.zero,
            bottom: isLast ? const Radius.circular(16) : Radius.zero,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: DColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(flag, style: const TextStyle(fontSize: 18)),
            ),
            const SizedBox(width: 12),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color:
                        isSelected ? DColors.primary : DColors.neutral6)),
            const Spacer(),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: DColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              ),
          ],
        ),
      ),
    );
  }
}

class _ProfileError extends StatelessWidget {
  final VoidCallback onRetry;
  const _ProfileError({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: DColors.danger1,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.wifi_off_rounded,
                size: 40, color: DColors.danger6),
          ),
          const SizedBox(height: 20),
          const Text(
            'Could not load profile',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'Check your connection and try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: DColors.neutral4, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 28),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
