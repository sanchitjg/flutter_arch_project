part of '../../flutter_arch_project.dart';

/// An abstract base class representing an event in a `JGBloc`.
///
/// This class extends `Equatable` to enable value comparison of events.
/// Subclasses of `JGBlocEvent` can define specific events that a `JGBloc` can handle.
abstract class JGBlocEvent extends Equatable {
  /// A list of properties to include in the equality comparison.
  ///
  /// Returns an empty list by default, but subclasses can override this
  /// to include specific properties for comparison.
  @override
  List<Object?> get props => [];
}