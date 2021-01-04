Feature: Azure Policies

Scenario: Ensure that database firewall is not permissive
  Given I have azurerm_postgresql_firewall_rule defined
  When its start_ip_address has "0.0.0.0"
  And its end_ip_address has "255.255.255.255"
  Then it fails


Scenario: Ensure database password conforms to Azure requirements (https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portal)
  Given I have azurerm_postgresql_server defined
  When it contains administrator_login_password
  Then its value must match the "(^[a-zA-Z0-9\S]{8,128})" regex