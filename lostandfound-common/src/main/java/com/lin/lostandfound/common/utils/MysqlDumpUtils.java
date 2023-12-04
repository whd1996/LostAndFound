package com.lin.lostandfound.common.utils;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.*;

/** 
 * @author lin 
 * @since  2017-2-15 
 */  
public class MysqlDumpUtils {  
      
    private static String USERNAME;//数据库用户名  
    private static String PASSWORD;//数据库用户密码  
    private static String IP;//数据库ip地址
    private static String PORT;//数据库开放端口
    private static String DATABASENAME;//数据库名称


    private static String contextClassLoaderPath = Thread.currentThread().getContextClassLoader().
    getResource("").getPath();
      
  
    /** 
     * 配置数据库连接信息 
     * @param username 数据库用户名 
     * @param password 数据库用户密码 
     * @param databaseName 数据库名称 
     * @param ip 数据库ip地址 
     * @param port 数据库开放端口 
     */  
    
    private MysqlDumpUtils(){
    	
    }
    
    // 数据库配置信息
    public static void config(String username,String password,String databaseName,String ip,String port){  
        MysqlDumpUtils.USERNAME = username;  
        MysqlDumpUtils.PASSWORD = password;  
        MysqlDumpUtils.DATABASENAME = databaseName;  
        MysqlDumpUtils.PORT = port;  
        MysqlDumpUtils.IP = ip;  
    }  
      
    /** 
     * 根据数据库表名查找对应创建该表的sql语句脚本 
     * @param tableName 数据库名 
     * @return             创建该表的sql语句脚本 
     * @throws IOException              文件读写错误 
     */  
    public static String getTableSql(String tableName) throws IOException{  
        File file =  getMysqlDump();  
        if(file == null){  
            throw new FileNotFoundException("在resource/database路径下没有找到名为'mysqldump'的mysql工具,MysqlDumpUtil类的功能依赖此文件!");  
        }  
          
        //构建远程数据库命令字符串  
        StringBuilder cmdStr = new StringBuilder();  
        cmdStr.append(" -d --compact -u")  
              .append(USERNAME)  
              .append(" -p")  
              .append(PASSWORD)  
              .append(" -h")  
              .append(IP)  
              .append(" -P")  
              .append(PORT)  
              .append(" ").append(DATABASENAME)  
              .append(" ").append(tableName);  
                
        Runtime rt = Runtime.getRuntime();  
        //数据库构建表的sql脚本  
        StringBuilder tableSql = new StringBuilder();   
        // 调用mysqldump的cmd命令  
        Process process = null;  
        if(isWindows()){  
            process = rt.exec(new String[]{"cmd","/c",file.getPath() + cmdStr.toString()});  
        } else {  
            process = rt.exec(new String[]{"sh","-c","cd "+ file.getParent() + " | mysqldump " + cmdStr.toString()});  
        }  
        // 把进程执行中的控制台输出信息写入.sql文件  
        // 注:如果不对控制台信息进行读出，则会导致进程堵塞无法运行  
        InputStream in = process.getInputStream();  
        BufferedReader br = new BufferedReader(new InputStreamReader(in, "UTF-8"));  
  
        for (String inStr = null; (inStr = br.readLine()) != null;) {  
            tableSql.append(inStr).append("<br>");  
        }  
  
        in.close();  
        br.close();  
  
        //处理错误的信息  
        String errMsg = getErrMsg(process);  
        if (errMsg != null) {  
            throw new IOException(errMsg);  
        }  
  
        return tableSql.toString();  
    }  
      
      
    /** 
     * 备份数据库操作 
     * @return BackupInfo备份状态对象 
     * @throws IOException 文件读写错误 
     * @throws InterruptedException 
     * @throws InterruptedException 
     */  
    public static BackupInfo backup(String path) throws IOException, InterruptedException, ExecutionException {
        File file =  getMysqlDump();  
        if(file == null){  
            throw new FileNotFoundException("在resources/database路径下没有找到名为'mysqldump'的mysql工具,MysqlDumpUtil类的功能依赖此文件!");
        }  
          
        //构建远程数据库命令字符串  
        StringBuilder cmdStr = new StringBuilder();  
        cmdStr.append(" -h")  
		  	  	.append(IP)
		  	  	.append(" -u ")  
		        .append(USERNAME)  
		        .append(" -p")  
		        .append(PASSWORD) 
		        .append(" -P")
		        .append(PORT)  
		        .append("  --ignore-table=")  
		        .append(DATABASENAME).append(".t_backup_database ")  
		        .append(" ").append(DATABASENAME); 
          
        //创建备份信息对象  
        final BackupInfo backup = new BackupInfo();  
        Runtime rt = Runtime.getRuntime();  
        // 调用mysqldump的cmd命令  
        final Process process;  
        if(isWindows()){ 
        	System.out.println(file.getPath() + cmdStr.toString());
            //System.out.println(DataBaseBackupUtils.getMysqlPath()+"bin"+ "\\mysqldump" +cmdStr.toString());
        	//process = rt.exec(/*new String[]{"cmd","/c",*/DataBaseBackupUtils.getMysqlPath()+"bin"+ "\\mysqldump"/*f.getPath()*//*.substring(0,f.getPath().lastIndexOf("."))*/ + cmdStr.toString());  
        	process = rt.exec(new String[]{"cmd","/c",file.getPath() + cmdStr.toString()});
        } else {  
            process = rt.exec(new String[]{"sh","-c","cd "+ file.getParent() + " | mysqldump " +cmdStr.toString()});  
        }  
        //备份文件地址  
        path =  path + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()).toString().replaceAll(":", "") + ".sql";
        final String newPath = path;
        System.out.println("path: " +path);

