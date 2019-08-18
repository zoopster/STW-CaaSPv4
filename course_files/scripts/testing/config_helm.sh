#!/bin/bash

echo install helm client on workstation
sudo zypper install helm

kubectl create serviceaccount --namespace kube-system tiller

kubectl create clusterrolebinding tiller --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

helm init --tiller-image registry.suse.com/caasp/v4/helm-tiller:2.8.2 --service-account tiller

helm repo add suse-charts https://kubernetes-charts.suse.com

helm install suse-charts/log-agent-rsyslog --name 1.0.1 --set server.host=rsyslog-server.default.svc.cluster.local --set server.port=514