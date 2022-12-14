import 'package:flutter_appsa/common/base/base_bloc.dart';
import 'package:flutter_appsa/common/base/base_event.dart';
import 'package:flutter_appsa/common/consttants/variable_constant.dart';
import 'package:flutter_appsa/data/datasources/local/cache/app_cache.dart';
import 'dart:async';

import 'package:flutter_appsa/data/datasources/models/user_model.dart';
import 'package:flutter_appsa/data/repositories/authentication_repository.dart';
import 'package:flutter_appsa/presentations/features/sign_in/sgin_in_event.dart';

class SignInBloc extends BaseBloc {
  StreamController<UserModel> userModelController = StreamController();
  StreamController<String> message = StreamController();
  late AuthenticationRepository _authenticationRepository;

  void setAuthenticationRepository(
      {required AuthenticationRepository authenticationRepository}) {
    _authenticationRepository = authenticationRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    if (event is LoginEvent) {
      _executeLogin(event);
    }
  }

  void _executeLogin(LoginEvent event) {
    loadingSink.add(true);
    _authenticationRepository
        .login(email: event.email, password: event.password)
        .then((userResponse) {
      userModelController.sink.add(UserModel(
          email: userResponse.email ?? "",
          name: userResponse.name ?? "",
          phone: userResponse.phone ?? "",
          token: userResponse.token ?? ""));
      AppCache.setString(
          key: VariableConstant.TOKEN, value: userResponse.token!);
      loadingSink.add(false);
      progressSink.add(LoginSuccessEvent());
    }).catchError((error) {
      message.sink.add(error);
      loadingSink.add(false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    userModelController.close();
    message.close();
  }
}
