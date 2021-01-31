import 'package:SafeDine/Models/ItemDetails.dart';
import 'package:SafeDine/Screens/Menu/widgets/ItemDetailAppBar.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Widgets/SafeDineButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatefulWidget {
  final ItemDetails itemDetails;
  final String buttonText;
  final Function buttonFunction;
  ItemDetailScreen(
      {@required this.itemDetails,
      @required this.buttonFunction,
      @required this.buttonText});

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<AppTheme>(context,listen: false).white,
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(
          delegate: ItemDetailAppBar(
              expandedHeight: 180.h,
              item: widget.itemDetails.getItem(),
              collapsedHeight: 100),
          pinned: true,
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              details(),
              SizedBox(height: 20),
              Divider(
                color: Provider.of<AppTheme>(context,listen: false).grey,
              ),
              SizedBox(height: 10),
              Text(
                'Additions',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              addOnsWidget(context),
              SizedBox(height: 10),
              Divider(
                color: Provider.of<AppTheme>(context,listen: false).grey,
              ),
              SizedBox(height: 10),
              Text(
                'Quantity',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              quantityWidget(context),
              SizedBox(height: 110),
            ]),
          ),
        ),
      ]),
      floatingActionButton: bottomButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.itemDetails.getItem().getName()}',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text('${widget.itemDetails.getItem().getDescription()}',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
      ],
    );
  }

  Widget bottomButton(context) {
    String prefixText = '';
    if (widget.buttonFunction != null) prefixText = widget.buttonText;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 15, spreadRadius: -6)
          ],
        ),
        child: SafeDineButton(
          text:
              '$prefixText SAR ${widget.itemDetails.getTotalSelectionPrice().toStringAsFixed(2)}',
          fontSize: 17.sp,
          function: () {
            if (widget.buttonFunction != null) widget.buttonFunction();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget quantityWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: Provider.of<AppTheme>(context,listen: false).darkWhite,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  widget.itemDetails.decreaseQuantityByOne();
                });
              },
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text('${widget.itemDetails.getQuantity()}',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ),
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: Provider.of<AppTheme>(context,listen: false).darkWhite,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Center(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  widget.itemDetails.increaseQuantityBy(1);
                });
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget addOnsWidget(context) {
    return Column(
      children: widget.itemDetails
          .getItem()
          .getAddOns()
          .asMap()
          .map((index, addOn) => MapEntry(
                index,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${addOn.getName()}'),
                    Row(
                      children: [
                        Text('${addOn.getPrice().toStringAsFixed(2)}'),
                        Checkbox(
                          value: widget.itemDetails
                              .getSelectedAddOns()
                              .contains(addOn),
                          activeColor: Provider.of<AppTheme>(context,listen: false).primary,
                          onChanged: (selected) {
                            setState(() {
                              if (selected)
                                widget.itemDetails.addSelectedAddOn(addOn);
                              else
                                widget.itemDetails.removeSelectedAddOn(addOn);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ))
          .values
          .toList(),
    );
  }
}
