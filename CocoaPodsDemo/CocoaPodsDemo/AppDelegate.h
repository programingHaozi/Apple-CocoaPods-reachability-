//
//  AppDelegate.h
//  CocoaPodsDemo
//
//  Created by chenhao on 14/11/12.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NetworkStatus m_netStatus;
}
@property (strong, nonatomic) UIWindow *window;


@end

