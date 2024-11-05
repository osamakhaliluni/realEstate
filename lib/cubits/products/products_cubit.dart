import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/cubits/user/user_cubit.dart';
import 'package:frontend/models/product_model.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final UserCubit userCubit;
  ProductsCubit(this.userCubit) : super(ProductsInitial());

  static ProductsCubit get(context) => BlocProvider.of(context);

  Future<void> getProducts() async {
    emit(ProductsLoading());
    String baseUrl = dotenv.get('BASE_URL');
    try {
      Dio dio = Dio();
      Response response = await dio.get('$baseUrl/products');

      if (response.statusCode == 200 && response.data is List) {
        print(response.data);
        List<ProductModel> products = (response.data as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
        emit(ProductsLoaded(products));
      } else {
        emit(ProductsError("Failed to load products"));
      }
    } catch (e) {
      print(e.toString());
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> addProduct(ProductModel product) async {
    emit(ProductsLoading());
    String baseUrl = dotenv.get('BASE_URL');
    final token = userCubit.token;
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        '$baseUrl/products',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
        data: product.toJson(),
      );

      if (response.statusCode == 201) {
        getProducts();
      } else {
        emit(ProductsError(
            "Failed to add product: ${response.data['message']}"));
      }
    } catch (e) {
      emit(ProductsError("An error occurred: $e"));
    }
  }
}
