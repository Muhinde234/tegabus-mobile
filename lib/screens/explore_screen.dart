import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widgets/shimmers/ticket_card_shimmer.dart';
import 'package:mobile/widgets/ticket_card.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final state = ref.watch(schedulesNotifierProvider);

    if (state.isInit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(schedulesNotifierProvider.notifier).fetchSchedules();
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.exploreRoutes)),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(schedulesNotifierProvider.notifier).fetchSchedules(),
        child: _buildBody(context, state, ref, l),
      ),
    );
  }

  Widget _buildBody(BuildContext context, dynamic state, WidgetRef ref,
      dynamic l) {
    if (state.isInit || state.isLoading) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, __) => const TicketCardShimmer(),
      );
    }

    if (state.isSuccess) {
      final schedules = state.data ?? [];
      if (schedules.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.directions_bus_outlined,
                  size: 64, color: DColors.neutral2),
              const SizedBox(height: 16),
              Text(l.noSchedulesAvailable,
                  style: const TextStyle(
                      color: DColors.neutral4, fontSize: 15)),
            ],
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: schedules.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) => TicketCard(schedule: schedules[i]),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              'No connection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'We couldn\'t fetch schedules.\nCheck your internet and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: DColors.neutral4, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: () =>
                  ref.read(schedulesNotifierProvider.notifier).fetchSchedules(),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(l.retry),
            ),
          ],
        ),
      ),
    );
  }
}
