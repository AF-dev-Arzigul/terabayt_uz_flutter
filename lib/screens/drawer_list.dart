import 'package:flutter/material.dart';
import 'package:terabayt_uz/data/source/remote/api/app_api.dart';
import 'package:terabayt_uz/data/source/remote/response/categories_response.dart';
import 'package:terabayt_uz/di/di.dart';


class DrawerList extends StatefulWidget {
  final Function(int) onDataReceived;

  const DrawerList({Key? key, required this.onDataReceived}) : super(key: key);

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  final AppApi api = di.get<AppApi>();
  List<Categories> categories = <Categories>[];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    setState(() {});
    try {
      var response = await api.getCategories();
      categories = response;
      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox(
        height: 500,
        width: double.infinity,
        child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  widget.onDataReceived.call(categories[index].id);
                  Navigator.pop(context);
                },
                child: CategoryItem(
                  category: categories[index],
                ),
              );
            }),
      );
    });
  }
}

class CategoryItem extends StatelessWidget {
  final Categories category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        category.name,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
      ),
    );
  }
}
