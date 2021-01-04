# Policy as Code

This is a repository with examples for an O'Reilly Live Training.

Examples are labeled numerically in order by which they appear
in the training.

There are a few different tools demonstrated:

1. Python 3 (test framework: pytest)
   1. Install Python 3
   1. Run `pip3 install -r requirements.txt`
   1. Run `pytest -v` to check you installed the Python testing framework.

1. `terraform-compliance` v1.3.8

1. Open Policy Agent v0.25.2

## Python native testing

You can run exercise 1 and 2 using `pytest`. Both exercises
fail by default.

```shell
$ pytest 01_sox_compliance

2 failed, 1 passed in 0.11s
```

```shell
$ pytest 02_infrastructure_configuration

1 failed in 0.22s
```

## BDD-style Policy Frameworks

When you run `terraform-compliance` via CLI, you will get failing scenarios.
Correct `03_bdd/mock.json` until your tests pass!

```shell
$ terraform-compliance --planfile 03_bdd/mock.json --features 03_bdd

3 features (0 passed, 3 failed)
9 scenarios (5 passed, 4 failed)
```

## Open Policy Agent

In this example, you parse the output of the Consul Intentions API. Intentions
allow and deny network traffic between services, in this case a web service, app service,
and a database.

When you run OPA via CLI, you will get failures.
Correct `mock.json` until the tests pass.

```shell
$ opa eval --format pretty -i 04_dsl/input/mock.json -d 04_dsl "data.service.policies"

{
  "deny": [
    "traffic should only be allowed from web to app, currently web to [\"database\", \"app\"]",
    "intention should deny all other traffic by default, currently [\"allow\"]",
    "number of intentions should be 3, currently 4"
  ]
}
```