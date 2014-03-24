//
//  Getraenke.h
//  Biergarten
//
//  Created by platzerworld on 24.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Biergarten;

@interface Getraenke : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * apfelschorle;
@property (nonatomic, retain) NSString * biermarke;
@property (nonatomic, retain) NSDecimalNumber * mass;
@property (nonatomic, retain) Biergarten *biergarten;

@end
