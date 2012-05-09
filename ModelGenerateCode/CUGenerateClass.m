//
//  CUGenerateClass.m
//  ModelGenerateCodeExample
//
//  Created by curer yg on 12-5-8.
//  Copyright (c) 2012年 zhubu. All rights reserved.
//

#import "CUGenerateClass.h"

@interface CUGenerateClass ()

@property (nonatomic, retain) NSArray *properList;
@property (nonatomic, retain) NSString *className;

- (NSString *)generateBeginClassHeader:(NSString *)className;
- (NSString *)generateEndClassHeader;

- (NSString *)generateProperty:(NSString *)text;
- (NSString *)generateSynthesize:(NSString *)text;

- (NSString *)pushLine;

@end

@implementation CUGenerateClass

@synthesize properList;
@synthesize className;

- (id)initWithPropertyList:(NSArray *)arr className:(NSString *)aClassName
{
    if (self = [super init]) {
        self.properList = arr;
        self.className = aClassName;
    }
    
    return self;
}

- (void)dealloc
{
    self.properList = nil;
    self.className = nil;
    
    [super dealloc];
}

- (void)createHeader
{
    NSString *fileName = [NSString stringWithFormat:@"%@.h", self.className];
    NSString *outPath = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    
    NSMutableString *printStr = [NSMutableString string];
    
    [printStr appendString:@"#import <Foundation/Foundation.h>\n\n"];
    [printStr appendString:[self generateBeginClassHeader:self.className]];
    
    for (NSString *item in properList) {
        [printStr appendString:[self generateProperty:item]];
    }
    
    [printStr appendString:[self pushLine]];
    
    [printStr appendString:[self generateMethodHeader:self.className]];
    
    [printStr appendString:[self generateEndClassHeader]];
    
    [printStr writeToFile:outPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)createImp
{
    NSString *fileName = [NSString stringWithFormat:@"%@.m", self.className];
    NSString *outPath = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    
    NSMutableString *printStr = [NSMutableString string];
    
    NSString *importStr = [NSString stringWithFormat:@"#import \"%@.h\"\n\n", self.className];
    [printStr appendString:importStr];
    
    [printStr appendString:[self generateBeginClassImplementHeader:self.className]];
    
    for (NSString *item in properList) {
        [printStr appendString:[self generateSynthesize:item]];
    }
    
    [printStr appendString:[self pushLine]];
    [printStr appendString:[self generateDealloc:properList]];
    
    [printStr appendString:[self pushLine]];
    [printStr appendString:[self generateMethod:self.className]];
    
    [printStr appendString:[self generateEndClassHeader]];
    
    [printStr writeToFile:outPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

#pragma mark - private

- (NSString *)generateBeginClassHeader:(NSString *)aClassName
{
    return [NSString stringWithFormat:@"@interface %@ : NSObject\n\n", aClassName];
}

- (NSString *)generateEndClassHeader
{
    return @"\n@end";
}

- (NSString *)generateProperty:(NSString *)text
{
    return [NSString stringWithFormat:@"@property (nonatomic, retain) NSString *%@;\n", text];
}

- (NSString *)generateSynthesize:(NSString *)text
{
    return [NSString stringWithFormat:@"@synthesize %@;\n", text];
}

- (NSString *)pushLine
{
    return [NSString stringWithFormat:@"\n\n"];
}

- (NSString *)generateMethodHeader:(NSString *)aClassName
{
    NSMutableString *result = [NSMutableString string];
    [result appendString:[NSString stringWithFormat:@"+ (%@ *)%@WithDictionary:(NSDictionary *)dic;\n",
                          aClassName, aClassName]];
    return result;
}

- (NSString *)generateMethod:(NSString *)aClassName
{
    NSMutableString *result = [NSMutableString string];
    
    [result appendString:[NSString stringWithFormat:@"+ (%@ *)%@WithDictionary:(NSDictionary *)dic\n",
                          aClassName, aClassName]];
    
    [result appendString:@"{\n"];
    
    NSString *allocStr = [NSString stringWithFormat:@"    %@ *res = [[[%@ alloc] init] autorelease];\n\n",
                          aClassName, aClassName];
    [result appendString:allocStr];
    
    for (NSString *item in self.properList) {
        NSString *line = [NSString stringWithFormat:@"    res.%@ = [dic objectForKey:@\"%@\"];\n",
                          item, item];
        [result appendString:line];
    }
    
    [result appendString:@"\n    return res;\n"];
    
    [result appendString:@"}\n"];
    
    return result;
}

#pragma mark 

- (NSString *)generateBeginClassImplementHeader:(NSString *)aClassName
{
    return [NSString stringWithFormat:@"@implementation %@\n\n", aClassName];
}

- (NSString *)generateDealloc:(NSArray *)paramArr
{
    NSMutableString *res = [NSMutableString string];
    
    [res appendString:@"- (void)dealloc\n"];
    [res appendString:@"{\n"];
    
    for (NSString *item in paramArr) {
        
        NSString *line = [NSString stringWithFormat:@"    self.%@ = nil;\n",item];
        
        [res appendString:line];
    }
    
    [res appendString:@"\n    [super dealloc];\n"];
    
    [res appendString:@"}\n"];
    
    return res;
}

@end
