package com.lin.lostandfound.configs.datasource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

/**
 * @author lgllink
 * @date 2020/3/18
 */
@Configuration
//@AutoConfigureOrder(Ordered.HIGHEST_PRECEDENCE +100)
public class HibernateSessionFactoryConfig {

    @Autowired
    @Qualifier("dynamicDataSource")
    private DynamicDataSource dynamicDataSource;

    @Bean(name = "sessionFactory")
    //@ConditionalOnBean(DynamicDataSource.class)
    public SessionFactory sessionFactory() throws IOException {
        LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
        sessionFactory.setDataSource(this.dynamicDataSource);
        sessionFactory.setPackagesToScan("classpath:com.lin.**.domain");
        sessionFactory.setMappingLocations(resolveMapperLocations());
        sessionFactory.setHibernateProperties(setProperties());
        sessionFactory.afterPropertiesSet();

        System.out.println("sessionFactory初始化完成" +sessionFactory.getObject());
        System.out.println("dynamicDataSource: " +this.dynamicDataSource);

        return sessionFactory.getObject();
    }

    private Resource[] resolveMapperLocations() {
        ResourcePatternResolver resourceResolver = new PathMatchingResourcePatternResolver();
        List<String> mapperLocations = new ArrayList<>();
        mapperLocations.add("classpath*:com/lin/lostandfound/entities/domain/*.hbm.xml");
        System.out.println("mapperLocations: " +mapperLocations);
        List<Resource> resources = new ArrayList();
        if (mapperLocations != null) {
            for (String mapperLocation : mapperLocations) {
                try {
                    Resource[] mappers = resourceResolver.getResources(mapperLocation);
                    System.out.println("mappers: " +mappers +"----" +Arrays.asList(mappers));
                    resources.addAll(Arrays.asList(mappers));
                } catch (IOException e) {
                    // ignore
                    e.printStackTrace();
                }
            }
        }
        return resources.toArray(new Resource[resources.size()]);
    }

    private Properties setProperties() {
        Properties properties = new Properties();
        properties.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
        properties.setProperty("hibernate.show_sql", "true");
        properties.setProperty("hibernate.format_sql", "true");
        properties.setProperty("hibernate.hbm2ddl.auto", "update");
        properties.setProperty("hibernate.current_session_context_class", "org.springframework.orm.hibernate5.SpringSessionContext");

        return properties;
    }

}
