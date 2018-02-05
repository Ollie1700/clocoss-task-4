#!/bin/bash

BUCKET_NAME="bucket-$1";
NAMESPACE="$1s4";

printf "#!/bin/bash\n\nbash datastore-export.sh $BUCKET_NAME $NAMESPACE" > cron-job.sh;

gsutil mb -l europe-west2 gs://$BUCKET_NAME;

bash datastore-export.sh $BUCKET_NAME $NAMESPACE;

export EDITOR=nano;

USERNAME=`whoami`;

echo "The bucket and cron job have been generated.";
echo "Now we need to add the generated cron job file to the execution list.";
echo "Please copy the line of code below (betweek the asterisks) and paste it at the bottom of the file when the nano editor appears (REMEMBER TO SAVE IT TOO!)";
echo "***";
echo "0 * * * * sh /home/$USERNAME/clocoss-4/cron-job.sh";
echo "***";
read -p "Press enter when you are ready...";

crontab -e;

echo "All done! The backup is now running once per hour (assuming you pasted the code into the crontab successfully)";
