# IN BASH, CONDITIONS RETURN TRUE=0 AND FALSE=1

##### UTILS #####
# SET DEFAULT VALUE FOR USER INPUT
function DEFAULT_VALUE () {
    if [[ $IS_PASSWORD = 0 ]]; then SILENCE_INPUT='-s'; fi

    read -p "$QUESTION [$DEFAULT_INPUT_VALUE] (Leave blank to use default value): " $SILENCE_INPUT USER_INPUT # Ask the user to enter a string and show a default input value in []
    USER_INPUT=${USER_INPUT:-$DEFAULT_INPUT_VALUE} # Is user doesn't input, assign DEFAULT_INPUT_VALUE

    if [[ $IS_PASSWORD = 0 ]]; then echo '' >&2; fi 
    echo $USER_INPUT # Returning value
}

# SPECIAL INPUT STATUS (such as default value and/or password)
function SPECIAL_STATUS () {
    if [[ $IS_DEFAULT = 0 ]]; then
        # If field is checked to have a default value and is password
        local USER_DEFAULT_INPUT=$1 # Get default input value
        USER_INPUT=$(DEFAULT_VALUE $QUESTION $USER_DEFAULT_INPUT) # Ask the user to enter a string or leave it empty to keep default value

    elif [[ $IS_PASSWORD = 0 ]]; then
        read -p "$QUESTION: " -s USER_INPUT # Ask the user to enter a password (-s to hide input)

    else
        read -p "$QUESTION: " USER_INPUT # Ask the user to enter a string
    fi

    echo $USER_INPUT
}

# SET THE FIELD AS "REQUIRED"
function REQUIRED_FIELD () {
    local QUESTION=$1 # Show question
    local DEFAULT_INPUT_VALUE=$2 # Get default input value

    # Check if field is supposed to have a default value
    [[ $3 = 'DEFAULT' ]]
    local IS_DEFAULT=$? 
    
    # Check if field is password field
    [[ $4 == 'PASSWORD' ]]
    local IS_PASSWORD=$? 

    local USER_INPUT=$(SPECIAL_STATUS $DEFAULT_INPUT_VALUE $IS_DEFAULT $IS_PASSWORD)

    # If field is required, ask user untill he force stops or he enters a value
    while  [[ -z $USER_INPUT ]] # While string is empty...
    do
        echo "This field is required." >&2 # Ask the user to enter a valid string (>&2 if for direct echo output)
        USER_INPUT=$(SPECIAL_STATUS $DEFAULT_INPUT_VALUE $IS_DEFAULT $IS_PASSWORD)
    done 

    echo '' >&2
    echo $USER_INPUT # Returning value of user input
}

# Generating random number between 100000 and 999999 to avoid duplicate project names
function rand () {
    echo $(awk -v seed="$RANDOM" 'BEGIN{srand(seed);print int(rand()*(999999-100000))+100000 }')
}
##### UTILS #####