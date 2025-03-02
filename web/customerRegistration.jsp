<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Registration</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="css/style.css">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .registration-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .form-control {
            margin-bottom: 15px;
        }
        .btn-custom {
            width: 100%;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="registration-container">
            <h2 class="text-center">Customer Registration</h2>

            <form action="CustomerServlet" method="post">
                <div class="mb-3">
                    <label class="form-label">Full Name:</label>
                    <input type="text" class="form-control" name="fullName" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Address:</label>
                    <input type="text" class="form-control" name="address" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">NIC:</label>
                    <input type="text" class="form-control" name="nic" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Phone Number:</label>
                    <input type="text" class="form-control" name="phone" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email:</label>
                    <input type="email" class="form-control" name="email" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Username:</label>
                    <input type="text" class="form-control" name="username" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password:</label>
                    <input type="password" class="form-control" name="password" required>
                </div>

                <button type="submit" class="btn btn-primary btn-custom">Register</button>
            </form>

            <div class="text-center mt-3">
                <p>Already have an account? <a href="login.jsp" class="btn btn-link">Login</a></p>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (Optional, for interactive features) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
