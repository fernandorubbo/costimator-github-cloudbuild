# costimator github + cloudbuild example

```bash
GITHUB_USER=..
GITHUB_EMAIL=..
GITHUB_TOKEN=..
GITHUB_COST_REVIEWER=..
BUCKET=..
KEY=costimator-key.json
GITHUB_REPO=$(basename `pwd`)


gcloud iam service-accounts create costimator --display-name=costimator
SA=$(gcloud iam service-accounts list --filter='displayName=costimator' --format='value(email)')
gcloud iam service-accounts keys create $KEY --iam-account $SA


gsutil mb gs://$BUCKET
gsutil cp $KEY gs://$BUCKET/$KEY.json


sed  "s/GITHUB_USER/$GITHUB_USER/g; s/GITHUB_EMAIL/$GITHUB_EMAIL/g; s/GITHUB_REPO/$GITHUB_REPO/g; s/GITHUB_COST_REVIEWER/$GITHUB_COST_REVIEWER/g; s/BUCKET/$BUCKET/g; s/KEY/$KEY/g" cloudbuild.yaml.tpl  > cloudbuild.yaml


curl -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    https://api.github.com/user/repos \
    -d "{\"name\":\"$GITHUB_REPO\"}"

git init
git add -A .
git commit -m "first commit"
git remote add origin git@github.com:$GITHUB_USER/$GITHUB_REPO.git
git push -u origin main


echo https://github.com/$GITHUB_USER/$GITHUB_REPO.git
```

1. Navigate to the generated link to see your code. 
1. In github configure Google Cloud Build App.
    1. TODO: Connect repo
    1. TODO: Create trigger
1. Update trigger to trigger only on PR
    https://pantheon.corp.google.com/cloud-build/triggers
1. Add variable
    _GITHUB_TOKEN = YOUR $GITHUB_TOKEN above
1. git checkout -b b1
1. update your code
1. git add -A . && git commit -m "change" && git push origin b1
1. git 


