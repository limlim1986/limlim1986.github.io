---
layout: post
title:  "Typescript starter"
categories: typescript
tags: typescript eslint prettier husky  
description: This basic tutorial will walk you through the very basics of setting up a typescript development environment from the ground up
---
Most who start a typescript project use scaffolding tools to get started quickly. Those tools abstract the complexity of setting up a good typescript environment so you can focus on coding productively asap. Unfortunately this leads to many developers not understanding what is actually happening behind the scenes. This basic tutorial will walk you through the very basics of setting up a typescript development environment from the ground up so you can get a better understanding of the parts involved and how they work. 

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
echo -e "node_modules \nbuild" > .gitignore
echo -e "* text=auto" > .gitattributes
npm init -y
git add -A
git commit -m "initial commit"
```

Now that we have node set up we can start installing dependencies. First off install typescript.

```sh
npm install --save-dev typescript 
```

Now we want to initialize a new typescript project. To do this we will use npx. Npm includes a tool called npx, which will allow you yo run executable packages without having to install them.

### Create tsconfig.json 
```sh
npx tsc --init
```

This command will create a tsconfig.json file with the default settings and contains comments explaining the different compiler options available. For our purposes we will edit the contents of the tsconfig.json file and replace it with the following.

```json
{
  "compilerOptions": {
    "target": "es2016",
    "module": "commonjs",
    "sourceMap": true,
    "outDir": "build",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": true,
    "skipLibCheck": true
  },
  "include": [
    "src/**/*"
  ]
}
```

Note that we are now defining an `outDir` to instruct where to put our compiled javascript files. We have also added an `include` section to define what files the compiler should process.


### Set up source entry point
Now that we have typescript and it's configuration set up it's time to create a folder for our source code. Create a new folder `src` and in that folder create a new file 
`index.ts` with a simple console log statement.

```sh
mkdir src
echo "console.log(\"hello from typescript\")" > src/index.ts
```

### Build and run
Our application entry point is set up and the next step is to add build and run commands. Since we are using node we will leverage npm scripts that can be defined 
in the `package.json` file "scripts" section. Open the package.json file and modify it's script section to look like this.

```json
"scripts": {
  "start": "node ./build/index.js",
  "build": "tsc"
}
```
The `build` script will run the typescript compiler that in turn uses the instructions in `tsconfig.json` to process the .ts files and output javascript.

The `start` script runs our application entrypoint index.js with node.

Try the commands yourself from your terminal.
```sh
npm run build
npm start
```

You should see the console output of `hello from typescript`

We now have a working typescript application and it's time to move on to making our development experience with typescript as smooth as possible.

## ESLint

ESlint is a static code analyzer that can quickly help you write clean and coherent typescript based on rules that are built into eslint and/or custom rules that can be provided by you or others through plugins. We will start by installing eslint as a dev dependency with npm.

```sh
npm install --save-dev eslint 
```

Once that is done we can utilize the eslint init command to guide us through the process of creating a configuration file.

```sh
npm init @eslint/config
```

You will be asked a series of questions. Make sure to make the choices described below to ensure the rest of this tutorial will work for you.

<sub>
__How would you like to use ESLint?__ _To check syntax, find problems, and enforce code style_  
__What type of modules does your project use?__ _JavaScript modules (import/export)_  
__Which framework does your project use?__ _None of these_  
__Does your project use TypeScript?__ _Yes_  
__Where does your code run?__ _node_ (use space to deselect browser and choose only node at this question)  
__How would you like to define a style for your project?__ _Use a popular style guide_  
__Which style guide do you want to follow?__ _Google: https://github.com/google/eslint-config-google_  
__What format do you want your config file to be in?__ _JSON_  
__The config that you've selected requires the following dependencies Would you like to install them now?:__ _Yes_  
__Which package manager do you want to use?__ _npm_  
</sub>

You should now have a `.eslintrc.json` file in the root folder and it contains contents according to the answers you provided to the questions above. You will also find that there have been a bunch of dependencies added to your `package.json` file related to your answers. To try eslint out we can now run it on any file we want to check like this:

```sh 
npx eslint src/index.ts
```

You should see something similar to the below in your console output:

![eslint-errors](/assets/img/typescript-eslint-errors.jpg)

This is the result of running your file through the configured rules of eslint. To get the full benefit of this at development time we will be installing the eslint extension for visual studio code. Open the extensions panel with `Ctrl+Shift+X` and search for Eslint. Install the extension and restart visual studio code. You should now be able to open your `src/index.ts` file and see the eslint errors as red squigglys and if you hover over them you can see what the actual error is.

To try and automatically fix our we can run the eslint command with the `--fix` option. Let's try it.
```sh
npx eslint src/index.ts --fix
``` 

Your `index.ts` file should now be fixed with the double quotes changed to single quotes and a semi colon added to the end of the line. Great job! We now have a static code analyzer set up to help us quickly find errors and to write our code in a coherent way throughout our project.

## Prettier

We have got our linter set up making sure we code according to our rules set up. However we will be using another tool to complement the static analysis of our code.
We will be using prettier to enforce a coherent format throughout all the files in our solution. Essentially removing the possibility for the programmer to diverge from the configured format by automatically enforcing it.


### Install and configure
We will start by installing prettier as a dev dependency with npm.

```sh
npm install --save-dev --save-exact prettier
```

Then we will add an empty prettier configuration file.
```sh
echo {} > .prettierrc.json
```

and last but not least we will add a `.prettierignore` file to make sure the prettier cli and editors know what files _not_ to format.
```sh
echo -e "build \nnode_modules \npackage-lock.json" > .prettierignore
```

To try out our prettier setup we can now run the following command.
```sh
npx prettier --write .
```

The result should look something like this:
![prettier-write-result](/assets/img/prettier-write-result.jpg)

You can now go back and check your `index.ts` file and you will notice that prettier has added back the double quotes to your string. This in turn will cause eslint to warn again that you should not be using double quotes. So we have a conflict here between prettier and eslint.

### ESLint and prettier in harmony

To make ESLint and Prettier play nice with each other we will install another npm package called [eslint-plugin-prettier](https://github.com/prettier/eslint-plugin-prettier). It runs Prettier as an ESLint rule and reports differences as individual ESLint issues and it also comes with a recommended config setup that sets up both the plugin and [eslint-config-prettier](https://github.com/prettier/eslint-config-prettier) in one go. [eslint-config-prettier](https://github.com/prettier/eslint-config-prettier) turns off all ESLint rules that are unnecessary or might conflict with your Prettier setup.

```sh
npm install --save-dev eslint-plugin-prettier 
npm install --save-dev eslint-config-prettier
```

Then, add configuration in your `.eslintrc.json` file. Make sure to put the prettier extends rules and plugins last, so it gets the chance to override other settings.
This is what your file should look like
```json
{
  "env": {
    "es2021": true,
    "node": true
  },
  "extends": ["google", "plugin:prettier/recommended"],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "plugins": ["@typescript-eslint", "prettier"],
  "rules": {
    "prettier/prettier": "error"
  }
}
```

Once the file is saved you might need to restart visual studio code for the changes to take affect. With that done you can check your index.ts file again and you should see the error about double quotes gone. This means we are now using prettiers formatting rules. To make sure you can change your `prettierrc.json` file to this.

```json
{
  "singleQuote": true
}
```

Checking the index.ts file again you should see an error and hovering over that error should show its originating from ESLint through the prettier/prettier plugin and. 
![prettier-write-result](/assets/img/prettier-error.jpg)

### Setting the default formatter

We have solved the problem with conflicting rules between prettier and also making sure all errors are picked up by ESLint by using the prettier plugin.
To leverage the full power of prettier we also want to make sure our editor can help us clean any formatting issues when we save a file we are working on. To do this we will install the prettier extension to visual studio code. 

`Ctrl+Shift+X` to open the extensions plane. Search for prettier and install it.

To configure visual studio code with prettier as the default formatter for typescript files.  
- Open your `index.ts` file and from there open the command pallet `Ctrl+Shift+P`  
- Type: `Format Document With ...`  
- At the end of the list of options click on `Configure Default Formatter` and choose prettier.

Repeat this process for any json file if you want prettier to automatically format those also.

### Formatting on save

The formatter to use is now set up and we want to tell visual studio to automatically run it when we save files.  

- Open the command pallet `Ctrl+Shift+P`  
- Type: `open settings ui ..`  
- Click the one and only option in the dropdown to open the settings tab. 
- Search: `formatonsave` and tick the checkbox
![prettier-write-result](/assets/img/format-on-save.jpg)

You should now be able to get auto formatting according to your prettier rules when saving your typescript files. Try it out by removing the trailing semicolon in your `index.ts` file. It should show you an error but if you save the file prettier will automatically add the missing semi colon.

Our development environment is now helping us to automatically follow all our linting and formatting rules automatically so we can focus on the functionality! Great success. Next step is to make sure anything that gets committed to our repository also follow our rules. For this we will use Husky and lint-staged.

## Husky

[Husky](https://typicode.github.io/husky/#/) is a utility used to make working with git hooks easy. For our setup we want to use husky to be able to enforce that our format and linting rules are always followed when committing code. We will accomplish this by running ESlint and prettier on commits. To ensure we only run on files that have actually changed we will use [lint-staged](https://github.com/okonet/lint-staged).

### Install and configure
```sh
npx husky-init && npm install
```

This will setup husky, modify `package.json` and create a sample pre-commit hook that you can edit. By default, it will run npm test when you commit.

Now install lint-staged.
```sh
npm install --save-dev lint-staged 
```

With lint-staged installed we want to configure our husky pre-commit hook to run lint-staged. In the `.husky` folder open the pre-commit file and put the following in it.
```sh
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx lint-staged
```

All that is left now is to set up lint-staged so it knows what to run. We will do this by adding a lint-staged section in our `package.json`file.

```json
"lint-staged":{
    "**/*.{js,jsx,ts,tsx}":[
      "npx eslint --fix",
      "npx prettier --write",
    ]
  }
```
In short this will run eslint fix and prettier on all the files matching the glob pattern before anything is actually committed. If there is any error the code will not commit and the developer has to fix any rule or format violations manually before being able to commit code. This will ensure we do not get any code that violates our rules into our repository and everyone can be assured we have clean and well formatted code to work with.

To try this out lets add a new file `src/consolePrinter.ts` with the following contents:
```typescript
export const consolePrinter = (message: string) => {
  console.log(message);
};
``` 
and also modify our `src/index.ts` to be:
```typescript
import { consolePrinter } from './consolePrinter';

consolePrinter('hello from typescript');
```

Make sure you can build and run the application with:
```sh
npm run build && npm start
```

Now try to stage and commit your changes to see our new git hook with lint-staged in action.
```sh
git add -A
git commit -m "trying out git hooks"
```


