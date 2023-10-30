import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getpost/getcat.dart';
import 'package:http/http.dart'as http;

import 'classcat/cat.dart';

class postcli extends StatefulWidget {
  final int catId;
  const postcli(this.catId, {super.key});

  @override
  State<postcli> createState() => _postcliState();
}

class _postcliState extends State<postcli> {
  TextEditingController txt1 = TextEditingController();
  TextEditingController txt2 = TextEditingController();
  TextEditingController txt3 = TextEditingController();
  
  Future<bool> addclient( String id ,String cate, String des,) async{
    var a = await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/Category/InsertCategory"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
          "categoryId" : id,
          "category" : cate ,
          "description": des ,
          "createdBy": "1"

      }),
    );
    if (a.statusCode==200){
      return true;
    }
    else {
      return false;
    }
  }
  
  
  @override

  void initState(){
    super.initState();
    print(widget.catId);
    getCategory();
  }
  List<CategoryList> catList = [];
  List<CategoryList> catList1 = [];
  Future<List<CategoryList>> getclient() async{
    List<CategoryList> list = [];
    var a = await http.get(Uri.parse("http://catodotest.elevadosoftwares.com//Category/GetAllCategories"));
    var res= jsonDecode(a.body)["categoryList"] as List;
    list = res.map((e) => CategoryList.fromJson(e)).toList();
    return list;
  }

  getCategory() async {

    catList.addAll(await getclient());

    catList1.addAll(catList.where((e) => e.categoryId == widget.catId));
    
    if(catList1.isNotEmpty) {
      setState(() {
        txt2.text = catList1[0].category!;
        txt3.text = catList1[0].description!;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: txt2,
            decoration: InputDecoration(
              hintText: "catagery",
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: txt3,
            decoration: InputDecoration(
              hintText: "description",
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(onPressed: () async {
            await addclient(widget.catId.toString(),txt2.text,txt3.text);
            Navigator.push(context,MaterialPageRoute(builder: (context)=>getcat()));
          }, child: Text("add")),
        ],
      ),

    );
  }
}
