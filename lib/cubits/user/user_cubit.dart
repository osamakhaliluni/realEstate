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
  String? token; // Make token nullable
  final FlutterSecureStorage storage = FlutterSecureStorage();

  static UserCubit get(context) => BlocProvider.of(context);

  Future<void> checkLogin() async {
    emit(UserLoading());
    final prefs = await SharedPreferences.getInstance();
    final isLogin =
        prefs.getBool('isLogin') ?? false; // Keep key names consistent

    if (isLogin) {
      // Retrieve user data
      final id = prefs.getString('userId');
      final fName = prefs.getString('fName');
      final lName = prefs.getString('lName');
      final phone = prefs.getString('phone');
      final email = prefs.getString('email');
      final image = prefs.getString('image');

      // Retrieve token securely
      token = await storage.read(key: 'userToken');

      if (id != null && fName != null && email != null) {
        emit(UserLoggedIn(UserModel(
          id: id,
          fName: fName,
          lName: lName,
          phone: phone,
          email: email,
          image: image,
        )));
        return;
      }
    }
    emit(UserLoggedOut());
  }

  Future<void> login(String username, String password) async {
    emit(UserLoading());
    String baseUrl = dotenv.get('BASE_URL');
    try {
      Dio dio = Dio();
      Response response = await dio.post('${baseUrl}/login',
          data: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.data);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogin', true); // Consistent naming
        await prefs.setString('userId', user.id ?? '');
        await prefs.setString('fName', user.fName);
        await prefs.setString('lName', user.lName ?? '');
        await prefs.setString('phone', user.phone ?? '');
        await prefs.setString('email', user.email);
        await prefs.setString('image', user.image ?? '');
        await storage.write(key: 'userToken', value: response.data['token']);
        emit(UserLoggedIn(user));
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
      // Prepare the registration data
      final registrationData = {
        'fName': fName,
        'lName': lName,
        'phone': phone,
        'email': email,
        'password': password,
        'image': image, // Optional: only include if user provides it
      };

      // Make the POST request for registration
      Response response =
          await dio.post('${baseUrl}/register', data: registrationData);

      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.data);
        // Optionally save user data in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(
            'isLogin', true); // Or whatever you use for logged in state
        await prefs.setString('userId', user.id ?? '');
        await prefs.setString('fName', user.fName);
        await prefs.setString('lName', user.lName ?? '');
        await prefs.setString('phone', user.phone ?? '');
        await prefs.setString('email', user.email);
        await prefs.setString('image', user.image ?? '');
        await storage.write(
            key: 'userToken',
            value: response.data['token']); // Save token if returned

        emit(UserLoggedIn(user));
      } else {
        // Handle error message from the response
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
