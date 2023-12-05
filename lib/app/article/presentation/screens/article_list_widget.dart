import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/app/article/presentation/components/article_list_item.dart';
import 'package:untitled/app/article/presentation/components/header_widget.dart';
import 'package:untitled/app/article/presentation/controllers/article_list_cubit.dart';
import 'package:untitled/core/constants/app_colors.dart';
import 'package:untitled/injection.dart';

class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: BlocProvider(
        create: (context) => locator<ArticleListCubit>(),
        child: BlocBuilder<ArticleListCubit, ArticleListState>(
            builder: (context, state) {
          return Column(
            children: [
              Header(
                search: () {
                  context.read<ArticleListCubit>().searchInArticleList();
                },
                controller: context.read<ArticleListCubit>().searchController,
                instantSearch: (String? value) {
                  context.read<ArticleListCubit>().search(value);
                },
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: (state.articles.isNotEmpty)
                      ? DynamicHeightGridView(
                          itemCount: state.articles.length,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          builder: (context, index) {
                            return ArticleListItem(
                                articleEntity: state.articles[index]);
                          })
                      : Center(
                          child: Text(
                            "Pas d'article trouvé",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
