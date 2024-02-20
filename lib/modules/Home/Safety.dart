import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Home/HomeScreen.dart.dart';
import 'package:gunlox/network/endpoints.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Safety extends StatefulWidget {
  const Safety({super.key});

  @override
  State<Safety> createState() => _SafetyState();
}

class _SafetyState extends State<Safety> {
  WebViewController? webViewController;
  bool isLoading = true;
  var loadingPercentage = 0;

  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (int progress) {
              print("onprogress $progress");
              // Update loading bar.
            },
            onPageStarted: (String url) {
              print("onPageStarted $url");
            },
            onPageFinished: (String url) {
              print("onPageFinished $url");
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            },
            onWebResourceError: (WebResourceError error) {
              print("onWebResourceError $error");
            },
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onUrlChange: (UrlChange urlchange) {}),
      )
      ..loadRequest(Uri.parse(Endpoints.SAFETY_URL));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    webViewController!.loadRequest(Uri.parse('about:blank'));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0.h,
                right: 0.w,
                child: Container(
                  alignment: Alignment.centerRight,
                  width: 100.w,
                  height: 15.h,
                  // Adjusted from left to right
                  child: Image.asset(
                    AppImages.wave,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(30.0),
                          topEnd: Radius.circular(30.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondaryColor,
                            // Set the color of the shadow
                            offset:
                                Offset(0, 0.0), // Set the offset of the shadow
                            blurRadius:
                                10.0, // Set the blur radius of the shadow
                            spreadRadius:
                                -2.0, // Set a negative spread radius for an inner shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.offAll(() => const HomeScreen());
                                      },
                                      child: Container(
                                        height: 8.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(AppImages.arrow),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Container(
                                      height: 10.h,
                                      alignment: Alignment.center,
                                      child: Text(
                                        Constants.safety,
                                        style: CommonTextStyles.poppinsBoldStyle
                                            .copyWith(
                                          fontSize: CommonFontSizes.sp22.sp,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: AppColors.secondaryColor,
                                      ))
                                    : SizedBox(
                                        height: 70.h,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: WebViewWidget(
                                                controller: webViewController!,
                                                // gestureRecognizers: <dynamic>{}
                                                //   ..add(Factory<
                                                //           VerticalDragGestureRecognizer>(
                                                //       () =>
                                                //           VerticalDragGestureRecognizer())),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 8.h,
                          width: 45.w,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.splashLogo),
                            ),
                          ),
                        ),
                        Container(
                          height: 8.h,
                          width: 10.w,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppImages.useracc),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
