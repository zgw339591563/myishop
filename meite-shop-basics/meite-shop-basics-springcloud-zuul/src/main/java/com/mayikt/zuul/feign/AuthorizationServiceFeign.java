package com.mayikt.zuul.feign;


import com.mayikt.auth.service.api.AuthorizationService;
import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(value="app-mayikt-auth")
public interface AuthorizationServiceFeign extends AuthorizationService {

}
