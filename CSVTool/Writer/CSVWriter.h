//
// Created by Eugene Butusov on 30/12/2016.
// Copyright (c) 2016 VedideV. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CSVWriter : NSObject

@property (nonatomic, strong) NSArray <NSString *> *header;

-(instancetype)initWithSeparator:(NSString *)separator;
+(instancetype)writerWithSeparator:(NSString *)separator;

-(void)addRow:(NSArray <NSString *> *)row;
-(void)removeRowAtIndex:(NSUInteger)index;

-(NSString *)write;
-(void)writeToFile:(NSString *)file;

@end