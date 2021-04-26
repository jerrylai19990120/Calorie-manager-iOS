//
//  DataService.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "User.h"
@import Firebase;
@import SDWebImage;

@interface DataService()

@end


@implementation DataService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ref = nil;
        self.ref = [[FIRDatabase database]reference];
        self.storage = nil;
        self.storageRef = nil;
        self.storage = [FIRStorage storage];
        self.storageRef = [self.storage reference];
    }
    return self;
}

+ (instancetype)sharedInstance{
    
    static DataService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataService alloc]init];
    });
    
    return sharedInstance;
}

- (void)createDBUserWithUid:(NSString *)uid dict:(NSDictionary *)dict completion:(void (^)(BOOL))completion{
    [[[self.ref child:@"users"]child:uid]updateChildValues:dict withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if(error==nil){
            completion(true);
        }else{
            completion(false);
        }
    }];
}

- (void)addBasicInfoWithAge:(NSNumber *)age height:(NSNumber *)height weight:(NSNumber *)weight uid:(NSString *)uid completion:(void (^)(BOOL *))completion{
    if(age==nil || height==nil || weight==nil){
        completion(false);
    }else{
        [[[[self.ref child:@"users"]child:uid]child:@"age"]setValue:age];
        [[[[self.ref child:@"users"]child:uid]child:@"height"]setValue:height];
        [[[[self.ref child:@"users"]child:uid]child:@"weight"]setValue:weight];
        completion(true);
    }
}

- (NSDictionary *)getUserInfo{
    
    __block NSDictionary *dict = nil;
    
    [[[self.ref child:@"users"]child:[[[FIRAuth auth]currentUser]uid]]getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nonnull snapshot) {
        if(error==nil){
            
            
        }
    }];
    NSLog(@"%@", dict);
    return dict;
}

+ (void)userWithCompletion:(void (^)(User *))completion{
    
    [[[DataService.sharedInstance.ref child:@"users"]child:[[[FIRAuth auth]currentUser]uid]]getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nonnull snapshot) {
        if(error==nil){
            
            User *user = [[User alloc]initWithUid:[FIRAuth auth].currentUser.uid username:snapshot.value[@"username"] email:snapshot.value[@"email"] age:(NSNumber *)snapshot.value[@"age"] height:(NSNumber *)snapshot.value[@"height"] weight:(NSNumber *)snapshot.value[@"weight"] imgUrl:snapshot.value[@"img_url"]];
            completion(user);
        }else{
            completion(nil);
        }
    }];
}

- (void)addMeal:(Meal *)meal completion:(void (^)(BOOL *))completion{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    NSString *today = [formatter stringFromDate:[NSDate date]];
    
    NSString *key = [DataService.sharedInstance.ref childByAutoId].key;
    
    NSString *finalKey = [NSString stringWithFormat:@"%@:%@",today, key];
    
    NSDictionary *values = @{
        @"mealName": meal.mealName,
        @"mealType": meal.mealType,
        @"calories": meal.calories,
        @"date": today
    };
    
    NSDictionary *updatedValue = @{
        finalKey: values
    };
    
    
    [[[[DataService.sharedInstance.ref child:@"users"]child:[FIRAuth auth].currentUser.uid]child:@"meals"]updateChildValues:updatedValue withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if(error==nil){
            
            completion(true);
        }else{
            completion(false);
        }
    }];
}


- (void)getAllMealsWithCompletion:(void (^)(NSMutableArray *))completion{
    
    NSMutableArray *meals = [[NSMutableArray alloc]init];
    
    [[[[DataService.sharedInstance.ref child:@"users"]child:[FIRAuth auth].currentUser.uid]child:@"meals"]getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nonnull snapshot) {
        if(error==nil){
            for (FIRDataSnapshot *meal in snapshot.children.allObjects) {
                Meal *item = [[Meal alloc]initWithName:meal.value[@"mealName"] type:meal.value[@"mealType"] calories:(NSNumber *)meal.value[@"calories"] date:snapshot.value[@"date"]];
                [meals addObject:item];
            }
            completion(meals);
        }else{
            completion(meals);
        }
    }];
}


