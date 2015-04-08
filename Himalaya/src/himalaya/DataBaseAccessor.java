package himalaya;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;

public class DataBaseAccessor 
{
    public static final String DRIVER = "oracle.jdbc.OracleDriver"; 
    public static final String DATABASE_URL = "jdbc:oracle:thin:@himalaya.phporaclehosting.com/XE";
    public static final String USERNAME = "himalaya";
    public static final String PASSWORD = "uc7smU8d56";
    
    private PreparedStatement insertNewAddress = null;
    private PreparedStatement insertNewAuction = null;
    private PreparedStatement insertNewBid = null;
    private PreparedStatement insertNewCategory = null;
    private PreparedStatement insertNewCredit_Cards = null;
    private PreparedStatement insertNewItem = null;
    private PreparedStatement insertNewOrder = null;
    private PreparedStatement insertNewOrder_Addresses = null;
    private PreparedStatement insertNewOrder_Credit_Cards = null;
    private PreparedStatement insertNewOrder_Auction_Items = null;
    private PreparedStatement insertNewOrder_Sale_Items = null;
    private PreparedStatement insertNewAuctionRating = null;
    private PreparedStatement insertNewItemRating = null;
    private PreparedStatement insertNewSupplierRating = null;
    private PreparedStatement insertNewSells = null;
    private PreparedStatement insertNewSupplier = null;
    private PreparedStatement insertNewUser = null;
    private PreparedStatement search = null;
    private PreparedStatement updateMinBid = null;
    private PreparedStatement getAuctionTime = null;
    private PreparedStatement getCurrentTime = null;
    private PreparedStatement endThisAuction = null;
    private PreparedStatement getRemainingTime = null;
    
    private ResultSet results = null;
    
