The solution involves adding a context to the KVO observation and removing the observer based on that context:

```objectivec
@interface MyObject : NSObject
@property (nonatomic, strong) NSString *myValue;
@end

@implementation MyObject

static void *MyObjectKVOContext = &MyObjectKVOContext;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addObserver:self forKeyPath:@"myValue" options:NSKeyValueObservingOptionNew context:MyObjectKVOContext];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == MyObjectKVOContext && [keyPath isEqual: @"myValue"]) {
        // ... process the change ...
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"myValue" context:MyObjectKVOContext];
}

@end
```
This ensures that only the correct observer is removed, preventing crashes during deallocation.