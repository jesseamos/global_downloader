import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';
import 'package:spotify_downloader/core/icons/vectors_icon.dart';
import 'package:spotify_downloader/core/presentation/widgets/custom_button.dart';
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';

Widget buildHeader() {
  return Text.rich(
    style: TextStyle(fontSize: 24),
    TextSpan(
      text: 'spotify_downloader',
      children: [
        TextSpan(
          text: '.Africa',
          style: TextStyle(color: ColorsConstant.primaryColor),
        ),
      ],
    ),
  );
}

Widget buildWelcomeText(
  BuildContext context, {
  required String headerText,
  required String? description,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        headerText,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorsConstant.darkTextPrimary
              : ColorsConstant.primaryBlackText,
        ),
      ),
      const SizedBox(height: 5),
      if (description != null)
        Text(
          description,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorsConstant.darkTextSecondary
                : ColorsConstant.primaryGreyText,
          ),
        ),
    ],
  );
}

Widget buildDivider({String? text, required BuildContext context}) {
  return Row(
    children: [
      Expanded(
        child: Divider(
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorsConstant.darkGreyBorder
              : ColorsConstant.grey50,
          height: 0,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          text ?? 'Or continue with',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorsConstant.darkTextSecondary
                : ColorsConstant.primaryBlackText,
            fontSize: 14,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorsConstant.darkGreyBorder
              : ColorsConstant.grey50,
          height: 0,
        ),
      ),
    ],
  );
}

void showBottomModal(
  BuildContext context,
  String title,
  Widget content, {
  bool isBlankSheet = false,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 6,
          left: 6,
          top: 6,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isBlankSheet == false) ...[
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(
                            Icons.cancel_rounded,
                            color: Colors.black.withOpacity(0.25),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: ColorsConstant.grey50, height: 0),
                ],
                content,
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showBankBottomModal(
  BuildContext context,
  String title,
  Widget content, {
  bool isBlankSheet = false,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final bottomInset = MediaQuery.of(context).viewInsets.bottom;
      return Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          initialChildSize: 0.6,
          builder: (_, controller) {
            return Container(
              margin: EdgeInsets.only(right: 6, left: 6, top: 6),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isBlankSheet) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.cancel_rounded,
                            color: Colors.black.withOpacity(0.25),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    SizedBox(height: 10),
                  ],

                  /// 🔥 The content now gets the scroll controller
                  Expanded(child: content),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

void showReviewBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      const double sheetHeight = 320.0;
      const double flameOverlap = 50.0;
      return SizedBox(
        height: sheetHeight,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: flameOverlap,
              left: 0,
              right: 0,
              child: Container(
                height: sheetHeight - flameOverlap,
                padding: const EdgeInsets.only(
                  top: flameOverlap + 10,
                  left: 24,
                  right: 24,
                  bottom: 24,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 30),
                          Text(
                            'Task is Under Review',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorsConstant.primaryBlackText,
                            ),
                          ),

                          SizedBox(
                            width: 298,
                            child: Text(
                              "You've successfully completed all task for the day.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorsConstant.primaryGreyText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 33),
                      CustomButton(
                        btnText: 'Awesome!',
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();

                          context.pop();
                        },
                        bgColor: ColorsConstant.darkerPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -20,
              child: Center(
                child: SvgIcon(svgPath: flameIcon, width: 103, height: 155),
              ),
            ),
          ],
        ),
      );
    },
  );
}
