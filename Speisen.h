//
//  Speisen.h
//  Biergarten
//
//  Created by platzerworld on 24.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Biergarten;

@interface Speisen : NSManagedObject

@property (nonatomic, retain) NSString * lieblingsgericht;
@property (nonatomic, retain) NSDecimalNumber * obazda;
@property (nonatomic, retain) NSDecimalNumber * riesenbreze;
@property (nonatomic, retain) NSString * kommentar;
@property (nonatomic, retain) Biergarten *biergarten;

@end
