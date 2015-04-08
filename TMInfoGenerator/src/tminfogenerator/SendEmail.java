/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package tminfogenerator;

import javax.mail.*;
import javax.mail.internet.*;

import java.util.Properties;

/**
 *
 * @author Administrator
 */
public class SendEmail {

    private static final String SMTP_HOST_NAME = "smtp.gmail.com";
    private static final int SMTP_HOST_PORT = 465;
    private static final String SMTP_AUTH_USER = "jps330@gmail.com";
    private static final String SMTP_AUTH_PWD  = "";
    
    public static void sendMail(String messageToSend, String destEmail) throws NoSuchProviderException, MessagingException
    {
        
            Properties props = new Properties();
            props.put("mail.transport.protocol", "smtps");
            props.put("mail.smtps.host", SMTP_HOST_NAME);
            props.put("mail.smtps.auth", "true");
            // props.put("mail.smtps.quitwait", "false");

            Session mailSession = Session.getDefaultInstance(props);
            mailSession.setDebug(true);
            Transport transport = mailSession.getTransport();

            MimeMessage message = new MimeMessage(mailSession);
            message.setSubject("Telemarketing Report");
            message.setContent(messageToSend, "text/plain");

            message.addRecipient(Message.RecipientType.TO,
                 new InternetAddress(destEmail));

            transport.connect
              (SMTP_HOST_NAME, SMTP_HOST_PORT, SMTP_AUTH_USER, SMTP_AUTH_PWD);

            transport.sendMessage(message,
                message.getRecipients(Message.RecipientType.TO));
            transport.close();
        }
    
    
}
