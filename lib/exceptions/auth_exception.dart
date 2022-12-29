class AuthException implements Exception {
  static const Map<String, String> errors = {
    "EMAIL_EXISTS": "E-mail já cadastrado.",
    "OPERATION_NOT_ALLOWED": "Operação não permitida!",
    "TOO_MANY_ATTEMPTS_TRY_LATER":
        "Acesso temporariamente bloqueado. Tente novamente mais tarde.",
    "EMAIL_NOT_FOUND": "E-mail não encontrado.",
    "INVALID_PASSWORD": "E-mail ou senha incorreta.",
    "USER_DISABLED": "Conta de usuário desabilitada.",
  };
  final String key;

  const AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? "ocorreu um erro no processo de autenticação.";
  }
}
