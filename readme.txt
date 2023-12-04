开发环境：
IIntelliJ DEA + JDK1.8 + Maven + MySQL 8+

运行环境：
IntelliJ IDEA + JDK1.8 + + Maven + MySQL 8+ + Tomcat 9.0

1.Spring Boot 构建（Spring + Spring Boot + Hibernate）+ MYSQL
   拆分成7个模块：
   lostandfound-entities
   lostandfound-common
   lostandfound-configs
   lostandfound-repositories
   lostandfound-services
   lostandfound-websocket
   lostandfound-web

   各模块依赖关系：
   lostandfound-entities： 无依赖
   lostandfound-common: ---> lostandfound-entities
   lostandfound-configs: ---> lostandfound-entities,lostandfound-common,lostandfound-services
   lostandfound-repositories: ---> lostandfound-entities,lostandfound-common
   lostandfound-services： ---> lostandfound-entities,lostandfound-common,lostandfound-repositories
   lostandfound-websocket: ---> lostandfound-entities,lostandfound-common
   lostandfound-web : ---> lostandfound-entities,lostandfound-common,lostandfound-configs,lostandfound-services,lostandfound-websocket


   数据库相关配置在lostandfound-configs （默认配置一个数据库（主数据源））
   其他相关配置在lostandfound-web

   启动lostandfound-web模块即可
   特别注意：
   1.. 把lostandfound-web模块打成war包的时候，需要把下面的<scope>注释去掉(去掉内置tomcat)，
       <!-- tomcat 依赖包 -->
       <dependency>
           <groupId>org.apache.tomcat.embed</groupId>
           <artifactId>tomcat-embed-jasper</artifactId>
           <!--<scope>provided</scope>-->
       </dependency>

   2.. 直接在IntelliJ IDEA里启动(配置工作目录为$MODULE_WORKING_DIR$)
      可选用spring-boot maven plugin 运行，
      Maven：
      lostandfound-web >>> Plugins >>> spring-boot >>>
      spring-boot:run or spring-boot:start / spring-boot:stop

2.项目名称：LostAndFound

3.前台访问地址：http://localhost:8080/LostAndFoundindex.html
  登录账号  2013031308 2013031308

4.后台访问地址：http://localhost:8080/LostAndFound/admin/
  登录账号  admin 12345678
