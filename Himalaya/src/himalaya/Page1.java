/*
 * Page1.java
 *
 * Created on March 24, 2008, 3:40 PM
 * Copyright Adam
 */
package himalaya;

import com.sun.rave.web.ui.appbase.AbstractPageBean;
import com.sun.rave.web.ui.component.Body;
import com.sun.rave.web.ui.component.Button;
import com.sun.rave.web.ui.component.Calendar;
import com.sun.rave.web.ui.component.Form;
import com.sun.rave.web.ui.component.Head;
import com.sun.rave.web.ui.component.Html;
import com.sun.rave.web.ui.component.Label;
import com.sun.rave.web.ui.component.Link;
import com.sun.rave.web.ui.component.Page;
import com.sun.rave.web.ui.component.PasswordField;
import com.sun.rave.web.ui.component.RadioButton;
import com.sun.rave.web.ui.component.RadioButtonGroup;
import com.sun.rave.web.ui.component.TextField;
import com.sun.rave.web.ui.component.StaticText;
import com.sun.rave.web.ui.model.SingleSelectOptionsList;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.ValidatorException;
import javax.faces.application.FacesMessage;
import javax.faces.FacesException;
import javax.faces.event.ValueChangeEvent;
import javax.faces.validator.LengthValidator;

/**
 * <p>Page bean that corresponds to a similarly named JSP page.  This
 * class contains component definitions (and initialization code) for
 * all components that you have defined on this page, as well as
 * lifecycle methods and event handlers where you may add behavior
 * to respond to incoming events.</p>
 */
public class Page1 extends AbstractPageBean {
    // <editor-fold defaultstate="collapsed" desc="Managed Component Definition">
    private int __placeholder;
    
    /**
     * <p>Automatically managed component initialization.  <strong>WARNING:</strong>
     * This method is automatically generated, so any user-specified code inserted
     * here is subject to being replaced.</p>
     */
    private void _init() throws Exception {
    }
    
    private Page page1 = new Page();
    
    public Page getPage1() {
        return page1;
    }
    
    public void setPage1(Page p) {
        this.page1 = p;
    }
    
    private Html html1 = new Html();
    
    public Html getHtml1() {
        return html1;
    }
    
    public void setHtml1(Html h) {
        this.html1 = h;
    }
    
    private Head head1 = new Head();
    
    public Head getHead1() {
        return head1;
    }
    
    public void setHead1(Head h) {
        this.head1 = h;
    }
    
    private Link link1 = new Link();
    
    public Link getLink1() {
        return link1;
    }
    
    public void setLink1(Link l) {
        this.link1 = l;
    }
    
    private Body body1 = new Body();
    
    public Body getBody1() {
        return body1;
    }
    
    public void setBody1(Body b) {
        this.body1 = b;
    }
    
    private Form form1 = new Form();
    
    public Form getForm1() {
        return form1;
    }
    
    public void setForm1(Form f) {
        this.form1 = f;
    }

    private TextField userID_TF = new TextField();

    public TextField getUserID_TF() {
        return userID_TF;
    }

    public void setUserID_TF(TextField tf) {
        this.userID_TF = tf;
    }

    private TextField fname_TF = new TextField();

    public TextField getFname_TF() {
        return fname_TF;
    }

    public void setFname_TF(TextField tf) {
        this.fname_TF = tf;
    }

    private TextField lname_TF = new TextField();

    public TextField getLname_TF() {
        return lname_TF;
    }

    public void setLname_TF(TextField tf) {
        this.lname_TF = tf;
    }

    private PasswordField password_PF = new PasswordField();

    public PasswordField getPassword_PF() {
        return password_PF;
    }

    public void setPassword_PF(PasswordField pf) {
        this.password_PF = pf;
    }

    private PasswordField confirm_PF = new PasswordField();

    public PasswordField getConfirm_PF() {
        return confirm_PF;
    }

    public void setConfirm_PF(PasswordField pf) {
        this.confirm_PF = pf;
    }

    private Calendar birthdate_Calendar = new Calendar();

    public Calendar getBirthdate_Calendar() {
        return birthdate_Calendar;
    }

    public void setBirthdate_Calendar(Calendar c) {
        this.birthdate_Calendar = c;
    }

    private RadioButton radioButton1 = new RadioButton();

    public RadioButton getRadioButton1() {
        return radioButton1;
    }

    public void setRadioButton1(RadioButton rb) {
        this.radioButton1 = rb;
    }

    private RadioButton radioButton2 = new RadioButton();

    public RadioButton getRadioButton2() {
        return radioButton2;
    }

    public void setRadioButton2(RadioButton rb) {
        this.radioButton2 = rb;
    }

    private Label label1 = new Label();

    public Label getLabel1() {
        return label1;
    }

    public void setLabel1(Label l) {
        this.label1 = l;
    }

