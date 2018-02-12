#import "MSCrashesUtil.h"
#import "MSCrashesUtilPrivate.h"
#import "MSTestFrameworks.h"

@interface MSCrashesUtilTests : XCTestCase

@property(nonatomic) id bundleMock;

@end

@implementation MSCrashesUtilTests

#pragma mark - Housekeeping

- (void)setUp {
  [super setUp];
  self.bundleMock = OCMClassMock([NSBundle class]);
  OCMStub([self.bundleMock mainBundle]).andReturn(self.bundleMock);
  OCMStub([self.bundleMock bundleIdentifier]).andReturn(@"com.test.app");
  [MSCrashesUtil resetDirectory];
}

- (void)tearDown {
  [self.bundleMock stopMocking];
  [MSCrashesUtil resetDirectory];
  [super tearDown];
}

#pragma mark - Tests

- (void)testCreateCrashesDir {
  NSString *crashesDir = [[MSCrashesUtil crashesDir] path];
  NSString *expectedDir;
  XCTAssertNotNil(crashesDir);
#if TARGET_OS_OSX
  expectedDir = @"/Library/Caches/com.test.app/com.microsoft.appcenter/crashes";
#else
  expectedDir = @"/Library/Caches/com.microsoft.appcenter/crashes";
#endif
  XCTAssertTrue([crashesDir rangeOfString:expectedDir].location != NSNotFound);
  BOOL isDir = YES;
  BOOL dirExists = [[NSFileManager defaultManager] fileExistsAtPath:crashesDir isDirectory:&isDir];
  XCTAssertTrue(dirExists);
}

- (void)testCreateLogBufferDir {
  NSString *bufferDir = [[MSCrashesUtil logBufferDir] path];
  NSString *expectedDir;
  XCTAssertNotNil(bufferDir);
#if TARGET_OS_OSX
  expectedDir = @"/Library/Caches/com.test.app/com.microsoft.appcenter/crasheslogbuffer";
#else
  expectedDir = @"/Library/Caches/com.microsoft.appcenter/crasheslogbuffer";
#endif
  XCTAssertTrue([bufferDir rangeOfString:expectedDir].location != NSNotFound);
  BOOL isDir = YES;
  BOOL dirExists = [[NSFileManager defaultManager] fileExistsAtPath:bufferDir isDirectory:&isDir];
  XCTAssertTrue(dirExists);
}

@end
