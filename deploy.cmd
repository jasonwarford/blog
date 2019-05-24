echo Deploying updates to GitHub . . .

hugo

@echo off
cd public

git add .

set message=Rebuilding site %date%

IF NOT "%1"=="" set message=%1

git commit -m "%message%"

@echo on
git push origin master

@echo off
cd ..

git add .
git commit -m "%message%"

@echo on
git push origin master

echo Deployment complete.




