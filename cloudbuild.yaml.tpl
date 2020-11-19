
steps:

- name: 'gcr.io/cloud-builders/git'
  entrypoint: 'bash'
  args: [ '-c', 'set -x && git config --global user.email "GITHUB_EMAIL" && git config --global user.name "GITHUB_USER" && git clone https://github.com/GITHUB_USER/GITHUB_REPO.git /data && cd /data && git checkout $_BASE_BRANCH' ]
  volumes:
  - name: 'data'
    path: /data

- name: gcr.io/cloud-builders/gcloud
  entrypoint: 'bash'
  args: [ '-c', 'gsutil cp gs://BUCKET/KEY /data' ]
  volumes:
  - name: 'data'
    path: /data

- name: us-central1-docker.pkg.dev/$PROJECT_ID/docker-repo/costimator:v0.0.1 
  entrypoint: 'bash'
  args: [ '-c', 'set -x; costimator --pkg-prev /data/wordpress --pkg /workspace/wordpress --gcp-authkey-file /data/KEY --output /data/out.json' ]
  volumes:
  - name: 'data'
    path: /data

- name: gcr.io/cloud-builders/gcloud
  entrypoint: 'bash'
  args: [ '-c', 'set -x; curl -X POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: Bearer $_GITHUB_TOKEN" https://api.github.com/repos/GITHUB_USER/GITHUB_REPO/issues/$_PR_NUMBER/comments -d "$(cat /data/out.json)"; if grep -q "8593;" /data/out.json; then    curl -X POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: Bearer $_GITHUB_TOKEN" https://api.github.com/repos/GITHUB_USER/GITHUB_REPO/pulls/$_PR_NUMBER/requested_reviewers -d "{\"reviewers\":[\"GITHUB_COST_REVIEWER\"]}"; fi ' ]
  volumes:
  - name: 'data'
    path: /data
