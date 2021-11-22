package com.notsosecure.devsecops.util;

import java.net.URI;
import java.net.URISyntaxException;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.vault.authentication.TokenAuthentication;
import org.springframework.vault.client.VaultEndpoint;
import org.springframework.vault.core.VaultTemplate;
import org.springframework.vault.support.VaultResponseSupport;

import com.notsosecure.devsecops.model.Brand;
import com.notsosecure.devsecops.model.Cart;
import com.notsosecure.devsecops.model.Category;
import com.notsosecure.devsecops.model.Checkout;
import com.notsosecure.devsecops.model.Country;
import com.notsosecure.devsecops.model.Image;
import com.notsosecure.devsecops.model.Products;
import com.notsosecure.devsecops.model.Users;
import com.notsosecure.devsecops.model.WishProduct;

public class HibernateUtils {
   	   private static Logger logger = LoggerFactory.getLogger(HibernateUtils.class);

	   private static ServiceRegistryBuilder registry;
	   private static SessionFactory sessionFactory;
	   private static ServiceRegistry serviceRegistry ;
	   
	   private static String dbDriver = "com.mysql.jdbc.Driver";
	   private static String connectionUrl = System.getenv("MYSQL_JDBC_URL");
	   private static String userName = "";
	   private static String password = "" ;
	   private static String mysql_db_name = System.getenv("MYSQL_DB_NAME");
	   private static String vault_addr = System.getenv("VAULT_ADDR");

	   public static SessionFactory getSessionFactory() {
		   logger.info("Inside Session Factory");
		   
		   if (sessionFactory == null) {
	         try {

	 			if (isNullOrEmpty(vault_addr)) {
					logger.debug("Inside traditional DB Configuration");
					
					userName = System.getenv("MYSQL_DB_USER");
					password = System.getenv("MYSQL_DB_PASSWORD");
				} else {
					
					logger.debug("Inside Vault Configuration");
					
					VaultEndpoint endpoint = null;
					try {
						logger.debug("Vault Address Found : "+vault_addr);
						
						endpoint = VaultEndpoint.from(new URI(vault_addr));
					} catch (URISyntaxException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					VaultTemplate vaultTemplate = new VaultTemplate(endpoint,
							new TokenAuthentication(System.getenv("VAULT_TOKEN_MYSQL")));
					VaultResponseSupport<Credentials> response = vaultTemplate.read(System.getenv("VAULT_PATH_MYSQL"),
							Credentials.class);
					userName = response.getData().getUsername();
					password = response.getData().getPassword();
					
					logger.debug("Vault Cofiguration Success !");

				}
				 String url = "jdbc:mysql://"+connectionUrl+"/"+mysql_db_name+"?useSSL=false" ;
	        	 Configuration configuration = new Configuration();
	        	 configuration.addAnnotatedClass (Products.class);
	        	 configuration.addAnnotatedClass (Image.class);
	        	 configuration.addAnnotatedClass (Country.class);
	        	 configuration.addAnnotatedClass (Category.class);
	        	 configuration.addAnnotatedClass (Brand.class);
	        	 configuration.addAnnotatedClass (Cart.class);
	        	 configuration.addAnnotatedClass (WishProduct.class);
	        	 configuration.addAnnotatedClass (Checkout.class);
	        	 configuration.addAnnotatedClass (Users.class);
		         configuration.setProperty(Environment.DRIVER, dbDriver);
	             configuration.setProperty(Environment.URL,url);
	             configuration.setProperty(Environment.USER,userName);
	             configuration.setProperty(Environment.PASS,password);
	             configuration.setProperty(Environment.DIALECT, "org.hibernate.dialect.MySQL5Dialect");
	             configuration.setProperty("hibernate.hbm2ddl.auto", "update");
	             configuration.setProperty("hibernate.show_sql", "true");
	             
	             registry = new ServiceRegistryBuilder();
	             registry.applySettings(configuration.getProperties());
	             ServiceRegistry serviceRegistry = registry.buildServiceRegistry();
	             sessionFactory = configuration.buildSessionFactory(serviceRegistry); 

	         } catch (Exception e) {
	            e.printStackTrace();
	            if (serviceRegistry != null) {
	            	ServiceRegistryBuilder.destroy(serviceRegistry);
	            }
	         }
	      }
	      return sessionFactory;
	   }

	   public static void shutdown() {
	      if (serviceRegistry != null) {
	    	  ServiceRegistryBuilder.destroy(serviceRegistry);
	      }
	   }
	   
		public static boolean isNullOrEmpty(String str) {
			if (str != null && !str.isEmpty())
				return false;
			return true;
		}

	   
//	   public static void main(String[] args) {
//		    Session session = HibernateUtils.getSessionFactory().openSession();
//		    session.beginTransaction();
//
//		    // Check database version
//		    String sql = "select version()";
//
//		    CategoryManager categoryManager = new CategoryManager();		    
//		    System.out.println(categoryManager.getCategories());
//		    session.close();
//
//		    HibernateUtils.shutdown();
//		  }
	   
	}