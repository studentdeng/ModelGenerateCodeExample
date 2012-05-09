//
//  CUViewController.h
//  ModelGenerateCodeExample
//
//  Created by curer yg on 12-5-8.
//  Copyright (c) 2012年 zhubu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CUViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *classNameField;
@property (nonatomic, retain) IBOutlet UITextView *textView;

- (IBAction)create:(id)sender;
- (IBAction)readDataFromFile:(id)sender;

@end
