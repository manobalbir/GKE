gcloud components install kubectl # won't work for ubuntu
sudo apt-get install kubectl # for ubuntu

gcloud config set project root-melody-306922
gcloud config set compute/zone australia-southeast1-b

# permissive cluster with Istio enabled
gcloud beta container clusters create asyncfeedback \
    --addons=Istio --istio-config=auth=MTLS_PERMISSIVE \
    --cluster-version=latest \
    --machine-type=n1-standard-2 \
    --num-nodes=4

# test query
gcloud container clusters

# Knative stuff from https://knative.dev/docs/install/any-kubernetes-cluster/
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.21.0/serving-crds.yaml
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.21.0/serving-core.yaml
kubectl apply --filename https://github.com/knative/net-istio/releases/download/v0.21.0/istio.yaml
kubectl apply --filename https://github.com/knative/net-istio/releases/download/v0.21.0/net-istio.yaml

kubectl --namespace istio-system get service istio-ingressgateway

gcloud pubsub topics create feedback-created
gcloud pubsub topics create feedback-classified


