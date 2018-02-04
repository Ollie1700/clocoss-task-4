#!/bin/bash

BUCKET_NAME="$1"
NAMESPACE="$2"

gcloud beta datastore export --namespaces=$NAMESPACE gs://$BUCKET_NAME
