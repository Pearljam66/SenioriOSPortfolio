# Concurrent Task Scheduler Problem

**Question: Concurrent Task Scheduler**

## Description:
Design a TaskScheduler in Swift that:

- Executes a list of async tasks with a configurable concurrency limit (e.g., max 3 at a time).  
- Returns results in the order tasks were submitted.  
- Cancels all tasks if one fails (optional completion handler).

## Requirements:  
- Use Swift concurrency (async/await, Task).  
- Ensure thread safety and order preservation.  
- Handle cancellation and errors gracefully.  
- **Timeframe: 70 minutes**

