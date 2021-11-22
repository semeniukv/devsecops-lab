package com.notsosecure.devsecops.actions.api;

import java.io.BufferedInputStream;
import java.io.PrintWriter;
import java.io.StringWriter;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.w3c.dom.CharacterData;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.notsosecure.devsecops.model.Student;
import com.notsosecure.devsecops.service.StudentService;
import com.opensymphony.xwork2.ActionSupport;

public class StudentDetailsApi extends ActionSupport implements ServletResponseAware, ServletRequestAware {

	private static final long serialVersionUID = -4078698440637641649L;
	protected HttpServletRequest servletRequest;
	protected HttpServletResponse servletResponse;
	private String userName;

//	@Action(value = "/api/user")
	public String execute() throws Exception {
		System.out.println("Inside Student Get");
		ServletInputStream xmlString = servletRequest.getInputStream();
		BufferedInputStream bis = new BufferedInputStream(xmlString);
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		InputSource is = new InputSource();
		is.setByteStream(xmlString);
		Document doc = db.parse(is);
		NodeList nodes = doc.getElementsByTagName("user");
		Element element = (Element) nodes.item(0);
		NodeList name = element.getElementsByTagName("username");
		Element line = (Element) name.item(0);
		String userName = getCharacterDataFromElement(line);
		System.out.println(userName);
		StudentService studentService = new StudentService();
		Student student = studentService.fetchUserDetails(userName);
		System.out.println(student.getEmailAddress());
		String outPutXML=jaxbObjectToXML(student);
		PrintWriter printWriter = servletResponse.getWriter();
		printWriter.print(outPutXML);
		return NONE;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.servletRequest = request;
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.servletResponse = response;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public static String getCharacterDataFromElement(Element e) {
		Node child = e.getFirstChild();
		if (child instanceof CharacterData) {
			CharacterData cd = (CharacterData) child;
			return cd.getData();
		}
		return "?";
	}

	private static String jaxbObjectToXML(Student student) {
	    String xmlString = "";
	    try {
	        JAXBContext context = JAXBContext.newInstance(Student.class);
	        Marshaller m = context.createMarshaller();

	        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE); // To format XML

	        StringWriter sw = new StringWriter();
	        m.marshal(student, sw);
	        xmlString = sw.toString();

	    } catch (JAXBException e) {
	        e.printStackTrace();
	    }

	    return xmlString;
	}
	
}
