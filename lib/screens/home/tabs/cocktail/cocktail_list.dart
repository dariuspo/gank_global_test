import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gank_global_test/helpers/styles.dart';
import 'package:gank_global_test/models/cocktail_model.dart';
import 'package:gank_global_test/screens/home/tabs/cocktail/bloc/bloc.dart';
import 'package:gank_global_test/widgets/animations/circular_progress_widget.dart';

class CocktailList extends StatefulWidget {
  final BuildContext context;

  CocktailList(this.context);

  @override
  _CocktailListState createState() => _CocktailListState();
}

class _CocktailListState extends State<CocktailList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CocktailBloc, CocktailState>(
      builder: (context, state) {
        if (state is CocktailInitial) {
          return CircularProgressWidget();
        }
        if (state is CocktailLoaded) {
          print(state.cocktails);
          if (state.cocktails?.isEmpty ?? false) {
            return Center(child: Text('empty cocktails'));
          }
          return true
              ? CustomScrollView(
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      // This is the flip side of the SliverOverlapAbsorber
                      // above.
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          widget.context),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          CocktailModel cocktailModel = state.cocktails[index];

                          return Image.network(cocktailModel.strDrinkThumb);
                        },
                        childCount: state.cocktails.length,
                      ),
                    )
                  ],
                )
              : AnimationLimiter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.cocktails?.length ?? 0,
                    itemBuilder: (context, index) {
                      CocktailModel cocktailModel = state.cocktails[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 500),
                        child: SlideAnimation(
                          horizontalOffset: 50,
                          child: FadeInAnimation(
                            child: Image.network(cocktailModel.strDrinkThumb),
                          ),
                        ),
                      );
                    },
                  ),
                );
        }
        if (state is CocktailError) {
          return Text('error');
        }
        return SizedBox.shrink();
      },
    );
  }
}
