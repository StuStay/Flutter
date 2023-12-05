import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/app/article/domain/entities/article_entity.dart';
import 'package:untitled/app/article/presentation/controllers/article_details_cubit.dart';
import 'package:untitled/core/constants/app_colors.dart';
import 'package:untitled/core/services/navigation_service.dart';
import 'package:untitled/injection.dart';

import '../../../shared_widget/named_container.dart';
import '../components/header_widget.dart';

class ArticleDetailsArguments {
  final ArticleEntity articleEntity;

  ArticleDetailsArguments({required this.articleEntity});
}

class ArticleDetailsWidget extends StatelessWidget {
  const ArticleDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ArticleDetailsArguments?;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: BlocProvider(
        create: (context) => locator<ArticleDetailsCubit>(),
        child: BlocBuilder<ArticleDetailsCubit , ArticleDetailsState>(
          builder: (context , state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            locator<NavigationService>().pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                      Text(
                        args!.articleEntity.titels,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0 , right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Expanded(
                         child: NamedContainer(
                           title: '',
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                             Container(
                               height: 500,
                               width: MediaQuery.sizeOf(context).width,
                               decoration: BoxDecoration(
                                   border: Border.all(color: Colors.white),
                                   borderRadius: BorderRadius.only(
                                       topLeft: Radius.circular(20),
                                       topRight: Radius.circular(20),
                                       bottomLeft: Radius.circular(20),
                                       bottomRight: Radius.circular(20)),
                                   image: DecorationImage(
                                       fit: BoxFit.fitWidth,
                                       image: CachedNetworkImageProvider(
                                           args.articleEntity.articleImage))),
                             ),
                             SizedBox(height: 20,),
                             Text(
                               args.articleEntity.content,
                               textAlign: TextAlign.justify,
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold),
                             )
                           ],),
                         ),
                       ),
                        SizedBox(width: 30,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileCard(),
                              SizedBox(height: 30,),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<ArticleDetailsCubit>().openBanForm();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                  ),
                                  child: Text(
                                    'Ban logement',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30,),
                              if(state.openBanFrom)  NamedContainer(
                                title: '',
                                child: Form(
                                  key: context.read<ArticleDetailsCubit>().formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextFormField(
                                        controller: context.read<ArticleDetailsCubit>().objectFieldController,
                                        decoration: InputDecoration( hintText: "Objet",
                                          hintStyle: TextStyle(color: Colors.white),
                                          fillColor: secondaryColor,
                                          filled: true,
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          ),),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Ce champ est obligatoire';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      TextFormField(
                                        controller: context.read<ArticleDetailsCubit>().reasonFieldController,
                                        minLines: 5,
                                        maxLines: 20,
                                        decoration: InputDecoration( hintText: "Raison du ban",
                                          hintStyle: TextStyle(color: Colors.white),
                                          fillColor: secondaryColor,
                                          filled: true,
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          ),),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Ce champ est obligatoire';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              if (context.read<ArticleDetailsCubit>().formKey.currentState?.validate() ?? false) {

                                              }
                                            },
                                            child: Text('Valider' , style: TextStyle(color: secondaryColor),),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Perform your cancel logic
                                              context.read<ArticleDetailsCubit>().formKey.currentState?.reset();
                                              context.read<ArticleDetailsCubit>().openBanForm();
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                            ),
                                            child: Text('Annuler' , style: TextStyle(color: Colors.white),),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
