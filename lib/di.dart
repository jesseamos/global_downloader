import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:spotify_downloader/core/network/connection_checker.dart';
import 'package:spotify_downloader/core/network/dio_client.dart';
import 'package:spotify_downloader/core/presentation/cubit/theme_cubit.dart';
import 'package:spotify_downloader/core/utils/user_storage.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load(fileName: ".env");
  await Future.delayed(const Duration(seconds: 3));
  // _initAuth();
  // _initUser();
  // _initNotifications();
  // _initUpload();
  // _initWallets();
  // _initBank();
  // _initPlatforms();
  // _initOrdersPromotions();
  // _initTaskPromotions();
  // _initReferrals();
  final DioClient dioClient = DioClient();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final UserStorage userStorage = UserStorage();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  // Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => dioClient);
  serviceLocator.registerLazySingleton(() => userStorage);
  serviceLocator.registerLazySingleton(() => googleSignIn);
  serviceLocator.registerLazySingleton(() => storage);
  serviceLocator.registerLazySingleton(() => ThemeCubit(serviceLocator()));
  // serviceLocator.registerLazySingleton(
  //   () => Hive.box(name: 'user'),
  // );

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
}
