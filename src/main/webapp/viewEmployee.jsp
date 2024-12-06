<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.models.Employee" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Employees</title>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    table, th, td {
        border: 1px solid black;
    }
    th, td {
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>
    <h2>Employee List</h2>
    <table>
        <thead>
            <tr>
                <th>Employee ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>State</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Employee> employees = (List<Employee>) request.getAttribute("employees");
                if (employees != null) {
                    for (Employee emp : employees) {
            %>
            <tr>
                <td><%= emp.getEmployeeId() %></td>
                <td><%= emp.getUsername() %></td>
                <td><%= emp.getEmail() %></td>
                <td><%= emp.getState() %></td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="4">No employees found.</td>
            </tr>
            <% 
                }
            %>
        </tbody>
    </table>
</body>
</html>
