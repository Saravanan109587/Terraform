terraform {
  required_providers {
    myauth0 = {
      source  = "auth0/auth0"
      version = ">= 1.0.0"
    }
  }
}

provider "myauth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_client_id
  client_secret = var.auth0_client_secret
  debug         = true
}

resource "auth0_client" "webapp" {
  name                                = var.appname
  custom_login_page_on                = true
  is_first_party                      = true
  is_token_endpoint_ip_header_trusted = true
  oidc_conformant                     = false
  callbacks                           = ["https://localhost:4200/callback"]
  allowed_origins                     = ["https://localhost:4200"]
  allowed_logout_urls                 = ["https://localhost:4200"]
  web_origins                         = ["https://localhost:4200"]
  grant_types = [
    "authorization_code"
  ]
  provider = "myauth0"
}
