import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../component/component.dart';
import '../../constant.dart';
import '../../models/category_model.dart';
import 'cubit/search-cubit.dart';
import 'cubit/search_state.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          if(state is SearchErrorState){
            flutterToast(msg: 'حدث خطأ ما الرجاء المحاولة مرة اخرى', state: ToastState.ERROR);
          }
        },
        builder: (context, states) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: Text('Search',style:TextStyle(color: Colors.black)),),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    // onChanged: (value){
                    //   SearchCubit.get(context).search(text: value);
                    // },
                    onFieldSubmitted: (value) {
                      cubit.search(text: value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (states is SearchLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child:cubit.searchModel!=null? ListView.separated(
                      itemCount: cubit.searchModel!.data!.data.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        return searchItem(cubit.searchModel!.data!.data[index] as DataList);
                      },
                    ):Center(child: Icon(Icons.search,size:200,color: defaultColor,),),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget searchItem(DataList dataList){
  return Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image:NetworkImage(dataList.image),
          height: 120,
          width: 120,
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(dataList.name,style: TextStyle(fontWeight: FontWeight.bold),maxLines: 2,)),
              Text('${dataList.name} \$',style: TextStyle(color: defaultColor,fontWeight: FontWeight.bold),),
            ],
          ),
        )
      ],
    ),
  );
}
