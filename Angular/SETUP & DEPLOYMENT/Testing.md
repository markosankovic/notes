# Testing

This guide offers tips and techniques for unit and integration testing Angular applications.

## Setup

The Angular CLI downloads and install everything you need to test an Angular application with the Jasmine test framework.

```sh
ng test
```

The `ng test` command builds the app in _watch mode_, and launches the Karma test runner.

### Configuration

The CLI takes care of Jasmine and Karma configuration for you.

You can fine-tune many options by editing the `karma.conf.js` and the `test.ts` files in the `src/` folder.

The `karma.conf.js` file is a partial Karma configuration file. The CLI constructs the full runtime configuration in memory, based on application structure specified in the `angular.json` file, supplemented by `karma.conf.js`.

### Other test frameworks

You can also unit test an Angular app with other testing libraries and test runners. Each library and runner has its own distinctive installation procedures, configuration, and syntax.

### Test file name and location

>The test file extension **must be** `.spec.ts` so that tooling can identify it as a file with tests (AKA, a _spec_ file).

The `app.component.ts` and `app.component.spec.ts` files are siblings in the same folder. The root file names (`app.component`) are the same for both files.

Adopt these two conventions in your own projects for every kind of test file.

## Set up continuous integration

One of the best ways to keep your project bug free is through a test suite, but it's easy to forget to run tests all the time. Continuous integration (CI) servers let you set up your project repository so that your tests run on every commit and pull request.

### Configure project for Circle CI

Step 1: Create a folder called `.circleci` at the project root.

Step 2: In the new folder, create a file called `config.yml`

This configuration caches `node_modules/` and uses `npm run` to run CLI commands, because `@angular/cli` is not installed globally. The double dash (--) is needed to pass arguments into the `npm` script.

Step 3: Commit your changes and push them to your repository.

Step 4: Sign up for Circle CI and add your project. Your project should start building.

### Configure project for Travis CI

Step 1: Create a file called `.travis.yml` at the project root.

Step 2: Commit your changes and push them to your repository.

Step 3: Sign up for Travis CI and add your project. You'll need to push a new commit to trigger a build.

### Configure CLI for CI testing in Chrome

When the CLI commands `ng test` and `ng e2e` are generally running the CI tests in your environment, you might still need to adjust your configuration to run the Chrome browser tests.

There are configuration files for both the Karma JavaScript test runner and Protractor end-to-end testing tool, which you must adjust to start Chrome without sandboxing.

We'll be using Headless Chrome in these examples.

In the Karma configuration file, `karma.conf.js`, add a custom launcher called ChromeHeadlessCI below browsers:

```js
browsers: ['Chrome'],
customLaunchers: {
  ChromeHeadlessCI: {
    base: 'ChromeHeadless',
    flags: ['--no-sandbox']
  }
},
```

```sh
ng test -- --no-watch --no-progress --browsers=ChromeHeadlessCI
ng e2e -- --protractor-config=e2e/protractor-ci.conf.js
```

## Enable code coverage reports

The CLI can run unit tests and create code coverage reports. Code coverage reports show you any parts of our code base that may not be properly tested by your unit tests.

```sh
ng test --no-watch --code-coverage
```

When the tests are complete, the command creates a new `/coverage` folder in the project. Open the `index.html` file to see a report with your source code and code coverage values.

## Service Tests

Services are often the easiest files to unit test.

### Services with dependencies

Services often depend on other services that Angular injects into the constructor. In many cases, it's easy to create and _inject_ these dependencies by hand while calling the service's constructor.

app/demo/demo.spec.ts

The first test creates a `ValueService` with new and passes it to the `MasterService` constructor.

However, injecting the real service rarely works well as most dependent services are difficult to create and control.

Instead you can mock the dependency, use a dummy value, or create a spy on the pertinent service method.

> Prefer spies as they are usually the easiest way to mock services.

These standard testing techniques are great for unit testing services in isolation.

### Testing services with the _TestBed_

Your app relies on Angular dependency injection (DI) to create services. When a service has a dependent service, DI finds or creates that dependent service. And if that dependent service has its own dependencies, DI finds-or-creates them as well.

As service _consumer_, you don't worry about any of this. You don't worry about the order of constructor arguments or how they're created.

As a service _tester_, you must at least think about the first level of service dependencies but you _can_ let Angular DI do the service creation and deal with constructor argument order when you use the `TestBed` testing utility to provide and create services.

### Angular _TestBed_

The `TestBed` is the most important of the Angular testing utilities. The `TestBed` creates a dynamically-constructed Angular _test_ module that emulates an Angular `@NgModule`.

The `TestBed.configureTestingModule()` method takes a metadata object that can have most of the properties of an `@NgModule`.

To test a service, you set the `providers` metadata property with an array of the services that you'll test or mock.

