// #import "CustomUserDefaults.h"

// @implementation CustomUserDefaults

// - (void)setObject:(id)object forKey:(NSString *)key{
//     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//     [defaults setObject:object forKey:key];
//     [defaults synchronize];
// }

// - (void)setObject:(NSDictionary *)object{
//     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//     for (NSString* key in object) {
//         [defaults setObject:[object objectForKey:key] forKey:key];
//     }
//     [defaults synchronize];
// }

// - (id)getObject:(NSString *)object{
//     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//     return [defaults objectForKey:object];
// }

// - (void)deleteObject:(NSString *)object{
//     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//     [defaults removeObjectForKey:object];
// }

// @end
