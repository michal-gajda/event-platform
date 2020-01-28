import { Module } from '@nestjs/common';
import { MongooseModule } from "@nestjs/mongoose";
import { DatabaseModule } from "./database/database.module";
import { WebHookModule } from "./webhook/webhook.module";
import { APP_GUARD } from '@nestjs/core';
import { JwtGuard, JwtModule } from 'nestjs-jwt2';
import { InfoModule } from './info/info.module';
import { ConfigModule } from './configs/config.module';

const mongoUri = `mongodb://${process.env.DB_USERNAME}:${process.env.DB_PASSWORD}@${process.env.DB_ADDRESS}`;

@Module({
    imports: [
        ConfigModule,
        InfoModule,
        MongooseModule.forRoot(mongoUri, { useMongoClient: true }),
        DatabaseModule,
        WebHookModule,
        JwtModule
    ],
    providers: [{
        provide: APP_GUARD,
        useClass: JwtGuard
    }]
})
export class ApplicationModule {
}