        Callable call = new Callable<BackupInfo>(){
            @Override
            public BackupInfo call() throws Exception {
                //得到远程数据库备份的流文件
                InputStream in = process.getInputStream();
                try {
                    BufferedReader br = new BufferedReader(new InputStreamReader(in, "UTF-8"));
                    OutputStreamWriter writer = new OutputStreamWriter(new FileOutputStream(new File(newPath)), "UTF-8");
                    //向指定地址写文件
                    for (String str = null; (str = br.readLine()) != null; ) {
                        writer.write(str + "\r\n");
                        writer.flush();
                        //记录当前写入字节数
                        backup.setSize(str.getBytes().length + backup.getSize());
                    }

                    backup.setPath(newPath);
                    backup.setComplete(true);

                    in.close();
                    br.close();
                    writer.close();

                    //处理错误的信息
                    String errMsg = getErrMsg(process);
                    if (errMsg != null) {
                        backup.setError(true);
                        backup.setComplete(false);
                        backup.setErrMsg(errMsg);
                        System.err.println("备份过程中出现错误：" + errMsg);
                    } else {
                        backup.setError(false);
                        backup.setComplete(true);
                        backup.setErrMsg(errMsg);
                    }
                    System.out.println("备份方法结束!");
                } catch (IOException e) {
                    System.out.println("备份出错!");
                    backup.setComplete(false);
                    backup.setError(true);
                    backup.setErrMsg(e.getMessage());
                    e.printStackTrace();
                }
                return  backup;
            }
        };

        ExecutorService executor = Executors.newFixedThreadPool(3);
        Future<BackupInfo> future = executor.submit(call);
        BackupInfo backupInfo = future.get();

        if(backupInfo.getErrMsg() == null)
        	System.out.println("备份完成!");
        
