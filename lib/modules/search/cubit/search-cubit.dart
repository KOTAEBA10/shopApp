
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/modules/search/cubit/search_state.dart';

import '../../../constant.dart';
import '../../../models/search_model.dart';
import '../../../network/dio.dart';


class SearchCubit extends Cubit<SearchStates>{

  SearchCubit(): super(SearchInitialState()) ;
 static SearchCubit get(context)=>BlocProvider.of(context);
  //----------------------------------------------------------

  SearchModel? searchModel;
   void search({required String text}){
     emit(SearchLoadingState());
     DioHelper.postData(url: 'home/search',token: TOKEN, data: {
       'text':text,
     }).then((value) {
        searchModel=SearchModel.fromJsom(value.data);
        // print(searchModel!.status);
        emit(SearchSuccessState());
     }).catchError((error){
       print(error);
       emit(SearchErrorState(error.toString()));
     });
   }

}