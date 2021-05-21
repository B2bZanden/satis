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

## Updating packages
To update existing packages run `zsh update.zsh`.

## Adding new packages
To Add new packages edit the satis.json file and run `zsh update.sh`.  
If this is your first time cloning the repo run `composer install` first.

> Note: Composer repository is in docs folder
