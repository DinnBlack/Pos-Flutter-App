import 'package:flutter/material.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = _createRouter();
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
