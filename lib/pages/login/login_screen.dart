import 'package:believe_app/pages/login/login_with_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../constant/colors.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../utils/session_manager.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  final bool _isLoading = false;
  bool _passwordVisible = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  SessionManager sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: button_bg,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));

    return Scaffold(
        backgroundColor: button_bg,
        resizeToAvoidBottomInset: true,
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
                decoration:
                    const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 75),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 75),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset('assets/images/ic_login_logo.png', height: 120, width: 180),
                          const Spacer(),
                          Text(
                            "Log In With Email",
                            textAlign: TextAlign.start,
                            style: titleFontLarge(black),
                          ),
                          const Gap(10),
                          const Text(
                            "Please enter email address and\npassword to login.",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 18, fontFamily: otherFont, color: black, fontWeight: FontWeight.w400),
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
                          const Gap(20),
                          TextField(
                            cursorColor: black,
                            controller: _pwController,
                            obscureText: _passwordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            style: editTextStyle(),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                child: Icon(
                                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: button_bg,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              TextButton(
                                onPressed: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  startActivity(context, ForgotPasswordScreen());
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(fontSize: 16, fontFamily: otherFont, color: button_bg, fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
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
                                        String email = _emailController.text.toString().trim();
                                        String password = _pwController.text.toString().trim();
                                        if (email.isEmpty) {
                                          showSnackBar("Please enter a email", context);
                                        } else if (password.isEmpty) {
                                          showSnackBar("Please enter password", context);
                                        } else {
                                          if (isOnline) {
                                            // logInRequest();
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
                                              "Log In",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16, fontFamily: otherFont, color: white, fontWeight: FontWeight.w600),
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
                                                  style: TextStyle(fontSize: 16, fontFamily: otherFont, color: white, fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                    )),
                              ),
                              const Gap(10),
                              TextButton(
                                onPressed: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  startActivity(context, LoginWithMobileScreen());
                                },
                                child: const Text(
                                  'Login With Mobile?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: otherFont,
                                    color: button_bg,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const Gap(10)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  @override
  void castStatefulWidget() {
    widget is LoginScreen;
  }
}
