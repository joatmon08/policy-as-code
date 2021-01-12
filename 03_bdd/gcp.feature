Feature: GCP Kubernetes Policies

Scenario: Ensure cluster uses RBAC and not ABAC
  Given I have google_container_cluster defined
  Then its enable_legacy_abac must be "false"

Scenario: Ensure cluster doesn't define username for authentication
  Given I have google_container_cluster defined
  When it contains master_auth
  Then its username must be ""

Scenario: Ensure cluster doesn't allow password for authentication
  Given I have google_container_cluster defined
  When it contains master_auth
  Then its password must be ""

Scenario: Ensure cluster doesn't allow client certificate for authentication
  Given I have google_container_cluster defined
  When it contains client_certificate_config
  Then its issue_client_certificate must be "false"

@warning
Scenario: Verify maximum Kubernetes cluster node count does not exceed recommended
  Given I have google_container_node_pool defined
  When it contains autoscaling
  And it contains max_node_count
  Then its value must be lesser and equal to 2

Scenario: Ensure cluster only allows logging and monitoring for OAuth scopes
  Given I have google_container_node_pool defined
  When it contains node_config
  And it contains oauth_scopes
  Then its value must match the "https://www.googleapis.com/auth/logging.write|https://www.googleapis.com/auth/monitoring" regex