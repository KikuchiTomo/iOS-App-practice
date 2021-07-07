#import <Foundation/Foundation.h>
#import "objcpp.h"
#import "TestCppClass.hpp"

@implementation TestObjCppClass {
    TestCppClass *cpp;
}

- (id)init{
    self = [super init];
    cpp = new TestCppClass();
    return self;
}

- (void)dealloc{
    delete cpp;
    [super dealloc];
}

- (void)add:(int)num{
    cpp->add(num);
}

- (void)sub:(int)num{
    cpp->sub(num);
}

- (void)print{
    cpp->print();
}

@end
