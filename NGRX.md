# NGRX

Reactive state for Angular.

## STORE

### Getting Started

#### Store

Store is RxJS powered state management for Angular applications, inspired by Redux. Store is a controlled state container designed to help write peformant, consistent applications on top of Angular.

#### Key concepts

- Actions describe unique events that are dispatched from components and services.
- State changes are handled by pure functions called *reducers* that take the current state and the latest action to compute a new state.
- Selectors are pure functions used to select, derive and compose pieces of state.
- State accessed with the *Store*, an observable of state and an observer of actions.

### Architecture

#### Actions

Actions are one of the main building blocks in NgRx. Actions express *unique events* that happen throughout your application. From user interaction with the page, external interaction through nework requests, and direct interaction with device APIs, these and more events are described with actions.

##### Introduction

Actions are used in many areas of NgRx. Actions are the inputs and outputs of many systems in NgRx. Actions help you to understand how events are handled in your application.

##### The Action interface

An `Action` in NgRx is made up of a simple interface:

    interface Action {
      type: string;
    }

The interface has a single property, the `type`, represented as a string. The `type` property is for describing the action that will be dispatched in your application. The value of the type comes in the form of `[Source] Event` and is used to provide a context of what category of action it is, and where an action was disptached from. You add properties to an action to provide additional context or metadata for an action. The most common property is `payload`, which adds any associated data needed for the action. Examples:

    {
      type: '[Auth API]: Login Success'
    }

    {
      type: '[Login Page]: Login',
      payload: {
        username: string;
        password: string;
      }
    }

##### Writing actions

There are a few rules to writing good actions within your application.

- Upfront - write actions before developing features to understand and gain a shared knowledge of the feature being implemented.
- Divide - categorize actions based on the event source.
- Many- actions are inexpensive to write, so the more you write, the better you express flows in your application.
- Event-Driven - capture *events* **not** *commands* as you are separating the description of an event and the handling of that event.
- Description - provide context that are targeted to a unique event with more detailed information you can use to aid in debugging with the developer tools.

Following these guidelines helps you follow how these actions flow throught your application.

    import { Action } from '@ngrx/store';

    export class Login implements Action {
      readonly type = '[Login Page] Login';

      constructor(public payload: { username: string; password: string }) {}
    }

Actions are written as classes to provide type-safe way to construct an action when it's being dispatched. The `login` action implements the `Action` interface to adhere to its structure. The `payload` in this example is an object of a username and password, that is additional metadata needed for the handling of the action.

Instantiate a new instance of the action to use when dispatching.

    store.dispatch(new Login({ username: 'test', password: 'test' }));

The Login action has very specific context about where the action came from and what event happened.

- The category of the action is captured within the square brackets `[]`.
- The category is used to group actions for a particular area, whether it be a component page, backend API, or browser API.
- The `Login` text after the category is a description about what even occured from this actions. In this case, the user clicked a login button from the login page to attempt to authenticate with a username and password.

##### Creating action unions

The consumers of actions, whether it be reducers or effects use the type information from an action to determine whether they need to handle it. Actions are grouped together by feature area, but also need to expose the action type information. Looking at the previous example of the `Login` action, you'll define some additional type information for the actions.

    import { Action } from '@ngrx/store';

    export enum ActionTypes {
      Login = '[Login Page] Login'
    }

    export class Login implements Action {
      readonly type = ActionTypes.Login;

      constructor(public payload: { username: string, password: string }) {}
    }

    export type Union = Login;

Instead of putting the action type string directly in the class, the `[Login Page] Login` string is now provided in the ActionTypes enum Also, an additional `Union` type is exported with the `Login` class. These additional exports allow you to take advantage of discriminated unions in TypeScript.

##### Next Steps

Actions only responsibility are to express unique events and intents.

#### Reducers

Reducers in NgRx are responsible from handling transitions from one state to the next state in your application. Reducer functions handle these transitions by determining which actions to handle based on the type.

##### Introduction

Reducer functions are pure functions in that they produce the same output for a given input. They are without side effects and handle each state transition synchronously. Each reducer function takes the latest `Action` dispatched, the current state, and determines whether to return a newly modified state or the original state.

##### The reducer function

There are a few consistent parts of every piece of state managed by a reducer.

- An interface or type that defines the shape of the state.
- The arguments including the inital state or current state and the current action.
- The switch statement.

