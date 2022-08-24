import 'package:flutter/material.dart';
import 'package:flutter_appsa/common/base/base_widget.dart';
import 'package:flutter_appsa/common/consttants/variable_constant.dart';
import 'package:flutter_appsa/data/datasources/local/cache/app_cache.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration(seconds: 2), () {
      String token = AppCache.getString(VariableConstant.TOKEN);
      print("token: $token");
      if (token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/sign-in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset('assets/animations/abc.json',
                animate: true, repeat: true),
            Text("Welcome",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white))
          ],
        ));
  }
}
