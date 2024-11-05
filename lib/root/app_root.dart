import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/style/themes.dart';
import 'package:frontend/cubits/products/products_cubit.dart';
import 'package:frontend/cubits/theme/theme_cubit.dart';
import 'package:frontend/cubits/user/user_cubit.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/splash_screen.dart';
import 'package:frontend/utils/size_config.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(context.read<UserCubit>()),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          SizeConfig.init(context);
          return MaterialApp(
            themeMode: ThemeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute: "splash",
            routes: {
              "splash": (context) => SplashScreen(),
              "home": (context) => HomeScreen(),
            },
          );
        },
      ),
    );
  }
}
