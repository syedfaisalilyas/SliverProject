import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ECommerceScreen(),
    );
  }
}

class ECommerceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('E-Commerce App',selectionColor: Colors.white,),
              background: Image.network(
                'https://www.w3schools.com/w3images/lights.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SliverToBoxAdapter for categories
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Product Categories',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          // SliverList for category items
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                title: Text('Category #$index'),
                onTap: () {
                  // Handle category tap
                },
              ),
              childCount: 5,
            ),
          ),
          // SliverToBoxAdapter for a separator
          SliverToBoxAdapter(
            child: Divider(
              height: 1.0,
              color: Colors.grey,
            ),
          ),
          // SliverToBoxAdapter for a title
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Featured Products',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // SliverGrid for product items
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                color: Colors.teal[100 * (index % 9)],
                child: Center(
                  child: Text('Product #$index'),
                ),
              ),
              childCount: 20,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
          ),
          // Custom Sliver for promotional banner
          MyCustomSliver(
            child: Container(
              height: 150,
              color: Colors.orange,
              child: Center(
                child: Text(
                  'Special Promotion!',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomSliver extends SingleChildRenderObjectWidget {
  MyCustomSliver({Widget? child}) : super(child: child);

  @override
  RenderMyCustomSliver createRenderObject(BuildContext context) {
    return RenderMyCustomSliver();
  }
}

class RenderMyCustomSliver extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
      final double childExtent = child!.size.height;
      geometry = SliverGeometry(
        paintExtent: childExtent,
        maxPaintExtent: childExtent,
        scrollExtent: childExtent,
      );
    } else {
      geometry = SliverGeometry.zero;
    }
  }
}
