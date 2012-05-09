//
//  CUGenerateClass.h
//  ModelGenerateCodeExample
//
//  Created by curer yg on 12-5-8.
//  Copyright (c) 2012年 zhubu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CUGenerateClass : NSObject

- (id)initWithPropertyList:(NSArray *)arr className:(NSString *)className;

- (void)createHeader;
- (void)createImp;

@end
