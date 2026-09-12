import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import configuration from './config/configuration.js';
import { DatabaseModule } from './database/database.module.js';
import { HealthModule } from './modules/health/health.module.js';
import { MarketsModule } from './modules/markets/markets.module.js';
import { PricesModule } from './modules/prices/prices.module.js';
import { ProductsModule } from './modules/products/products.module.js';
import { ShoppingListsModule } from './modules/shopping-lists/shopping-lists.module.js';
import { UsersModule } from './modules/users/users.module.js';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      load: [configuration],
    }),
    DatabaseModule,
    HealthModule,
    ProductsModule,
    PricesModule,
    MarketsModule,
    ShoppingListsModule,
    UsersModule,
  ],
})
export class AppModule {}
