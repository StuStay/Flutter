

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ArticleDetailsCubit extends Cubit<ArticleDetailsState> {

  bool _openBanFrom = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController objectFieldController = TextEditingController();
  final TextEditingController reasonFieldController = TextEditingController();

  ArticleDetailsCubit() : super(ArticleDetailsState());


  void openBanForm(){
    if(_openBanFrom){
      _openBanFrom = false ;
    }else{
      _openBanFrom = true ;
    }
    _updateState();
  }

  _updateState(){
    emit(ArticleDetailsState(openBanFrom: _openBanFrom));
  }

  void markAsVerified() {}
}

class ArticleDetailsState {
  bool openBanFrom;

  ArticleDetailsState({ this.openBanFrom = false});
}