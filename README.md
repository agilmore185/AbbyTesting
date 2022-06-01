# AbbyTesting
#putting a comment to commit note you need to do in this order post get patch put . 
curl \
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token " \
  https://api.github.com/repos/agilmore185/AbbyTesting/pulls \
  -d '{"title":"NewRequest","body":"Please pull these awesome changes in!","head":"agilmore185:Abby-Feature-Test","base":"main"}'

  curl \
  -X PUT \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token " \
  https://api.github.com/repos/agilmore185/AbbyTesting/pulls/1/merge

  curl \
  -X PATCH \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token " \
  https://api.github.com/repos/agilmore185/AbbyTesting/pulls/1 \
  -d '{"title":"New Title again","body":"updated body","state":"open","base":"main"}'