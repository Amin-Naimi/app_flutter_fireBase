import 'package:dsi32_flutter_project/features/products/presentation/blocs/addUpdateDeleteBloc/add_update_delete_product_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/productBloc/product_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/pages/product_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/go_router_config.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'features/products/presentation/blocs/landingPageBloc/landing_page_bloc.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=>di.sl<ProductBloc>()..add(GetAllProductsEvent())),
          BlocProvider(create: (_) => di.sl<AddUpdateDeleteProductBloc>()),
          BlocProvider(create: (context) => LandingPageBloc()),
             BlocProvider(
          create: (_) => di.sl<AuthBloc>(),
        ),
                BlocProvider(create: (_) => di.sl<UserManagerBloc>()),

        ],
        child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Amotech',
            routerConfig: di.sl<AppRouter>().router,
          );
        },
      ),);
  }
}
