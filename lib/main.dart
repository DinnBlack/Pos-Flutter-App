import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_management_flutter_app/features/product/bloc/product_bloc.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'core/controllers/menu_app_controller.dart';
import 'core/utils/theme.dart';
import 'features/cart/bloc/cart_bloc.dart';
import 'features/floor/bloc/floor_bloc.dart';
import 'features/order/bloc/order_bloc.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _handleDeepLinks();
  }

  void _handleDeepLinks() async {
    final Uri? initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      debugPrint("App mở từ link ban đầu: $initialUri");
    }
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        debugPrint("App nhận link: $uri");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: MultiBlocProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MenuAppController()),
          BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
          BlocProvider<CartBloc>(create: (context) => CartBloc()),
          BlocProvider<TableBloc>(create: (context) => TableBloc()),
          BlocProvider<FloorBloc>(create: (context) => FloorBloc()),
          BlocProvider<OrderBloc>(create: (context) => OrderBloc()),
        ],
        child: MainScreen(),
      ),
    );
  }
}
