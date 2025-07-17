import 'package:flutter/material.dart';
import 'package:flutter_application_1/contoller/Bookcontroller.dart';
import 'package:flutter_application_1/widgets/card.dart';
import 'package:provider/provider.dart';



class SearchBook extends StatefulWidget {
  const SearchBook({super.key});

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  final TextEditingController _searchController = TextEditingController();

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Provider.of<BookController>(context, listen: false).searchBooks(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BookController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Book Search'), backgroundColor: Colors.deepPurple),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onSubmitted: (_) => _performSearch(),
              decoration: InputDecoration(
                hintText: 'Search books...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 10),
            if (controller.isLoading)
              const CircularProgressIndicator()
            else if (controller.errorMessage.isNotEmpty)
              Text(controller.errorMessage)
            else if (controller.books.isEmpty)
              const Text('No results found.')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: controller.books.length,
                  itemBuilder: (context, index) =>
                      BookTile(book: controller.books[index]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