    static Connection connection = null;
    static Statement statement;
    static ResultSet resultSet;
    /** Creates a new instance of DataBaseAccessor */
    public DataBaseAccessor() 
    {
        try
        {
            Class.forName( DRIVER );
            connection = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
            statement = null;
            resultSet = null;
            
            insertNewAddress = connection.prepareStatement("INSERT INTO ADDRESSES ( ADDRESSID, STREET, CITY, USA_STATE, ZIP, USERID ) VALUES ( address_seq.nextval, ?, ?, ?, ?, ? )");
            insertNewAuction = connection.prepareStatement("INSERT INTO AUCTIONS ( AUCTIONID, START_TIME, END_TIME, BUY_NOW_PRICE, RESERVE_PRICE, ITEMID, USERID, MIN_BID ) VALUES ( auction_seq.nextval, SYSDATE, SYSDATE+7, ?, ?, ?, ?, ? )");
            insertNewBid = connection.prepareStatement("INSERT INTO BIDS_ON ( AUCTIONID, USERID, AMOUNT, TIME ) VALUES ( ?, ?, ?, SYSDATE )");
            insertNewCategory = connection.prepareStatement("INSERT INTO CATEGORIES ( CATEGORY_NAME, PARENT_CATEGORY ) VALUES ( ?, ? )");
            insertNewCredit_Cards = connection.prepareStatement("INSERT INTO CREDIT_CARDS ( CC_NUMBER, COMPANY, EXPIRATION, CVV, NAME_ON_CARD, USERID ) VALUES ( ?, ?, ?, ?, ?, ? )");
            insertNewItem = connection.prepareStatement("INSERT INTO ITEMS ( ITEMID, ITEM_NAME, DESCRIPTION, IMAGE, URL, CATEGORY_NAME ) VALUES (item_seq.nextval, ?, ?, ?, ?, ? )");
            insertNewOrder = connection.prepareStatement("INSERT INTO ORDERS ( ORDERID, ORDER_DATE, ORDER_STATUS, USERID ) VALUES ( order_seq.nextval, SYSDATE, ?, ? )");
            insertNewOrder_Addresses = connection.prepareStatement("INSERT INTO ORDER_ADDRESSES ( ORDERID, ADDRESSID, TYPE_OF_ADDRESS ) VALUES ( ?, ?, ? )");
            insertNewOrder_Credit_Cards = connection.prepareStatement("INSERT INTO ORDER_CREDIT_CARDS ( ORDERID, CC_NUMBER ) VALUES ( ?, ? )");
            insertNewOrder_Auction_Items = connection.prepareStatement("INSERT INTO ORDER_AUCTION_ITEMS ( ORDERID, AUCTIONID, WINNING_BID ) VALUES ( ?, ?, ? )");
            insertNewOrder_Sale_Items = connection.prepareStatement("INSERT INTO ORDER_SALE_ITEMS ( ORDERID, SUPPLIERID, ITEMID, QUANTITY, PURCHASE_PRICE ) VALUES ( ?, ?, ?, ? ,? )");
            insertNewAuctionRating = connection.prepareStatement("INSERT INTO RATES_AUCTIONS ( USERID, AUCTIONID, RATING, COMMENTS, RATING_DATE ) VALUES ( ?, ?, ?, ?, SYSDATE )");
            insertNewItemRating = connection.prepareStatement("INSERT INTO RATES_ITEMS ( USERID, ITEMID, RATING, COMMENTS, RATING_DATE ) VALUES ( ?, ?, ?, ?, SYSDATE )");
            insertNewSupplierRating = connection.prepareStatement("INSERT INTO RATES_SUPPLIERS ( USERID, SUPPLIERID, RATING, COMMENTS, RATING_DATE ) VALUES ( ?, ?, ?, ?, SYSDATE )");
            insertNewSells = connection.prepareStatement("INSERT INTO SELLS ( SUPPLIERID, ITEMID, PRICE, INVENTORY ) VALUES ( ?, ?, ?, ? )");
            insertNewSupplier = connection.prepareStatement("INSERT INTO SUPPLIERS ( SUPPLIERID, SUPPLIER_NAME, SUPPLIER_ADDRESS, POINT_OF_CONTACT, PHONE, COMPANY_CATEGORY ) VALUES ( supplier_seq.nextval, ?, ?, ?, ?, ?)");
            insertNewUser = connection.prepareStatement("INSERT INTO USERS ( USERID, PASSWORD, ADMINISTRATOR, USER_NAME, EMAIL, DOB, GENDER, PHONE, SALARY ) VALUES ( ?, ?, 0, ?, ?, ?, ?, ?, ?)");
            search = connection.prepareStatement("SELECT ITEMID, ITEM_NAME, URL FROM ITEMS WHERE UPPER(DESCRIPTION) LIKE UPPER( ? ) OR UPPER(ITEM_NAME) LIKE UPPER( ? )");
            updateMinBid = connection.prepareStatement("UPDATE AUCTIONS SET MIN_BID = ? WHERE AUCTIONID = ?");
            getAuctionTime = connection.prepareStatement("SELECT END_TIME FROM AUCTIONS WHERE AUCTIONID = ?");
            getCurrentTime = connection.prepareStatement("SELECT SYSDATE FROM dual");
            endThisAuction = connection.prepareStatement("UPDATE AUCTIONS SET END_TIME = SYSDATE, MIN_BID = BUY_NOW_PRICE WHERE AUCTIONID = ?");
            String grt = "SELECT trunc( END_TIME-sysdate ) \"Dy\", trunc( mod( (END_TIME-sysdate)*24, 24 ) ) \"Hr\", trunc( mod( (END_TIME-sysdate)*24*60, 60 ) )  \"Mi\", trunc( mod( (END_TIME-sysdate)*24*60*60, 60 ) ) \"Sec\" FROM AUCTIONS WHERE AUCTIONID = ?";
            getRemainingTime = connection.prepareStatement(grt);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            System.exit(1);
        }
        openConnection();
    }

    public static void executeStatement(String str)
    {
        try
        {
            statement = connection.createStatement();
            statement.execute(str);
            statement.close();
        }
        catch (SQLException sqlExcept)
        {
            sqlExcept.printStackTrace();
        }
    }

    public static ResultSet runQuery(String str)
    {
        resultSet = null;
        try
        {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(str);
        }
        catch (SQLException sqlExcept)
        {
            sqlExcept.printStackTrace();
        }
        return resultSet;
    }
    
