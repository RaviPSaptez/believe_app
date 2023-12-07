import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../constant/colors.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreen createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends BaseState<ForgotPasswordScreen> {
  final bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: button_bg,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
        backgroundColor: button_bg,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: orange),
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 60, bottom: 60, left: 18, right: 18)),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 75),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Column(
                    children: [
                      Expanded(child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/ic_login_logo.png', height: 120, width: 180),
                          Text(
                            "Forgot Password",
                            textAlign: TextAlign.start,
                            style: titleFontLarge(black),
                          ),
                          const Gap(10),
                          const Text(
                            "Please enter email address to forgot your password.",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 18, fontFamily: otherFont,color: black, fontWeight: FontWeight.w500),
                          ),
                          const Gap(30),
                          TextField(
                            cursorColor: black,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: editTextStyle(),
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                        ],
                      )),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(button_bg)),
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (!_isLoading) {
                                FocusScope.of(context).requestFocus(FocusNode());
                                String email = _emailController.text.toString().trim();
                                if (email.isEmpty) {
                                  showSnackBar("Please enter a mobile number", context);
                                }
                                else {
                                  if (isOnline) {
                                    Navigator.pop(context);
                                  } else {
                                    noInterNet(context);
                                  }
                                }
                              } else {
                                showToast("Please wait..", context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: !_isLoading
                                  ? const Text(
                                "Forgot Password",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18, fontFamily: otherFont,color: white, fontWeight: FontWeight.w600),
                              )
                                  : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: white,
                                                width: 1,
                                              )),
                                          child: const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: CircularProgressIndicator(color: white, strokeWidth: 2),
                                          ))),
                                  const Text(
                                    "   Please wait..",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, fontFamily: otherFont,color: white, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      const Gap(10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Back to Login Page?',
                          style: TextStyle(fontSize: 16,fontFamily: otherFont, color: button_bg, fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,),
                        ),
                      ),
                      const Gap(15)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  @override
  void castStatefulWidget() {
    widget is ForgotPasswordScreen;
  }

}
