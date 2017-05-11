//
//  NotificationViewController.m
//  NotifiicationContent
//
//  Created by Piyush Sharma on 10/05/17.
//  Copyright © 2017 Piyush Sharma. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification
{
    UNNotificationAttachment *attachment = [notification.request.content.attachments lastObject];
    if ([attachment.URL startAccessingSecurityScopedResource])
    {
        _imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:attachment.URL]];

    }
    
}

@end
