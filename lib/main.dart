import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_downloader/core/config/app_router.dart';
import 'package:spotify_downloader/core/config/app_theme.dart';
import 'package:spotify_downloader/core/presentation/cubit/theme_cubit.dart';
import 'package:spotify_downloader/di.dart';
import 'package:spotify_downloader/features/spotify/presentation/cubit/sportify_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<ThemeCubit>()),
            BlocProvider(create: (_) => serviceLocator<SportifyCubit>()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                title: 'Big Downloader',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                routerConfig: appRouter,
              );
            },
          ),
        );
      },
    );
  }
}
