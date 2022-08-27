import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque_guide/core/utils/app_colors.dart';
import 'package:mosque_guide/core/utils/constants.dart';
import 'package:mosque_guide/core/utils/hex_color.dart';
import 'package:mosque_guide/features/contact%20us/presentation/cubit/contact_us_cubit.dart';
import 'package:mosque_guide/features/contact%20us/presentation/widgets/message_form_field.dart';
import 'package:mosque_guide/features/user/presentation/widgets/custom_elevated_button.dart';
import 'package:mosque_guide/inject_container.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

import '../../../user/data/datasources/user_local_data_source.dart';
import '../../../user/data/datasources/user_remote_data_source.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUser = sl<UserLocalDataSource>().getCurrentUser();
    print(currentUser!.phoneNumber);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'تواصل معنا',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HexColor('#F5F5F5'),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('الاسم'),
                      SizedBox(
                        height: 8,
                      ),
                      Text(currentUser.isAnonymous
                          ? 'زائر'
                          : currentUser.displayName!),
                    ],
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                // Container(
                //   height: 100,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('رقم الجوال'),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         currentUser.phoneNumber!,
                //         style: TextStyle(
                //           color: Colors.red,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                MessageFormField(
                  controller: _messageController,
                ),
                SizedBox(
                  height: 90,
                ),
                CustomElevatedButton(
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  label: 'ارسال',
                  backgroundColor: AppColors.primary,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ContactUsCubit>(context)
                          .sendMessage(_messageController.text);
                    }
                  },
                ),
                contactUsLoadingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget contactUsLoadingWidget() {
    return BlocListener<ContactUsCubit, ContactUsState>(
      listener: (context, state) {
        if (state is ContactUsLoadingState) {
          OverlayLoadingProgress.start(context, barrierDismissible: false);
        } else if (state is ContactUsErrorState) {
          OverlayLoadingProgress.stop(context);
          Constant.showErrorMessage(context: context);
        } else if (state is ContactUsSuccessState) {
          OverlayLoadingProgress.stop(context);
          _messageController.clear();
          Constant.showSuccessMessage(context: context);
        }
      },
      child: SizedBox(),
    );
  }
}
