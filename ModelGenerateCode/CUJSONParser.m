//
//  CUJSONParser.m
//  ModelGenerateCodeExample
//
//  Created by curer yg on 12-5-9.
//  Copyright (c) 2012年 zhubu. All rights reserved.
//

#import "CUJSONParser.h"
#import "JSON.h"

@implementation CUJSONParser

@synthesize propertyList;

- (id)init
{
    if (self = [super init]) {
        self.propertyList = [NSMutableArray array];
    }
    
    return self;
}

- (void)dealloc
{
    self.propertyList = nil;
    
    [super dealloc];
}


- (NSArray *)getResult
{
    return [[self.propertyList copy] autorelease];
}

- (BOOL)parserDictionaryJSON:(NSString *)filePath
{
    NSString *str = [[NSString alloc] initWithContentsOfFile:filePath 
                                                    encoding:NSUTF8StringEncoding 
                                                       error:nil];
    
    NSDictionary *dic = [str JSONValue];
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    [self.propertyList removeAllObjects];
    
    [self parseDictionary:dic];
    
    [str release];
    
    return YES;
}

- (void)parseDictionary:(NSDictionary *)dic
{
    for (NSString *item in dic) {
        [self.propertyList addObject:item];
    }
}

@end
