package cn.gcks.smartcity.oss;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;

/**
 * Created by Pasenger on 15/5/23.
 */

@SpringBootApplication
public class Application extends SpringBootServletInitializer {
    public static void main(String[] args) throws Exception {
        new SpringApplicationBuilder(Application.class).run(args);
    }
}
