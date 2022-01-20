import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/model/product_model.dart';
import 'package:portfolio/pages/product_detail/product_detail.dart';
import 'package:portfolio/widgets/product_card.dart';
import 'package:portfolio/widgets/search_widget.dart';

class SearchPage extends StatefulWidget {
  final List<Product> search;
  SearchPage({required this.search});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  String query = "";
  searchItem(String query) {
    List<Product> searchFood = widget.search.where((element) {
      return element.name.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

 

  @override
  Widget build(BuildContext context) {
    List<Product> _searchItem = searchItem(query);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.sort),
            ),
          ),
        ],
      ),
     
      body: ListView(
        children: [
          SizedBox(height: 20,),
          Container(
            height: 52,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: primaryColor),
                
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Search for items in the store",
                labelStyle: TextStyle(color: primaryColor),
                suffixIcon: Icon(Icons.search,),
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Column(
            children: _searchItem.map((data) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(product: data),
                    ),
                  );
                },
                leading: Image.asset(
          data.imageUrl,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(data.name),
        subtitle: Text(data.description, maxLines: 1, overflow: TextOverflow.ellipsis,),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

}
