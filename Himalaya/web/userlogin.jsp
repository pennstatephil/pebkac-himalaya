<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="1.2" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html" xmlns:jsp="http://java.sun.com/JSP/Page" xmlns:ui="http://www.sun.com/web/ui">
    <jsp:directive.page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"/>
    <f:view>
        <ui:page binding="#{userlogin.page1}" id="page1">
            <ui:html binding="#{userlogin.html1}" id="html1">
                <ui:head binding="#{userlogin.head1}" id="head1">
                    <ui:link binding="#{userlogin.link1}" id="link1" url="/resources/stylesheet.css"/>
                </ui:head>
                <ui:body binding="#{userlogin.body1}" focus="form1:textField1" id="body1" style="-rave-layout: grid">
                    <ui:form binding="#{userlogin.form1}" id="form1">
                        <ui:textField binding="#{userlogin.userID_TF}" id="userID_TF" label="UserID" required="true"
                            style="left: 96px; top: 72px; position: absolute; width: 190px" validator="#{userlogin.lengthValidator1.validate}"/>
                        <ui:textField binding="#{userlogin.fname_TF}" id="fname_TF" label="FIrst Name" required="true" style="left: 96px; top: 264px; position: absolute; width: 214px"/>
                        <ui:textField binding="#{userlogin.lname_TF}" id="lname_TF" label="Last Name" required="true" style="left: 336px; top: 264px; position: absolute; width: 214px"/>
                        <ui:passwordField binding="#{userlogin.password_PF}" id="password_PF" label="Password" required="true" style="left: 96px; top: 120px; position: absolute; width: 214px"/>
                        <ui:passwordField binding="#{userlogin.confirm_PF}" id="confirm_PF" label="Confirm Password" required="true" style="left: 96px; top: 168px; position: absolute; width: 214px"/>
                        <ui:calendar binding="#{userlogin.birthdate_Calendar}" id="birthdate_Calendar" label="Birthdate" required="true" style="left: 96px; top: 312px; position: absolute"/>
                        <ui:radioButton binding="#{userlogin.radioButton1}" id="radioButton1" label=" M" name="radioButton-group-form1" style="left: 480px; top: 312px; position: absolute"/>
                        <ui:radioButton binding="#{userlogin.radioButton2}" id="radioButton2" label=" F" name="radioButton-group-form1" style="left: 528px; top: 312px; position: absolute"/>
                        <ui:label binding="#{userlogin.label1}" id="label1" style="left: 432px; top: 312px; position: absolute" text="Gender"/>
                        <ui:label binding="#{userlogin.label2}" id="label2" style="font-size: 50px; left: 24px; top: 0px; position: absolute" text="Himalaya.com"/>
                        <ui:textField binding="#{userlogin.email_TF}" id="email_TF" label="E-mail Address" required="true"
                            style="height: 24px; left: 96px; top: 216px; position: absolute; width: 214px" validator="#{userlogin.emailTF_validate}"/>
                        <ui:button binding="#{userlogin.submit_Btn}" id="submit_Btn" style="left: 95px; top: 384px; position: absolute" text="Submit"/>
                        <ui:staticText binding="#{userlogin.emailResult}" id="emailResult" style="height: 24px; left: 336px; top: 216px; position: absolute; width: 216px"/>
                        <ui:staticText binding="#{userlogin.emailResultLabel}" id="emailResultLabel"/>
                    </ui:form>
                </ui:body>
            </ui:html>
        </ui:page>
    </f:view>
</jsp:root>
