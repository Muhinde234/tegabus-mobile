import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/api/services/ticket_schedule_service.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/responses/schedules_response.dart';
import 'package:mobile/screens/booking_confirmation_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';

enum _PaymentMethod { mtn, airtel }

class PaymentScreen extends ConsumerStatefulWidget {
  final Schedule schedule;
  final int seatId;
  final String seatNumber;

  const PaymentScreen({
    super.key,
    required this.schedule,
    required this.seatId,
    required this.seatNumber,
  });

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  _PaymentMethod _method = _PaymentMethod.mtn;
  final _phoneCtrl = TextEditingController();
  String? _phoneError;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool _validatePhone() {
    // Rwandan mobile money numbers: 9 digits starting with 7, often written
    // with a leading 0 (10 digits). Accept either form to be friendly.
    final raw = _phoneCtrl.text.replaceAll(RegExp(r'\s+'), '');
    final ok = RegExp(r'^(0?7[2389]\d{7})$').hasMatch(raw);
    setState(() => _phoneError = ok ? null : 'Enter a valid phone number');
    return ok;
  }

  Future<void> _pay() async {
    if (!_validatePhone()) return;
    // The dummy buyTicket already does a 600ms simulated delay; navigate
    // straight to the confirmation screen on success. The success listener
    // is below in build() so the same handler covers form/refresh-driven
    // re-runs of the buy flow.
    await ref.read(buyTicketNotifierProvider.notifier).buyTicket(
          widget.schedule.id,
          widget.seatId,
          price: widget.schedule.price,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final s = widget.schedule;
    final buyState = ref.watch(buyTicketNotifierProvider);
    final company = TicketScheduleService.companyFor(s.id);

    final priceText = '${NumberFormat('#,###').format(s.price.toInt())} RWF';
    final dep = DateFormat('EEE, MMM d • h:mm a').format(s.departureTime);

    ref.listen(buyTicketNotifierProvider, (_, curr) {
      if (curr.isSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BookingConfirmationScreen(booking: curr.data!),
          ),
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
      backgroundColor: DColors.background,
      appBar: AppBar(
        title: Text(l.paymentTitle),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: DColors.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Iconsax.arrow_left_2, size: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: AbsorbPointer(
        absorbing: buyState.isLoading,
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
              children: [
                // ── Order summary ──
                _SectionLabel(text: l.paymentSummary),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: DColors.softShadow,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: company.brandColor,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              company.logoLetter,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                height: 1.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(company.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14)),
                                Text(s.bus,
                                    style: const TextStyle(
                                        color: DColors.neutral4,
                                        fontSize: 11)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _SummaryRow(
                          label: l.paymentTrip,
                          value: '${s.from} → ${s.to}'),
                      _SummaryRow(label: 'Departure', value: dep),
                      _SummaryRow(
                          label: l.paymentSeat, value: widget.seatNumber),
                      const Divider(height: 24, color: DColors.neutral2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l.paymentTotal,
                              style: const TextStyle(
                                  color: DColors.neutral5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)),
                          Text(priceText,
                              style: const TextStyle(
                                  color: DColors.primary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Method picker ──
                _SectionLabel(text: l.paymentMethod),
                const SizedBox(height: 8),
                _MethodTile(
                  selected: _method == _PaymentMethod.mtn,
                  brandColor: const Color(0xFFFFCC00),
                  brandLetter: 'M',
                  brandTextColor: const Color(0xFF111111),
                  title: l.paymentMtn,
                  subtitle: 'MoMo',
                  onTap: () => setState(() => _method = _PaymentMethod.mtn),
                ),
                const SizedBox(height: 10),
                _MethodTile(
                  selected: _method == _PaymentMethod.airtel,
                  brandColor: const Color(0xFFE60012),
                  brandLetter: 'A',
                  brandTextColor: Colors.white,
                  title: l.paymentAirtel,
                  subtitle: 'Airtel Money',
                  onTap: () =>
                      setState(() => _method = _PaymentMethod.airtel),
                ),

                const SizedBox(height: 24),

                // ── Phone number ──
                _SectionLabel(text: l.paymentPhoneLabel),
                const SizedBox(height: 8),
                TextField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
                    LengthLimitingTextInputFormatter(13),
                  ],
                  onChanged: (_) {
                    if (_phoneError != null) {
                      setState(() => _phoneError = null);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: l.paymentPhoneHint,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Iconsax.call, size: 18),
                          SizedBox(width: 6),
                          Text('+250',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: DColors.neutral5)),
                        ],
                      ),
                    ),
                    prefixIconConstraints:
                        const BoxConstraints(minWidth: 0, minHeight: 0),
                    errorText: _phoneError,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(color: DColors.neutral2, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(color: DColors.neutral2, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(color: DColors.primary, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l.paymentInstructions,
                  style: const TextStyle(
                      color: DColors.neutral4, fontSize: 12, height: 1.4),
                ),
              ],
            ),

            // ── Sticky pay button ──
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Container(
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
                      onPressed: buyState.isLoading ? null : _pay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        disabledBackgroundColor: Colors.transparent,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: buyState.isLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : Text(
                              l.paymentPayNow(priceText),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Processing overlay ──
            if (buyState.isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.35),
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(
                            color: DColors.primary, strokeWidth: 3),
                        const SizedBox(height: 18),
                        Text(l.paymentProcessing,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: DColors.neutral5,
        letterSpacing: 0.4,
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label,
                style: const TextStyle(
                    color: DColors.neutral4, fontSize: 12)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: DColors.neutral6),
            ),
          ),
        ],
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  final bool selected;
  final Color brandColor;
  final Color brandTextColor;
  final String brandLetter;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MethodTile({
    required this.selected,
    required this.brandColor,
    required this.brandTextColor,
    required this.brandLetter,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? DColors.primary : DColors.neutral2,
              width: selected ? 1.8 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: DColors.primary.withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Brand mark — square with rounded corners holding the
              // operator letter (M / A) in their corporate color.
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: brandColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  brandLetter,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: brandTextColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    height: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: const TextStyle(
                            color: DColors.neutral4, fontSize: 12)),
                  ],
                ),
              ),
              // Radio indicator on the right.
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? DColors.primary : Colors.white,
                  border: Border.all(
                    color: selected ? DColors.primary : DColors.neutral3,
                    width: 2,
                  ),
                ),
                child: selected
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
