<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Bill</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f4f4f9;
    }
    form {
        background-color: #fff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
    }
    input[type="text"], input[type="number"], input[type="date"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    input[type="submit"] {
        background-color: #007bff;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #0056b3;
    }
    .message {
        margin-bottom: 20px;
        padding: 10px;
        border-radius: 4px;
        color: #fff;
    }
    .success {
        background-color: #4CAF50;
    }
    .error {
        background-color: #f44336;
    }
</style>
</head>
<body>
    <h2>Add Bill</h2>

    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
            String messageClass = message.contains("successfully") ? "success" : "error";
    %>
        <div class="message <%= messageClass %>"><%= message %></div>
    <%
        }
    %>

    <form action="AddBillServlet" method="post">
        <label for="meter_number">Meter Number:</label>
        <input type="text" id="meter_number" name="meter_number" required>

        <label for="units_consumed">Units Consumed:</label>
        <input type="number" id="units_consumed" name="units_consumed" required>

        <label for="reading_date">Reading Date:</label>
        <input type="date" id="reading_date" name="reading_date" required>

        <input type="submit" value="Add Bill">
    </form>
</body>
</html>
