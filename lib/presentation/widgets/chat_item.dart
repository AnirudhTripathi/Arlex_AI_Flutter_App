import 'package:arlex_getx/controller/home_screen_controller.dart';
import 'package:arlex_getx/presentation/widgets/expandable_text_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatItemWidget extends StatelessWidget {
  final Content content;

  const ChatItemWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        content.role == "user"
            ? Padding(
                padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                child: Row(
                  children: [
                    Container(
                      width: 35.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.homescreenBgColor),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: const Color(0xFF7176ED)),
                        child: ExpandableTextWidget(
                          text: content.parts?.lastOrNull!.text ??
                              'Some error occured',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 15.w),
                          child: Markdown(
                              shrinkWrap: true,
                              selectable: true,
                              softLineBreak: true,
                              styleSheet: MarkdownStyleSheet(
                                p: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              data: content.parts?.lastOrNull?.text ??
                                  'cannot generate data!'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                              text:
                                  content.parts?.lastOrNull?.text.toString() ??
                                      ""),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Data copied to clipboard successfully!'),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Obx(
                        () => Padding(
                          padding: EdgeInsets.only(
                            left: 250.w,
                          ),
                          child: Get.find<HomeScreenController>()
                                  .streamingData
                                  .value
                              ? Lottie.asset(
                                  'assets/lottie/streaming.json',
                                  width: 25.w,
                                  height: 25.h,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.r),
                                      color: const Color(0xFF7176ED)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.w),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.copy_all_outlined,
                                          size: 25.sp,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Copy",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
