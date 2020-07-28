// #import "PortfolioSimulatorUtil.h"

// @implementation PortfolioSimulatorUtil

// NSString *const SIMULATOR_DEFAULT_PORTFOLIO_NAME = @"My Portfolio (Mobile)";

// - (void)saveProductToNestedPlist:(NSDictionary *)productDict portfolioName:(NSString *)portfolioName{
//     CustomPlist *customPlist = [[CustomPlist alloc]init];
    
//     [customPlist saveNestedPlist:[self class] plistFileName:@"PortfolioSimulator" dictionaryKey:[NSString stringWithFormat:@"%@", portfolioName] dictionaryObject:productDict];
// }

// - (NSString *)getPortfolioName{
//     NSDictionary *dict = [self getPortfolioDict];
//     return [dict.allKeys objectAtIndex:0];
// }

// - (NSDictionary *)loadProductBasedOnPortfolioName:(NSString *)portfolioName{
//     NSDictionary *dict = [self getPortfolioDict];
    
//     return [dict objectForKey:portfolioName];
// }

// - (NSDictionary *)getPortfolioDict{
//     CustomPlist *customPlist = [[CustomPlist alloc]init];
    
//     return (NSDictionary *)[customPlist loadPlist:[self class] plistFileName:@"PortfolioSimulator" dictionaryKey:@"SG"];
// }

// - (void)saveDefaultPortfolioWithPortfolioName:(NSString *)portfolioName{
//     NSMutableDictionary *defaultDict = [NSMutableDictionary new];
//     [defaultDict setObject:[self getDefaultPortfolioDictWithPosition:1 allocation:15] forKey:@"SGFEFIUS"];
//     [defaultDict setObject:[self getDefaultPortfolioDictWithPosition:2 allocation:15] forKey:@"SGFEFIEU"];
//     [defaultDict setObject:[self getDefaultPortfolioDictWithPosition:3 allocation:30] forKey:@"SGFEFIAS"];
//     [defaultDict setObject:[self getDefaultPortfolioDictWithPosition:4 allocation:40] forKey:@"SGFBFI"];
    
//     [self saveProductToNestedPlist:defaultDict portfolioName:portfolioName];
// }

// @end
