package tminfogenerator;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Administrator
 */
public class DataBaseAccessor {
    public static final String DRIVER = "oracle.jdbc.OracleDriver"; 
    public static final String DATABASE_URL = "jdbc:oracle:thin:@himalaya.phporaclehosting.com/XE";
    public static final String USERNAME = "himalaya";
    public static final String PASSWORD = "uc7smU8d56";
    
    private PreparedStatement getUserTableInfo = null;
    private PreparedStatement getUserAddresses = null;
    private PreparedStatement getUserBidCount = null;
    
    static Connection connection = null;
    static Statement statement;
    static ResultSet resultSet1;
    static ResultSet resultSet2;
    
    public DataBaseAccessor() 
    {
        try
        {
            Class.forName( DRIVER );
            connection = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
            statement = null;
            resultSet1 = null;
            
            getUserTableInfo = connection.prepareStatement("select phone,userid,user_name, email,dob, gender,salary from users");
            getUserAddresses = connection.prepareStatement("select a.street,a.city,a.usa_state,a.zip from addresses a where a.userid=?");
            getUserBidCount = connection.prepareStatement("select count(*) as count from bids_on b where b.userid=?");
        }
        catch (Exception e)
        {
            e.printStackTrace();
            System.exit(1);
        }
    }
    
    public ArrayList<CustomerInfo> getCustomerInfo()
    {
        ArrayList<CustomerInfo> results = new ArrayList<CustomerInfo>();
        
        try
        {
            resultSet1 = getUserTableInfo.executeQuery();
            
            while(resultSet1.next())
            {
                
                boolean addedBidCount = false;
                CustomerInfo newInfo = new CustomerInfo();
                
                Date dob = new Date(resultSet1.getDate("DOB").getTime());
                newInfo.setAge(""+ageYears(dob));
                newInfo.setAnnualIncome(resultSet1.getString("SALARY"));
                newInfo.setEmail(resultSet1.getString("EMAIL"));
                newInfo.setGender(resultSet1.getString("GENDER"));
                newInfo.setName(resultSet1.getString("USER_NAME"));
                newInfo.setPhoneNumber(resultSet1.getString("PHONE"));
                
                getUserAddresses.setString(1,resultSet1.getString("userid"));
                resultSet2 = getUserAddresses.executeQuery();
                
                while(resultSet2.next())
                {
                    newInfo.setAddress(resultSet2.getString("Street")+" "+resultSet2.getString("CITY")+" "+resultSet2.getString("USA_STATE")+" "+resultSet2.getString("ZIP"));
                    
                }
                
                
                getUserBidCount.setString(1,resultSet1.getString("userid"));
                resultSet2 = getUserBidCount.executeQuery();
                
                while(resultSet2.next())
                {
                    newInfo.setTotalBids(resultSet2.getString("count"));
                    addedBidCount = true;
                }
                if(addedBidCount==false){newInfo.setTotalBids("No Bids");}
                
                results.add(newInfo);
            }
            
        }
        catch (SQLException sqlExcept)
        {
            sqlExcept.printStackTrace();
        }
        
        return results;
    }
    
    public static int ageYears(Date dateOfBirth) {
        // get todays date
        Calendar now = Calendar.getInstance();
        // get a calendar representing their birth date
        Calendar cal = Calendar.getInstance();
        cal.setTime(dateOfBirth);

        // calculate age as the difference in years.
        int age = now.get(Calendar.YEAR) - cal.get(Calendar.YEAR);

        // now for the tricky bit.
        // set the "birth" calendar to be this year
        // this now represents the date of the birthday THIS year.
        // if that date has not occurred yet, subtract one from age
        cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
        if (now.before(cal)) {
            age = age - 1;
        }
        return age;
    }

    public void closeConnection()
    {
        try
        {
            if (resultSet1 != null)
            {
                resultSet1.close();
            }
            if (resultSet2 != null)
            {
                resultSet2.close();
            }
            if (statement != null)
            {
                statement.close();
            }
            if (connection != null)
            {
                connection.close();
            } 
        }
        catch (SQLException sqlExcept)
        {
            sqlExcept.printStackTrace();
        }
    }
}
