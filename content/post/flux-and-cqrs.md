+++
date = "2014-11-13"
tags = ["react", "flux", "cqrs"]
title = "Flux and cqrs"
description = "About the simularities between flux and cqrs"
draft = true
+++

About flux and cqrs, what do I want to write about this???

Things I want to find out.
actions in the past: because it's something that has happend. nothing todo about it.

deleting actions is not possible, only update.
Store all actions in an event store for replay?

How about authentication and validation actions and flux.
For example: action 'MESSAGE_SUBMITTED'. But the message must be validated before
it is added. The MessageStore is responsible for validating because it's specific logic
of the store.

(If you don't want to solve it like this you have to wait on the server before moving on.
You can move on as soon as the server says: everything ok.)

There are now 2 possible outcomes:

1. The message gets validated and it's added to the store.
2. The message is invalid and can not be added.

Situation 1 easy: proceed. Situtation 2 is a bit harder. This is how I solve it:
The store has an error object that gets set if there is an error. Now a component
can see that the error is set, and that the object is not submitted.

The only problem I have with this setup is that the name of the actions is not a
real mirror of the business event. For example:

MESSAGE_DELETED. If the MessageStore checks if the user has the necessary authentication
to execute the delete and stops the delete, the name MESSAGE_DELETED is now
incorrect. MESSAGE_TRY_DELETE would be better.

The problem also exists between client and server. The server cannot execute
any of the actions from the client without verification, so every action
can possible fail.

Replay is still possible, but the names are not good enough...

Solution for this:

name the actions not in the past.

what about the api???

Flux and API pattern (see blog about it...)

ActionCreators (API) send the action and also send to the server.
Wouldn't it be nice to just sent the samen actions to the server? Yes but
1. probably not necessary to send all actions to the server.
2. pattern of confirmed, should not be sent to the server again. For example
message submitted fails on the server because of .... authentication. The api
receives a new action: MESSAGE_SUBMITTED_FAILED (good name?). This action
doesn't need to be sent of to the server again.
Should the server internally use the same action names??

## Resources

gist of ....
https://gist.github.com/abdullin/5953ab4f5eae0a7fc8f9#comment-1326317
http://www.code-experience.com/async-requests-with-react-js-and-flux-revisited/
