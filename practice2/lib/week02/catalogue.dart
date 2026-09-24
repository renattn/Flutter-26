import 'models.dart';

class Library {
  final List<LibraryItem> items = [];

  late final DateTime openedAt;

  String? _cachedReport;

  void add(LibraryItem item) => items.add(item);

  void open() => openedAt = DateTime.now();

  Book? findByTitle(String title) {
    for (final item in items) {
      if (item is Book && item.title == title) return item;
    }
    return null;
  }

  String countryOf(String title) => findByTitle(title)?.author.country ?? 'unknown';

  String buildReport() => _cachedReport ??= _buildReport();

  Iterable<String> get allTitles => items.map((item) => item.title);

  Iterable<Book> get booksAfter2010 => items.whereType<Book>().where((b) => b.year > 2010);

  double get averagePages =>
      items.whereType<Book>().isEmpty
          ? 0
          : items.whereType<Book>().fold<int>(0, (sum, b) => sum + b.pages) /
              items.whereType<Book>().length;

  Map<String, int> get bookCountByAuthor => items.whereType<Book>().fold<Map<String, int>>(
    const {},
    (counts, book) => {...counts, book.author.name: (counts[book.author.name] ?? 0) + 1},
  );

  Set<String> get authorNames => items.whereType<Book>().map((b) => b.author.name).toSet();

  Set<Genre> get genresPresent => items.whereType<Book>().map((b) => b.genre).toSet();

  List<String> get displayList => [
    'CATALOGUE',
    for (final b in items.whereType<Book>()) '${b.title} (${b.year})',
    ...authorNames,
    if (items.whereType<Book>().any((b) => b.pages == 0)) '(incomplete data)',
  ];

  String _buildReport() => displayList.join('\n');
}
