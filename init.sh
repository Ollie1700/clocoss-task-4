#!/bin/bash

BUCKET_NAME="bucket-$1";
NAMESPACE="$1s4";

printf "#!/bin/bash\n\nbash datastore-export.sh $BUCKET_NAME $NAMESPACE" > cron-job.sh;

gsutil mb -l europe-west2 gs://$BUCKET_NAME;

bash datastore-export.sh $BUCKET_NAME $NAMESPACE;