Below is an example of a set of actions to handle the state of a scoreboard, and the associated reducer function.

    import { Action } from '@ngrx/store';

    export enum ActionTypes {
      IncrementHome = '[Scoreboard Page] Home Score',
      IncrementAway = '[Scoreboard Page] Away Score',
      Reset = '[Scoreboard Page] Score Reset'
    }

    export class IncrementHome implements Action {
      readonly type = ActionTypes.IncrementHome;
    }

    export class IncrementAway implements Action {
      readonly type = ActionTypes.IncrementAway;
    }

    export class Reset implements Action {
      readonly type = ActionTypes.Reset;

      constructor(public payload: { home: number; away: number }) {}
    }

    export type ActionsUnion = IncrementHome | IncrementAway | Reset;

##### Defining the state shape

Each reducer function is a listener of actions. The scoreboard actions defined above describe the possible transitions handled by the reducer. Import multiple sets of actions to handle additional state transitions within a reducer.

    import * as Scoreboard from './scoreboard.actions';

    export interface State {
      home: number;
      away: number;
    }

You define the shape of the state according to what you are capturing, whether it be a single type such as a number, or a more complex object with multiple properties.

##### Setting the initial state

The initial state gives the state an initial value, or provides a value if the current state is `undefined`. You set the initial state with defaults for your required state properties.

    export const initialState: State = {
      home: 0,
      away: 0
    };

##### Creating the reducer function

The reducer function's responsibility is to handle the state transition in an immutable way.

    export function reducer(
      state = initialState,
      action: Scoreboard.ActionsUnion
    ): State {
      switch (action.type) {
        case Scoreboard.ActionTypes.IncrementHome: {
          return {
            ...state,
            home: state.home + 1
          };
        }
      }
    }

#### Selectors

Selectors are pure functions used for obtaining slices of store state. @ngrx/store provides a few helper functions for optimizing this selection. Selectors provide many features when selecting slices of state.

- Portable
- Memoization
- Composition
- Testable
- Type-safe

When using the `createSelector` and `createFeatureSelector` functions @ngrx/store keeps track of the latest arguments in which your selector function was invoked. Because selectors are pure functions, the last result can be returned when the arguments match without reinvoking your selector function. This can provide performance benefits, particularly with selectors that perform expensive computation. This practice is known as memoization.

##### Using a selector for one piece of state

    import { createSelector } from '@ngrx/store';

    export interface FeatureState {
      counter: number;
    }

    export interface AppState {
      feature: FeatureState;
    }

    export const selectFeature = (state: AppState) => state.feature;

    export const selectFeatureCount = createSelector(
      selectFeature,
      (state: FeatureState) => state.counter
    );

##### Using selectors for multiple pieces of state

The `createSelector` can be used to select some data from the state based on several slices of the same state.

The `createSelector` function can take up to 8 selector function for more complete state selections.

For example, imagine you have a selectedUser object in the state. You also have an allBooks array of book objects.

And you want to show all books for the current user.

You can use createSelector to achieve just that. Your visible books will always be up to date even if you update them in allBooks. They will always show the books that belong to your user if there is one selected and will show all the books when there is no user selected.

The result will be just some of your state filtered by another section of the state. And it will be always up to date.

    import { createSelector } from '@ngrx/store';

    export interface User {
      id: number;
      name: string;
    }

    export interface Book {
      id: number;
      userId: number;
      name: string;
    }

    export interface AppState {
      selectedUser: User;
      allBooks: Book[];
    }

    export const selectUser = (state: AppState) => state.selectedUser;
    export const selectAllBooks = (state: AppState) => state.allBooks;

    export const selectVisibleBooks = createSelector(
      selectUser,
      selectAllBooks,
      (selectedUser: User, allBooks: Book[]) => {
        if (selectedUser && allBooks) {
          return allBooks.filter((book: Book) => book.userId === selectedUser.id);
        } else {
          return allBooks;
        }
      }
    );

##### Using selectors with props

To select a piece of state based on data that isn't available in the store you can pass props to the selector function. These props gets passed through every selector and the projector function. To do so we must specify these props when we use the selector inside our component.

For example if we have a counter and we want to multiply its value, we can add the multiply factor as a prop:

The last argument of a selector or a projector is the props argument, for our example it looks as follows:

    export const getCount = createSelector {
      getCounterValue,
      (counter, props) => counter * props.multiply
    }

