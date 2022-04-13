#!/bin/bash

kubectl apply -f ../../manifests/secrets/pihole-secret.yml

helm repo add pihole https://mojo2600.github.io/pihole-kubernetes
helm repo update

helm upgrade --install pihole pihole/pihole -f pihole-kubernetes.yaml