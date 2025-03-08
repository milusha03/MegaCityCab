<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    
    <style>
        body {
    background-color: #f8f9fa;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
}

.login-container {
    background-color: white;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    width: 350px;
    text-align: center;
}

.logo-container {
    background-color: #3f51b5; /* Blue background for logo */
    width: 80px;
    height: 80px;
    border-radius: 50%;
    margin: 0 auto 20px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.logo {
    color: white;
    font-size: 30px;
}

.input-group {
    margin-bottom: 20px;
    text-align: left;
}

.input-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: 600;
}

.input-field {
    display: flex;
    align-items: center;
    border: 1px solid #ced4da;
    border-radius: 5px;
    padding: 8px;
}

.input-field i {
    margin-right: 10px;
    color: #6c757d;
}

.input-field input {
    border: none;
    outline: none;
    flex-grow: 1;
}

.btn-primary {
    background-color: #3f51b5; /* Blue button */
    border-color: #3f51b5;
    width: 100%;
    padding: 10px;
    border-radius: 5px;
}

.btn-primary:hover {
    background-color: #303f9f;
    border-color: #303f9f;
}

.signup-link {
    margin-top: 20px;
}

.copyright {
    margin-top: 20px;
    font-size: 12px;
    color: #6c757d;
}
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo-container">
            <div class="logo">
                <i class="fas fa-car"></i>
            </div>
        </div>
        <h2>Welcome Back</h2>
        <p>Sign in to book your next ride</p>
        <form action="CustomerLoginServlet" method="post">
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
            <button type="submit" class="btn btn-primary btn-block">Sign In</button>
        </form>
        <p class="signup-link">Don't have an account? <a href="customerRegistration.jsp">Sign up now</a></p>
        <p class="copyright">&copy; 2023 Cab Service. All rights reserved.</p>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>