import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/article_entity.dart';

@injectable
class ArticleListCubit extends Cubit<ArticleListState> {
  
  List<ArticleEntity> _articles = List.empty(growable: true);

  final TextEditingController searchController = TextEditingController();
  ArticleListCubit() : super(ArticleListState()){
    
    _articles = [
      ArticleEntity(id: 1, authorId: 2, titels: 'logement 1', content: "Belle maison avec vue sur la mer, proche de toutes commodités. Idéal pour des vacances en famille.", articleImage: 'https://picsum.photos/200/300' , ),
      ArticleEntity(id: 2, authorId: 3, titels: 'logement 2', content: "Appartement moderne dans le centre-ville, à proximité des transports en commun et des commerces.", articleImage: 'https://picsum.photos/200/300' , ),
      ArticleEntity(id: 3, authorId: 4, titels: 'logement 3', content: "Magnifique chalet en montagne, parfait pour les amoureux de la nature. Paisible et confortable.", articleImage: 'https://picsum.photos/200/300' , ),
      ArticleEntity(id: 4, authorId: 5, titels: 'logement 4', content: "Expérience unique dans cette cabane au bord du lac. Calme absolu et vue imprenable.", articleImage: 'https://picsum.photos/200/300' , ),
      ArticleEntity(id: 5, authorId: 6, titels: 'logement 5', content: "Superbe villa avec piscine privée. Parfait pour un séjour luxueux et détendu.", articleImage: 'https://picsum.photos/200/300' , ),
      ArticleEntity(id: 6, authorId: 7, titels: 'logement 6', content: "Maison traditionnelle avec jardin, située dans un quartier pittoresque. Charme authentique.", articleImage: 'https://picsum.photos/200/300' , ),
      ArticleEntity(id: 7, authorId: 8, titels: 'logement 7', content: "Appartement lumineux avec vue panoramique. Proche des attractions touristiques.", articleImage: 'https://picsum.photos/200/300' , ),
    ];

  
    _articles.add(ArticleEntity(
      id: 8,
      authorId: 9,
      titels: 'Mauvaise expérience',
      content: "J'ai eu une expérience terrible avec ce logement. La propreté était médiocre, le propriétaire était impoli et le quartier était bruyant. Je ne recommande pas.",
      articleImage: 'https://picsum.photos/200/300',
    ));

    _updateState();
  }

  void search(String? value){
    List<ArticleEntity> articles = [] ;
  if(value != null) {
    articles = _articles.where((article) => article.titels.toLowerCase().contains(value.toLowerCase())).toList();
    _updateState(articles: articles);
  } else {
    _updateState(articles: _articles);
  }
  }

  void searchInArticleList(){
    List<ArticleEntity> articles = [] ;
    articles = _articles.where((article) => article.titels.contains(searchController.text)).toList();
    _updateState(articles: articles);
  }

  _updateState({List<ArticleEntity>? articles}){
    emit(ArticleListState(articles: articles ?? _articles));
  }

}

class ArticleListState {

  List<ArticleEntity> articles ;
  ArticleListState({List<ArticleEntity>? articles}) : articles = articles ?? [];
}
