import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gank_global_test/helpers/styles.dart';
import 'package:gank_global_test/models/gank_user_model.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_bloc.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_bloc_components.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_repository.dart';
import 'package:gank_global_test/screens/home/tabs/chat/chat_detail/chat_detail_screen.dart';
import 'package:gank_global_test/widgets/animations/circular_progress_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gank_global_test/widgets/online_indicator_widget.dart';
import 'package:get/get.dart';

class ChatListScreen extends StatelessWidget {
  final BuildContext context;

  ChatListScreen(this.context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (contest, state) {
      if (state is LoggedIn) {
        return AnimationLimiter(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber
                // above.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              StreamBuilder<List<GankUserModel>>(
                  stream: state.gankUserModels,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            GankUserModel gankUserModel = snapshot.data[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 100,
                                child: FadeInAnimation(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(ChatDetailScreen(
                                            chatWithUser: gankUserModel,
                                          ));
                                        },
                                        child: Row(
                                          children: [
                                            Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: IgnorePointer(
                                                    ignoring: true,
                                                    child:
                                                        CircularProfileAvatar(
                                                      '',
                                                      radius: 60.w,
                                                      backgroundColor: Colors
                                                          .primaries[index],
                                                      initialsText: Text(
                                                        gankUserModel.name[0],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      elevation: 5.0,
                                                      cacheImage: true,
                                                      showInitialTextAbovePicture:
                                                          true,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: OnlineIndicatorWidget(
                                                      gankUserModel:
                                                          gankUserModel),
                                                ),
                                              ],
                                            ),
                                            Styles.mediumSpace,
                                            Expanded(
                                              child: Text(
                                                gankUserModel.name,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (index != snapshot.data.length - 1)
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 120.w,
                                            ),
                                            Styles.mediumSpace,
                                            Expanded(
                                                child: Divider(
                                              height: 10,
                                              color: Colors.grey,
                                              thickness: 0.1,
                                            )),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: snapshot.data.length,
                        ),
                      );
                    }
                    return SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    );
                  })
            ],
          ),
        );
        /*return ListView.builder(
          itemCount: state.gankUserModels.length,
          itemBuilder: (context, index) {
            GankUserModel gankUserModel = state.gankUserModels[index];
            print(gankUserModel.name);
            return ListTile(
              title: Text(gankUserModel.name),
            );
          },
        );*/
      }
      return CircularProgressWidget();
    });
  }
}

