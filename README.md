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

## Run as Docker container

Pull the image:

```sh
docker pull composer/satis:latest
```

Run the image (with Composer cache from host):

```sh
docker run --rm --init -it \
  --user $(id -u):$(id -g) \
  --volume $(pwd):/build \
  --volume "${COMPOSER_HOME:-$HOME/.composer}:/composer" \
  composer/satis build <configuration-file> <output-directory>
```

- `<configuration-file>` = `satis.json`
- `<output-directory>` = `docs`

```sh
docker pull composer/satis:latest &&
docker run --rm --init -it \
  --name satis \
  --user $(id -u):$(id -g) \
  --volume $(pwd):/build \
  --volume "${COMPOSER_HOME:-$HOME/.composer}:/composer" \
  composer/satis build satis.json docs &&
git add -A &&
git commit -m ":arrow_up: update dependencies" &&
git push;
```


## Updating Satis

Pull the latest image. 