- (void)addPlan:(Plan *)plan completion:(void (^)(BOOL *))completion{
    
    NSDictionary *values = @{
        @"title": plan.title,
        @"progress": plan.progress,
        @"length": plan.goalDays,
        @"uid": plan.uid
    };
    
    NSDictionary *updated = @{
        plan.uid: values
    };
    
    [[[[DataService.sharedInstance.ref child:@"users"]child:[FIRAuth auth].currentUser.uid]child:@"plans"]updateChildValues:updated withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if(error==nil){
            completion(true);
        }else{
            completion(false);
        }
    }];
}

- (void)getAllPlansWithCompletion:(void (^)(NSMutableArray *))completion{
    NSMutableArray *plans = [[NSMutableArray alloc]init];
    
    [[[[DataService.sharedInstance.ref child:@"users"]child:[FIRAuth auth].currentUser.uid]child:@"plans"]getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nonnull snapshot) {
        if(error==nil){
            for(FIRDataSnapshot *plan in snapshot.children.allObjects){
                Plan *item = [[Plan alloc]initWithTitle:plan.value[@"title"] progress:(NSNumber *)plan.value[@"progress"] goalDays:(NSNumber *)plan.value[@"length"] uid:plan.value[@"uid"]];
                
                [plans addObject:item];
            }
            
            completion(plans);
        }else{
            completion(plans);
        }
    }];
}


- (void)uploadImage:(UIImage *)image completion:(void (^)(BOOL))completion{
    FIRStorageReference *imageRef = [self.storageRef child:[NSString stringWithFormat:@"avatarImages/%@",[FIRAuth auth].currentUser.uid]];
    
    NSData *data = UIImagePNGRepresentation(image);
    [imageRef putData:data metadata:nil completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
        if(error!=nil){
            NSLog(@"%@",error.localizedDescription);
            completion(false);
        }else{
            [imageRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                if(error!=nil){
                    completion(false);
                }else{
                    NSURL *url = URL;
                    NSDictionary *updatedValue = @{
                        @"img_url": url.absoluteString
                    };
                    [[[self.ref child:@"users"]child:[FIRAuth auth].currentUser.uid]updateChildValues:updatedValue];
                    completion(true);
                }
            }];
        }
    }];
    
    
}

- (void)downloadImageWithURL:(NSString *)url imageView:(UIImageView *)imageView{
    NSURL *URL = [NSURL URLWithString:url];
    [imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"anon"]];
}

- (void)getMealsForTodayWithCompletion:(void (^)(NSMutableArray *))completion{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    
    NSMutableArray *meals = [[NSMutableArray alloc]init];
    
    [[[[self.ref child:@"users"]child:[FIRAuth auth].currentUser.uid]child:@"meals"]getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nonnull snapshot) {
        
        if(error!=nil){
            NSLog(@"%@", error.localizedDescription);
            completion(meals);
        }else{
            for(FIRDataSnapshot *meal in snapshot.children.allObjects){
                NSString *dateString = [meal.key componentsSeparatedByString:@":"][0];
                NSDate *date = [formatter dateFromString:dateString];
                if([[NSCalendar currentCalendar]isDateInToday:date]){
                    Meal *item = [[Meal alloc]initWithName:meal.value[@"mealName"] type:meal.value[@"mealType"] calories:(NSNumber *)meal.value[@"calories"] date:meal.value[@"date"]];
                    
                    [meals addObject:item];
                }
                
            }
            
            completion(meals);
        }
    }];
    
}


- (void)logPlanProgressWithPlan:(Plan *)plan{
    
    NSNumber *val = [NSNumber numberWithInt:plan.progress.intValue+1];
    
    NSDictionary *updated = @{
        @"uid": plan.uid,
        @"progress": val
    };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlanLogged" object:nil userInfo:updated];
    
    [[[[[self.ref child:@"users"]child:[FIRAuth auth].currentUser.uid]child:@"plans"]child:plan.uid]updateChildValues:updated];
}

- (void)removePlan:(Plan *)plan{
    
    NSDictionary *dict = @{
        @"uid": plan.uid
    };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlanRemoved" object:nil userInfo:dict];
    
    [[[[[self.ref child:@"users"]child:[FIRAuth auth].currentUser.uid]child:@"plans"]child:plan.uid]removeValue];
}
@end
