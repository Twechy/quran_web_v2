import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/index.dart';
import '../http/clients.dart';

final surahClientProvider =
    Provider.autoDispose<SurasClient>((ref) => SurasClient());

final surasProvider =
    StreamProvider.autoDispose<List<RawySurahVm>>((ref) async* {
  final service = ref.watch(surahClientProvider);
  yield* Stream.fromFuture(service.suras());
});

final surahNamesProvider =
    StreamProvider.autoDispose<List<SurahNamesVm>>((ref) async* {
  final service = ref.watch(surahClientProvider);
  yield* Stream.fromFuture(service.surahNames());
});
