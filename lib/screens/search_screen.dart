import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  late String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ClimaX'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                icon: Icon(Icons.location_city,color: Colors.white,),
                hintText: 'Enter city name',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                )
              ),
              onChanged: (value){
                print('value = $value');
              },
              onSubmitted: (value){
                cityName = value;
                Navigator.pop(context, cityName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
