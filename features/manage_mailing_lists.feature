@mailing_lists
Feature: Mailing Lists
  In order to have mailing_lists on my website
  As an administrator
  I want to manage mailing_lists

  Background:
    Given I am a logged in refinery user
    And I have no mailing_lists

  @mailing_lists-list @list
  Scenario: Mailing Lists List
   Given I have mailing_lists titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of mailing_lists
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @mailing_lists-valid @valid
  Scenario: Create Valid Mailing List
    When I go to the list of mailing_lists
    And I follow "Add New Mailing List"
    And I fill in "Email" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 mailing_list

  @mailing_lists-invalid @invalid
  Scenario: Create Invalid Mailing List (without email)
    When I go to the list of mailing_lists
    And I follow "Add New Mailing List"
    And I press "Save"
    Then I should see "Email can't be blank"
    And I should have 0 mailing_lists

  @mailing_lists-edit @edit
  Scenario: Edit Existing Mailing List
    Given I have mailing_lists titled "A email"
    When I go to the list of mailing_lists
    And I follow "Edit this mailing_list" within ".actions"
    Then I fill in "Email" with "A different email"
    And I press "Save"
    Then I should see "'A different email' was successfully updated."
    And I should be on the list of mailing_lists
    And I should not see "A email"

  @mailing_lists-duplicate @duplicate
  Scenario: Create Duplicate Mailing List
    Given I only have mailing_lists titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of mailing_lists
    And I follow "Add New Mailing List"
    And I fill in "Email" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 mailing_lists

  @mailing_lists-delete @delete
  Scenario: Delete Mailing List
    Given I only have mailing_lists titled UniqueTitleOne
    When I go to the list of mailing_lists
    And I follow "Remove this mailing list forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 mailing_lists
 