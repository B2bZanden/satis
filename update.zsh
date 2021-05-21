php $(pwd)/vendor/bin/satis build satis.json docs
git add .
git commit -m "update dependencies"
git push origin main -f
