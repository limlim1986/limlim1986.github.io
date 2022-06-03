---
layout: post
title:  "Typescript starter"
categories: typescript
tags: typescript eslint prettier husky  
description: This basic tutorial will walk you through the very basics of setting up a typescript development environment from the ground up
---
Many who start a typescript project use some scaffolding tool to get started quickly. Those tools abstract the complexity of setting up a good typescript environment so you can focus on coding productively asap. Unfortunately this leads to many developers not understanding what is actually happening behind the scenes. This basic tutorial will walk you through the very basics of setting up a typescript development environment from the ground up so you can get a better understanding of the parts involved and how they work. 

## Prerequisites
To be able to follow along with this tutorial you will first of all need to have some things installed. 

1. Install the latest version of node. It can be found [here]("https://nodejs.org/").
2. We will be using visual studio code as our editor. Install the latest version. It can be found [here](https://code.visualstudio.com/).
3. We will be using git for source control. Install the latest version. It can be found [here]("https://git-scm.com/"). 

## Initialize your workspace
Creating an empty folder for your project

Open the folder with visual studio code `File -> Open Folder`

Open a fresh terminal window in visual studio code `Terminal -> New Terminal`

Initiate a new Git repository and node project.
```sh
git init
npm init -y
```

Now that we have node set up we can start installing dependencies. First off install typescript.

```sh
npm install typescript --save-dev
```

Now we want to initialize a new typescript project. To do this we will use npx. Npm includes a tool called npx, which will allow you yo run executable packages without having to install them.

```sh
npx tsc --init
```

This command will create a tsconfig.json file with the default settings.

## ESLint

## Prettier

## Husky