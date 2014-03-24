//
//  PWDataManager.h
//  Biergarten
//
//  Created by platzerworld on 21.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


+ (id)sharedManager;

- (id) insertManagedObjectOfClass: (Class) aClass;

- (BOOL) saveManagedObjectContext;

- (NSArray*) fetchEntitiesForClass: (Class) aClass withPredicate: (NSPredicate*) predicate;

@end
