package com.kaishengit.util;

import javax.servlet.http.HttpServletRequest;

public class ServletUtil {

    public static String getRemoteIp(HttpServletRequest request){
        String ip = request.getRemoteAddr();
        if ("0:0:0:0:0:0:0:1".equals(ip)){
            ip = "127.0.0.1";
        }
        return ip;
    }
}
