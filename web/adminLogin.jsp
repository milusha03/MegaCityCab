<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="container">
        <div class="card p-4 shadow" style="max-width: 400px; margin: auto;">
            <div class="text-center mb-4">
                <div class="rounded-circle bg-warning mx-auto" style="width: 20px; height: 20px;"></div>
                <h2 class="mt-2">Mega City Cab Admin</h2>
                <p class="text-muted">Login to access the admin dashboard</p>
            </div>
            <% 
                String loginError = (String) request.getAttribute("loginError");
                if (loginError != null) {
            %>
                <div class="alert alert-danger" role="alert">
                    <%= loginError %>
                </div>
            <% 
                }
            %>
            <form action="AdminLoginServlet" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                        </div>
                        <input type="text" name="username" id="username" class="form-control" placeholder="Enter your username" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        </div>
                        <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-warning btn-block">Login</button>
            </form>
            <div class="text-center mt-3">
                <small class="text-muted">&copy; 2023 Cab Service Admin System. All rights reserved.</small>
            </div>
        </div>
    </div>
    <script src="https://kit.fontawesome.com/your-font-awesome-kit.js" crossorigin="anonymous"></script>
</body>
</html>