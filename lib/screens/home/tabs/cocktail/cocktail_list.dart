import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gank_global_test/helpers/styles.dart';
import 'package:gank_global_test/models/cocktail_model.dart';
import 'package:gank_global_test/screens/home/tabs/cocktail/bloc/cocktail_bloc_components.dart';
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
          if (state.cocktails?.isEmpty ?? false) {
            return Center(child: Text('empty cocktails'));
          }
          return AnimationLimiter(
            child: CustomScrollView(
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
                    childAspectRatio: 9 / 11,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      CocktailModel cocktailModel = state.cocktails[index];

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 100,
                          child: FadeInAnimation(
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 9,
                                  child: Card(
                                    color: Styles.backgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 5,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.network(
                                      cocktailModel.strDrinkThumb,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    cocktailModel.strDrink,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    cocktailModel.strCategory,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: state.cocktails.length,
                  ),
                )
              ],
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
