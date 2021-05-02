//
//  DataService.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#ifndef DataService_h
#define DataService_h
@import Firebase;
#import "User.h"
#import "Meal.h"
#import "Plan.h"
#import <UIKit/UIKit.h>

@interface DataService : NSObject
+ (instancetype)sharedInstance;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRStorage *storage;
@property (strong, nonatomic) FIRStorageReference *storageRef;
- (void)createDBUserWithUid:(NSString *)uid dict:(NSDictionary *)dict completion:(void (^)(BOOL status))completion;
- (void)addBasicInfoWithAge:(NSNumber *)age height:(NSNumber *)height weight:(NSNumber *)weight uid:(NSString *)uid completion:(void (^)(BOOL *status))completion;
- (NSDictionary *)getUserInfo;
+ (void)userWithCompletion:(void (^)(User *user))completion;
- (void)addMeal:(Meal *)meal completion:(void (^)(BOOL *status))completion;
- (void)getAllMealsWithCompletion:(void (^)(NSMutableArray *meals))completion;
- (void)addPlan:(Plan *)plan completion:(void (^)(BOOL *status))completion;
- (void)getAllPlansWithCompletion:(void (^)(NSMutableArray *plans))completion;
- (void)uploadImage:(UIImage *)image completion:(void (^)(BOOL status))completion;
- (void)downloadImageWithURL:(NSString *)url imageView:(UIImageView *)imageView;
- (void)getMealsForTodayWithCompletion:(void (^)(NSMutableArray *meals))completion;
- (void)logPlanProgressWithPlan:(Plan *)plan;
- (void)removePlan:(Plan *)plan;
- (void)updateBasicInfoWithAge:(NSString *)age height:(NSString *)height weight:(NSString *)weight completion:(void (^)(BOOL status))completion;
@end

#endif /* DataService_h */
