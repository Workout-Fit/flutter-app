import 'package:http/http.dart';

// logo: Upload!
MultipartFile fromGraphQLUploadToDartMultipartFile(MultipartFile file) => file;
MultipartFile fromDartMultipartFileToGraphQLUpload(MultipartFile file) => file;

// logoSmall: Upload
MultipartFile? fromGraphQLUploadNullableToDartMultipartFileNullable(
        MultipartFile? file) =>
    file;
MultipartFile? fromDartMultipartFileNullableToGraphQLUploadNullable(
        MultipartFile? file) =>
    file;
