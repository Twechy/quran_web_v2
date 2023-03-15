
import '../../models/index.dart';
import 'baseClient.dart';

class SurasClient extends BaseClient {
  Future<OperationResult> updateReading(
      UpdateReadingDto updateReadingDto) async {
    var response = await post('Readers/UpdateRead', updateReadingDto.toJson());

    return OperationResult.fromJson(response.data);
  }

  Future<List<RawySurahVm>> suras() async {
    var locations = <RawySurahVm>[];
    var response = await get('Surah/RawySuras');

    List data = response.data;

    if (data.isNotEmpty) {
      for (var route in data) {
        locations.add(RawySurahVm.fromMap(route));
      }
    }

    return locations;
  }

  Future<SearchItemVm> search({
    String? term,
    int rawy = 32678,
  }) async {
    var response = await get('Surah/Search', queryParameters: {
      'term': term,
      'rawy': rawy,
    });

    final responseData = SearchItemVm.fromJson(response.data);

    return responseData;
  }

  Future<List<SurahNamesVm>> surahNames() async {
    var surahNames = <SurahNamesVm>[];
    var response = await get('Surah/SurahNames');

    List data = response.data;

    if (data.isNotEmpty) {
      for (var name in data) {
        surahNames.add(SurahNamesVm.fromJson(name));
      }
    }

    return surahNames;
  }

  Future<List<RewayaVm>> rewayat() async {
    var readers = <RewayaVm>[];
    var response = await get('Readers/Reyawat');

    List data = response.data;

    if (data.isNotEmpty) {
      for (var reader in data) {
        var rewaya = RewayaVm.fromMap(reader);
        readers.add(rewaya);
      }
    }

    return readers;
  }
}

class ReadersClient extends BaseClient {
  Future<List<ReaderInfo>> getReaders() async {
    var readers = <ReaderInfo>[];
    var response = await get('Readers/ReadersVm');

    List data = response.data;

    if (data.isNotEmpty) {
      for (var reader in data) {
        readers.add(ReaderInfo.fromMap(reader));
      }
    }

    return readers;
  }
}
