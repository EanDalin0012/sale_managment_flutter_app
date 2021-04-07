import 'package:flutter/material.dart';
import 'package:sale_managment/share/constant/text_style.dart';
import 'package:sale_managment/share/model/catgory.dart';

class EditCategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  EditCategoryScreen(this.categoryModel);
  @override
  _AddNewCategoryScreenState createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<EditCategoryScreen> {
  var borderColorsTextField = Colors.deepPurple;
  var labelStyle = TextStyle(fontSize: 20, color: Colors.deepPurple, fontFamily: 'roboto');
  var hintStyle = TextStyle(fontFamily: 'roboto');
  var nameValueController = new TextEditingController();
  var remarkValueController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.categoryModel.toString());
    this.nameValueController.text = widget.categoryModel.name;
    this.remarkValueController.text = widget.categoryModel.remark;
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: <Widget>[
          _container(),
          _body(),
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  _save();
                },
                child: Container(
                  width: size.width,
                  height: 45,
                  color: Colors.red,
                  // margin: EdgeInsets.only(
                  //   left: 5,
                  //   right: 5
                  // ),
                  child: Center(child: Text('EDIT', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
        title: Text('Category', style: TextStyle(fontFamily: 'roboto', fontWeight: FontWeight.w700)),
        backgroundColor: Colors.purple[900]
    );
  }

  Container _container() {
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      padding: EdgeInsets.only(
          left: 10,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              'Edit Category',
              style: containStyle
          ),
        ],
      ),
    );
  }

  Expanded _body() {
    return Expanded(
        child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10),
            physics: ClampingScrollPhysics(),
            child: Column(
                children: <Widget>[
                  _categoryNameField(),
                  _categoryRemarkField()
                ])
        )
    );
  }

  Padding _categoryNameField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: nameValueController,
        decoration: InputDecoration(
            hintText: 'Enter category name',
            labelText: 'Name',
            // helperText: 'Category Name',
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            // helperStyle: TextStyle(
            //     color: Colors.blueGrey,
            //     fontWeight: FontWeight.bold,
            //     fontFamily: 'roboto'
            // ),
            // border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColorsTextField,
                    width: 1.5,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.5,
                    style: BorderStyle.solid
                )
            ),
            prefixIcon: Icon(
              Icons.info_outline,
              color: Colors.black54,
            )

        ),
      ),
    );
  }

  Padding _categoryRemarkField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: remarkValueController,
        decoration: InputDecoration(
            hintText: 'Enter remark',
            labelText: 'Remark',
            // helperText: 'Remark',
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            // helperStyle: TextStyle(
            //     color: Colors.blueGrey,
            //     fontWeight: FontWeight.bold
            // ),
            // border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColorsTextField,
                    width: 1.5,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.5,
                    style: BorderStyle.solid
                )
            ),
            prefixIcon: Icon(
              Icons.edit,
              color: Colors.black54,
            )

        ),
      ),
    );
  }
  _save() {
    var categoryModel = new CategoryModel(nameValueController.text, remarkValueController.text);
    print(categoryModel.toString());
  }
}
