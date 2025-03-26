# Expanding Circle View Problem

## Question
**Custom UIView with Animation and Gesture Handling**

## Description
Create a custom `UIView` subclass called `ExpandingCircleView` that:
- Displays a circle with a configurable radius and color.
- Animates its expansion to double its size when tapped, then returns to its original size after 1 second.
- Supports dragging the circle around the screen using a pan gesture.
- Ensures smooth animations and gesture interactions without conflicts.

The implementation should deliver a polished, interactive UI component.

## Requirements
- Use `CALayer` or `CAShapeLayer` for rendering the circle.
- Implement `UIView` animation or `CAAnimation` for the expand/shrink behavior.
- Handle gesture states properly (e.g., `began`, `changed`, `ended`).
- **Timeframe**: 50 minutes  
  *(This balances time for UI setup, animation logic, and gesture handling.)*

## Solution
The solution is implemented in [`ExpandingCircleView.swift`](./ExpandingCircleView.swift). It features:
- `CAShapeLayer` for efficient circle rendering with customizable properties.
- `UIView.animate` for a smooth expand/shrink animation sequence.
- `UIPanGestureRecognizer` for drag functionality, integrated seamlessly with tap animations.
- Proper gesture state management to avoid conflicts.

## Usage
Example usage in Swift:
```swift
let circleView = ExpandingCircleView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
circleView.radius = 25
circleView.circleColor = .blue
view.addSubview(circleView)
