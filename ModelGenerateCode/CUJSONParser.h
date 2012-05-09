//
//  CUJSONParser.h
//  ModelGenerateCodeExample
//
//  Created by curer yg on 12-5-9.
//  Copyright (c) 2012年 zhubu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CUJSONParser : NSObject

@property (nonatomic, retain) NSMutableArray *propertyList;

- (BOOL)parserDictionaryJSON:(NSString *)filePath;

- (NSArray *)getResult;

@end
