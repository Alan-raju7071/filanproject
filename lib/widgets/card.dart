import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Bookmodels.dart';



class BookTile extends StatelessWidget {
  final Book book;
  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
       leading: Image.network(
  book.thumbnail,
  width: 60,
  height: 90,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return const SizedBox(
      width: 60,
      height: 90,
      child: Center(child: CircularProgressIndicator()),
    );
  },
  errorBuilder: (context, error, stackTrace) {
    return const SizedBox(
      width: 60,
      height: 90,
      child: Icon(Icons.broken_image, size: 40),
    );
  },
),


        title: Text(book.title),
        subtitle: Text(
          '${book.authors.join(", ")}\nPublished: ${book.publishedDate}',
          style: const TextStyle(fontSize: 12),
        ),
        isThreeLine: true,
      ),
    );
  }
}
