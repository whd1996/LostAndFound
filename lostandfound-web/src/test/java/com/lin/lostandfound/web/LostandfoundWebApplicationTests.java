package com.lin.lostandfound.web;

import com.lin.lostandfound.entities.domain.ExpressThanks;
import com.lin.lostandfound.services.IExpressThanksService;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Bean;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.Map;

@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest
public class LostandfoundWebApplicationTests {

    @Autowired
    private IExpressThanksService expressThanksService;

    @Autowired
    DataSource dataSource;

    @Bean
    public Object testBean(PlatformTransactionManager platformTransactionManager){
        System.out.println(">>>>>>>>>>" + platformTransactionManager.getClass().getName());
        return new Object();
    }

    @Test
    public void contextLoads() throws SQLException {

        System.out.println("数据源>>>>>>" + dataSource.getClass());
        Connection connection = dataSource.getConnection();

        System.out.println("连接>>>>>>>>>" + connection);
        System.out.println("连接地址>>>>>" + connection.getMetaData().getURL());
        System.out.println("用户名>>>>>" +connection.getMetaData().getUserName());

        //connection.close();
    }

    @Test
    public void test() throws Exception{
        contextLoads();
        System.out.println("==================");
        Map<String, Object> stringObjectMap = expressThanksService.queryAll(null,0,20,"id","desc");
        log.info("stringObjectMap{}", stringObjectMap);

        contextLoads();
    }

    @Test
    public void add() throws Exception{
        contextLoads();
        ExpressThanks expressThanks = new ExpressThanks("test", "tesst-sub", 1, "20123223", new Date());
        expressThanksService.add(expressThanks);

    }

}
