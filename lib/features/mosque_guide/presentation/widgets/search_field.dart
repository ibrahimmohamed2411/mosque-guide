import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosque_guide/core/utils/constants.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/mosque.dart';
import '../cubit/mosque_cubit.dart';
import 'mosque_suggestion_item.dart';

class SearchField extends StatefulWidget {
  SearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  LatLng? currentLocation;

  @override
  Widget build(BuildContext context) {

    return BlocListener<MosqueCubit, MosqueState>(
      listenWhen: (previous, current) => current is LocationLoadedState,
      listener: (context, state) {
        if (state is LocationLoadedState) {
          currentLocation = state.location;
        }
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
        height: 50,
        width: double.infinity,
        child: TypeAheadField<Mosque>(
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.brightGreen,
              ),
              hintText: 'ابحث عن ماتريدة',
              hintStyle: TextStyle(fontSize: 15, color: AppColors.hint),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          suggestionsCallback: (pattern) async {
            return await context.read<MosqueCubit>().getMosquesByName(pattern);
          },
          itemBuilder: (context, suggestion) {
            return MosqueSuggestionItem(
              mosque: suggestion,
            );
          },
          onSuggestionSelected: (suggestion) async {
            Constant.showMosqueInfo(
              context: context,
              mosque: suggestion,
              currentLocation: currentLocation!,
            );
          },
        ),
      ),
    );
  }
}
