---
title: "GitHub Action: Build and Deploy .Net Core to Digital Ocean"
draft: false
showonlyimage: false
categories: ["snippets"]
tags: ["github action, .net core, hosting"]
date: "2020-01-24"
weight: 1
---

This is a Github action that will build, publish and deploy an Asp.Net Core web application to a Digitial Ocean droplet that is running Ubuntu.

<!--more-->

This snippet requires a couple of things be set up.

1. SSH on the sever using an SSH key
2. User with access to the target deployement directory


```yaml
name: Build and Deploy ASP.NET Core to Digital Ocean

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Setup .NET Core
      uses: actions/setup-dotnet@v1
      with:
        dotnet-version: '3.1.100'
    - name: Build with dotnet
      run: dotnet build --configuration Release
    - name: dotnet publish 
      run: |
        dotnet publish --configuration Release -o outputDirectory
    - name: Push code to Digital Ocean
      uses: appleboy/scp-action@master
      env:
        HOST: ${{ secrets.REMOTE_HOST }}
        USERNAME: ${{ secrets.REMOTE_USER }}
        PORT: ${{ secrets.REMOTE_PORT }}
        KEY: ${{ secrets.SERVER_SSH_KEY }}
      with:
        source: "outputDirectory"
        target: "/var/www"
```