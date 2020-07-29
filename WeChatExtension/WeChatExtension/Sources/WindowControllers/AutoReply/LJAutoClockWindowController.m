//
//  LJAutoClockWindowController.m
//  WeChatExtension
//
//  Created by 李君 on 2020/7/23.
//  Copyright © 2020 MustangYM. All rights reserved.
//

#import "LJAutoClockWindowController.h"

@interface LJAutoClockWindowController ()
@property (nonatomic, strong) NSTextField *sportdesLabel;
@property (nonatomic, strong) NSTextField *healthLabel;
@property (nonatomic, strong) NSTextField *delayLabel;
@property (nonatomic, strong) NSButton *submitBtn;
@end

@implementation LJAutoClockWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    [self  initSubviews];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
- (void)initSubviews
{
    self.window.title = @"自动打卡设置";
    
    self.delayLabel =({
        NSTextField *txt = [[NSTextField alloc] init];
        txt.placeholderString=@"请输入延迟时间";
        txt.frame = NSMakeRect(25, 200, 150, 30);
        txt;
    });
    
    self.sportdesLabel =({
        NSTextField *txt = [[NSTextField alloc] init];
        txt.placeholderString=@"请输入运动打卡内容";
        txt.frame = NSMakeRect(25, 160, 150, 30);
        txt;
    });
    
    self.healthLabel = ({
        NSTextField *txt = [[NSTextField alloc] init];
        txt.placeholderString = @"请输入健康打卡内容";
        txt.frame = NSMakeRect(25, 100, 150, 30);
        txt;
    });
    
    self.submitBtn = ({
        NSButton *btn = [NSButton tk_buttonWithTitle:@"确定" target:self action:@selector(submit)];
        btn.frame = NSMakeRect(75, 50, 50, 30);
        btn;
    });
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"sportdes"]){
        self.sportdesLabel.stringValue = [[NSUserDefaults standardUserDefaults] valueForKey:@"sportdes"];
    }
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"healthdes"]){
        self.healthLabel.stringValue = [[NSUserDefaults standardUserDefaults] valueForKey:@"healthdes"];
    }
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"delayclock"]){
        self.delayLabel.stringValue = [[NSUserDefaults standardUserDefaults] valueForKey:@"delayclock"];
    }
    
    [self.window.contentView addSubviews:@[self.sportdesLabel,
                                           self.healthLabel,
                                           self.submitBtn,
                                           self.delayLabel
                                        ]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowShouldClose:) name:NSWindowWillCloseNotification object:nil];
}

-(void)submit{
    [[NSUserDefaults standardUserDefaults]setValue:self.sportdesLabel.stringValue forKey:@"sportdes"];
    [[NSUserDefaults standardUserDefaults] setValue:self.healthLabel.stringValue forKey:@"healthdes"];
    [[NSUserDefaults standardUserDefaults] setInteger:self.delayLabel.intValue forKey:@"delayclock"];
    self.sportdesLabel.stringValue = [[NSUserDefaults standardUserDefaults] valueForKey:@"sportdes"];
    self.healthLabel.stringValue = [[NSUserDefaults standardUserDefaults] valueForKey:@"healthdes"];

    self.delayLabel.stringValue = [[NSUserDefaults standardUserDefaults] valueForKey:@"delayclock"];
    
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"sporton"];
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"healthon"];

}

/**
 关闭窗口事件

 */
- (BOOL)windowShouldClose:(id)sender
{
    [[TKWeChatPluginConfig sharedConfig] saveRemoteControlModels];
    return YES;
}
@end
