//
//  main.m
//  CUITest01
//
//  Created by 舛田 明寛 on 0132/04/14.
//  Copyright (c) 2013年 舛田 明寛. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Hoge : NSObject
{
    int val;
}
- (id)initVal:(int)v;
- (id)say;
@end

@implementation Hoge
- (id)initVal:(int)v{
    val = v;
    return self;
}
- (id)say{
    printf("Hoge_v : %d\n", val);
    return NULL;
}
@end

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Hello, World!");
        printf("hohgehogeho\n");
        
        id vv = [[Hoge alloc] initVal:1999];
        [vv say];
        
    }
    return 0;
}

