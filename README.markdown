# Real Life Core Data

A robust, battle-tested Core Data example project.


## High Level Architecture

Each project is typically designed around a singleton RLCoreDataEnvironment object which holds all the required objects and implements the key "under the hood" functionality.

The model is reperesented by entity obejcts and entity managers.

The RLBaseEntityManager incorporates most of the funtionality that you acutally need for doing work against your model.

## RLCoreDataEnvironment

The RLCoreDataEnvironment object is architected with one persistant store coordinator, one managed object model and multiple managed object contexts.

There are two built-in contexts, the main thread context and the background context.

You can also create as many user-defined contexts as you need.  There is a cost.  Each context increases the time it takes to save as every context needs to be updated when any other context is saved.  User-defined contexts are intented to be created then eventually disposed of.

## Entities and Entity Managers

The decision to split functionality related to entities into two different objects was the product of experience.  

Entity objects, (such as CDBook) should have methods that act upon a single entity.

Entity Manager objects (ie. CDBookManager) are designed to encapsulate functionality that acts across the entire set of a given entity (all books).

## UI

The sample project does not yet show off the UI integration, but look for updates soon.


## Misc

Please let me know if you have any questions.  Documentation is in progress but I'd love to hear what makes the most or least sense.

<https://github.com/amattn>

<http://twitter.com/amattn>
