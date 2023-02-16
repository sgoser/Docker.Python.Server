# Simple Webserver on Python

Build and push to DockerHub using GitHub Actions with some image and container tests.

Github action runs on tag. Using this tag as Docker image tag.

## GitHub Actions Jobs

1. Building image from Dockerfile.
2. Testing CURL response from running container.
3. Checking container user is not root (if it is - sending Warning to Slack).
4. Pushing image to DockerHub.
5. Gathering all information as artifact.
6. Sending message and artifact file to Slack.

## Jenkinsfile pipline Stages (gitHub action Docker build and test alternative + deployment)

1. Checkout. Clone repository
2. Lint Dockerfile
3. Build Docker image (taged as "jv${env.BUILD_ID}")
4. Test image to get answer from web-server (get index.html)
5. Push Image to repo (requirenment: "registryCredential")
6. Change image tag in deployment manifest
7. Deploy in pre-prod namespace (requirenment: credentialsId: 'k3skubeconfig')
8. Slack Pre-Prod Notification
9. Deploy in prod. Cleaning pre-prod namespace (Pipline paused. Required approve on Jenkins WebUI interface)
10. Cleaning. Delete builded image
11. Post steps - Slack notification with succses / failure Jenkins Job status

## Requirements

GitHub Secrets: Slack Token.
GitHub Secrets: DockerHub Token.
Everything else as variables in the workflow file.
