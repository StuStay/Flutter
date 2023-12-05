import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app/article/domain/entities/article_entity.dart';
import 'package:untitled/core/constants/app_colors.dart';
import 'package:untitled/core/modules/article_module.dart';
import '../screens/article_details_widget.dart';

class ArticleListItem extends StatelessWidget {
  ArticleEntity articleEntity;

  ArticleListItem({super.key, required this.articleEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showArticleMenu(context);
      },
      child: Card(
        elevation: 2,
        color: secondaryColor.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.cyan),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: CachedNetworkImageProvider(
                    articleEntity.articleImage,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
              child: Text(
                articleEntity.titels,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
              child: Text(
                '${articleEntity.content.substring(0, 50)}...',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showArticleMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, 0, 0, 0),
      items: [
        PopupMenuItem(
          value: "LogementDetails",
          child: Text("Logement Details"),
        ),
        PopupMenuItem(
          value: "LogOut",
          child: Text("Log Out"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == "LogementDetails") {
        ArticleModuleRoute.articleDetails
            .push(args: ArticleDetailsArguments(articleEntity: articleEntity));
      } else if (value == "LogOut") {
        // Handle the log-out action
        // You can add your log-out logic here
        print("Log Out");
      }
    });
  }
}
