import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widgets/shimmers/ticket_card_shimmer.dart';
import 'package:mobile/widgets/ticket_card.dart';

class SearchResults extends ConsumerWidget {
  final String from;
  final String to;
  final DateTime date;

  const SearchResults({
    super.key,
    required this.from,
    required this.to,
    required this.date,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final state = ref.watch(schedulesNotifierProvider);

    if (state.isInit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(schedulesNotifierProvider.notifier).fetchSchedules(
              from: from,
              to: to,
              date: date,
            );
      });
    }

    final resultCount = state.isSuccess ? (state.data?.length ?? 0) : 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: context.colors.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Iconsax.arrow_left_2, size: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$from → $to'),
            Row(
              children: [
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: TextStyle(color: context.colors.neutral4, fontSize: 12),
                ),
                if (state.isSuccess) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: context.colors.primary1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$resultCount found',
                      style: const TextStyle(
                          color: DColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: DColors.primary,
        onRefresh: () => ref
            .read(schedulesNotifierProvider.notifier)
            .fetchSchedules(from: from, to: to, date: date),
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
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => const TicketCardShimmer(),
      );
    }

    if (state.isSuccess) {
      final schedules = state.data ?? [];
      if (schedules.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: context.colors.primary1,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Iconsax.search_status,
                      size: 40, color: context.colors.primary3),
                ),
                const SizedBox(height: 16),
                Text(l.noSchedulesFound,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 17)),
                SizedBox(height: 6),
                Text(l.tryDifferentDateOrRoute,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: context.colors.neutral4, fontSize: 14)),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Iconsax.arrow_left_2, size: 16),
                  label: const Text('Modify Search'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: DColors.primary,
                    side: const BorderSide(color: DColors.primary),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: schedules.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) => TicketCard(schedule: schedules[i]),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: DColors.danger1,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.error_outline,
                  color: DColors.danger6, size: 40),
            ),
            SizedBox(height: 16),
            Text('${state.error}',
                textAlign: TextAlign.center,
                style: TextStyle(color: context.colors.neutral4)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => ref
                  .read(schedulesNotifierProvider.notifier)
                  .fetchSchedules(from: from, to: to, date: date),
              child: Text(l.retry),
            ),
          ],
        ),
      ),
    );
  }
}
