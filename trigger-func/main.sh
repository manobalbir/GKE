# from https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity
APP="trigger-func"
TOPIC="feedback-created"
PROJECT="root-melody-306922"

gcloud config set project $PROJECT
kubectl create serviceaccount $APP
gcloud iam service-accounts create $APP

gcloud container clusters update asyncfeedback \
  --workload-pool=$PROJECT.svc.id.goog

GSA="$APP@$PROJECT.iam.gserviceaccount.com"

gcloud projects add-iam-policy-binding $PROJECT\
  --member "serviceAccount:$GSA" --role roles/datastore.user

gcloud pubsub topics add-iam-policy-binding $TOPIC \
  --member "serviceAccount:$GSA" --role roles/pubsub.publisher

gcloud iam service-accounts add-iam-policy-binding \
  --role roles/iam.workloadIdentityUser \
  --member "serviceAccount:$PROJECT.svc.id.goog[default/$APP]" \
  $GSA

kubectl annotate serviceaccount \
  $APP iam.gke.io/gcp-service-account=$GSA --overwrite

TAG="gcr.io/$PROJECT/$APP"
gcloud builds submit --tag $TAG
kubectl apply --filename service.yaml

