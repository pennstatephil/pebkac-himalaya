/*
 * ValidateInput.java
 *
 * Created on March 24, 2008, 9:39 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package himalaya;

/**
 *
 * @author shelley
 */
  // Fig. 29.20: ValidateInput.java
    // Validate user information using regular expressions.
    
    public class ValidateInput  
    {
       // validate first name
       public static boolean validateFirstName( String firstName )
       {
          return firstName.matches( "[A-Z][a-zA-Z]*" );
       } // end method validateFirstName
    
       // validate last name
       public static boolean validateLastName( String lastName )
       {
          return lastName.matches( "[A-Z][a-zA-z]+([ '-][a-zA-Z]+)*" );
       } // end method validateLastName
       
       public static boolean validateFullName( String name )
       {
           return name.matches("\\D+");//no digits
       }
    
       // validate address
       public static boolean validateAddress( String address )
       {
          return address.matches(                          
             "\\d+\\s+([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)" );
       } // end method validateAddress
    
       // validate city
       public static boolean validateCity( String city )
       {
          return city.matches( "([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)" );
       } // end method validateCity
    
       // validate state
       public static boolean validateState( String state )
       {
          return state.matches( "([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)" ) ;
       } // end method validateState
    
       // validate zip
       public static boolean validateZip( String zip )
       {
          return zip.matches( "\\d{5}" );
       } // end method validateZip
    
       // validate phone
       public static boolean validatePhone( String phone )
       {
          return phone.matches( "[1-9]\\d{2}-[1-9]\\d{2}-\\d{4}" );
       } // end method validatePhone
       
       public static boolean validateEmail( String email)
       {      
           return email.matches( "(\\w+)@(\\w+\\.)(\\w+)(\\.\\w+)*" );
       }
       
    } // end class ValidateInput