        return backupInfo;
    }  
      
      
    /** 
     * 还原数据库 
     * @param path 要还原的sql脚本文件路径 
     * @throws IOException 文件读写出错 
     */  
    public static boolean recover(String path) throws IOException{  
        File file =  getMysql();  
        if(file == null){  
            throw new FileNotFoundException("在resources/database路径下没有找到名为'mysql'的mysql工具,MysqlDumpUtil类的功能依赖此文件!");
        }  
          
        //构建远程数据库命令字符串  
        StringBuilder cmdStr = new StringBuilder();  
        cmdStr.append(" -u")  
              .append(USERNAME)  
              .append(" -p")  
              .append(PASSWORD)  
              .append(" -h")  
              .append(IP)  
              .append(" -P")  
              .append(PORT)  
              .append(" ").append(DATABASENAME).append("<").append(path);  
                
        Runtime rt = Runtime.getRuntime();  
        // 调用mysqldump的cmd命令  
        Process process = null;  
        if(isWindows()){  
            process = rt.exec(new String[]{"cmd","/c",file.getPath() + cmdStr.toString()});  
        } else {  
            process = rt.exec(new String[]{"sh","-c","cd "+ file.getParent() + " | mysql "+cmdStr.toString()});  
        }  
        
        boolean flag = true;
        
        //处理错误的信息  
        String errMsg = getErrMsg(process);  
        if (errMsg != null) { 
        	flag = false;
            throw new IOException(errMsg);  
        }  
        
        return flag;
    }  
      
      
    /** 
     * @author lin 
     * @since  2017-2-19 
     * 封装了备份数据库时的状态信息 
     */  
    public static class BackupInfo{  
        //备份是否完成  
        private boolean isComplete;  
        //备份文件大小  
        private double size;  
        //备份是否出错      
        private boolean isError;  
        //出错信息  
        private String errMsg;  
        //备份路径  
        private String path;  
          
        public boolean isComplete() {  
            return isComplete;  
        }  
        public void setComplete(boolean isComplete) {  
            this.isComplete = isComplete;  
        }  
        public boolean isError() {  
            return isError;  
        }  
        public void setError(boolean isError) {  
            this.isError = isError;  
        }  
        public String getErrMsg() {  
            return errMsg;  
        }  
        public void setErrMsg(String errMsg) {  
            this.errMsg = errMsg;  
        }  
        public void setSize(double size) {  
            this.size = size;  
        }  
        public double getSize() {  
            return size;  
        }  
        public String getPath() {  
            return path;  
        }  
        public void setPath(String path) {  
            this.path = path;  
        }
        
		@Override
		public String toString() {
			return "BackupInfo [isComplete=" + isComplete + ", size=" + size
					+ ", isError=" + isError + ", errMsg=" + errMsg + ", path="
					+ path + "]";
		}  
        
    }  
      
    /** 
     * 获取mysqldump工具所的位置 
     * @return 名为"mysqldump.exe"的文件路径 
     */  
    private static File getMysqlDump(){  
        File file = null;
        try{
            if(isWindows()){ 
            	//System.out.println("Windows平台： "+MysqlUtils.class.getResource("/resource/mysqldump.exe"));
            	if(isX86())
            		file = new File(contextClassLoaderPath+ "/database/mysqldump.exe");
            	else 
            		file = new File(contextClassLoaderPath+"/database/mysqldumpx64.exe");
            } else {  
                file = new File(contextClassLoaderPath+"/database/mysqldump");
            }  
              
        } catch(NullPointerException e){
            e.printStackTrace();
        }
          
        return file;   
    }  
      
    /** 
     * 获取mysql工具所在的位置 
     * @return 名为"mysql.exe"的文件路径 
     */  
    private static File getMysql(){  
        File file = null;
        try{
            if(isWindows()){
            	if(isX86())
            		file = new File(contextClassLoaderPath+ "/database/mysql.exe");
            	else 
            		file = new File(contextClassLoaderPath+ "/database/mysqlx64.exe");
            } else {  
                file = new File(contextClassLoaderPath+ "/database/mysql");
            }  
              
        } catch (NullPointerException e){
            e.printStackTrace();
        }
        
        return file;  
    }  
      
    /** 
     * 获取备份文件夹,没有则创建一个 
     * @return 返回备份文件夹 
     */  
    public static String getBackupPath(){
        String backupPath = contextClassLoaderPath+"/database/backup";
        System.out.println("backupPath: " +backupPath);
        File file = new File(backupPath);
        //获得web-info目录下的backup文件夹
        if(!file.isDirectory()){
            file.mkdir();
        }

        return backupPath;
    }  
      
    /** 
     * 获取cmd命令执行的错误信息 
     * @param p Process对象 
     * @return  错误信息字符串 
     * @throws IOException 文件读写错误 
     */  
    private static String getErrMsg(Process p) throws IOException{  
        StringBuilder errMsg = new StringBuilder();  
        InputStream in = p.getErrorStream();  
        BufferedReader br = new BufferedReader(new InputStreamReader(in,"UTF-8")); 
        String inStr = null;
        while((inStr = br.readLine()) != null){ 
        	if(!inStr.startsWith("Warning:"))
        		errMsg.append(inStr).append("<br>"); 
        	
            System.out.println("inStr: " +inStr);
        }  
        in.close();  
        br.close();  
        
        return errMsg.length() == 0 ? null : errMsg.toString();  
    }  
      
    /** 
     * 判断是不是windows平台 
     * @return true是Windows平台,false非Windows平台 
     */  
    private static boolean isWindows() {  
        return System.getProperty("os.name").indexOf("Windows") != -1;  
    } 
    
    
    /** 
     * 判断是不是x86系统
     * @return true是Windows平台,false非Windows平台 
     */  
    private static boolean isX86() {  
        return System.getProperty("os.arch").equalsIgnoreCase("x86");  
    } 
      
}  