    private LengthValidator lengthValidator1 = new LengthValidator();

    public LengthValidator getLengthValidator1() {
        return lengthValidator1;
    }

    public void setLengthValidator1(LengthValidator lv) {
        this.lengthValidator1 = lv;
    }

    private Label label2 = new Label();

    public Label getLabel2() {
        return label2;
    }

    public void setLabel2(Label l) {
        this.label2 = l;
    }

    private TextField email_TF = new TextField();

    public TextField getEmail_TF() {
        return email_TF;
    }

    public void setEmail_TF(TextField tf) {
        this.email_TF = tf;
    }

    private StaticText emailResultLabel = new StaticText();

    public StaticText getEmailResultLabel() {
        return emailResultLabel;
    }

    public void setEmailResultLabel(StaticText st) {
        this.emailResultLabel = st;
    }

    private StaticText emailResult = new StaticText();

    public StaticText getEmailResult() {
        return emailResult;
    }

    public void setEmailResult(StaticText st) {
        this.emailResult = st;
    }
    
    private Button submit_Btn = new Button();

    public Button getSubmit_Btn() {
        return submit_Btn;
    }

    public void setSubmit_Btn(Button b) {
        this.submit_Btn = b;
    }
    
    // </editor-fold>
    /**
     * <p>Construct a new Page bean instance.</p>
     */
    public Page1() {
    }
    
    /**
     * <p>Callback method that is called whenever a page is navigated to,
     * either directly via a URL, or indirectly via page navigation.
     * Customize this method to acquire resources that will be needed
     * for event handlers and lifecycle methods, whether or not this
     * page is performing post back processing.</p>
     *
     * <p>Note that, if the current request is a postback, the property
     * values of the components do <strong>not</strong> represent any
     * values submitted with this request.  Instead, they represent the
     * property values that were saved for this view when it was rendered.</p>
     */
    public void init() {
        // Perform initializations inherited from our superclass
        super.init();
        // Perform application initialization that must complete
        // *before* managed components are initialized
        // TODO - add your own initialiation code here
        
        // <editor-fold defaultstate="collapsed" desc="Managed Component Initialization">
        // Initialize automatically managed components
        // *Note* - this logic should NOT be modified
        try {
            _init();
        } catch (Exception e) {
            log("Page1 Initialization Failure", e);
            throw e instanceof FacesException ? (FacesException) e: new FacesException(e);
        }
        
        // </editor-fold>
        // Perform application initialization that must complete
        // *after* managed components are initialized
        // TODO - add your own initialization code here
    }
    
    /**
     * <p>Callback method that is called after the component tree has been
     * restored, but before any event processing takes place.  This method
     * will <strong>only</strong> be called on a postback request that
     * is processing a form submit.  Customize this method to allocate
     * resources that will be required in your event handlers.</p>
     */
    public void preprocess() {
    }
    
    /**
     * <p>Callback method that is called just before rendering takes place.
     * This method will <strong>only</strong> be called for the page that
     * will actually be rendered (and not, for example, on a page that
     * handled a postback and then navigated to a different page).  Customize
     * this method to allocate resources that will be required for rendering
     * this page.</p>
     */
    public void prerender() {
    }
    
    /**
     * <p>Callback method that is called after rendering is completed for
     * this request, if <code>init()</code> was called (regardless of whether
     * or not this was the page that was actually rendered).  Customize this
     * method to release resources acquired in the <code>init()</code>,
     * <code>preprocess()</code>, or <code>prerender()</code> methods (or
     * acquired during execution of an event handler).</p>
     */
    public void destroy() {
    }

    /**
     * <p>Return a reference to the scoped data bean.</p>
     */
    protected SessionBean1 getSessionBean1() {
        return (SessionBean1)getBean("SessionBean1");
    }

    /**
     * <p>Return a reference to the scoped data bean.</p>
     */
    protected ApplicationBean1 getApplicationBean1() {
        return (ApplicationBean1)getBean("ApplicationBean1");
    }

    /**
     * <p>Return a reference to the scoped data bean.</p>
     */
    protected RequestBean1 getRequestBean1() {
        return (RequestBean1)getBean("RequestBean1");
    }
    
    public void emailTF_validate( FacesContext context, UIComponent component, Object value )
    {
        String email = String.valueOf( value );
        
        //if entered email address is not in a valid format
        if (!email.matches("\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"))
        {
            throw new ValidatorException( new FacesMessage( "Enter a valid email address, e.g. user@domain.com "));
        }
    }
    
    public String submitButton_action()
    {
        String email = String.valueOf(email_TF.getValue() );
        emailResult.setValue( email );
        return null;
    }

    public void passwordField1_processValueChange(ValueChangeEvent event) {
        // TODO: Replace with your code
        
    }
}

