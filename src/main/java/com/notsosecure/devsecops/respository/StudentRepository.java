package com.notsosecure.devsecops.respository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.notsosecure.devsecops.model.Student;
import com.notsosecure.devsecops.util.DbUtil;

public class StudentRepository {
	private Connection dbConnection;

	public StudentRepository() {
		dbConnection = DbUtil.getConnection();
	}

	public void save(String userName, String password, String firstName, String lastName, String dateOfBirth,
			String emailAddress) {
		if (dbConnection != null) {
			try {
				PreparedStatement prepStatement = dbConnection.prepareStatement(
						"insert into student(userName, password, firstName, lastName, dateOfBirth, emailAddress) values (?, ?, ?, ?, ?, ?)");
				prepStatement.setString(1, userName);
				prepStatement.setString(2, password);
				prepStatement.setString(3, firstName);
				prepStatement.setString(4, lastName);

				prepStatement.setDate(5, new java.sql.Date(
						new SimpleDateFormat("MM/dd/yyyy").parse(dateOfBirth.substring(0, 10)).getTime()));

				prepStatement.setString(6, emailAddress);

				prepStatement.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}

	public void update(String userName, String firstName, String lastName, String dateOfBirth, String emailAddress) {
		if (dbConnection != null) {
			try {
				PreparedStatement prepStatement = dbConnection.prepareStatement(
						"update student set firstName=?,lastName=?,dateOfBirth=?,emailAddress=? where userName=?");
				prepStatement.setString(1, firstName);
				prepStatement.setString(2, lastName);
				prepStatement.setDate(3, new java.sql.Date(
						new SimpleDateFormat("MM/dd/yyyy").parse(dateOfBirth.substring(0, 10)).getTime()));
				prepStatement.setString(4, emailAddress);
				prepStatement.setString(4, userName);

				prepStatement.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}

	public boolean findByUserName(String userName) {
		if (dbConnection != null) {
			try {
				PreparedStatement prepStatement = dbConnection
						.prepareStatement("select count(*) from student where userName = ?");
				prepStatement.setString(1, userName);

				ResultSet result = prepStatement.executeQuery();
				if (result != null) {
					while (result.next()) {
						if (result.getInt(1) == 1) {
							return true;
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	// public boolean findByLogin(String userName, String password) {
	// 	if (dbConnection != null) {
	// 		try {
	// 			PreparedStatement prepStatement = dbConnection
	// 					.prepareStatement("select password from student where userName = ?");
	// 			prepStatement.setString(1, userName);

	// 			ResultSet result = prepStatement.executeQuery();
	// 			if (result != null) {
	// 				while (result.next()) {
	// 					if (result.getString(1).equals(password)) {
	// 						return true;
	// 					}
	// 				}
	// 			}
	// 		} catch (Exception e) {
	// 			e.printStackTrace();
	// 		}
	// 	}
	// 	return false;
	// }

// VULNERABLE CODE
	 public boolean findByLoginSQL(String userName, String password) {
	
	 	if (dbConnection != null) {
	 		try {
	
	 			Statement stmt = dbConnection.createStatement();
	 			 ResultSet rs;
	 			 rs = stmt.executeQuery("select password from student where userName="+userName);
	 			 if (rs != null) {
	 					while (rs.next()) {
	 						if (rs.getString(1).equals(password)) {
	 							return true;
	 						}
	 					}
	 				}
	 		} catch (Exception e) {
	 			e.printStackTrace();
	 		}
	 	}
	 	return false;
	 }

	public List<Student> list() {
		List<Student> students = new ArrayList<Student>();

		if (dbConnection != null) {
			Student student = null;

			try {
				PreparedStatement prepStatement = dbConnection
						.prepareStatement("select userName,lastName,firstName,emailAddress,dateOfBirth from student");
				ResultSet result = prepStatement.executeQuery();
				if (result != null) {
					while (result.next()) {
						student = new Student();
						student.setUserName(result.getString("userName"));
						student.setLastName(result.getString("lastName"));
						student.setFirstName(result.getString("firstName"));
						student.setEmailAddress(result.getString("emailAddress"));
						student.setDateOfBirth(result.getDate("dateOfBirth"));
						students.add(student);
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return students;
	}

	public Student fetchUserDetails(String userName) {
		Student student = null;
		if (dbConnection != null) {
			try {
				PreparedStatement prepStatement = dbConnection
						.prepareStatement("select userName,lastName,firstName,emailAddress,dateOfBirth from student where userName = ?");
				prepStatement.setString(1, userName);
				ResultSet result = prepStatement.executeQuery();
				if (result != null) {
					while (result.next()) {
						student = new Student();
						student.setUserName(result.getString("userName"));
						student.setLastName(result.getString("lastName"));
						student.setFirstName(result.getString("firstName"));
						student.setEmailAddress(result.getString("emailAddress"));
						student.setDateOfBirth(result.getDate("dateOfBirth"));
						student.setPassword("*********");
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return student ;
	}

}
