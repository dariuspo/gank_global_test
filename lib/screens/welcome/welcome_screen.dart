import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gank_global_test/helpers/after_init.dart';
import 'package:gank_global_test/helpers/styles.dart';
import 'package:gank_global_test/screens/home_screen.dart';
import 'package:gank_global_test/widgets/buttons/elevated_round_button.dart';
import 'package:gank_global_test/widgets/containers/color_cover_gradient_widget.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with AfterInitMixin<WelcomeScreen> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/intro_video.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      showControls: false,
      showControlsOnInitialize: false,
      autoInitialize: true,
      aspectRatio: 9 / 19,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  void afterInitState() {
    ScreenUtil.init(context,
        designSize: Size(1080, 2400), allowFontScaling: true);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Chewie(
          controller: _chewieController,
        ),
        ColorCoverGradientWidget(),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 300.h),
            child: Column(
              children: [
                SizedBox(
                  width: 450.w,
                  child: Image.asset('assets/icons/open_logo.png'),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 200.h),
            child: ElevatedRoundButton(
              'Sign in anonymously',
              () {
                Get.off(HomeScreen());
              },
            ),
          ),
        )
      ],
    );
  }
}


