@qtype @qtype_multianswer
Feature: Test creating a Multianswer (Cloze) question with REGEXP sub-question and Preview it
  As a teacher
  In order to test my students
  I need to be able to create a Cloze question including a REGEXP sub-question and Preview it

  Background:
    Given the following "users" exist:
      | username |
      | teacher  |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user    | course | role           |
      | teacher | C1     | editingteacher |

  @javascript
  Scenario: Create a Cloze question with basic REGEXP sub-question with errors
    When I am on the "Course 1" "core_question > course question bank" page logged in as teacher
    And I press "Create a new question ..."
    And I set the field "Embedded answers (Cloze)" to "1"
    And I click on "Add" "button" in the "Choose a question type to add" "dialogue"
    And I set the field "Question name" to "multianswer-00"
    And I set the field "Question text" to "The French flag is {1:REGEXP:%10%blue, white and red#Congratulations! ~%0%--.*blue.*#Missing blue!}."
    And I press "id_submitbutton"
    Then I should see " One of the answers should have a score of 100% so it is possible to get full marks for this question."
    And I set the field "Question text" to "The French flag is {1:REGEXP:%100%blue, white and red#Congratulations! ~%0%--.*blue.*#Missing blue!}."
    And I press "id_submitbutton"
    Then I should see "multianswer-00" in the "categoryquestions" "table"

  @javascript
  Scenario: Create a Cloze question with basic REGEXP sub-question and Preview it
    When I am on the "Course 1" "core_question > course question bank" page logged in as teacher
    And I add a "Embedded answers (Cloze)" question filling the form with:
      | Question name        | multianswer-01                                     |
      | Question text        | The French flag is {1:REGEXP:%100%blue, white and red#Congratulations! ~%0%--.*blue.*#Missing blue!}. The German flag is {1:REGEXP_C:%100%Black, red and gold#Very good!~%0%black, red and gold#Start with a capital letter}.     |
      | General feedback     | Both flags have 3 colours.|
    Then I should see "multianswer-01" in the "categoryquestions" "table"

    # Preview it.
    And I choose "Preview" action for "multianswer-01" in the question bank
    And I should see "The French flag is"
    # Set behaviour options
    And I set the following fields to these values:
      | behaviour | immediatefeedback |
    And I press "saverestart"
    
    And I set the field with xpath "//input[contains(@id, '1_sub1_answer')]" to "blue, white and red"
    And I set the field with xpath "//input[contains(@id, '1_sub2_answer')]" to "Black, red and gold"
    And I press "Check"
    
    # see https://stackoverflow.com/questions/5818681/xpath-how-to-select-node-with-some-attribute-by-index
    # Click on feedbacktrigger for blank #1
    And I click on "(//a[contains(@class, 'feedbacktrigger')])[1]" "xpath_element"
    And I wait "1" seconds
    Then I should see "Congratulations!"
    # Click on feedbacktrigger for blank #2
    And I click on "(//a[contains(@class, 'feedbacktrigger')])[2]" "xpath_element"
    And I wait "1" seconds
    Then I should see "Very good!"
    And I press "Start again"
    And I set the field with xpath "//input[contains(@id, '1_sub1_answer')]" to "white and red"
    And I set the field with xpath "//input[contains(@id, '1_sub2_answer')]" to "black, red and gold"
    And I press "Check"
    And I click on "(//a[contains(@class, 'feedbacktrigger')])[1]" "xpath_element"
    Then I should see "Missing blue!"
    And I click on "(//a[contains(@class, 'feedbacktrigger')])[2]" "xpath_element"
    Then I should see "Start with a capital letter"

  @javascript
  Scenario: Create a Cloze question with REGEXP sub-question with permutations and Preview it
    # Note: it's not possible to generate permutations in the multianswer question; we use a full-blown regular expression.
    # In that regular expression the pipe characters | must be escaped.
    When I am on the "Course 1" "core_question > course question bank" page logged in as teacher
    And I add a "Embedded answers (Cloze)" question filling the form with:
      | Question name        | multianswer-01                                     |
      | Question text        | The French flag is {1:REGEXP:%100%blue, white and red#Congratulations!~%0%--.*blue.*#Missing blue!~%100%(blue, white(,\| and) red\|blue, red(,\| and) white\|white, red(,\| and) blue\|white, blue(,\| and) red\|red, blue(,\| and) white\|red, white(,\| and) blue)#One of the 12 accepted answers}.     |
      | General feedback     | The general feedback.|
    Then I should see "multianswer-01" in the "categoryquestions" "table"

    # Preview it.
    And I choose "Preview" action for "multianswer-01" in the question bank
    And I should see "The French flag is"
    # Set behaviour options
    And I set the following fields to these values:
      | behaviour | immediatefeedback |
    And I press "saverestart"
    
    And I set the field with xpath "//input[contains(@id, '1_sub1_answer')]" to "blue, white and red"    
    And I press "Check"
    
    # Click on feedbacktrigger for blank #1
    And I click on "(//a[contains(@class, 'feedbacktrigger')])" "xpath_element"    
    Then I should see "Congratulations!"

    And I press "Start again"
    And I set the field with xpath "//input[contains(@id, '1_sub1_answer')]" to "white and red"
    And I press "Check"
    And I click on "(//a[contains(@class, 'feedbacktrigger')])" "xpath_element"
    Then I should see "Missing blue!"

    And I press "Start again"
    And I set the field with xpath "//input[contains(@id, '1_sub1_answer')]" to "white, blue and red"
    And I press "Check"
    And I click on "(//a[contains(@class, 'feedbacktrigger')])" "xpath_element"
    Then I should see "One of the 12 accepted answers"
    