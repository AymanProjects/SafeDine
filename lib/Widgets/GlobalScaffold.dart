import 'package:SafeDine/Screens/Home/HomeScreen.dart';
import 'package:SafeDine/Screens/Menu/widgets/DrawerIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GlobalScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget actionButtton;
  final bool hasDrawer; // if true == (SideBarIcon), if false ==(Back Icon)

  GlobalScaffold(
      {@required this.body, @required this.title, this.actionButtton,@required this.hasDrawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 15.w,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Builder(
            builder: (context)=> Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {           
                    hasDrawer ? Provider.of<HomeDrawerState>(context, listen: false).key.currentState.openDrawer()
                    : Navigator.of(context).pop();

                  },
                  child:
                  hasDrawer ? DrawerIcon(
                    width: 22.w,
                    hieght: 2.w,
                    spaceBetween: 4.w,
                    color: Colors.black54,
                  )
                  : Icon(Icons.arrow_back_ios,
                  size: 22,color: Colors.black54,)
                ),
                actionButtton == null ? SizedBox() : actionButtton,
              ],
            ),
          ),
        ),
        body: Column(children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            height: 50,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
            ),
          ),
          body,
        ]));
  }
}