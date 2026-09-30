# B2BZanden Composer Repository

https://b2bzanden.github.io/satis/

## Setting up this repository in your projects

Add this Composer repository to your project's composer.json file, then you can require these private packages just like you would with one from Packagist.

```
{
  "repositories": [{
    "type": "composer",
    "url": "https://b2bzanden.github.io/satis/"
  }],
  "minimum-stability": "dev",
  "prefer-stable": true
}
```

## GitHub access token

The repositories in `satis.json` are private `vcs` repositories owned by the `B2bZanden` organisation, so Satis needs a GitHub token to read them.

Create a **fine-grained** personal access token (https://github.com/settings/personal-access-tokens/new):

- **Resource owner:** `B2bZanden` (if the organisation is not listed, an org admin must allow fine-grained tokens under *Organization settings → Personal access tokens*; approval may be required)
- **Repository access:** *Only select repositories* → the `B2bzanden_M2_*` repositories listed in `satis.json`
- **Permissions:** *Contents: Read-only* (*Metadata: Read-only* is added automatically) — nothing else
- **Expiration:** short (30–90 days); create a new one when it expires

Do not use a classic `repo` token, and do not paste the token at Composer's interactive prompt: that stores it in plain text in `~/.composer/auth.json` and replaces the token other projects may rely on.

Instead, store it in a local `.env` file (ignored by git):

```sh
echo 'SATIS_GITHUB_TOKEN=github_pat_xxx' > .env
```

or read it from 1Password when building (see below). The token is passed to the container via `COMPOSER_AUTH`, which takes precedence over `auth.json` and only applies to this run.

## Run as Docker container

Pull the image:

```sh
docker pull composer/satis:latest
```

Run the image (with Composer cache from host):

```sh
docker run --rm --init -it \
  --platform linux/amd64 \
  --name satis \
  --user $(id -u):$(id -g) \
  --volume $(pwd):/build \
  --volume "${COMPOSER_HOME:-$HOME/.composer}:/composer" \
  --env COMPOSER_AUTH="{\"github-oauth\":{\"github.com\":\"${SATIS_GITHUB_TOKEN}\"}}" \
  composer/satis build <configuration-file> <output-directory>
```

- `<configuration-file>` = `satis.json`
- `<output-directory>` = `docs`

Build, commit and push in one go:

```sh
set -a && . ./.env && set +a &&
docker pull composer/satis:latest &&
docker run --rm --init -it \
  --platform linux/amd64 \
  --name satis \
  --user "$(id -u):$(id -g)" \
  --volume "$(pwd):/build" \
  --volume "${COMPOSER_HOME:-$HOME/.composer}:/composer" \
  --env COMPOSER_AUTH="{\"github-oauth\":{\"github.com\":\"${SATIS_GITHUB_TOKEN}\"}}" \
  composer/satis build satis.json docs &&
git add docs &&
git diff --cached --quiet || (git commit -m ":arrow_up: update dependencies" && git push)
```

Using 1Password instead of `.env`: replace the first line with

```sh
SATIS_GITHUB_TOKEN="$(op read 'op://<vault>/<item>/credential')" &&
```

## Updating Satis

Pull the latest image. 
