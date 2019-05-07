# Getting started [DONE]

This guide shows you how to build and run a simple Angular app. You'll use the [Angular CLI tool](https://angular.io/cli) to accelerate development, while adhering to the [Style Guide](https://angular.io/guide/styleguide) recommendations that benefit every Angular project.

## Prerequisites

### Node.js

Angular requires Node.js version 8.x or 10.x. To check your version, run `node -v` in a terminal/console window.

### npm package manager

To check that you have the npm client installed, run `npm -v` in a terminal/console window.

## Step 1: Install the Angular CLI

You use the Angular CLI to create projects, generate application and library code, and perform a variety of ongoing development tasks such as testing, bundling, and deployment.

Install the Angular CLI globally. To install the CLI using npm, open a terminal/console window and enter the following command:

    npm install -g @angular/cli

## Step 2: Create a workspace and inital application

You develop apps in the context of an Angular workspace. A [workspace](https://angular.io/guide/glossary#workspace) contains the files for one or more [projects](https://angular.io/guide/glossary/#project). A project is the set of files that comprise an app, a library, or end-to-end (e2e) tests.

To create a new workspace and initial app project:

1. Run the CLI command ng new and provide the name my-app, as shown here: `ng new my-app`
2. The `ng new` command prompts you for information about features to include in the initial app project. Accept the defaults by pressing the Enter or Return key.

The Angular CLI installs the necessary Angular npm packages and other dependencies. This can take a few minutes.

It also creates the following workspace and starter project files:

- A new workspace, with a root folder named `my-app`.
- An initial skeleton app project, also called `my-app` (in the src subfolder)
- An end-to-end test project (in the `e2e` subfolder)
- Related configuration files

## Step 3: Serve the application

Angular includes a server, so that you can easily build and serve your app locally.

    cd my-app
    ng serve --open

### _project_

In Angular, a folder within a workspace that contains an Angular app or library. A workspace can contain multiple projects. All apps in a workspace can use libraries in the same workspace.

### _workspace_

In Angular, a folder that contains projects (that is, apps and libraries). The CLI `ng new` command creates a workspace to contain projects. Commands that create or operate on apps and libraries (such as add and generate) must be executed from within a workspace folder.

## Step 4: Edit your first Angular component

[Components](https://angular.io/guide/glossary#component) are the fundamental building blocks of Angular applications. They display data on the screen, listen for user input, and take action based on that input.

### _component_

A class with the @Component() [decorator](https://angular.io/guide/glossary#decorator) that associates it with a companion [template](https://angular.io/guide/glossary#template). Together, the component and template define a [view](https://angular.io/guide/glossary#view). A component is a special type of [directive](https://angular.io/guide/glossary#directive). The @Component() decorator extends the @Directive() decorator with template-oriented features.

An Angular component class is responsible for exposing data and handling most of the view's display and user-interaction logic through [data binding](https://angular.io/guide/glossary#data-binding).

Read more about components, templates, and views in [Architecture Overview](https://angular.io/guide/architecture).
