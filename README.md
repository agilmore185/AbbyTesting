# AbbyTesting
#putting a comment to commit 
curl \
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token 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" \
  https://api.github.com/repos/agilmore185/AbbyTesting/pulls \
  -d '{"title":"Amazing new feature","body":"Please pull these awesome changes in!","head":"agilmore185:Abby-Feature-Test","base":"main"}'

  curl \
  -X PUT \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token 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" \
  https://api.github.com/repos/agilmore185/AbbyTesting/pulls/1/merge

  curl \
  -X PATCH \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token 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" \
  https://api.github.com/repos/agilmore185/AbbyTesting/pulls/1 \
  -d '{"title":"new title","body":"updated body","state":"open","base":"main"}'