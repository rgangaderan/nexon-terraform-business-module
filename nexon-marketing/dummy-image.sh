set -ex

region="$(echo "$REPOSITORY_URI" | cut -d. -f4)"
#repository_url="$(echo "$repository_uri" | cut -d/ -f1)"

aws ecr get-login-password --region "$region" --profile "$PROFILE" | docker login --username AWS --password-stdin "$REPOSITORY_URI"
docker pull raj5444/webapp:v1.4
docker tag raj5444/webapp:v1.4 "$REPOSITORY_URI":latest
docker push "$REPOSITORY_URI":latest
