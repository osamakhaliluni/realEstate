import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  String? token;
  UserModel? user;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  static UserCubit get(context) => BlocProvider.of(context);

  Future<void> checkLogin() async {
    emit(UserLoading());
    final prefs = await SharedPreferences.getInstance();
    final isLogin = prefs.getBool('isLogin') ?? false;

    if (isLogin) {
      final id = prefs.getString('userId');
      final fName = prefs.getString('fName')!;
      final lName = prefs.getString('lName');
      final phone = prefs.getString('phone');
      final email = prefs.getString('email')!;
      final image = prefs.getString('image');

      user = UserModel(
        id: id,
        fName: fName,
        lName: lName,
        phone: phone,
        email: email,
        image: image,
      );
      token = await storage.read(key: 'userToken');
      emit(UserLoggedIn());
      return;
    }
    emit(UserLoggedOut());
  }

  Future<void> login(String email, String password) async {
    emit(UserLoading());
    String baseUrl = dotenv.get('BASE_URL');
    try {
      Dio dio = Dio();
      Response response = await dio.post('${baseUrl}/user/login',
          data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        user = UserModel.fromJson(response.data);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogin', true);
        await prefs.setString('userId', user!.id ?? '');
        await prefs.setString('fName', user!.fName);
        await prefs.setString('lName', user!.lName ?? '');
        await prefs.setString('phone', user!.phone ?? '');
        await prefs.setString('email', user!.email);
        await prefs.setString('image', user!.image ?? '');
        await storage.write(key: 'userToken', value: response.data['token']);
        emit(UserLoggedIn());
      } else {
        emit(UserError(response.data['message']));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> register(String fName, String? lName, String? phone,
      String email, String password, String? image) async {
    emit(UserLoading());
    String baseUrl = dotenv.get('BASE_URL');
    try {
      Dio dio = Dio();
      final registrationData = {
        'fName': fName,
        'lName': lName ?? "",
        'email': email,
        'phone': phone ?? "",
        'password': password,
        'image': image ?? "",
      };

      Response response =
          await dio.post('${baseUrl}/user/register', data: registrationData);

      print(response);
      if (response.statusCode == 201) {
        user = UserModel.fromJson(response.data);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogin', true);
        await prefs.setString('userId', user!.id ?? '');
        await prefs.setString('fName', user!.fName);
        await prefs.setString('lName', user!.lName ?? '');
        await prefs.setString('phone', user!.phone ?? '');
        await prefs.setString('email', user!.email);
        await prefs.setString('image', user!.image ?? '');
        await storage.write(key: 'userToken', value: response.data['token']);

        emit(UserLoggedIn());
      } else {
        emit(UserError(response.data['message']));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  // Log the user out
  Future<void> logout() async {
    emit(UserLoading());
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.setBool('isLogin', false);

    await storage.delete(key: 'userToken');
    emit(UserLoggedOut());
  }
}
