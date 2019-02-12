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
