import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    hide TabBar, TabBarIndicatorSize, TabBarView;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gank_global_test/blocs/auth/auth_bloc_components.dart';
import 'package:gank_global_test/custom_libs/tabs.dart';
import 'package:gank_global_test/datas/tabs_data.dart';
import 'package:gank_global_test/helpers/after_init.dart';
import 'package:gank_global_test/helpers/styles.dart';
import 'package:gank_global_test/screens/home/tabs/account/account_screen.dart';
import 'package:gank_global_test/screens/home/tabs/cocktail/cocktail_screen.dart';
import 'package:gank_global_test/widgets/containers/color_cover_gradient_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, AfterInitMixin<HomeScreen> {
  TabController _tabController;
  ScrollController _scrollViewController;
  double _top = 0.0;
  StreamController<int> _streamController = StreamController<int>()..add(0);
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      _streamController.add(_tabController.index);
    });
  }

  @override
  void afterInitState() {
    ScreenUtil.init(context,
        designSize: Size(1080, 2400), allowFontScaling: true);
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void dispose() {
    _streamController.close();
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 200.0,
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                elevation: 0,
                bottom: PreferredSize(
                  // Add this code
                  preferredSize: Size.fromHeight(120.0.h), // Add this code
                  child: Text(''), // Add this code
                ),
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    _top = constraints.biggest.height;
                    return FlexibleSpaceBar(
                      titlePadding: EdgeInsets.zero,
                      centerTitle: false,
                      title: Stack(
                        children: [
                          StreamBuilder<int>(
                              stream: _streamController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Positioned.fill(
                                    child: Image.asset(
                                      tabsData[snapshot.data].bgImage,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              }),
                          ColorCoverGradientWidget(),
                          SafeArea(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: TabBar(
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  isScrollable: true,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  controller: _tabController,
                                  indicator: BoxDecoration(
                                    border: Border.all(
                                        color: Styles.accentColor, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  tabs: tabsData
                                      .map(
                                        (e) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AnimatedOpacity(
                                              duration:
                                                  Duration(milliseconds: 100),
                                              opacity: _top <= 150 ? 0 : 1,
                                              child: Text(e.title),
                                            ),
                                            Styles.smallSpace,
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                width: 260.w,
                                                height: 140.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image:
                                                        AssetImage(e.bgImage),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: e.frontImage == null
                                                    ? SizedBox.shrink()
                                                    : CircleAvatar(
                                                        backgroundColor: Styles
                                                            .backgroundColor,
                                                        child: Image.asset(
                                                          e.frontImage,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      /*background: ,*/
                    );
                  },
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            SafeArea(
              top: false,
              bottom: false,
              child: Builder(builder: (BuildContext context) {
                return CocktailScreen(context);
              }),
            ),
            Text('ho'),
            AccountScreen(),
          ],
        ),
      ),
    );
  }
}
