import 'dart:async';
import 'dart:convert';
import 'package:believe_app/pages/task/my_task_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/login/SendOTPResponseModel.dart';
import '../../model/login/VerifyOtpResponseModel.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';

class VerifyOTPScreen extends StatefulWidget {
  String mobileNumber;
  String userId;

  VerifyOTPScreen(this.mobileNumber,this.userId, {Key? key}) : super(key: key);

  @override
  _VerifyOTPScreen createState() => _VerifyOTPScreen();
}

class _VerifyOTPScreen extends BaseState<VerifyOTPScreen> {
  bool _isLoading = false;
  FocusNode inputNode = FocusNode();
  String mobileNumber = "";
  String strPin = "";
  String otp = "";
  String userId = "";
  bool visibilityResend = false;
  TextEditingController otpController = TextEditingController();
  late Timer _timer;
  int _start = 20;

  @override
  void initState() {
    mobileNumber = (widget as VerifyOTPScreen).mobileNumber;
    userId = (widget as VerifyOTPScreen).userId;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      openKeyboard();
    });
    startTimer();
    super.initState();
  }

  void openKeyboard() {
    // FocusScope.of(context).requestFocus(inputNode);
  }

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
                decoration:
                    const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 75),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/ic_login_logo.png', height: 120, width: 180),
                          Text(
                            "Verify OTP",
                            textAlign: TextAlign.start,
                            style: titleFontLarge(black),
                          ),
                          const Gap(10),
                          Text(
                            "We just sent a OTP to your mobile number\n$mobileNumber",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 18, fontFamily: otherFont, color: black, fontWeight: FontWeight.w500),
                          ),
                          const Gap(30),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 20, bottom: 4, left: 34, right: 34),
                            child: PinCodeTextField(
                              // focusNode: inputNode,
                              autoDisposeControllers: false,
                              controller: otpController,
                              appContext: context,
                              pastedTextStyle: const TextStyle(
                                color: black,
                                fontSize: 16,
                                fontFamily: otherFont,
                                fontWeight: FontWeight.w600,
                              ),
                              textStyle: const TextStyle(fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w600, color: black),
                              length: 4,
                              autoFocus: false,
                              obscureText: false,
                              blinkWhenObscuring: true,
                              autoDismissKeyboard: true,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.circle,
                                borderWidth: 1,
                                fieldHeight: 50,
                                fieldWidth: 50,
                                activeColor: black,
                                selectedColor: Colors.black,
                                disabledColor: grayDark,
                                inactiveColor: grayDark,
                                activeFillColor: Colors.transparent,
                                selectedFillColor: Colors.transparent,
                                inactiveFillColor: Colors.transparent,
                              ),
                              cursorColor: black,
                              animationDuration: const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              keyboardType: TextInputType.number,
                              onCompleted: (v) {
                                setState(() {
                                  strPin = v;
                                });
                                if (isOnline) {
                                  _verifyOTPCall();
                                } else {
                                  noInterNet(context);
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  strPin = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            ),
                          ),
                          !visibilityResend
                              ? Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  alignment: Alignment.center,
                                  child: RichText(
                                    text: TextSpan(
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      children: [
                                        const TextSpan(
                                          text: 'Resend OTP in',
                                          style: TextStyle(fontSize: 14, fontFamily: otherFont, color: black, fontWeight: FontWeight.w400),
                                        ),
                                        TextSpan(
                                          text: " $_start Seconds",
                                          style: const TextStyle(fontSize: 15, fontFamily: otherFont, color: black, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      setState(() {
                                        visibilityResend = false;
                                        _start = 60;
                                      });
                                      startTimer();
                                      _getOTPFromAPI();
                                    },
                                    child: const Text(
                                      'Resend OTP',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: otherFont,
                                        color: button_bg,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                )
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
                                String contact = otpController.text.toString().trim();
                                if (contact.isEmpty)
                                {
                                  showSnackBar("Please enter a OTP", context);
                                }
                                else if (contact.length != 4)
                                {
                                  showSnackBar("Please enter valid OTP", context);
                                }
                                else
                                {
                                  if (isOnline)
                                  {
                                    _verifyOTPCall();
                                  }
                                  else
                                  {
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
                                      "Verify OTP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18, fontFamily: otherFont, color: white, fontWeight: FontWeight.w600),
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
                      const Gap(15),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void startTimer() {
    const oneSec = Duration(milliseconds: 1000);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            visibilityResend = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  _getOTPFromAPI() async {
    if(isOnline)
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(API_URL + login);
        Map<String, String> jsonBody =
        {
          'user_id': userId,
          'call_app': CALL_APP,
          'from_app': IS_FROM_APP
        };

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
            userId = checkValidString(dataResponse.userId);
          }
          catch (e)
          {
            print(e);
          }
        } else {
          showSnackBar(dataResponse.message, context);
        }
      }
    else
      {
        noInterNet(context);
      }
  }

  _verifyOTPCall() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL + verifyOTP);

    Map<String, String> jsonBody =
    {
      'user_id': userId,
      'call_app': CALL_APP,
      'from_app': IS_FROM_APP,
      'otp' : strPin
    };

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": API_Token,
    });

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = VerifyOtpResponseModel.fromJson(user);
    if (statusCode == 200 && dataResponse.success == 1) {
      try
      {
        sessionManager.setIsLoggedIn(true);
        sessionManager.createLoginSession(dataResponse.data);
        openNextPage();
      }
      catch (e)
      {
        print(e);
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      showSnackBar(dataResponse.message, context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void castStatefulWidget() {
    widget is VerifyOTPScreen;
  }

  void openNextPage() {
    startActivity(context, const MyTaskListScreen());
  }
}
