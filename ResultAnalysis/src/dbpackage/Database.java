package dbpackage;
import java.sql.*;


public class Database {
	//Declaration
	private Connection con=null;
	private Statement st=null;
	private ResultSet rs=null;
	//Constructor

	public Database() throws Exception {
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		con=DriverManager.getConnection("jdbc:odbc:marks","admin","");
		st=con.createStatement();
	}

	//To Return ResultSet from the Table

	public ResultSet executeDBQuery(String Qry) throws Exception {
             rs=st.executeQuery(Qry);
             return rs;
	}


	//To Insert or Update the Table


	public int executeDBUpdate(String Qry) throws Exception {
             int no=st.executeUpdate(Qry);
		return no;
     }
	public void addDBBatch(String Qry) throws Exception {
        st.addBatch(Qry);
        return;
		}
	public void executeDBBatch() throws Exception {
        st.executeBatch();
        	return; 
		}

     // To Close Connection, Statememt and ResultSet

     public void closeResultSet() throws Exception {
        	rs.close();
        	st.close();
        	con.close();
     }
     public void closeConnections() throws Exception {
     	st.close();
     	con.close();
  }
    
public void DBCommit() throws SQLException
     {
    	 con.commit();
     }
     public void DBRollback() throws SQLException
     {
    	 con.rollback();
     }
     public void setDBAutoCommit(boolean value ) throws SQLException
     {
    	 con.setAutoCommit(value);
     }
}


