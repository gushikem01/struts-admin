#!/bin/bash

# Google Cloud Run deployment script for Struts Admin
set -e

# Configuration
PROJECT_ID=${1:-"your-project-id"}
REGION=${2:-"us-central1"}
SERVICE_NAME="struts-admin"
IMAGE_NAME="gcr.io/$PROJECT_ID/$SERVICE_NAME"

echo "🚀 Deploying Struts Admin to Google Cloud Run..."
echo "Project ID: $PROJECT_ID"
echo "Region: $REGION"
echo "Service: $SERVICE_NAME"
echo ""

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "❌ gcloud CLI is not installed. Please install it first."
    echo "https://cloud.google.com/sdk/docs/install"
    exit 1
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install it first."
    exit 1
fi

# Set the project
echo "📋 Setting project..."
gcloud config set project $PROJECT_ID

# Enable required APIs
echo "🔧 Enabling required APIs..."
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.googleapis.com

# Build and push image using Cloud Build
echo "🏗️  Building image with Cloud Build..."
gcloud builds submit --tag $IMAGE_NAME .

# Deploy to Cloud Run
echo "🚀 Deploying to Cloud Run..."
gcloud run deploy $SERVICE_NAME \
    --image $IMAGE_NAME \
    --region $REGION \
    --platform managed \
    --allow-unauthenticated \
    --memory 1Gi \
    --cpu 2 \
    --concurrency 80 \
    --max-instances 10 \
    --timeout 600 \
    --port 8080 \
    --set-env-vars "PORT=8080" \
    --cpu-boost \
    --quiet

# Get the service URL
SERVICE_URL=$(gcloud run services describe $SERVICE_NAME --region $REGION --format 'value(status.url)')

echo ""
echo "✅ Deployment completed successfully!"
echo "🌐 Service URL: $SERVICE_URL"
echo ""
echo "📊 To view logs:"
echo "gcloud logs tail --follow --project $PROJECT_ID --format 'value(textPayload)' /projects/$PROJECT_ID/logs/run.googleapis.com%2Fstderr"
echo ""
echo "🔧 To update the service:"
echo "./deploy.sh $PROJECT_ID $REGION"