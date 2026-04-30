import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      appBar: AppBar(title: Text(l.profileTitle), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(profileNotifierProvider.notifier).fetchProfile(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
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
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: DColors.primary2,
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
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: DColors.primary),
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                      color: DColors.primary, shape: BoxShape.circle),
                  child: const Icon(Icons.edit,
                      color: Colors.white, size: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            '${profile.firstName} ${profile.lastName}',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ),
        Center(
          child: Text(profile.email,
              style: const TextStyle(
                  color: DColors.neutral4, fontSize: 14)),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: DColors.primary2,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              profile.role.toUpperCase(),
              style: const TextStyle(
                  color: DColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2),
            ),
          ),
        ),
        const SizedBox(height: 28),

        Text(l.personalInformation,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),

        _infoTile(Icons.phone_outlined, l.phoneLabel, profile.phoneNumber),
        _infoTile(
            Icons.public_outlined, l.nationalityInfo, profile.nationality),
        _infoTile(
            Icons.calendar_today_outlined, l.memberSince, joined),

        const SizedBox(height: 24),

        Text(l.languageTitle,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),

        _LanguageTile(
          flag: '🇬🇧',
          label: l.englishLanguage,
          code: 'en',
          isSelected: currentLocale == 'en',
          ref: ref,
        ),
        const SizedBox(height: 8),
        _LanguageTile(
          flag: '🇷🇼',
          label: l.kinyarwandaLanguage,
          code: 'rw',
          isSelected: currentLocale == 'rw',
          ref: ref,
        ),
        const SizedBox(height: 8),
        _LanguageTile(
          flag: '🇫🇷',
          label: l.frenchLanguage,
          code: 'fr',
          isSelected: currentLocale == 'fr',
          ref: ref,
        ),

        const SizedBox(height: 32),
        const LogoutButton(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DColors.neutral2),
      ),
      child: Row(
        children: [
          Icon(icon, color: DColors.primary, size: 20),
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

  const _LanguageTile({
    required this.flag,
    required this.label,
    required this.code,
    required this.isSelected,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          ref.read(localeProvider.notifier).setLocale(code),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? DColors.primary2 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected ? DColors.primary : DColors.neutral2),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color:
                        isSelected ? DColors.primary : DColors.neutral6)),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle,
                  color: DColors.primary, size: 20),
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
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: DColors.danger6.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.wifi_off_rounded,
                size: 48, color: DColors.danger6),
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
