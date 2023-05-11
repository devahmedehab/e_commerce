
import 'package:e_commerce/presentation/search/view_model/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/constants.dart';
import '../../../../data/network/dio_helper.dart';
import '../../../resources/end_point.dart';
import '../search_model.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() :super(SearchInitialState());


  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data:
        {
          'text': text,
        },
    ).then((value){
      model= SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
      
    }).catchError((error){
      emit(SearchErrorState());
    });
  }

}