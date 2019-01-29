import { NgModule } from "@angular/core";
import { ApiService } from "./api.service";
import { AuthApi } from "./auth.api";
import { HTTP_INTERCEPTORS, HttpClientModule } from "@angular/common/http";
import { AttendeeApi } from "./attendee.api";
import { EventApi } from "./event.api";
import { EventInterceptor } from "./interceptors/event.interceptor";
import { RegistrationApi } from "./registration.api";
import { ForgetApi } from "./forget.api";
import { TeamApi } from "./team.api";

@NgModule({
    imports: [
        HttpClientModule
    ],
    providers: [
        { provide: HTTP_INTERCEPTORS, useClass: EventInterceptor, multi: true },
        AuthApi,
        AttendeeApi,
        EventApi,
        RegistrationApi,
        ForgetApi,
        TeamApi,
        ApiService
    ]
})
export class ApiModule {}
