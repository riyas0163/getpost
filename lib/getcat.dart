import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getpost/postcli.dart';
import 'package:http/http.dart' as http;

import 'classcat/cat.dart';

class getcat extends StatefulWidget {
  const getcat({super.key});

  @override
  State<getcat> createState() => _getcatState();
}

class _getcatState extends State<getcat> {
  List<CategoryList> list = [];
  Future<List<CategoryList>> getclient() async{
    
    var a = await http.get(Uri.parse("http://catodotest.elevadosoftwares.com//Category/GetAllCategories"));
    var res= jsonDecode(a.body)["categoryList"] as List;
    return res.map((e) => CategoryList.fromJson(e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catlist"),
        // actions: [
        //   IconButton(onPressed: (){
        //     Navigator.push(context,MaterialPageRoute(builder: (context)=>postcli(0)) );
        //   }, icon: Icon(Icons.add,))
        // ],
      ),
      body: FutureBuilder<List<CategoryList>>(
        future: getclient(),
        builder: (context ,snapshot){
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context ,int index){
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    border: TableBorder.all(),
                      columns: [
                        DataColumn(label: Text("id")),
                        DataColumn(label: Text("category")),
                        DataColumn(label: Text("description")),
                        DataColumn(label: Text("deleteon")),
                        DataColumn(label: Text("remove")),
                        DataColumn(label: Text("created by")),
                        DataColumn(label: Text("Action")),
                      ],
                      rows: snapshot.data!.map((e) => DataRow(cells:
                      [
                        DataCell(Text(e.categoryId.toString())),
                        DataCell(Text(e.category.toString())),
                        DataCell(Text(e.description.toString())),
                        DataCell(Text(e.deletedOn.toString())),
                        DataCell(Text(e.removedRemarks.toString())),
                        DataCell(Text(e.createdBy.toString())),
                        DataCell(IconButton(onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder:(context)=> postcli(int.parse(e.categoryId.toString()))));
                        }, icon: Icon(Icons.add))),

                      ])).toList()),
                );
              }
            );
          }
          else if (snapshot.hasError){
            return Text(("${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}