    public void addNewAddress(String street, String city, String state, String zip, String userID)
    {
        
        try
        {
            insertNewAddress.setString(1, street);
            insertNewAddress.setString(2, city);
            insertNewAddress.setString(3, state);
            insertNewAddress.setString(4, zip);
            insertNewAddress.setString(5, userID);
            insertNewAddress.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewAuction(double buyNowPrice, double reservePrice, int itemID, String userID, double minBid)
    {
        try
        {
            insertNewAuction.setDouble(1, buyNowPrice);
            insertNewAuction.setDouble(2, reservePrice);
            insertNewAuction.setInt(3, itemID);
            insertNewAuction.setString(4, userID);
            insertNewAuction.setDouble(5, minBid);
            insertNewAuction.executeUpdate();
        }
        catch (Exception e)
        {
            e.printStackTrace();
            closeConnection();            
        }
    }
    
    public void addNewBid(int auctionID, String userID, double amount)
    {
        try
        {
            insertNewBid.setInt(1, auctionID);
            insertNewBid.setString(2, userID);
            insertNewBid.setDouble(3, amount);
            insertNewBid.executeUpdate();
            updateMinBid.setDouble(1, amount);
            updateMinBid.setInt(2, auctionID);
            updateMinBid.executeUpdate();
        }
       catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
        
    }
    
    public void addNewCategory(String name, String parent)
    {
        try
        {
            insertNewCategory.setString(1, name);
            insertNewCategory.setString(2, parent);
            insertNewCategory.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewCredit_Card(String ccNum, String company, String expiration, String cvv, String name, String userID)
    {
        SimpleDateFormat formatter = new SimpleDateFormat("MM/yy");
        
        try
        {
            java.util.Date parsedDate = formatter.parse(expiration);
            java.sql.Date sqlExp = new java.sql.Date(parsedDate.getTime());
            insertNewCredit_Cards.setString(1, ccNum);
            insertNewCredit_Cards.setString(2, company);
            insertNewCredit_Cards.setDate(3, sqlExp);
            insertNewCredit_Cards.setString(4, cvv);
            insertNewCredit_Cards.setString(5, name);
            insertNewCredit_Cards.setString(6, userID);
            insertNewCredit_Cards.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewItem(String itemName, String description, String image, String URL, String categoryName)
    {
        try
        {
            insertNewItem.setString(1, itemName);
            insertNewItem.setString(2, description);
            insertNewItem.setString(3, URL);
            insertNewItem.setString(4, image);
            insertNewItem.setString(5, categoryName);
            insertNewItem.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewOrder(String status, String userID)
    {
        try
        {
            insertNewOrder.setString(1, status);
            insertNewOrder.setString(2, userID);
            insertNewOrder.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewOrder_Address(int orderID, int addressID, String type)
    {
        try
        {
            insertNewOrder_Addresses.setInt(1, orderID);
            insertNewOrder_Addresses.setInt(2, addressID);
            insertNewOrder_Addresses.setString(3, type);
            insertNewOrder_Addresses.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewOrder_Credit_Card(int orderID, String ccNum)
    {
        try
        {
            insertNewOrder_Credit_Cards.setInt(1, orderID);
            insertNewOrder_Credit_Cards.setString(2, ccNum);
            insertNewOrder_Credit_Cards.execute();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewOrder_Sale_Items(int orderID, int itemID, int quantity)
    {
        try
        {
            insertNewOrder_Sale_Items.setInt(1, orderID);
            insertNewOrder_Sale_Items.setInt(2, itemID);
            insertNewOrder_Sale_Items.setInt(3, quantity);
            insertNewOrder_Sale_Items.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewOrder_Auction_Items(int orderID, int auctionID, double winningBid)
    {
        try
        {
            insertNewOrder_Auction_Items.setInt(1, orderID);
            insertNewOrder_Auction_Items.setInt(2, auctionID);
            insertNewOrder_Auction_Items.setDouble(3, winningBid);
            insertNewOrder_Auction_Items.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewAuctionRating(String userID, int auctionID, int rating, String comment)
    {
        try
        {
            insertNewAuctionRating.setString(1, userID);
            insertNewAuctionRating.setInt(2, auctionID);
            insertNewAuctionRating.setInt(3, rating);
            insertNewAuctionRating.setString(4, comment);
            insertNewAuctionRating.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewItemRating(String userID, String itemID, int rating, String comment)
    {
        try
        {
            insertNewItemRating.setString(1, userID);
            insertNewItemRating.setString(2, itemID);
            insertNewItemRating.setInt(3, rating);
            insertNewItemRating.setString(4, comment);
            insertNewItemRating.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewSupplierRating(String userID, int supplierID, int rating, String comment)
    {
        try
        {
            insertNewSupplierRating.setString(1, userID);
            insertNewSupplierRating.setInt(2, supplierID);
            insertNewSupplierRating.setInt(3, rating);
            insertNewSupplierRating.setString(4, comment);
            insertNewSupplierRating.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewSells(String supplierID, int itemID, double price, int quantity)
    {
        try
        {
            insertNewSells.setString(1, supplierID);
            insertNewSells.setInt(2, itemID);
            insertNewSells.setDouble(3, price);
            insertNewSells.setInt(4, quantity);
            insertNewSells.executeUpdate();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewSupplier(/*String supplierID,*/ String name, String address, String poc, String phone, String category)
    {
        try
        {
            //insertNewSupplier.setString(1, supplierID);
            insertNewSupplier.setString(1, name);
            insertNewSupplier.setString(2, address);
            insertNewSupplier.setString(3, poc);
            insertNewSupplier.setString(4, phone);
            insertNewSupplier.setString(5, category);
            insertNewSupplier.executeUpdate();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public void addNewUser(String id, String pwd, String name, String email, String dob, String gender, String phone, double salary)
    {
        SimpleDateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
        
        try
        {   
            java.util.Date parsedDate = formatter.parse(dob);
            java.sql.Date sqlDob = new java.sql.Date(parsedDate.getTime());
            insertNewUser.setString(1, id);
            insertNewUser.setString(2, pwd);
            insertNewUser.setString(3, name);
            insertNewUser.setString(4, email);
            insertNewUser.setDate(5, sqlDob);
            insertNewUser.setString(6, gender);
            insertNewUser.setString(7, phone);
            insertNewUser.setDouble(8, salary);
            insertNewUser.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }
    }
    
    public ResultSet getRemainingAuctionTime(int auctionID)
    {
        resultSet = null;
        try
        {
            getRemainingTime.setInt(1, auctionID);
            resultSet = getRemainingTime.executeQuery();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            closeConnection();
        }

        return resultSet;
    }
    
    public boolean auctionOver(int auctionID)
    {
        resultSet = null;
        java.sql.Date auctionEndTime = null;
        java.sql.Date currentTime = null;
        boolean over = false;
            
        try
        {
            getAuctionTime.setInt(1, auctionID);
            resultSet = getAuctionTime.executeQuery();
            resultSet.next();
            auctionEndTime = resultSet.getDate("END_TIME");
            resultSet = null;
            resultSet= getCurrentTime.executeQuery();
            resultSet.next();
            currentTime = resultSet.getDate("SYSDATE");
            over = auctionEndTime.before(currentTime);
        }
        catch (SQLException sqlException)
        {
            sqlException.printStackTrace();
        }
        finally
        {
            try
            {
                resultSet.close();
            }
            catch (SQLException sqlException)
            {
                sqlException.printStackTrace();
                closeConnection();
            }
        }
        return over;
    }
 /*   
    public void processBuyNow(int auctionID, String userID)
    {
        resultSet = null;
        try
        {
            //addNewOrder("BuyItNow", userID);
            //resultSet = getMostRecentOrder.executeQuery();
            //statement.executeQuery("SELECT ORDERID FROM ORDERS WHERE ROWNUM = 1 ORDER BY ORDERID DESC");
            resultSet.next();
            int mostRecentOrder = resultSet.getInt("ORDERID");
            getWinningBid.setString(1, userID);
            getWinningBid.setInt(2, auctionID);
            resultSet = getWinningBid.executeQuery();
            resultSet.next();
            double winningBid = resultSet.getDouble("AMOUNT");
            addNewOrder_Auction_Items(mostRecentOrder, auctionID, winningBid);
        }
        catch (SQLException sqlException)
        {
            sqlException.printStackTrace();
        }
        finally
        {
            try
            {
                resultSet.close();
            }
            catch (SQLException sqlException)
            {
                sqlException.printStackTrace();
                closeConnection();
            }
        }
    }
   */ 
    public void endAuction(int auctionID)
    {
        try
        {
            endThisAuction.setInt(1, auctionID);
            endThisAuction.executeUpdate();
            
        }
        catch (SQLException sqlException)
        {
            sqlException.printStackTrace();
            closeConnection();
        }
    }
    
    public ResultSet doSearch(String searchStr)
    {
        resultSet = null;
        try
        {
            search.setString(1, searchStr);
            search.setString(2, searchStr);
            resultSet = search.executeQuery();
        }
        catch (SQLException sqlException)
        {
            sqlException.printStackTrace();
            closeConnection();
        }
        return resultSet;
    }

    public static void openConnection()
    {
        try
        {
            Class.forName(DRIVER);
            //Get a connection
            connection = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
        }
        catch (Exception except)
        {
            except.printStackTrace();
        }
    }

    public static void closeConnection()
    {
        try
        {
            if (resultSet != null)
            {
                resultSet.close();
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
