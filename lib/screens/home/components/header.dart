import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubits/products/products_cubit.dart';
import 'package:frontend/cubits/user/user_cubit.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/utils/size_config.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await ProductsCubit.get(context).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight / 10,
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoggedOut) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "welcome_message".tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  width: SizeConfig.screenWidth / 4,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "login");
                    },
                    child: Text("Login"),
                  ),
                ),
              ],
            );
          } else if (state is UserLoggedIn) {
            UserModel user = UserCubit.get(context).user!;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello !"),
                    Text(user.fName),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.screenWidth / 4,
                  child: ElevatedButton(
                    onPressed: () {
                      UserCubit.get(context).logout();
                      Navigator.pushReplacementNamed(context, "home");
                      _refreshProducts(context);
                    },
                    child: Text("Logout"),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: user.image != null && user.image!.isNotEmpty
                      ? NetworkImage(user.image!)
                      : null,
                  child: user.image == null || user.image!.isEmpty
                      ? Icon(Icons.person)
                      : null,
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
