import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/responses/my_ticket_response.dart';
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.myTickets),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.colors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: DColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: context.colors.neutral4,
                labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                padding: const EdgeInsets.all(3),
                tabs: const [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Past'),
                ],
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          color: DColors.primary,
          onRefresh: () =>
              ref.read(myTicketsNotifierProvider.notifier).fetchMyTickets(),
          child: _buildBody(context, state, l),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, dynamic state, dynamic l) {
    if (state.isInit || state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: DColors.primary,
        ),
      );
    }

    if (state.isSuccess) {
      final allTickets = (state.data?.data ?? []) as List<Ticket>;
      if (allTickets.isEmpty) {
        return _EmptyState(l: l);
      }

      final now = DateTime.now();
      final upcoming = allTickets
          .where((t) => t.departureTime.isAfter(now))
          .toList();
      final past = allTickets
          .where((t) => !t.departureTime.isAfter(now))
          .toList();

      return TabBarView(
        children: [
          _TicketList(tickets: upcoming, isEmpty: upcoming.isEmpty, emptyMsg: 'No upcoming trips'),
          _TicketList(tickets: past, isEmpty: past.isEmpty, emptyMsg: 'No past trips'),
        ],
      );
    }

    return _ErrorState();
  }
}

class _TicketList extends StatelessWidget {
  final List<Ticket> tickets;
  final bool isEmpty;
  final String emptyMsg;

  const _TicketList({
    required this.tickets,
    required this.isEmpty,
    required this.emptyMsg,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.colors.primary1,
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.ticket, size: 40, color: context.colors.primary3),
            ),
            const SizedBox(height: 16),
            Text(emptyMsg,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700, color: DColors.neutral5)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: tickets.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (_, i) => MyTicketCard(ticket: tickets[i]),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final dynamic l;
  const _EmptyState({required this.l});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: context.colors.primary1,
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.ticket_2, size: 48, color: context.colors.primary3),
            ),
            const SizedBox(height: 20),
            Text(l.noTicketsYet,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            SizedBox(height: 8),
            Text(l.bookFirstTrip,
                textAlign: TextAlign.center,
                style: TextStyle(color: context.colors.neutral4, fontSize: 14, height: 1.5)),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              'Something went wrong',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'We couldn\'t load your tickets.\nPull down to refresh.',
              textAlign: TextAlign.center,
              style: TextStyle(color: context.colors.neutral4, fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
