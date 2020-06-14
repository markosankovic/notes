# The Application Shell [DONE]

You begin by creating an initial application using the Angular CLI. Throughout this tutorial, you'll modify and extend that starter application to create the Tour of Heroes app.

In this part of the tutorial, you'll do the following:

1. Set up your environment.
2. Create a new workspace and initial app project.
3. Serve the application.
4. Make changes to the application.

## Set up your environment

Done in Getting Started.

## Create a new workspace and an initial application

You develop apps in the context of an Angular workspace. A [workspace](https://angular.io/guide/glossary#workspace) contains the files for one or more [projects](https://angular.io/guide/glossary/#project). A project is the set of files that comprise an app, a library, or end-to-end (e2e) tests. For this tutorial, you will create a new workspace.

    ng new angular-tour-of-heroes

The Angular CLI installs the necessary Angular npm packages and other dependencies. This can take a few minutes.

It also creates the following workspace and starter project files:

- A new workspace, with a root folder named angular-tour-of-heroes.
- An initial skeleton app project, also called angular-tour-of-heroes (in the src subfolder).
- An end-to-end test project (in the e2e subfolder).
- Related configuration files.

## Serve the application

    cd angular-tour-of-heroes
    ng serve --open

## Angular components

The page you see is the _application shell_. The shell is controlled by an Angular *component* named `AppComponent`.

_Components_ are the fundamental building blocks of Angular applications. They display data on the screen, listen for user input, and take action based on that input.

## Make changes to the application

Open the project in your favorite editor or IDE and navigate to the src/app folder to make some changes to the starter app.

### Change the application title

    <h1>{{title}}</h1>

The double curly braces are Angular's _interpolation binding_ syntax.

### Add application styles

Most apps strive for a consistent look across the application. The CLI generated an empty styles.css for this purpose. Put your application-wide styles there.

## Summary

- You created the initial application structure using the Angular CLI.
- You learned that Angular components display data.
- You used the double curly braces of interpolation to display the app title.
