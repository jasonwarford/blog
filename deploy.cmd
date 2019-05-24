@echo off
echo Deploying updates to GitHub . . .

hugo

echo Pushing changes to jasonwarford.github.io submodule . . .
cd public
git add .
set message=Rebuilding site %date%
IF NOT "%1"=="" set message=%1
git commit -m "%message%"
git push origin master

echo Pushing changes to blog repo . . .
cd ..
git add .
git commit -m "%message%"
git push origin master

echo Deployment complete!