Inside the component we can define the props:

    ngOnInit() {
      this.counter = this.store.pipe(select(fromRoot.getCount, { multiply: 2 }));
    }

Keep in mind that a selector only keeps the previous input arguments in its cache. If you re-use this selector with another multiply factor, the selector would always have to re-evaluate its value. This is because it's receiving both of the multiply factors (e.g. one time 2, the other time 4). In order to correctly memoize the selector, wrap the selector inside a factory function to create different instances of the selector.

The following is an example of using multiple counters differentiated by id.

    export const getCount = () =>
      createSelector(
        (state, props) => state.counter[props.id],
        (counter, props) => counter * props.multiply
      );

The component's selectors are now calling the factory function to create different selector instances:

    ngOnInit() {
      this.counter2 = this.store.pipe(select(fromRoot.getCount(), { id: 'counter2', multiply: 2 }));
      this.counter4 = this.store.pipe(select(fromRoot.getCount(), { id: 'counter4', multiply: 4 }));
      this.counter6 = this.store.pipe(select(fromRoot.getCount(), { id: 'counter6', multiply: 6 }));
    }

#### Selecting Feature States

The `createFeatureSelector` is a convenience method for returning a top level feature state. It returns a typed selector function for a feature slice of state.

...

#### Resetting Memoized Selectors

...

#### Advanced Usage

Selectors empower you to compose a read model for your application state. In terms of the CQRS architectural pattern, NgRx separates the read model (selectors) from the write model (reducers). An advanced technique is to combine selectors with RxJS pipeable operators.

This section covers some basics of how selectors compare to pipeable operators and demonstrates how `createSelector` and `scan` are utilized to display a history of state transitions.

##### Breaking Down the Basics

...

#### Advanced / Meta-Reducers

@ngrx/store composes your map of reducers into a single reducer.

Developers can think of meta-reducers as hooks into the action->reducer pipeline. Meta-reducers allow developers to pre-process actions before normal reducers are invoked.

Use the metaReducers configuration option to provide an array of meta-reducers that are composed from right to left.

*Note*: Meta-reducers in NgRx are similar to middleware used in Redux.

#### Recipes

##### Injecting Reducers

To inject the root reducers into your application, use an InjectionToken and a Provider to register the reducers through dependency injection.

...

### Store Devtools overview

### Effects

Effects are an RxJS powered side effect model for Store. Effects use streams to provide new sources of actions to reduce state based on external interactions such as network requests, web socket messages and time-based events.

#### Introduction

In a service-based Angular application, components are responsible for interacting with external resources directly through services. Instead, effects provide a way to interact with those services and isolate them from the components. Effects are where you handle tasks such as fetching data, long-running tasks that produce multiple events, and other external interactions where your components don't need explicit knowledge of these interactions.

#### Key Concepts

- Effects isolate side effects from components, allowing for more _pure_ components that select state and dispatch actions.
- Effects are long-running services that listen to an observable of _every_ action dispatched from the Store.
- Effects filter those actions based on the type of action they are interested in. This is done by using an operator.
- Effects perform tasks, which are synchronous or asynchronous and return a new action.

#### Comparison with component-based side effects

In a service-based application, your components interact with data through many different services that expose data through properties and methods. These services may depend on other services that manage other sets of data. Your components consume these services to perform tasks, giving your components many responsibilities.

Imagine that your application manages movies. Here is a component that fetches and displays a list of movies.

The component has multiple responsibilities:

    Managing the _state_ of the movies.
    Using the service to perform a _side effect_, reaching out to an external API to fetch the movies
    Changing the _state_ of the movies within the component.

Effects when used along with Store, decrease the responsibility of the component. In a larger application, this becomes more important because you have multiple sources of data, with multiple services required to fetch those pieces of data, and services potentially relying on other services.

Effects handle external data and interactions, allowing your services to be less stateful and only perform tasks related to external interactions. Next, refactor the component to put the shared movie data in the Store. Effects handle the fetching of movie data.

The movies are still fetched through the MoviesService, but the component is no longer concerned with how the movies are fetched and loaded. It's only responsible for declaring its _intent_ to load movies and using selectors to access movie list data. Effects are where the asynchronous activity of fetching movies happens. Your component becomes easier to test and less responsible for the data it needs.

#### Writing Effects

