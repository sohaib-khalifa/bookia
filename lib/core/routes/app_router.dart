import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/forget_password/screens/forgot_password_screen.dart';
import 'package:bookia/feature/auth/presentation/login_register/screens/login_screen.dart';
import 'package:bookia/feature/auth/presentation/login_register/screens/register_screen.dart';
import 'package:bookia/feature/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:bookia/feature/checkout/presentation/page/place_order_screen.dart';
import 'package:bookia/feature/details/page/details_screen.dart';
import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:bookia/feature/main/main_app_screen.dart';
import 'package:bookia/feature/splash/cubit/splash_cubit.dart';
import 'package:bookia/feature/splash/screen/splash_screen.dart';
import 'package:bookia/feature/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Person p = Person();
// p.name="mohamed";
// p.display();
// Person p = Person()..name="mohamed"...display();

// Navigator 1 vs Navigator 2 vs go_router

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final routes = GoRouter(
    navigatorKey: navigatorKey,

    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => BlocProvider(
          create: (context) {
            // return SplashCubit()..getInitData();
            var cubit = SplashCubit();
            cubit.getInitData();
            return cubit;
          },
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (context, state) {
          return ForgotPasswordScreen(email: state.extra as String);
          // return ForgotPasswordScreen();
        },
      ),
      GoRoute(
        path: Routes.main,
        builder: (context, state) => const MainAppScreen(),
      ),
      GoRoute(
        path: Routes.details,
        builder: (context, state) =>
            DetailsScreen(model: state.extra as Product),
      ),
      GoRoute(
        path: Routes.placeOrder,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => CheckoutCubit()..getGovernorates(),
            child: PlaceOrderScreen(total: state.extra as double),
          );
        },
      ),
    ],
  );
}
