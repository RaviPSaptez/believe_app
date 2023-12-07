import 'dart:convert';
import 'package:believe_app/pages/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/SendOTPResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';

class LoginWithMobileScreen extends StatefulWidget {
  const LoginWithMobileScreen({Key? key}) : super(key: key);

  @override
  _LoginWithMobileScreen createState() => _LoginWithMobileScreen();
}

class _LoginWithMobileScreen extends BaseState<LoginWithMobileScreen> {
  bool _isLoading = false;
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: button_bg,
      statusBarIconBrightness: Brightness.light,
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
                            "Log In With Mobile",
                            textAlign: TextAlign.start,
                            style: titleFontLarge(black),
                          ),
                          const Gap(10),
                          const Text(
                            "Please enter mobile number to login.",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 18, fontFamily: otherFont,color: black, fontWeight: FontWeight.w500),
                          ),
                          const Gap(30),
                          TextField(
                            controller: _mobileController,
                            cursorColor: black,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            style: editTextStyle(),
                            decoration: const InputDecoration(
                              hintText: 'Mobile Number',
                              counterText: '',
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
                                String mobileNumber = _mobileController.text.toString().trim();
                                if (mobileNumber.isEmpty) {
                                  showSnackBar("Please enter a mobile number", context);
                                }  else if (mobileNumber.toString().trim().length !=10) {
                                  showSnackBar("Please enter a valid mobile number", context);
                                }
                                else {
                                  if (isOnline) {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    _getOTPFromAPI(mobileNumber.toString().trim());
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
                                "Get OTP",
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
                          'Login With Email?',
                          style: TextStyle(fontSize: 16, fontFamily: otherFont,color: button_bg, fontWeight: FontWeight.w600,
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

  _getOTPFromAPI(String mobileNumber) async {
    if(isOnline)
    {
      setState(() {
        _isLoading = true;
      });
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + login);
      Map<String, String> jsonBody = {
        'contact_no': COUNTRY_CODE + mobileNumber.toString().trim(),
        'call_app': CALL_APP,
        'from_app': IS_FROM_APP};

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> user = jsonDecode(body);
      var dataResponse = SendOtpResponseModel.fromJson(user);
      if (statusCode == 200 && dataResponse.success == 1)
      {
        try
        {
          String userId = checkValidString(dataResponse.userId);
          if(userId.isNotEmpty)
          {
             openNextPage(mobileNumber,userId);
          }
          else
          {
              showToast("User id not found", context);
          }
        }
        catch (e)
        {
          print(e);
        }
        setState(()
        {
          _isLoading = false;
        });
      } else {
        showSnackBar(dataResponse.message, context);
        setState(()
        {
          _isLoading = false;
        });
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  void openNextPage(String mobileNumber,String userId) {
    startActivity(context, VerifyOTPScreen(mobileNumber,userId));
  }

  @override
  void castStatefulWidget() {
    widget is LoginWithMobileScreen;
  }

}
