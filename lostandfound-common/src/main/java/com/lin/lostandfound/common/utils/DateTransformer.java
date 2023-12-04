package com.lin.lostandfound.common.utils;

import flexjson.ObjectBinder;
import flexjson.ObjectFactory;
import flexjson.transformer.AbstractTransformer;

import java.lang.reflect.Type;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DateTransformer extends AbstractTransformer implements ObjectFactory {

    private SimpleDateFormat simpleDateFormatter;

    public DateTransformer(String dateFormat) {
        simpleDateFormatter = new SimpleDateFormat(dateFormat);
    }
   
    public void transform(Object value) {
        getContext().writeQuoted(simpleDateFormatter.format(value));
    }

    @SuppressWarnings("rawtypes")
	public Object instantiate(ObjectBinder context, Object value, Type targetType, Class targetClass) {
        try {
            return simpleDateFormatter.parse( value.toString() );            
        } catch (ParseException e) {
            //throw new JSONException(String.format( "Failed to parse %s with %s pattern.", value, simpleDateFormatter.toPattern() ), e );
        	return value;
        }
    }
}
