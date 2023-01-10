# Simple Webserver on Python

Build and push to DockerHub using GitHub Actions with tests.

Github action runs on tag. Using this tag as Docker image tag.

## GitHub Actions Jobs

1. Building image from Dockerfile.
2. Testing CURL response from running container.
3. Checking container user is not root (if it is - sending Warning to Slack).
4. Pushing image to DockerHub.
5. Gathering all information as artifact.
6. Sending message and artifact file to Slack.

## Requirements

GitHub Secrets: Slack Token.
GitHub Secrets: DockerHub Token.
Everything else as variables in the workflow file.
