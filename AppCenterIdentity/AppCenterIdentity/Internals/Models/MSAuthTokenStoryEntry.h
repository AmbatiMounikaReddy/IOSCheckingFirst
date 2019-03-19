// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSAuthTokenStoryEntry : NSObject

@property(nonatomic, nullable, copy, readonly) NSString *authToken;

@property(nonatomic, readonly) double timestamp;

- (instancetype)initWithAuthToken:(nullable NSString *)authToken
                     andTimestamp:(double)timestamp;

- (instancetype)initWithAuthToken:(nullable NSString *)authToken;

- (NSDate *)timestampAsDate;

@end

NS_ASSUME_NONNULL_END