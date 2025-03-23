import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_management_flutter_app/screens/main/main_customer_screen.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:go_router/go_router.dart';

import 'core/controllers/menu_app_controller.dart';
import 'core/utils/theme.dart';
import 'features/cart/bloc/cart_bloc.dart';
import 'features/floor/bloc/floor_bloc.dart';
import 'features/order/bloc/order_bloc.dart';
import 'features/product/bloc/product_bloc.dart';
import 'features/table/bloc/table_bloc.dart';
import 'screens/main/main_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

Future<void> setOrientationBasedOnDevice() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    bool isTablet =
        androidInfo.systemFeatures.contains('android.hardware.screen.large');
    if (isTablet) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    bool isTablet = iosInfo.model.toLowerCase().contains("ipad");
    if (isTablet) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = _createRouter();
    _handleDeepLinks();
  }

  GoRouter _createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          path: '/customer/order/table/:tableId',
          builder: (context, state) {
            final tableId = state.pathParameters['tableId']!;
            return MainCustomerScreen(tableId: tableId);
          },
        ),
      ],
    );
  }

  void _handleDeepLinks() async {
    final Uri? initialUri = await _appLinks.getInitialLink();
    _processDeepLink(initialUri);

    _appLinks.uriLinkStream.listen((Uri? uri) {
      _processDeepLink(uri);
    });
  }

  void _processDeepLink(Uri? uri) {
    if (uri == null) return;

    debugPrint("App nhận link: $uri");

    final RegExp regExp = RegExp(r"customer/order/table/(\d+)");
    final match = regExp.firstMatch(uri.toString());

    if (match != null) {
      String tableId = match.group(1)!;
      _router.go('/customer/order/table/$tableId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuAppController()),
        BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<TableBloc>(create: (context) => TableBloc()),
        BlocProvider<FloorBloc>(create: (context) => FloorBloc()),
        BlocProvider<OrderBloc>(create: (context) => OrderBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        routerConfig: _router,
      ),
    );
  }
}
