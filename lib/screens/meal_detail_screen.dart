// import 'dart:html';
// import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  // const MealDetailScreen({Key? key}) : super(key: key);
  final Function(Meal) onToggleFavorite;
  final bool Function(Meal) isFavorite;

  const MealDetailScreen(this.onToggleFavorite, this.isFavorite);

  Widget _createSEctionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _createsSectionContainer(Widget child) {
    return Container(
      width: 350,
      height: 200,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _createSEctionTitle(context, 'Ingredientes'),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 10),
            //   child: Text(
            //     'Ingredientes',
            //     style: Theme.of(context).textTheme.headline6,
            //   ),
            // ),
            _createsSectionContainer(
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(meal.ingredients[index]),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                  );
                },
              ),
            ),
            // Container(
            //   width: 300,
            //   height: 200,
            //   padding: EdgeInsets.all(10),
            //   margin: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border.all(color: Colors.grey),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: ListView.builder(
            //     itemCount: meal.ingredients.length,
            //     itemBuilder: (ctx, index) {
            //       return Card(
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 5,
            //             horizontal: 10,
            //           ),
            //           child: Text(meal.ingredients[index]),
            //         ),
            //         color: Theme.of(context).colorScheme.secondary,
            //       );
            //     },
            //   ),
            // ),
            _createSEctionTitle(context, 'Passos'),
            _createsSectionContainer(
              ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(meal) ? Icons.star : Icons.star_border),
        onPressed: () {
          onToggleFavorite(meal);
        },
      ),
    );
  }
}
