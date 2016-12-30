//
// Created by Eugene Butusov on 30/12/2016.
// Copyright (c) 2016 VedideV. All rights reserved.
//

#import "CSVWriter.h"


@implementation CSVWriter {
    NSString *_separator;

    NSMutableArray <NSArray <NSString *> *> *_rows;
}

-(instancetype)initWithSeparator:(NSString *)separator {
    if (self = [super init]) {
        assert(separator != nil);
        _separator = separator;
        _rows = [NSMutableArray new];
    }
    return self;
}

+(instancetype)writerWithSeparator:(NSString *)separator {
    return [[self class] initWithSeparator:separator];
}

-(void)addRow:(NSArray <NSString *> *)row {
    if (row.count != self.header.count) {
        @throw [NSException exceptionWithName:@"InvalidArgument" reason:NSLocalizedString(@"Row length can't be shorter than header length.", nil) userInfo:nil];
    }
    [_rows addObject:row];
}

-(void)removeRowAtIndex:(NSUInteger)index {
    if (index >= _rows.count) {
        @throw [NSException exceptionWithName:@"IndexOutOfRange" reason:NSLocalizedString(@"Can't remove that row.", nil) userInfo:nil];
    }
    [_rows removeObjectAtIndex:index];
}

-(NSArray <NSString *> *)sanitize:(NSArray <NSString *> *)row {
    NSMutableArray <NSString *> *result = [NSMutableArray new];
    for (NSString *item in row) {
        if ([item rangeOfString:_separator].location != NSNotFound) {
            [result addObject:[NSString stringWithFormat:@"\"%@\"", item]];
        } else {
            [result addObject:item];
        }
    }
    return [result copy];
}

-(NSString *)write {
    NSMutableString *result = [NSMutableString new];
    [result appendString:[[self sanitize:self.header] componentsJoinedByString:_separator]];
    [result appendString:@"\n"];

    for (NSArray <NSString *> * row in _rows) {
        [result appendString:[[self sanitize:row] componentsJoinedByString:_separator]];
        [result appendString:@"\n"];
    }

    return [result copy];
}

-(void)writeToFile:(NSString *)file {
    NSError *error;
    [[self write] writeToFile:file atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        @throw error;
    }
}

@end