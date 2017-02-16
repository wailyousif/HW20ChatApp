package com.ironyard.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class FileServerConfigurator extends WebMvcConfigurerAdapter
{

    @Value("${upload.location}")
    private String uploadLocation;


    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/ourCoolUploadedFiles/**")
                .addResourceLocations("file:"+uploadLocation);
    }
}