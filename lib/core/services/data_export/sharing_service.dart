import 'dart:io';

/// An abstract interface for services that handle sharing of files.
///
/// Implementations of this interface are responsible for providing a way
/// to share a given [File] with other applications or services on the device.
abstract interface class SharingService {
  /// Shares a given [file] with optional [text] and [subject].
  ///
  /// Returns `true` if the sharing operation was successful, `false` otherwise.
  ///
  /// [file]: The file to be shared.
  /// [text]: Optional text to accompany the shared file.
  /// [subject]: Optional subject for the shared content (e.g., for email).
  Future<bool> shareFile(File file, {String? text, String? subject});
}
