import json
import pytest


@pytest.mark.parametrize('example', ['02_infrastructure_configuration/infrastructure.json'])
def test_aws_security_group_rule_configuration(example):
    with open(example) as f:
        change = json.load(f)
    rule = change['resources'][0]['instances'][0]['attributes']
    assert rule['type'] == "ingress", "rule should be defined as ingress"
    assert rule['protocol'] == "tcp", "protocol should be tcp"
    assert rule['to_port'] == 5432, "allow traffic to port 5432 for postgres"
    assert rule['from_port'] == 5432, "allow traffic from port 5432 for postgres"
    assert '0.0.0.0/0' not in rule['cidr_blocks'], "CIDR block should not be open"
