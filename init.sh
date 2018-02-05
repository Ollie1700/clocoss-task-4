#!/bin/bash

# Check the parameter is not empty
if [ -z "$1" ]
then
  echo "Please provide your student ID as a parameter, in the exact format 'upXXXXXX' (excluding quotes)";
  exit 1;
fi

# Check the parameter starts with 'up'
if [[ $1 != up* ]]
then
  echo "Your student ID should start with 'up' (excluding quotes)";
  exit 1;
fi

# Check the parameter is exactly 8 characters long
if [[ ${#1} != 8 ]]
then
  echo "Your student ID should be exactly 8 characters long, in the exact format 'upXXXXXX' (excluding quotes)";
  exit 1;
fi

# When the parameter is valid, place it in 2 different strings
BUCKET_NAME="bucket-$1";
NAMESPACE="$1s4";

# Create the cron job file that will be executed every hour
printf "#!/bin/bash\n\nbash datastore-export.sh $BUCKET_NAME $NAMESPACE" > cron-job.sh;

# Create the bucket
gsutil mb -l europe-west2 gs://$BUCKET_NAME;

# Perform an initial backup
bash datastore-export.sh $BUCKET_NAME $NAMESPACE;

# Set the default editor to nano
export EDITOR=nano;

# Grab our name
USERNAME=`whoami`;

# Give user instructions on how to add a cron job
printf "\n==============\n";
printf "The bucket and cron job have been generated.\n";
printf "Now we need to add the generated cron job file to the execution list.\n";
printf "Please copy the line of code below (between the ===) and paste it at the bottom of the file when the nano editor appears (REMEMBER TO SAVE IT TOO!)";
printf "\n===";
printf "0 * * * * sh /home/$USERNAME/clocoss-4/cron-job.sh";
printf "===\n";

# Wait for the user to confirm they are ready
read -p "Press enter when you are ready...";

# Present the user with the cron file
crontab -e;

# Helpful output :)
echo "All done! The backup is now running once per hour (assuming you pasted the code into the crontab successfully)";
