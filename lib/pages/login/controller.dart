import 'package:flutter/material.dart';
import 'package:flutterlogout/common/routes/app_pages.dart';
import 'package:flutterlogout/common/values/values.dart';
import 'package:flutterlogout/pages/login/state.dart';
import 'package:get/get.dart';
import 'index.dart';
import '../../common/utils/utils.dart';
import '../../common/models/models.dart';
import '../../common/routes/app_pages.dart';

class SignInController extends GetxController {
  final state = SignInState();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  handleLogin() async {
    if (phoneController.text.length != 11) {
      ToastUtil.showToast("请输入正确的手机号");
      return;
    }
    if (passwordController.text == '') {
      ToastUtil.showToast("请输入正确的验证码");
      return;
    }
    var params = {
      "account": phoneController.text,
      "authCode": passwordController.text,
    };
    LoadingUtil.showLoading();
    Map<String, dynamic> map =
        await HttpUtil().post(SERVER_API_URL + LOGIN, data: params);
    LoadingUtil.dismissLoading();
    User? user = User.fromJson(map);
    print(user.result?.accessToken);
    bool a = await StorageUtil().setJSON(USERKEY, user);
    if (a) {
      Get.toNamed(AppRoutes.LOGOUT_NOTICE);
    }
  }
}
