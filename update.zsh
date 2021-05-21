php $(pwd)/vendor/bin/satis build satis.json docs
git add .
git commit -m ":arrow_up: update dependencies"
git push origin main -f
