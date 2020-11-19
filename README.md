# costimator github + cloudbuild example

```bash
GITHUB_USER=fernandorubbo
GITHUB_EMAIL=fernandorubbo@google.com
GITHUB_REPO=$(basename `pwd`)
GITHUB_COST_REVIEWER=fbrubbo
GS_BUCKET_NAME=rubbo-costimator
SA_KEY=rubbo-costimator-1-7c2c159e6951.json

sed  "s/GITHUB_USER/$GITHUB_USER/g; s/GITHUB_EMAIL/$GITHUB_EMAIL/g; s/GITHUB_REPO/$GITHUB_REPO/g; s/GITHUB_COST_REVIEWER/$GITHUB_COST_REVIEWER/g; s/GS_BUCKET_NAME/$GS_BUCKET_NAME/g; s/SA_KEY/$SA_KEY/g" cloudbuild.yaml.tpl  > cloudbuild.yaml

git init
git commit -m "first commit"
git remote add origin git@github.com:$GITHUB_USER/$GITHUB_REPO.git
git push -u origin master

```
