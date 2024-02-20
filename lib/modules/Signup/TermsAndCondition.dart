// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Signup/signupController.dart';
import 'package:gunlox/network/endpoints.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({
    super.key,
  });
  // String phoneNumber;
  // String accessToken;
  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  var signupController = Get.put(SignupController());
  WebViewController? webViewController;
  bool isLoading = true;

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
      ..loadRequest(Uri.parse(Endpoints.TANDC_URL));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    webViewController!.loadRequest(Uri.parse('about:blank'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 5.h),
                      Center(
                        child: Container(
                          height: 6.h,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.splashLogo),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 10.h,
                                width: 10.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.arrow),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              height: 10.h,
                              width: 10.w,
                              alignment: Alignment.center,
                              child: Text(
                                Constants.termsNcon,
                                style:
                                    CommonTextStyles.poppinsBoldStyle.copyWith(
                                  fontSize: CommonFontSizes.sp22.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 70.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors
                                .placeholdercolor, // You can set the color of the border
                            width: 2.0, // You can set the width of the border
                          ),
                        ),
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: AppColors.secondaryColor,
                              ))
                            : WebViewWidget(
                                controller: webViewController!,
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
    );
  }
}
