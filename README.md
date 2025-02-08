# Objective-C KVO Crash in dealloc

This repository demonstrates a potential crash in Objective-C when using Key-Value Observing (KVO) and removing observers in `dealloc`. The issue arises when the observer is still processing a notification at the time `dealloc` is called, leading to access of freed memory.

## Problem

The provided `bug.m` file contains an example of a `MyObject` class that observes its own `myValue` property.  If `dealloc` is called while a KVO notification is being delivered, the observer might attempt to access memory that has already been deallocated, resulting in a crash.

## Solution

The `bugSolution.m` file offers a solution by using `- (void) removeObserver:forKeyPath:context:` and providing a unique context, allowing for precise observer removal and preventing the crash.  This approach ensures the observer is properly removed before memory is deallocated, resolving the timing issue.