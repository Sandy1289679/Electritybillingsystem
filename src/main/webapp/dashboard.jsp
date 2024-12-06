<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
</head>
<body>
    <h2>Welcome, <%= session.getAttribute("username") %></h2>
    <h3>Meter Readings</h3>
    <table border="1">
        <tr>
            <th>Date</th>
            <th>Previous Reading</th>
            <th>Current Reading</th>
        </tr>
        <% 
            int userId = (int) session.getAttribute("user_id");
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "112233");
                String sql = "SELECT * FROM meter_readings WHERE user_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, userId);
                rs = pstmt.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getDate("reading_date") %></td>
            <td><%= rs.getInt("previous_reading") %></td>
            <td><%= rs.getInt("current_reading") %></td>
        </tr>
        <% 
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
    <h3>Bills</h3>
    <table border="1">
        <tr>
            <th>Billing Date</th>
            <th>Units Consumed</th>
            <th>Amount Due</th>
        </tr>
        <% 
            try {
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "112233");
                String sql = "SELECT * FROM bills WHERE user_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, userId);
                rs = pstmt.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getDate("billing_date") %></td>
            <td><%= rs.getInt("units_consumed") %></td>
            <td><%= rs.getBigDecimal("amount_due") %></td>
        </tr>
        <% 
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
</body>
</html>
