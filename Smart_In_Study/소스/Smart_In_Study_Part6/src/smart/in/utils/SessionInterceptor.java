package smart.in.utils;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends HandlerInterceptorAdapter {
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        try {
            //Session Object에서 user라는 Attribute가 null일경우 main페이지로 이동
            if(request.getSession().getAttribute("siscode") == null ){
                    response.sendRedirect("/Smart_In_Study/");
                    return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //user라는 Attribute가 존재시 요청페이지 이동
        return true;
    }
}
