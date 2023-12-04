package com.lin.lostandfound.configs.datasource;

import com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceBuilder;
import com.lin.lostandfound.common.constants.Constants;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.*;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;

/**
 * @author lgllink
 * @date 2020/3/18
 */
@PropertySource(value = {"classpath:database.properties"})
@Configuration
public class DynamicDataSourceConfig {

    @Primary
    @Bean(name = "masterDataSource")
    @ConfigurationProperties(prefix = "ds.lostandfound.druid.master")
    //@ConfigurationProperties(prefix = "ds.lostandfound.c3p0.master")
    public DataSource createMasterDataSource() {
        System.out.println("ds.lostandfound.master初始化..." );
        return DruidDataSourceBuilder.create().build();

        //return DataSourceBuilder.create().type(com.mchange.v2.c3p0.ComboPooledDataSource.class).build();
    }

    @Bean(name = "slaveDataSource")
    @ConfigurationProperties(prefix = "ds.lostandfound.druid.slave")
    //@ConfigurationProperties(prefix = "ds.lostandfound.c3p0.slave")
    public DataSource createSlaveDataSource() {
        System.out.println("ds.lostandfound.slave初始化...");
        return DruidDataSourceBuilder.create().build();

        //return DataSourceBuilder.create().type(com.mchange.v2.c3p0.ComboPooledDataSource.class).build();
    }

    @Bean(name = "dynamicDataSource")
    public DynamicDataSource dataSource(
            @Autowired @Qualifier("masterDataSource")DataSource masterDataSource,
            @Autowired @Qualifier("slaveDataSource")DataSource slaveDataSource) {
        Map<Object, Object> targetDataSources = new HashMap<>();
        targetDataSources.put(Constants.LocalDataSource, masterDataSource);
        targetDataSources.put(Constants.RemoteDataSource, slaveDataSource);
        System.out.println("dynamicDataSource初始化..." +masterDataSource.getClass()+ "\n" +slaveDataSource.getClass());
        return  new DynamicDataSource(targetDataSources, masterDataSource);
    }

    @Bean
    public Object testBean(PlatformTransactionManager platformTransactionManager){
        System.out.println("platformTransactionManager >>>>>>>>>>" + platformTransactionManager.getClass().getName());
        return new Object();
    }

    @Bean
    public PlatformTransactionManager transactionManager(
                    SessionFactory sessionFactory) {
        HibernateTransactionManager transactionManager = new HibernateTransactionManager();
        transactionManager.setSessionFactory(sessionFactory);

        return transactionManager;
    }

}
