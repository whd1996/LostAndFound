package com.lin.lostandfound.configs.datasource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

import java.util.Map;


public class DynamicDataSource extends AbstractRoutingDataSource {
	private static final Logger logger = LoggerFactory.getLogger(DynamicDataSource.class);

	public DynamicDataSource(Map<Object, Object> targetDataSources, Object defaultTargetDataSource){
		super.setTargetDataSources(targetDataSources);
		super.setDefaultTargetDataSource(defaultTargetDataSource);
		super.afterPropertiesSet();
	}

	@Override
	protected Object determineCurrentLookupKey() {
		logger.info("current datasource is : {}",DataSourceContextHolder.getDataSourceType());
		return DataSourceContextHolder.getDataSourceType();
	}

}
