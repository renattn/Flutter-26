class Author {
  final String name;
  final String? country;

  const Author({required this.name, this.country});

  @override
  String toString() => country == null ? name : '$name ($country)';
}

enum Genre {
  craft('Craft'),
  theory('Theory'),
  unknown('Unknown');

  final String label;

  const Genre(this.label);

  static Genre fromString(String? raw) => switch (raw) {
    'craft' => Genre.craft,
    'theory' => Genre.theory,
    _ => Genre.unknown,
  };
}

abstract class LibraryItem {
  final String title;
  final int year;

  const LibraryItem({required this.title, required this.year});

  String describe();

  bool get isOld => DateTime.now().year - year > 20;
}

mixin Borrowable on LibraryItem {
  String borrowLabel() => 'Borrow "$title"';
}

class Book extends LibraryItem with Borrowable {
  final int pages;
  final Author author;
  final Genre genre;
  final String? description;

  const Book({
    required super.title,
    required super.year,
    required this.pages,
    required this.author,
    required this.genre,
    this.description,
  });

  const Book.missing()
    : pages = 0,
      author = const Author(name: 'Unknown'),
      genre = Genre.unknown,
      description = null,
      super(title: 'Unknown title', year: 0);

  factory Book.fromJson(Map<String, dynamic> json) {
    final String title = json['title'] as String? ?? 'Unknown title';
    final int year = json['year'] as int? ?? 0;
    final int pages = json['pages'] as int? ?? 0;
    final String authorName = json['author'] as String? ?? 'Unknown';
    final String? country = json['country'] as String?;
    final Genre genre = Genre.fromString(json['genre'] as String?);
    final String? description = json['description'] as String?;

    return Book(
      title: title,
      year: year,
      pages: pages,
      author: Author(name: authorName, country: country),
      genre: genre,
      description: description,
    );
  }

  bool get isLong => pages > 400;

  @override
  String describe() => '$title ($year) by ${author.name}';

  Book copyWith({
    String? title,
    int? year,
    int? pages,
    Author? author,
    Genre? genre,
    String? description,
  }) {
    return Book(
      title: title ?? this.title,
      year: year ?? this.year,
      pages: pages ?? this.pages,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
    );
  }

  @override
  String toString() =>
      'Book(title: $title, year: $year, pages: $pages, '
      'author: ${author.name}, genre: ${genre.label})';
}

class Magazine extends LibraryItem {
  final int issue;

  const Magazine({required super.title, required super.year, required this.issue});

  @override
  String describe() => '$title issue #$issue ($year)';
}

class Ghost implements LibraryItem {
  @override
  final String title;
  @override
  final int year;

  const Ghost({required this.title, required this.year});

  @override
  String describe() => '$title is a ghost entry with no real data';

  @override
  bool get isOld => true;
}
