Feature: Running a system test or integration test
  As a tester I want to run a test automatically. In order to use the test
  results I want the test to automatically report its result to a permanent data storage.

  Scenario:  Run test
    Given I have created a test
    When the test runs
    Then the test should report that it has started
    And the test run should be unique
    And the test should be revision aware
    And the test should report its progress
    And the test should report its final status

  Scenario: Test steps and test state
    Given a test that is an external script
    Then the script output should serve as the test log
    And the test steps with results should be inferred from the test log
    And test result should be inferred from the test exit state
