package top.liyuqihxc.skeleton.zuul;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.ctrip.framework.apollo.spring.annotation.EnableApolloConfig;
import top.liyuqihxc.skeleton.zuul.filters.ErrorFilter;
import top.liyuqihxc.skeleton.zuul.filters.PostFilter;
import top.liyuqihxc.skeleton.zuul.filters.PreFilter;
import top.liyuqihxc.skeleton.zuul.filters.RouteFilter;

import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.zuul.EnableZuulProxy;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@EnableDiscoveryClient
@EnableApolloConfig()
@EnableZuulProxy
public class ZuulServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(ZuulServerApplication.class, args);
	}
	
	@Bean
	public PreFilter preFilter() {
		return new PreFilter();
	}
	@Bean
	public PostFilter postFilter() {
		return new PostFilter();
	}
	@Bean
	public ErrorFilter errorFilter() {
		return new ErrorFilter();
	}
	@Bean
	public RouteFilter routeFilter() {
		return new RouteFilter();
	}

}