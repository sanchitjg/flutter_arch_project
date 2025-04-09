part of '../../flutter_arch_project.dart';

/// An abstract base class representing the state of a `JGBloc`.
/// 
/// This class extends `Equatable` to enable value comparison of states.
abstract class JGBlocState extends Equatable {
  /// Default constructor for `JGBlocState`.
  JGBlocState();

  /// Factory constructor to create a `JGBlocState.sudo` instance.
  ///
  /// Returns an instance of `_JGBlocStateSudo`.
  factory JGBlocState.sudo() => _JGBlocStateSudo();

  /// A list of properties to include in the equality comparison.
  ///
  /// Returns an empty list by default.
  @override
  List<Object?> get props => [];
}

/// A final class representing a specific implementation of `JGBlocState`.
///
/// This class overrides the `props` getter to return an empty list.
final class _JGBlocStateSudo extends JGBlocState {
  /// A list of properties to include in the equality comparison.
  ///
  /// Returns an empty list.
  @override
  List<Object?> get props => [];
}