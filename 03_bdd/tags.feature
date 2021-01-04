Feature: Tag Policies

Scenario: Ensure that specific tags are defined
  Given I have resource that supports tags defined
  Then it must contain tags
  And its value must not be null