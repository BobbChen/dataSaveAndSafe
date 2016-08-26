//
//  ViewController.m
//  dataSaveAndSafe
//
//  Created by mac on 16/8/25.
//  Copyright © 2016年 chenbo. All rights reserved.
//

#import "ViewController.h"
#import "CHBUserMsgManager.h"
#import "KeychainItemWrapper.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *before;
@property (weak, nonatomic) IBOutlet UITextField *after;

@end

@implementation ViewController
- (IBAction)encryption:(id)sender {
    CHBUserMsgManager *manager = [CHBUserMsgManager sharedTool];
    self.after.text = [manager encryptionNSString:self.before.text];
    NSLog(@"%@",[manager encryptionNSString:self.before.text]);

}
- (IBAction)clear:(id)sender {
    self.before.text = @"";
    self.after.text = @"";

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
