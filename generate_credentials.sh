#!/usr/bin/env bash

CREDENTIALS_FILE=~/.aws/credentials

# validate AWS CLI config
function validateAWSCLI() {
  echo "Validating AWS CLI configuration..."

  if [ ! -d ~/.aws ]; then
    echo
    echo -e "'~/.aws' directory not present.\nMake sure it exists, and that you have at least one profile configured\nusing the 'config' and 'credentials' files within that directory."
    echo
    exit 1
  fi

  if [[ ! -f ~/.aws/config && ! -f ~/.aws/credentials ]]; then
    echo
    echo -e "'~/.aws/config' and '~/.aws/credentials' files not present.\nMake sure they exist. See http://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html for details on how to set them up."
    echo
    exit 1
  elif [ ! -f ~/.aws/config ]; then
    echo
    echo -e "'~/.aws/config' file not present.\nMake sure it and '~/.aws/credentials' files exists. See http://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html for details on how to set them up."
    echo
    exit 1
  elif [ ! -f ~/.aws/credentials ]; then
    echo
    echo -e "'~/.aws/credentials' file not present.\nMake sure it and '~/.aws/config' files exists. See http://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html for details on how to set them up."
    echo
    exit 1
  fi

  local PROFILES=$(cat $CREDENTIALS_FILE | grep -o '\[[^]]*' | cut -d"[" -f2)
  # check that base nexus profile is configured

  if [[ ! $PROFILES == "nexus"* ]]; then
    echo
    echo -e "NO CONFIGURED 'nexus' base AWS PROFILE FOUND.\nPlease make sure you have '~/.aws/credentials' file and '[nexus]' base profile configured. For more info, see AWS CLI documentation at:\nhttp://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html"
    echo
  fi

  echo "All OK"
}

validateAWSCLI


export AWS_PROFILE=nexus
export MFA_DEVICE_ARN=$(aws iam list-mfa-devices --output text | awk '{print $3}')
export USER_NAME=$(echo ${MFA_DEVICE_ARN} | sed 's/arn:aws:iam::062763764693:mfa\///')

read -p "Update ${CREDENTIALS_FILE}? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

eval "echo \"$(cat ./templates/credentials.tmpl)\"" >> $CREDENTIALS_FILE