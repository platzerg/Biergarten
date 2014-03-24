//
//  Adresse.h
//  Biergarten
//
//  Created by platzerworld on 24.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Biergarten;

@interface Adresse : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * strasse;
@property (nonatomic, retain) NSString * plz;
@property (nonatomic, retain) NSString * ort;
@property (nonatomic, retain) Biergarten *biergarten;

@end
