# Bash user input and rand

Simple light weighted script to ensure a user fill a required field in bash.
You can also hide what's user typing by using the PASSWORD value.
The rand function is just a bonus to generate random numbers between 100000 and 999999.

Please notice that no check is done on what the user is entering.

Text will be shown like this:
```bash
Question [default-value]: {user-input} # user-input is hidden if password arg is set.
```

# How to use ?
Copy-paste the script where you want to use it and source it in the bash you want (```. utils.sh```)

P.s: ```.``` is used rather than source because it works in bash & sh.

```bash
# My first question: {user-input}
TEST1=$(REQUIRED_FIELD "My first question")
# {user-input}
echo $TEST1

# Required field with default value
# My second question [default-value]: {user-input}
TEST2=$(REQUIRED_FIELD "My second question" "default-value" DEFAULT)
# {default-value/user-input}
echo $TEST2

# Password field
# My password: {hidden-user-input}
TEST3=$(REQUIRED_FIELD "My password" "" NO_DEFAULT PASSWORD)
# {hidden-user-input}
echo $TEST3

# Password field with default random value
# My password [random-number]: {hidden-user-input}
TEST4=$(REQUIRED_FIELD "My password" "$(rand)" DEFAULT PASSWORD)
# {random-number/hidden-user-input}
echo $TEST4

```

