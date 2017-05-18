#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

#import "MSUtility.h"

#if TARGET_OS_IPHONE
#define MS_DEVICE [UIDevice currentDevice]
#endif

/*
 * Workaround for exporting symbols from category object files.
 */
extern NSString *MSUtilityApplicationCategory;

/**
 *  App states
 */
typedef NS_ENUM(NSInteger, MSApplicationState) {

  /**
   * Application is active.
   */
#if TARGET_OS_IPHONE
  MSApplicationStateActive = UIApplicationStateActive,
#else
  MSApplicationStateActive,
#endif

  /**
   * Application is inactive.
   */
#if TARGET_OS_IPHONE
  MSApplicationStateInactive = UIApplicationStateInactive,
#else
  MSApplicationStateInactive,
#endif

  /**
   * Application is in background.
   */
#if TARGET_OS_IPHONE
  MSApplicationStateBackground = UIApplicationStateBackground,
#else
  MSApplicationStateBackground,
#endif

  /**
   * Application state can't be determined.
   */
  MSApplicationStateUnknown
};

typedef NS_ENUM(NSInteger, MSOpenURLState) {

  /**
   * Not being able to determine whether a URL has been processed or not.
   */
  MSOpenURLStateUnknown,

  /**
   * A URL has been processed successfully.
   */
  MSOpenURLStateSucceed,

  /**
   * A URL could not be processed.
   */
  MSOpenURLStateFailed
};

/**
 * Utility class that is used throughout the SDK.
 * Application part.
 */
@interface MSUtility (Application)

/**
 * Get current application state.
 *
 * @return Current state of the application or MSApplicationStateUnknown while the state can't be determined.
 *
 * @discussion The application state may not be available anywhere. Application extensions doesn't have it for instance,
 * in that case the MSApplicationStateUnknown value is returned.
 */
+ (MSApplicationState)applicationState;

/**
 * Attempt to open the URL asynchronously.
 *
 * @param url The URL to open.
 * @param options A dictionary of options to use when opening the URL.
 * @param completion The block to execute with the results.
 */
+ (void)sharedAppOpenUrl:(NSURL *)url
                 options:(NSDictionary<NSString *, id> *)options
       completionHandler:(void (^)(MSOpenURLState state))completion;
@end
