package com.lin.lostandfound;

import com.lin.lostandfound.configs.datasource.DynamicDataSourceConfig;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Import;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@EnableTransactionManagement // 开启注解事务管理，等同于xml配置文件中的 <tx:annotation-driven />
@ServletComponentScan
@SpringBootApplication(scanBasePackages = {"com.lin.lostandfound.**"},exclude = {DataSourceAutoConfiguration.class, HibernateJpaAutoConfiguration.class})
@Import(DynamicDataSourceConfig.class)
public class LostandfoundWebApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(LostandfoundWebApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(LostandfoundWebApplication.class, args);
    }

}
