package com.notsosecure.devsecops.util;

import java.nio.charset.StandardCharsets; // java 7
import javax.xml.bind.DatatypeConverter;

public class Base64Utils {

   private Base64Utils() {}

   public static String encode(String value) throws Exception {
      return  DatatypeConverter.printBase64Binary
          (value.getBytes(StandardCharsets.UTF_8)); // use "utf-8" if java 6
   }

   public static String decode(String value) throws Exception {
      byte[] decodedValue = DatatypeConverter.parseBase64Binary(value);
      return new String(decodedValue, StandardCharsets.UTF_8); // use "utf-8" if java 6
   }

public static String encode(byte[] byteArray) {
	return  DatatypeConverter.printBase64Binary
	          (byteArray);
}

public static byte[] decodeByte(String value) {
	 byte[] decodedValue = DatatypeConverter.parseBase64Binary(value);
	 return decodedValue ;
}

}
