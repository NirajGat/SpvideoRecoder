//
//  VideoRecording+CoreDataProperties.h
//  SPVideoRecoder
//
//  Created by Niraj Gat on 5/16/16.
//  Copyright © 2016 Niraj Gat. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VideoRecording.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoRecording (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *filename;
@property (nullable, nonatomic, retain) NSString *filepath;

@end

NS_ASSUME_NONNULL_END
