# Custom Stack with Undo Support Problem

**Question: Custom Stack with Undo Support**

## Description:
Design a generic UndoableStack in Swift that supports:

- push(value: T): Adds a value to the top.
- pop(): Removes and returns the top value (if it exists).
- undo(): Reverts the last push or pop operation.

The stack should maintain a history of operations for undo functionality.

## Requirements:
- Use generics for type flexibility.
- Implement undo using an efficient data structure (e.g., array or linked list).
- Handle edge cases (e.g., empty stack, no operations to undo).
- **Timeframe: 40 minutes**
