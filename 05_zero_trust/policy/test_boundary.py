import json
import pytest

PLAN_FILE = './plan.json'


@pytest.fixture
def resources():
    with open(PLAN_FILE, 'r') as f:
        plan = json.load(f)
    return plan['planned_values']['root_module']['resources']


@pytest.fixture
def boundary_roles(resources):
    roles = []
    for resource in resources:
        if resource['type'] == 'boundary_role':
            roles.append(resource)
    return roles


@pytest.fixture
def boundary_groups(resources):
    groups = []
    for resource in resources:
        if resource['type'] == 'boundary_group':
            groups.append(resource)
    return groups


def test_global_login_allows_auth(
        boundary_roles):
    GLOBAL_LOGIN_GRANTS = set([
        'id=*;type=auth-method;actions=list,authenticate',
        'type=scope;actions=list',
        'id={{account.id}};actions=read,change-password'
    ])
    for role in boundary_roles:
        if role['name'] == 'global_anon_listing':
            assert set(role['values']['grant_strings']) \
                == GLOBAL_LOGIN_GRANTS


def test_only_operations_has_admin(
        boundary_roles, boundary_groups):
    OPERATIONS_TEAM = 'operations_team'
    for role in boundary_roles:
        if role['name'] == 'project_admin':
            principal_ids = \
                role['values']['principal_ids']
    for group in boundary_groups:
        if group['values']['id'] in principal_ids:
            assert group['name'] == OPERATIONS_TEAM
