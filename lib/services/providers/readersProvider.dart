import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/index.dart';
import '../http/clients.dart';

final readersClientProvider =
    Provider.autoDispose<ReadersClient>((ref) => ReadersClient());

final readersProvider =
    FutureProvider.autoDispose<List<ReaderInfo>>((ref) async {
  final readersClient = ref.read(readersClientProvider);

  final readers = await readersClient.getReaders();
  return readers;
});
