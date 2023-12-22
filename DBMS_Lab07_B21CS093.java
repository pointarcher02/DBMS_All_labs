import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.io.BufferedReader;
import java.io.InputStreamReader;
public class DBMS_Lab07_B21CS093 {


    private Connection connection;
    
    public DBMS_Lab07_B21CS093() {
        try {
            String jdbcUrl = "jdbc:mysql://localhost:3306/Hospital"; 
            String user = "root"; 
            String password = "Shashank@2002"; 
            
            connection = DriverManager.getConnection(jdbcUrl, user, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateAppointment() {
        try {
            String sql = "INSERT INTO APPOINTMENT VALUES (?, ?,?,?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setInt(1, 12);
            preparedStatement.setString(2, "2022-10-15");
            preparedStatement.setString(3, "08:09:23");
            preparedStatement.setInt(4, 49);

            preparedStatement.executeUpdate();

            preparedStatement.setInt(1, 13);
            preparedStatement.setString(2, "2022-10-15");
            preparedStatement.setString(3, "09:09:23");
            preparedStatement.setInt(4, 44);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateAppointmentDynamic(BufferedReader reader) {
        for(int i=0;i<3;i++){
            try {
            String sql = "INSERT INTO APPOINTMENT VALUES (?, ?,?,?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            System.out.println("Enter APPOINT_NO: ");
            int appointNo = Integer.parseInt(reader.readLine());

            System.out.println("Enter APPOINT_DATE (YYYY-MM-DD): ");
            String appointDate = reader.readLine();

            System.out.println("Enter APPOINT_TIME (HH:MM:SS): ");
            String appointtime = reader.readLine();

            System.out.println("Enter REC_ID: ");
            int recId = Integer.parseInt(reader.readLine());

            preparedStatement.setInt(1, appointNo);
            preparedStatement.setString(2, appointDate);
            preparedStatement.setString(3, appointtime);
            preparedStatement.setInt(4, recId);

            preparedStatement.executeUpdate();
            }
            catch (IOException | SQLException e) {
            e.printStackTrace();
            }
        }
        
    }

    public void updateVisitDynamic(BufferedReader reader) {
        try {
            String sql = "INSERT INTO Visit VALUES (?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            for (int i = 1; i <= 3; i++) {
                System.out.println("Entry" + i + "\n");
   
                System.out.println("Enter Visit_date (YYYY-MM-DD): ");
                String visitDateStr = reader.readLine();

                System.out.println("Enter SSN: ");
                int ssn = Integer.parseInt(reader.readLine());

                System.out.println("Enter HOSP_NAME: ");
                String hospName = reader.readLine();
                java.util.Date visitDate = null;
                try {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    visitDate = dateFormat.parse(visitDateStr);
                } catch (ParseException e) {
                    System.out.println("Invalid date format. Use YYYY-MM-DD.");
                    continue; 
                }
                preparedStatement.setDate(1, new java.sql.Date(visitDate.getTime()));
                preparedStatement.setInt(2, ssn);
                preparedStatement.setString(3, hospName);

                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Visit record added successfully.");
                } else {
                    System.out.println("Failed to add visit record.");
                }
            }
        } catch (IOException | SQLException e) {
            e.printStackTrace();
        }
    }

    public void getMediCountryFromLetter(BufferedReader reader) throws IOException {
        try {
            String sql = "SELECT * FROM MEDICINE_COUNTRY WHERE MAN_COUNTRY LIKE ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            String letter = reader.readLine();
            
            preparedStatement.setString(1, letter + "%");

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String country = resultSet.getString("MAN_COUNTRY");
                int regNo = resultSet.getInt("REG_NO");
                System.out.println("Manufactured in: " + country + ", REG_NO: " + regNo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void deleteAffiliation(BufferedReader reader) throws NumberFormatException, IOException {
        for(int i=0;i<2;i++){
            try {

            String sql = "DELETE FROM Affiliation WHERE doc_id = ?"; // Assuming you want to delete 2 records for the given Doctor_ID

            int doctorId = Integer.parseInt(reader.readLine());
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setInt(1, doctorId);

            int rowsDeleted = preparedStatement.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("Deleted " + rowsDeleted + " records from Affiliation for Doctor ID " + doctorId);
            } else {
                System.out.println("No records found for Doctor ID " + doctorId);
            }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
    }

    public void closeConnection() {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws IOException {
        DBMS_Lab07_B21CS093 databaseHandler = new DBMS_Lab07_B21CS093();
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

        //1. Update Appointment (Static)
        System.out.println("Updating Appointment (Static)...");
        databaseHandler.updateAppointment();

        // 2. Update Appointment (Dynamic)
        System.out.println("Updating Appointment (Dynamic)...");
        databaseHandler.updateAppointmentDynamic(reader);

        //3,
        System.out.println("Updating Visit dynamic...");
        databaseHandler.updateVisitDynamic(reader);

        // 4. 
        System.out.println("Getting Medicine Countries Starting with...");
        databaseHandler.getMediCountryFromLetter(reader);

        //5.
        System.out.println("Deleting entries from Affiliation Table...");
        databaseHandler.deleteAffiliation(reader);

       
        databaseHandler.closeConnection();
    }
}

    // public static void main(String[] args) throws Exception {
    //     System.out.println("Hello, World!");
    // }



