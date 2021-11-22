package com.notsosecure.devsecops.util;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.vault.authentication.TokenAuthentication;
import org.springframework.vault.client.VaultEndpoint;
import org.springframework.vault.core.VaultTemplate;
import org.springframework.vault.support.VaultResponseSupport;

public class DbUtil {

	private	static Logger logger = LoggerFactory.getLogger(DbUtil.class.getName());

	private static Connection dbConnection = null;

	private static String userName = "";
	private static String password = "";

	public static Connection getConnection() {
//		if (dbConnection != null) {
//			return dbConnection;
//		} else {
//			logger.debug("Inside DB Configuration");
//			String dbDriver = "com.mysql.jdbc.Driver";
//			String connectionUrl = System.getenv("MYSQL_JDBC_URL");
//			String vault_addr = System.getenv("VAULT_ADDR");
//			if (isNullOrEmpty(vault_addr)) {
//				logger.debug("Inside traditional DB Configuration");
//				userName = System.getenv("MYSQL_USERNAME");
//				password = System.getenv("MYSQL_PASSWORD");
//			} else {
//				logger.debug("Inside Vault Configuration");
//				VaultEndpoint endpoint = null;
//				try {
//					logger.debug("Vault Address Found : "+vault_addr);
//					endpoint = VaultEndpoint.from(new URI(vault_addr));
//				} catch (URISyntaxException e1) {
//					// TODO Auto-generated catch block
//					e1.printStackTrace();
//				}
//				VaultTemplate vaultTemplate = new VaultTemplate(endpoint,
//						new TokenAuthentication(System.getenv("VAULT_TOKEN_MYSQL")));
//				VaultResponseSupport<Credentials> response = vaultTemplate.read("secret/db/mysql/credentials",
//						Credentials.class);
//				userName = response.getData().getUsername();
//				password = response.getData().getPassword();
//				logger.debug("Database Username : "+ userName +" Database Password: "+password);
//			}
//
//			try {
//				Class.forName(dbDriver).newInstance();
//				dbConnection = DriverManager.getConnection(connectionUrl, userName, password);
//				logger.debug("Database Connection established");
//			} catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) {
//				logger.error(e.getMessage());
//				e.printStackTrace();
//			} catch (SQLException e) {
//				logger.error(e.getMessage());
//				e.printStackTrace();
//			} finally {
//			    try {
//					if (dbConnection != null && !dbConnection.isClosed()) {
//					    try {
//					    	dbConnection.close();
//					    }
//					    catch (SQLException e) {
//					    	logger.error(e.getMessage());
//					        e.printStackTrace();
//					    }
//					}
//				} catch (SQLException e) {
//					logger.error(e.getMessage());
//					e.printStackTrace();
//				}
//			}
//			return dbConnection;
//		}
		return null ;
	}

	public static boolean isNullOrEmpty(String str) {
		if (str != null && !str.isEmpty())
			return false;
		return true;
	}

}