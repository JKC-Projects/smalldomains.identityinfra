resource "aws_cognito_user_pool" "smalldomains" {
  name = "smalldomains-users"

  # usernames are case sensitive
  case_sensitive = true

  password_policy {
    minimum_length    = 12
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  verification_message_template {
    default_email_option  = "CONFIRM_WITH_LINK"
    email_subject         = "Verify your Account with SmallDomains"
    email_message_by_link = "To verify your account, {##click here##}"
  }

  mfa_configuration = "OFF" # users are not required to use MFA

  software_token_mfa_configuration {
    enabled = true
  }

  device_configuration {
    challenge_required_on_new_device      = true
    device_only_remembered_on_user_prompt = true
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
    from_email_address    = "do-not-reply.verification@small.domains"
  }
}