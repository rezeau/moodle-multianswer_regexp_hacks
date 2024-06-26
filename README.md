# moodle-multianswer_regexp_hacks
This set of 3 files will enable you to use my REGEXP question type inside a cloze/multianswer question. 

Download the multianswer_regexp_hacks.zip file to your computer; unzip and copy the 3 php files to YOURMOODLE/question\type\multianswer folder where they will replace the existing PHP files of the same name. Files: edit_multianswer_form.php questiontype.php renderer.php

*Before doing that* you shoud copy & save those 3 Moodle original files somewhere, so you can revert things if needed, especially when upgrading to a newer version of Moodle.

The current version of the 3 hacked files is compatible with the current Moodle 4.x versions.

Be extremely careful and only use those hacks if you know what you are doing.

The add_regexp.feature script is only useful if you are running Behat tests. It needs to go into the YOURMOODLE/question\type\multianswer\tests\behat\ folder

See the documentation on the Moodle documentation site here: 
