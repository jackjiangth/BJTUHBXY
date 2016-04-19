//
//  MySession.h
//  MyPB
//
//  Created by lanou3g on 16/4/6.
//  Copyright © 2016年 hyc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MySession : NSObject
@property(nonatomic,strong)NSData *data;


-(void)myGetSession:(NSString *)urlString;

-(void)parsePage:(NSString *)pageStr;


@end
