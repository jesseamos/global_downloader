import 'package:go_router/go_router.dart';
import 'package:spotify_downloader/features/spotify/presentation/screens/download_spotify.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: DownloadSpotify.routeName,
  // navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: DownloadSpotify.routeName,
      name: DownloadSpotify.routeName,
      builder: (context, state) => DownloadSpotify(),
    ),
    // GoRoute(
    //   path: RegisterScreen.routeName,
    //   name: RegisterScreen.routeName,
    //   builder: (context, state) => RegisterScreen(),
    // ),
    // GoRoute(
    //   path: VerificationScreen.routeName,
    //   name: VerificationScreen.routeName,
    //   builder: (context, state) {
    //     final VerificationScreenProps props =
    //         state.extra as VerificationScreenProps;
    //     return VerificationScreen(props);
    //   },
    // ),
    // GoRoute(
    //   path: ForgotPasswordScreen.routeName,
    //   name: ForgotPasswordScreen.routeName,
    //   builder: (context, state) => ForgotPasswordScreen(),
    // ),
    // GoRoute(
    //   path: ResetLinkSent.routeName,
    //   name: ResetLinkSent.routeName,
    //   builder: (context, state) => ResetLinkSent(),
    // ),
    // GoRoute(
    //   path: NewPasswordScreen.routeName,
    //   name: NewPasswordScreen.routeName,
    //   builder: (context, state) {
    //     final NewPasswordScreenProps props =
    //         state.extra as NewPasswordScreenProps;
    //     return NewPasswordScreen(props);
    //   },
    // ),
    // GoRoute(
    //   path: MainDashboardScreen.routeName,
    //   name: MainDashboardScreen.routeName,
    //   builder: (context, state) {
    //     final int? props = state.extra as int?;
    //     return MainDashboardScreen(index: props);
    //   },
    // ),
    // GoRoute(
    //   path: NotificationsScreen.routeName,
    //   name: NotificationsScreen.routeName,
    //   builder: (context, state) => NotificationsScreen(),
    // ),
    // GoRoute(
    //   path: OnboardingScreen.routeName,
    //   name: OnboardingScreen.routeName,
    //   builder: (context, state) => OnboardingScreen(),
    // ),
    // GoRoute(
    //   path: HomeScreen.routeName,
    //   name: HomeScreen.routeName,
    //   builder: (context, state) => HomeScreen(),
    // ),
    // GoRoute(
    //   path: ProfileScreen.routeName,
    //   name: ProfileScreen.routeName,
    //   builder: (context, state) => ProfileScreen(),
    // ),
    // GoRoute(
    //   path: RewardsScreens.routeName,
    //   name: RewardsScreens.routeName,
    //   builder: (context, state) => RewardsScreens(),
    // ),
    // GoRoute(
    //   path: WalletScreen.routeName,
    //   name: WalletScreen.routeName,
    //   builder: (context, state) => WalletScreen(),
    // ),
  ],
);
