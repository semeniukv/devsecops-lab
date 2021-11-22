package com.notsosecure.devsecops.actions;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

public class ImageAction extends BaseAction {
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 2286332510889038567L;
	private byte[] imageInByte;
    private String imageId;

    public byte[] getCustomImageInBytes() {

        System.out.println("imageId" + imageId);

        BufferedImage originalImage;
        try {
            originalImage = ImageIO.read(getImageFile(this.imageId));
            // convert BufferedImage to byte array
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(originalImage, "jpg", baos);
            baos.flush();
            imageInByte = baos.toByteArray();
            baos.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return imageInByte;
    }

    private File getImageFile(String imageId) {
    	final String relativeWebPath = File.separator+"upload";
    	ServletContext context = ServletActionContext.getServletContext();
    	String absoluteFilePath = context.getRealPath(relativeWebPath);
        File file = new File(absoluteFilePath+File.separator+imageId);
        System.out.println(file.toString());
        return file;
    }

    public String getCustomContentType() {
        return "image/jpeg";
    }

    public String getCustomContentDisposition() {
        return "anyname.jpg";
    }
    public String getImageId() {
        return imageId;
    }

    public void setImageId(String imageId) {
        this.imageId = imageId;
    }
}
