import json
import pytest

examples = [
    '01_sox_compliance/sox_compliance_pass.json',
    '01_sox_compliance/sox_compliance_fail_01.json',
    '01_sox_compliance/sox_compliance_fail_02.json'
]


def check_two_different_reviewers(change):
    reviewers = [user['user']['login'] for user in change]
    return reviewers

@pytest.mark.parametrize("example", examples)
def test_change_should_have_two_different_reviewers(example):
    with open(example) as f:
        change = json.load(f)
    reviewers = check_two_different_reviewers(change)
    assert len(reviewers) >= 2, "you should have at least 2 reviewers"
    assert len(reviewers) == len(set(reviewers)
                                 ), "you should have two unique reviewers"
