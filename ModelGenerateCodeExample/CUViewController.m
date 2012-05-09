//
//  CUViewController.m
//  ModelGenerateCodeExample
//
//  Created by curer yg on 12-5-8.
//  Copyright (c) 2012年 zhubu. All rights reserved.
//

#import "CUViewController.h"
#import "CUGenerateClass.h"
#import "CUJSONParser.h"

@interface CUViewController ()

@end

@implementation CUViewController

@synthesize classNameField;
@synthesize textView;

- (void)dealloc
{
    self.classNameField = nil;
    self.textView = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)create:(id)sender
{
    NSString *text = self.textView.text;
    
    NSArray *properList = [text componentsSeparatedByString:@","];
    
    if ([properList count] == 0 || [self.classNameField.text length] == 0) {
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" 
                                                       message:@"properList eror" 
                                                      delegate:nil 
                                             cancelButtonTitle:@"ok" 
                                             otherButtonTitles:nil];
        
        [view show];
        
        [view release];
        
        return;
    }
    
    CUGenerateClass *generateClass = [[[CUGenerateClass alloc] 
                                       initWithPropertyList:properList className:self.classNameField.text] autorelease];
    
    [generateClass createHeader];
    [generateClass createImp];
}

- (IBAction)readDataFromFile:(id)sender
{
    NSString *fileName = self.classNameField.text;
    NSString *inPath = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    
    CUJSONParser *jsonParser = [[[CUJSONParser alloc] init] autorelease];
    
    if ([jsonParser parserDictionaryJSON:inPath]) {
        NSArray *properList = [jsonParser getResult];
        if ([properList count] == 0 || [fileName length] == 0) {
            
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" 
                                                           message:@"properList eror" 
                                                          delegate:nil 
                                                 cancelButtonTitle:@"ok" 
                                                 otherButtonTitles:nil];
            
            [view show];
            
            [view release];
            
            return;
        }
        
        CUGenerateClass *generateClass = [[[CUGenerateClass alloc] 
                                                    initWithPropertyList:properList 
                                                                className:fileName] 
                                                autorelease];
        
        [generateClass createHeader];
        [generateClass createImp];
    }
}

@end
