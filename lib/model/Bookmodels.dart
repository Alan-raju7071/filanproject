class Book {
  final String title;
  final List<String> authors;
  final String publishedDate;
  final String thumbnail;

  Book({
    required this.title,
    required this.authors,
    required this.publishedDate,
    required this.thumbnail,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    final imageLinks = volumeInfo['imageLinks'] ?? {};
    final rawThumbnail = imageLinks['thumbnail'] ?? '';
    final secureThumbnail = rawThumbnail.replaceAll('http://', 'https://');

    print('Thumbnail: $secureThumbnail');

    return Book(
      title: volumeInfo['title'] ?? 'No Title',
      authors: (volumeInfo['authors'] as List<dynamic>?)?.cast<String>() ?? ['Unknown'],
      publishedDate: volumeInfo['publishedDate'] ?? 'N/A',
      thumbnail: secureThumbnail.isNotEmpty
          ? secureThumbnail
          : 'https://via.placeholder.com/100x150',
    );
  }
}
