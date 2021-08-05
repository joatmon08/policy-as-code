### GOOGLE ###

resource "google_project_iam_member" "project" {
  project = var.project.gcp
  role    = "roles/${var.access_mappings.editor.gcp}"
  member  = var.user.gcp
}

### AWS ###

data "aws_iam_policy" "editor" {
  name = var.access_mappings.editor.aws
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = var.user.aws
  policy_arn = data.aws_iam_policy.editor.arn
}

### AZURE ###

data "azurerm_subscription" "primary" {}

data "azuread_service_principal" "user" {
  display_name = var.user.azure
}

resource "azurerm_role_assignment" "editor" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = var.access_mappings.editor.azure
  principal_id         = data.azuread_service_principal.user.object_id
}