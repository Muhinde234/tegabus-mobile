// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'TegaBus';

  @override
  String get retry => 'Retry';

  @override
  String get close => 'Close';

  @override
  String get required => 'Required';

  @override
  String get onboardingTitle => 'Your trip,\njust a tap away.';

  @override
  String get onboardingSubtitle =>
      'Book bus tickets across Rwanda instantly.\nNo queues. No hassle. Just go.';

  @override
  String get featureInstant => 'Instant';

  @override
  String get featureSecure => 'Secure';

  @override
  String get featureDigital => 'Digital';

  @override
  String get getStarted => 'Get Started';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get signInLink => 'Sign In';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get signInSubtitle => 'Sign in to continue booking';

  @override
  String get emailAddress => 'Email address';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get registerLink => 'Register';

  @override
  String get signInButton => 'Sign In';

  @override
  String get createAccount => 'Create account';

  @override
  String get registerSubtitle => 'Book buses across Rwanda in seconds';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get nationalityLabel => 'Nationality';

  @override
  String get phoneNumberLabel => 'Phone number';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get createAccountButton => 'Create Account';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get passwordRequirements =>
      'Min 8 chars, uppercase, lowercase & number';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get accountCreated =>
      'Account created! Check your email to verify, then sign in.';

  @override
  String get navHome => 'Home';

  @override
  String get navMyTickets => 'My Tickets';

  @override
  String get navExplore => 'Explore';

  @override
  String get navChat => 'Chat';

  @override
  String get navProfile => 'Profile';

  @override
  String get goodDay => 'Good day! 👋';

  @override
  String get whereAreYouGoing => 'Where are you going?';

  @override
  String get notifications => 'Notifications';

  @override
  String get popularRoutes => 'Popular Routes';

  @override
  String get whyTegaBus => 'Why TegaBus?';

  @override
  String get safeAndSecure => 'Safe & Secure';

  @override
  String get instantBooking => 'Instant Booking';

  @override
  String get digitalTicket => 'Digital Ticket';

  @override
  String get fromLabel => 'From';

  @override
  String get toLabel => 'To';

  @override
  String get selectDate => 'Select date';

  @override
  String get searchBuses => 'Search Buses';

  @override
  String get selectOriginDestinationDate =>
      'Please select origin, destination and date';

  @override
  String get exploreRoutes => 'Explore Routes';

  @override
  String get noSchedulesFound => 'No schedules found';

  @override
  String get tryDifferentDateOrRoute => 'Try a different date or route';

  @override
  String get noSchedulesAvailable => 'No schedules available';

  @override
  String get myTickets => 'My Tickets';

  @override
  String get noTicketsYet => 'No tickets yet';

  @override
  String get bookFirstTrip => 'Book your first trip to see it here';

  @override
  String get confirmedStatus => 'Confirmed';

  @override
  String get tapToViewQr => 'Tap to view QR code';

  @override
  String seatLabel(String number) {
    return 'Seat $number';
  }

  @override
  String seatsLeft(int count) {
    return '$count seats left';
  }

  @override
  String get profileTitle => 'Profile';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get nationalityInfo => 'Nationality';

  @override
  String get memberSince => 'Member since';

  @override
  String get logoutButton => 'Logout';

  @override
  String get languageTitle => 'Language';

  @override
  String get englishLanguage => 'English';

  @override
  String get kinyarwandaLanguage => 'Kinyarwanda';

  @override
  String get frenchLanguage => 'French';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get tegabusAssistant => 'TegaBus Assistant';

  @override
  String get onlineStatus => 'Online';

  @override
  String get askMeAnything => 'Ask me anything...';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get resetYourPassword => 'Reset your password';

  @override
  String get forgotPasswordDesc =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get resetLinkSent => 'Reset link sent — check your email.';

  @override
  String get enterValidEmail => 'Enter a valid email';

  @override
  String get bookingConfirmed => 'Booking Confirmed!';

  @override
  String get ticketBookedSuccessfully =>
      'Your ticket has been booked successfully.';

  @override
  String get scanToVerify => 'Scan to verify';

  @override
  String bookingRef(String ref) {
    return 'Booking #$ref';
  }

  @override
  String get goToHome => 'Go to Home';

  @override
  String get viewMyTickets => 'View My Tickets';

  @override
  String get availableSeat => 'Available';

  @override
  String get selectedSeat => 'Selected';

  @override
  String get bookedSeat => 'Booked';

  @override
  String get selectASeat => 'Select a Seat';

  @override
  String get bookSeat => 'Book Seat';

  @override
  String get failedToLoadSeats => 'Failed to load seats.';

  @override
  String get companiesTitle => 'Bus Companies';

  @override
  String get seeAll => 'See all';

  @override
  String byCompany(String company) {
    return 'By $company';
  }

  @override
  String routesCount(int count) {
    return '$count routes';
  }

  @override
  String schedulesByCompany(String company) {
    return '$company schedules';
  }

  @override
  String get noSchedulesForCompany => 'No schedules for this company yet';

  @override
  String get recentTrips => 'Recent Trips';

  @override
  String get operatedBy => 'OPERATED BY';

  @override
  String get filterByCompany => 'Filter by company';

  @override
  String get allCompanies => 'All';

  @override
  String get searchByRoute => 'Search route (e.g. Kigali → Huye)';

  @override
  String get filtersTitle => 'Filters';

  @override
  String get applyFilters => 'Apply';

  @override
  String get clearFilters => 'Clear all';

  @override
  String get paymentTitle => 'Payment';

  @override
  String get paymentSummary => 'Order summary';

  @override
  String get paymentMethod => 'Choose payment method';

  @override
  String get paymentMtn => 'MTN Mobile Money';

  @override
  String get paymentAirtel => 'Airtel Money';

  @override
  String get paymentPhoneLabel => 'Mobile money number';

  @override
  String get paymentPhoneHint => '07X XXX XXXX';

  @override
  String get paymentPhoneInvalid => 'Enter a valid phone number';

  @override
  String paymentPayNow(String amount) {
    return 'Pay $amount';
  }

  @override
  String get paymentProcessing => 'Processing payment…';

  @override
  String get paymentInstructions =>
      'A prompt will be sent to your phone. Approve it to complete payment.';

  @override
  String get paymentTotal => 'Total';

  @override
  String get paymentSeat => 'Seat';

  @override
  String get paymentTrip => 'Trip';

  @override
  String get themeTitle => 'Appearance';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System default';
}
