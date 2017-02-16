package com.ironyard;

import com.ironyard.services.Utils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SpringJpaWebApplicationTests {

	@Test
	public void contextLoads() {
		//String fileName = "mypic.jpg";

		String fileName = "mypic.jpg";
		String newFileName = Utils.getFileNameWithoutExtension(fileName);

		System.out.println("newFileName=" + newFileName + "#");
	}

}
