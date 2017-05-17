#import "MSUtility+Application.h"

/**
 * Utility class that is used throughout the SDK.
 * Application private part.
 */
@interface MSUtility (ApplicationPrivate)

/**
 * Get the shared app state.
 *
 * @return The shared app state.
 */
+ (MSApplicationState)sharedAppState;

@end
