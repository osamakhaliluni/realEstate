import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/style/colors.dart';
import 'package:frontend/cubits/products/products_cubit.dart';
import 'package:frontend/cubits/user/user_cubit.dart';
import 'package:frontend/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    _initPage();
    super.didChangeDependencies();
  }

  void _initPage() async {
    await UserCubit.get(context).checkLogin();
    await ProductsCubit.get(context).getProducts();
  }

  Future<void> _refreshProducts() async {
    print("Refreshing");
    await ProductsCubit.get(context).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // User info section
              SizedBox(
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
                                // Handle login navigation
                              },
                              child: Text("Login"),
                            ),
                          ),
                        ],
                      );
                    } else if (state is UserLoggedIn) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello !"),
                              Text(state.user.fName),
                            ],
                          ),
                          CircleAvatar(
                            backgroundImage: state.user.image != null &&
                                    state.user.image!.isNotEmpty
                                ? NetworkImage(state.user.image!)
                                : null,
                            child: state.user.image == null ||
                                    state.user.image!.isEmpty
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
              ),
              // Search and filter section
              SizedBox(
                height: SizeConfig.screenHeight / 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      width: SizeConfig.screenWidth / 5 * 3,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Handle search action
                            },
                            icon: Icon(
                              Icons.search,
                              color: primaryColor,
                              size: 30,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText:
                                    "Search...", // Use labelText for proper alignment
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 179, 179, 179),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: double.infinity,
                      width: SizeConfig.screenWidth / 7 * 2,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle filter action
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.filter_list),
                            Text("Filters"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Product listing section
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshProducts,
                  child: BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductsLoaded) {
                        return ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return Card(
                              color: Colors.white,
                              elevation: 10,
                              margin: EdgeInsets.all(20),
                              child: SizedBox(
                                height: 300,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: product.images.isNotEmpty
                                        ? NetworkImage(product.images[0])
                                        : null,
                                  ),
                                  title: Text(product.title),
                                  subtitle: Text(
                                      '\$${product.price.toString()}'), // Format price with a dollar sign
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is ProductsError) {
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Center(child: Text(state.message)),
                        );
                      } else {
                        return const SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Center(child: Text("Error loading products")),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
