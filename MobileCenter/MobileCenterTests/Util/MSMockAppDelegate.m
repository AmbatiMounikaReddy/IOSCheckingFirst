#import <Foundation/Foundation.h>

#import "MSAppDelegateForwarder.h"
#import "MSMockAppDelegate.h"

@implementation MSMockAppDelegate

- (instancetype)init {
  if ((self = [super init])) {
    _originalDelegateValidators = [NSMutableDictionary new];
    _customDelegateValidators = [NSMutableDictionary new];
  }
  return self;
}

#pragma mark - UIApplication

- (BOOL)application:(UIApplication *)app
              openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation {
  OriginalOpenURLiOS42Validator validator = self.originalDelegateValidators[NSStringFromSelector(_cmd)];
  return validator(app, url, sourceApplication, annotation);
}

#pragma mark - MSAppDelegate

- (BOOL)application:(UIApplication *)app
              openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation
        returnedValue:(BOOL)returnedValue {
  CustomOpenURLiOS42Validator validator = self.customDelegateValidators[NSStringFromSelector(_cmd)];
  return validator(app, url, sourceApplication, annotation, returnedValue);
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
      returnedValue:(BOOL)returnedValue {
  CustomOpenURLiOS9Validator validator = self.customDelegateValidators[NSStringFromSelector(_cmd)];
  return validator(app, url, options, returnedValue);
}

@end

#pragma mark - Swizzling

@implementation MSAppDelegateForwarder (MSDistribute)

+ (void)load{
  
  // Register selectors to swizzle for Ditribute.
  [self addAppDelegateSelectorToSwizzle:@selector(application:openURL:options:)];
  [self addAppDelegateSelectorToSwizzle:@selector(application:openURL:sourceApplication:annotation:)];
}

@end
