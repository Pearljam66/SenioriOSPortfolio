# Thread-Safe Linked List Problem

## Question
**Custom Linked List with Thread Safety**

## Description
Design and implement a thread-safe singly linked list in Swift that supports the following operations:
- **`append(value: T)`**: Adds a value to the end of the list.
- **`removeFirst()`**: Removes and returns the first value (if it exists), or `nil` if the list is empty.
- **`contains(value: T)`**: Checks if a value exists in the list.

The implementation must be efficient and safe for concurrent access from multiple threads.

## Requirements
- Use **generics** to make the list reusable for any type.
- Handle concurrency using an appropriate mechanism (e.g., `NSLock`, `DispatchQueue`, or `actor`).
- Include basic **error handling** (e.g., empty list cases).
- **Timeframe**: 45 minutes  
  *(This allows time to design the structure, implement concurrency, and test edge cases.)*

## Solution
The solution is implemented in [`ThreadSafeLinkedList.swift`](./ThreadSafeLinkedList.swift). It uses:
- A generic `Node` class for the linked list structure.
- Swift’s `actor` for thread safety (modern concurrency approach).
- Optional returns and checks for edge cases like empty lists.

## Usage
Example usage in Swift:
```swift
let list = ThreadSafeLinkedList<Int>()
await list.append(1)
await list.append(2)
let first = await list.removeFirst() // Returns 1
let hasTwo = await list.contains(2)  // Returns true
