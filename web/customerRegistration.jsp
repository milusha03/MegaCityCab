<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f4f7f9;
        }

        .registration-container {
            width: 400px;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .logo-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo {
            background-color: #3f51b5;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto;
        }

        .logo i {
            color: white;
            font-size: 24px;
        }

        h2 {
            text-align: center;
            margin-bottom: 5px;
            color: #333;
        }

        p {
            text-align: center;
            margin-bottom: 20px;
            color: #666;
        }

        .input-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .input-field {
            position: relative;
        }

        .input-field i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: calc(100% - 30px);
            padding: 10px 10px 10px 30px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #3f51b5;
        }

        .btn-primary {
            background-color: #3f51b5;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #283593;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
            color: #666;
        }

        .login-link a {
            color: #3f51b5;
            text-decoration: none;
        }

        .copyright {
            text-align: center;
            margin-top: 20px;
            color: #999;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <div class="logo-container">
            <div class="logo">
                <i class="fas fa-car"></i>
            </div>
        </div>
        <h2>Create an Account</h2>
        <p>Sign up to start booking rides</p>
        <form action="CustomerServlet" method="post">
            <div class="input-group">
                <label for="fullName">Full Name</label>
                <div class="input-field">
                    <i class="fas fa-user"></i>
                    <input type="text" name="fullName" id="fullName" placeholder="Enter your full name" required>
                </div>
            </div>
            <div class="input-group">
                <label for="address">Address</label>
                <div class="input-field">
                    <i class="fas fa-map-marker-alt"></i>
                    <input type="text" name="address" id="address" placeholder="Enter your address" required>
                </div>
            </div>
            <div class="input-group">
                <label for="nic">NIC</label>
                <div class="input-field">
                    <i class="fas fa-id-card"></i>
                    <input type="text" name="nic" id="nic" placeholder="Enter your NIC" required>
                </div>
            </div>
            <div class="input-group">
                <label for="phone">Phone Number</label>
                <div class="input-field">
                    <i class="fas fa-phone"></i>
                    <input type="text" name="phone" id="phone" placeholder="Enter your phone number" required>
                </div>
            </div>
            <div class="input-group">
                <label for="email">Email</label>
                <div class="input-field">
                    <i class="fas fa-envelope"></i>
                    <input type="email" name="email" id="email" placeholder="Enter your email" required>
                </div>
            </div>
            <div class="input-group">
                <label for="username">Username</label>
                <div class="input-field">
                    <i class="fas fa-user"></i>
                    <input type="text" name="username" id="username" placeholder="Enter your username" required>
                </div>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <div class="input-field">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" id="password" placeholder="Enter your password" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Register</button>
        </form>
        <p class="login-link">Already have an account? <a href="login.jsp">Sign in</a></p>
        <p class="copyright">&copy; 2023 Cab Service. All rights reserved.</p>
    </div>
</body>
</html>