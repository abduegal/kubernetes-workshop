#!/bin/bash

docker build -t gcr.io/aegal-kubernetes-workshop/webapp .
gcloud docker push gcr.io/aegal-kubernetes-workshop/webapp
