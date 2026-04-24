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
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline,
                color: DColors.danger6, size: 48),
            const SizedBox(height: 12),
            Text('${state.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: DColors.neutral4)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => ref
                  .read(schedulesNotifierProvider.notifier)
                  .fetchSchedules(),
              child: Text(l.retry),
            ),
          ],
        ),
      ),
    );
  }
}
