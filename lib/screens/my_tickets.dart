import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/screens/my_ticket_card.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';

class MyTickets extends ConsumerWidget {
  const MyTickets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final state = ref.watch(myTicketsNotifierProvider);

    if (state.isInit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(myTicketsNotifierProvider.notifier).fetchMyTickets();
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.myTickets), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(myTicketsNotifierProvider.notifier).fetchMyTickets(),
        child: _buildBody(context, state, l),
      ),
    );
  }

  Widget _buildBody(BuildContext context, dynamic state, dynamic l) {
    if (state.isInit || state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.isSuccess) {
      final tickets = state.data?.data ?? [];
      if (tickets.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.confirmation_num_outlined,
                  size: 72, color: DColors.neutral2),
              const SizedBox(height: 16),
              Text(l.noTicketsYet,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(l.bookFirstTrip,
                  style: const TextStyle(color: DColors.neutral4)),
            ],
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: tickets.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) => MyTicketCard(ticket: tickets[i]),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline,
              color: DColors.danger6, size: 48),
          const SizedBox(height: 12),
          Text('${state.error}',
              style: const TextStyle(color: DColors.neutral4)),
        ],
      ),
    );
  }
}
