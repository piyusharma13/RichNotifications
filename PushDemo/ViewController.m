//
//  ViewController.m
//  PushDemo
//
//  Created by Piyush Sharma on 09/05/17.
//  Copyright © 2017 Piyush Sharma. All rights reserved.
//

#import "ViewController.h"

#import <UserNotifications/UserNotifications.h>

#define ActionID_Play   @"IDPlay"
#define ActionID_Delete   @"IDDelete"

#define CategoryID         @"myNotificationCategory"

@interface ViewController ()<UNUserNotificationCenterDelegate>

@end

@implementation ViewController

//MARK: View Lifecycle Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"minion" ofType:@"gif"]];
    NSLog(@"%@", url);
    [self funcInitialise];
  
}

-(void)funcInitialise
{
    UNUserNotificationCenter.currentNotificationCenter.delegate = self;
    [self funcGetAuthorized];
}

-(void)funcGetAuthorized
{
    [UNUserNotificationCenter.currentNotificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted)
        {
            [self funcScheduleAlert];
        }
    }];
}

-(void)funcScheduleAlert
{
    // Set Actions
    UNNotificationAction *playAction = [UNNotificationAction actionWithIdentifier:ActionID_Play title:@"Play" options:UNNotificationActionOptionForeground];
    
    UNNotificationAction *deleteAction = [UNNotificationAction actionWithIdentifier:ActionID_Delete title:@"Delete" options:UNNotificationActionOptionForeground];

    //Set NotificationCategory
    UNNotificationCategory *notificationCategory = [UNNotificationCategory categoryWithIdentifier:CategoryID actions:@[playAction, deleteAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    
    [UNUserNotificationCenter.currentNotificationCenter setNotificationCategories:[[NSSet alloc] initWithObjects:notificationCategory, nil]];
    
    NSError *error;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"minion" ofType:@"gif"]];

    
    UNNotificationAttachment * attachement = [UNNotificationAttachment attachmentWithIdentifier:@"attachementID" URL:url options:nil error:&error];
    
    
    
    
    //Set NotificationContent
    UNMutableNotificationContent *mutableNotificationContent = [[UNMutableNotificationContent alloc] init];
    mutableNotificationContent.title = @"Hello World!";
    mutableNotificationContent.subtitle = @"your audio is ready.";
    
    mutableNotificationContent.body = @"The UserNotifications framework (UserNotifications.framework) supports the delivery and handling of local and remote notifications.";
    
    
    if (error == nil) {
        mutableNotificationContent.attachments = @[attachement];
        
    }
    else{
        NSLog(@"Attachement Error = %@",error);
    }
    
    
    
    
    
    mutableNotificationContent.categoryIdentifier = CategoryID;
    
    //Set Trigger
    UNTimeIntervalNotificationTrigger *notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10.0 repeats:NO];
    
    // Create Notification Request

    UNNotificationRequest *notificationRequest = [UNNotificationRequest  requestWithIdentifier:CategoryID content:mutableNotificationContent trigger:notificationTrigger];
    
    [UNUserNotificationCenter.currentNotificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
}


// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(nonnull UNNotificationResponse *)response withCompletionHandler:(nonnull void (^)())completionHandler
{
    
}

@end
