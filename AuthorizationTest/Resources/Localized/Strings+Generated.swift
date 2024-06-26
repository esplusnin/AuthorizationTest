// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum PasswordResetView {
    /// Закрыть
    internal static let close = Strings.tr("Localizable", "PasswordResetView.close", fallback: "Закрыть")
    /// Введите email для сброса пароля
    internal static let enterEmail = Strings.tr("Localizable", "PasswordResetView.enterEmail", fallback: "Введите email для сброса пароля")
    /// Письмо отправлено к вам на почту ✅
    internal static let messageDidSent = Strings.tr("Localizable", "PasswordResetView.messageDidSent", fallback: "Письмо отправлено к вам на почту ✅")
    /// Сбросить пароль
    internal static let resetPassword = Strings.tr("Localizable", "PasswordResetView.resetPassword", fallback: "Сбросить пароль")
    /// Восстановление доступа
    internal static let title = Strings.tr("Localizable", "PasswordResetView.title", fallback: "Восстановление доступа")
  }
  internal enum Authorization {
    /// Авторизация
    internal static let title = Strings.tr("Localizable", "authorization.title", fallback: "Авторизация")
  }
  internal enum DrawingTextPanel {
    /// Добавить
    internal static let add = Strings.tr("Localizable", "drawingTextPanel.add", fallback: "Добавить")
    /// Выйти
    internal static let cancel = Strings.tr("Localizable", "drawingTextPanel.cancel", fallback: "Выйти")
    /// Введите текст
    internal static let enterText = Strings.tr("Localizable", "drawingTextPanel.enterText", fallback: "Введите текст")
  }
  internal enum ErrorDescription {
    /// Не удалось создать аккаунт
    internal static let createNewAccountError = Strings.tr("Localizable", "errorDescription.createNewAccountError", fallback: "Не удалось создать аккаунт")
    /// Что - то пошло не так, попробуйте снова
    internal static let defalt = Strings.tr("Localizable", "errorDescription.defalt", fallback: "Что - то пошло не так, попробуйте снова")
    /// Не удалось отправить письмо с подтверждением
    internal static let emailVerificationError = Strings.tr("Localizable", "errorDescription.emailVerificationError", fallback: "Не удалось отправить письмо с подтверждением")
    /// Не удалось сбросить пароль
    internal static let resetPasswordError = Strings.tr("Localizable", "errorDescription.resetPasswordError", fallback: "Не удалось сбросить пароль")
    /// Ошибка авторизации
    internal static let signInByGoogleError = Strings.tr("Localizable", "errorDescription.signInByGoogleError", fallback: "Ошибка авторизации")
    /// Ошибка авторизации
    internal static let signInError = Strings.tr("Localizable", "errorDescription.signInError", fallback: "Ошибка авторизации")
  }
  internal enum ImageDrawing {
    /// Выйти
    internal static let cancel = Strings.tr("Localizable", "imageDrawing.cancel", fallback: "Выйти")
    /// Изображение успешно сохранено ✅
    internal static let imageSaved = Strings.tr("Localizable", "imageDrawing.imageSaved", fallback: "Изображение успешно сохранено ✅")
    /// Save
    internal static let save = Strings.tr("Localizable", "imageDrawing.save", fallback: "Save")
  }
  internal enum ImageEditor {
    /// Выйти
    internal static let cancel = Strings.tr("Localizable", "imageEditor.cancel", fallback: "Выйти")
    /// Выберите изображение из библиотеки
    internal static let choosePhoto = Strings.tr("Localizable", "imageEditor.choosePhoto", fallback: "Выберите изображение из библиотеки")
    /// Сбросить фильтры
    internal static let resetFilters = Strings.tr("Localizable", "imageEditor.resetFilters", fallback: "Сбросить фильтры")
    /// Поделиться
    internal static let share = Strings.tr("Localizable", "imageEditor.share", fallback: "Поделиться")
  }
  internal enum Registration {
    /// Повторите пароль
    internal static let confirmPassword = Strings.tr("Localizable", "registration.confirmPassword", fallback: "Повторите пароль")
    /// Создать новый аккаунт
    internal static let createAccount = Strings.tr("Localizable", "registration.createAccount", fallback: "Создать новый аккаунт")
    /// Введите адрес электронной почты
    internal static let email = Strings.tr("Localizable", "registration.email", fallback: "Введите адрес электронной почты")
    /// Забыли пароль?
    internal static let forgetPassword = Strings.tr("Localizable", "registration.forgetPassword", fallback: "Забыли пароль?")
    /// Уже зарегистрированы?
    internal static let hasAccount = Strings.tr("Localizable", "registration.hasAccount", fallback: "Уже зарегистрированы?")
    /// Введите пароль
    internal static let password = Strings.tr("Localizable", "registration.password", fallback: "Введите пароль")
    /// Восстановить
    internal static let resumePassword = Strings.tr("Localizable", "registration.resumePassword", fallback: "Восстановить")
    /// Войти с помощью Google
    internal static let signInWithGoogle = Strings.tr("Localizable", "registration.signInWithGoogle", fallback: "Войти с помощью Google")
    /// Войти
    internal static let singIn = Strings.tr("Localizable", "registration.singIn", fallback: "Войти")
    /// Регистрация
    internal static let title = Strings.tr("Localizable", "registration.title", fallback: "Регистрация")
    internal enum Prompt {
      /// Пароли должны совпадать
      internal static let confirmedPassword = Strings.tr("Localizable", "registration.prompt.confirmedPassword", fallback: "Пароли должны совпадать")
      /// Необходимо указать email с адресантом @
      internal static let email = Strings.tr("Localizable", "registration.prompt.email", fallback: "Необходимо указать email с адресантом @")
      /// Необходимо как минимум 8 символов
      internal static let passwordLength = Strings.tr("Localizable", "registration.prompt.passwordLength", fallback: "Необходимо как минимум 8 символов")
      /// Один из символов должен быть заглавным
      internal static let uppercasedLetter = Strings.tr("Localizable", "registration.prompt.uppercasedLetter", fallback: "Один из символов должен быть заглавным")
    }
  }
  internal enum SplashScreen {
    /// AuthorizationTetst
    internal static let title = Strings.tr("Localizable", "splashScreen.title", fallback: "AuthorizationTetst")
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
