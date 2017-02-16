package com.ironyard;

import com.ironyard.repo.UserPermissionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SpringJpaWebApplication {

	@Autowired
	private static UserPermissionRepo userPermissionRepo;

	public static void main(String[] args)
	{
		SpringApplication.run(SpringJpaWebApplication.class, args);

		//initialize permissions if not in DB
		initPermissions();
	}

	private static void initPermissions()
	{
		/*
		Iterable<UserPermission> userPermissionList = userPermissionRepo.findAll();
		UserPermission.Permission.
		*/
	}
}
