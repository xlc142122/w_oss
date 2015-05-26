//package cn.gcks.smartcity.oss.config;
//
///**
// * Created by Pasenger on 15/5/24.
// */
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
//import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
//
//@Configuration
//@EnableWebMvcSecurity
//public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
//    @Override
//    protected void configure(HttpSecurity http) throws Exception {
//        http
//                .authorizeRequests()
//                .antMatchers("/bootstrap/**", "/dist/**", "/plugins/**", "/echarts/**", "/", "/login/login.htm", "/dashboard/index.htm").permitAll()
//                .anyRequest().authenticated()
//                .and().formLogin().loginPage("/").failureUrl("/common/error.jsp").permitAll()
//                .and().logout().permitAll();
//    }
//
//    @Autowired
//    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//        auth
//                .inMemoryAuthentication()
//                .withUser("user").password("user").roles("USER")
//                .and().withUser("admin").password("admin").roles("ADMIN")
//            ;
//    }
//}