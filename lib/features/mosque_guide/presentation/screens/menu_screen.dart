import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mosque_guide/config/routes/app_routes.dart';
import 'package:mosque_guide/core/utils/media_query_values.dart';
import 'package:mosque_guide/inject_container.dart';

import '../../../user/data/datasources/user_local_data_source.dart';
import '../widgets/custom_list_tile.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = sl<UserLocalDataSource>().getCurrentUser();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 100),
      child: ListView(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: currentUser!.isAnonymous
                      ? Image.asset(
                          'assets/images/visitor.png',
                          fit: BoxFit.cover,
                        )
                      : ClipRRect(
                          child: Image.network(
                            currentUser.photoURL!,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مرحبا بك',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            currentUser.isAnonymous
                                ? 'زائر'
                                : currentUser.displayName!,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          CustomListTile(
            title: Text(
              'الرئيسية',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            leading: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onTap: ZoomDrawer.of(context)!.toggle,
          ),
          CustomListTile(
            title: Text(
              'حسابي',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          CustomListTile(
            title: Text(
              'اللغة',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            leading: Icon(
              Icons.language_sharp,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          CustomListTile(
            title: Text(
              'شارك التطبيق',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            leading: Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
          CustomListTile(
            title: Text(
              ' تواصل معنا',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            leading: Icon(
              Icons.contact_phone,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.contactUsScreen);
            },
          ),
          CustomListTile(
            title: Text(
              'عن التطبيق',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            leading: Icon(
              Icons.info,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.aboutAppScreen);
            },
          ),
          CustomListTile(
            title: Text(
              'تسجيل خروج',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onTap: () => sl<UserLocalDataSource>().signOut(),
          ),
        ],
      ),
    );
  }
}
