import 'catalogue.dart';
import 'data.dart';
import 'models.dart';
import 'shelf_state.dart';

void main() {
  final books = rawBooks.map(Book.fromJson).toList();

  final library = Library()..open();
  for (final book in books) {
    library.add(book);
  }
  library.add(const Magazine(title: 'National Geographic', year: 2023, issue: 12));
  library.add(const Ghost(title: 'Lost Catalogue Card', year: 1975));

  print('=== Library opened at ${library.openedAt} ===\n');

  print(library.buildReport());

  print('\n--- Level 2: hierarchy ---');
  for (final item in library.items) {
    final isOld = item.isOld;
    print('${item.describe()} (old: $isOld)');
  }
  final firstBook = books.first;
  print(firstBook.borrowLabel());
  print('${firstBook.title} isLong: ${firstBook.isLong}');
  final renamed = firstBook.copyWith(title: '${firstBook.title} (2nd ed.)');
  print('copyWith -> $renamed');

  print('\n--- Level 3: null safety ---');
  print('findByTitle("Refactoring") -> ${library.findByTitle('Refactoring')}');
  print('findByTitle("Nope") -> ${library.findByTitle('Nope')}');
  print('countryOf("Design Patterns") -> ${library.countryOf('Design Patterns')}');
  print('countryOf("Nope") -> ${library.countryOf('Nope')}');

  print('\n--- Level 4: collections ---');
  print('All titles: ${library.allTitles.join(', ')}');
  print('Books after 2010: ${library.booksAfter2010.map((b) => b.title).join(', ')}');
  print('Average pages: ${library.averagePages.toStringAsFixed(1)}');
  print('Books per author: ${library.bookCountByAuthor}');
  print('Distinct authors: ${library.authorNames}');
  print('Genres present: ${library.genresPresent.map((g) => g.label).join(', ')}');

  print('\n--- Level 5: Dart 3 ---');
  final stats = statsOf(books);
  print('statsOf -> count: ${stats.count}, avgPages: ${stats.avgPages.toStringAsFixed(1)}');

  const emptyState = Empty();
  final readyState = Ready(books);
  const brokenState = Broken('shelf collapsed');
  print(describe(emptyState));
  print(describe(readyState));
  print(describe(brokenState));
}
