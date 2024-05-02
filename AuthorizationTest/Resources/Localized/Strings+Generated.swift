// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum Authorization {
    /// Авторизация
    internal static let title = Strings.tr("Localizable", "authorization.title", fallback: "Авторизация")
  }
  internal enum Registration {
    /// Повторите пароль
    internal static let confirmPassword = Strings.tr("Localizable", "registration.confirmPassword", fallback: "Повторите пароль")
    /// Создать новый аккаунт
    internal static let createAccount = Strings.tr("Localizable", "registration.createAccount", fallback: "Создать новый аккаунт")
    /// Введите адресс электронной почты
    internal static let email = Strings.tr("Localizable", "registration.email", fallback: "Введите адресс электронной почты")
    /// Уже зарегистрированы?
    internal static let hasAccount = Strings.tr("Localizable", "registration.hasAccount", fallback: "Уже зарегистрированы?")
    /// Введите пароль
    internal static let password = Strings.tr("Localizable", "registration.password", fallback: "Введите пароль")
    /// Войти с помощью Google
    internal static let signInWithGoogle = Strings.tr("Localizable", "registration.signInWithGoogle", fallback: "Войти с помощью Google")
    /// Войти
    internal static let singIn = Strings.tr("Localizable", "registration.singIn", fallback: "Войти")
    /// Регистрация
    internal static let title = Strings.tr("Localizable", "registration.title", fallback: "Регистрация")
    internal enum Prompt {
      /// Пароли должны совпадать
      internal static let confirmedPassword = Strings.tr("Localizable", "registration.prompt.confirmedPassword", fallback: "Пароли должны совпадать")
      /// Необходимо как минимум 4 символа
      internal static let email = Strings.tr("Localizable", "registration.prompt.email", fallback: "Необходимо как минимум 4 символа")
      /// Необходимо как минимум 8 символов
      internal static let passwordLength = Strings.tr("Localizable", "registration.prompt.passwordLength", fallback: "Необходимо как минимум 8 символов")
      /// Один из символов должен быть заглавным
      internal static let uppercasedLetter = Strings.tr("Localizable", "registration.prompt.uppercasedLetter", fallback: "Один из символов должен быть заглавным")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
