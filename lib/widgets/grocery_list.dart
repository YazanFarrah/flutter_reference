import 'package:flutter/material.dart';
import 'package:flutter_reference/providers/grocery_items_provider.dart';
import 'package:flutter_reference/widgets/new_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroceryList extends ConsumerStatefulWidget {
  const GroceryList({super.key});

  @override
  ConsumerState<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends ConsumerState<GroceryList> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });

    await ref.read(groceryItemsProvider.notifier).getItems(context);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final groceryItems = ref.watch(groceryItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const NewItem();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : groceryItems.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: groceryItems.length,
                  itemBuilder: (ctx, index) {
                    return Dismissible(
                      background: Container(
                        color: Colors.red.withOpacity(0.7),
                      ),
                      key: ValueKey(groceryItems[index].id),
                      onDismissed: (direction) {
                        setState(() {
                          ref.read(groceryItemsProvider.notifier).removeItem(
                                item: groceryItems[index],
                                index: index,
                                context: context,
                              );
                        });
                      },
                      child: ListTile(
                        leading: Container(
                          height: 30,
                          width: 30,
                          color: groceryItems[index].category.color,
                        ),
                        title: Text(groceryItems[index].name),
                        trailing: Text(
                          groceryItems[index].quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  // Display a message when there are no items
                  child: Text(
                    'There\'s nothing here yet. Go add some!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                ),
    );
  }
}
