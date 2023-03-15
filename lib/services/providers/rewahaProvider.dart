import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_web_v2/services/providers/surasProvider.dart';

import '../../models/index.dart';


final rewayatData = FutureProvider.autoDispose<List<RewayaVm>>((ref) async {
  final watch = ref.read(surahClientProvider);

  final rewayat = await watch.rewayat();
  return rewayat;
});
