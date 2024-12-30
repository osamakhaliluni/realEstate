import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/style/colors.dart';
import 'package:frontend/cubits/products/products_cubit.dart';
import 'package:frontend/cubits/user/user_cubit.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/home/components/header.dart';
import 'package:frontend/screens/home/components/search.dart';
import 'package:frontend/utils/size_config.dart';
import 'package:frontend/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refreshProducts() async {
    await ProductsCubit.get(context).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // User info section
              Header(),
              // Search and filter section
              SizedBox(
                height: SizeConfig.screenHeight / 12,
                child: Search(),
              ),
              // Product listing section
              const SizedBox(height: 10),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshProducts,
                  child: BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductsLoaded) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.screenHeight / 10,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.categories.length,
                                  itemBuilder: (context, index) {
                                    final category = state.categories[index];
                                    return Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        constraints: BoxConstraints(
                                          minWidth: 50,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(child: Text(category)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight / 15,
                                child: Center(child: Text("All Categories")),
                              ),
                              ListView.builder(
                                itemCount: state.products.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final product = state.products[index];
                                  return ProductCard(product: product);
                                },
                              ),
                            ],
                          ),
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
