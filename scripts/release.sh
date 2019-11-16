cd ..

# get current version from package.json
TAG=$(cat package.json | grep version | cut -d " " -f 4 | tr -d "," | tr -d '"')
echo "add new tag to GitHub: ${TAG}"
 
# Add tag to GitHub
API_URL="https://api.github.com/repos/${REPO}/git/refs"
 
curl -s -X POST $API_URL \
  -H "Authorization: token $GTOKEN" \
  -d @- << EOS
{
  "ref": "refs/tags/${TAG}",
  "sha": "${COMMIT}"
}
EOS
