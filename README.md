# AWSAUTH #

Simple CLI for switching predefined profiles in AWS accounts (with autocomplete).

## How do I get set up? ###

### Configure *base* profile
Login to AWS console in management account. 
Retrieve AWS credentials and setup profile named **base** (in ~/.aws/credentials file).

### Configure default CLI setting 
Update ~/.aws/config file with default settings:
```properties
[default]
output = json
region = eu-west-1
```

### Generate AWS profile credentials
Execute `./generate_credentials.sh` script. It will use **base** profile configured previously to fetch
MFA device settings and create predefined environment specific profiles.

*NOTE*: Profiles can be edited in `./templates/credentials.tmpl` file.

### Configure awsauth and autocomplete
Execute `./configure.sh` script. It will deploy CLI script together with autocomplete support.

## Usage 
`awsauth $profile` use [TAB] to get autocomplete on available profiles.

## Contribution guidelines ###

Feel free to create PR with improvements you may miss in the current version.