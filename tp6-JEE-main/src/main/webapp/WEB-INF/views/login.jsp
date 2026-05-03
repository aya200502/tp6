<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - TP5 Spring MVC</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }
        .login-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        .login-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .login-btn:hover {
            transform: translateY(-2px);
        }
        .error-message {
            color: #d32f2f;
            background-color: #ffebee;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        .demo-credentials {
            background-color: #e3f2fd;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
            font-size: 14px;
            color: #333;
        }
        .demo-credentials h4 {
            margin: 0 0 10px 0;
            color: #1976d2;
        }
        .demo-credentials p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>🔐 Login</h2>
    
    <% String erreur = (String) request.getAttribute("erreur");
        if (erreur != null) { %>
        <div class="error-message"><%= erreur %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/login" method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <label for="login">Login:</label>
            <input type="text" id="login" name="login" required placeholder="Enter your login">
        </div>

        <div class="form-group">
            <label for="password">Mot de passe:</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password">
        </div>

        <button type="submit" class="login-btn">Se connecter</button>
    </form>

    <div class="demo-credentials">
        <h4>Demo Credentials:</h4>
        <p><strong>Admin:</strong> jalal / 1234</p>
        <p><strong>User:</strong> test / 1234</p>
    </div>
</div>

<script>
    function validateForm() {
        const login = document.getElementById('login').value.trim();
        const password = document.getElementById('password').value.trim();
        
        if (!login || !password) {
            alert('Please fill in all fields');
            return false;
        }
        return true;
    }

    // Auto-fill for testing
    document.addEventListener('DOMContentLoaded', function() {
        // Uncomment to auto-fill for testing
        // document.getElementById('login').value = 'jalal';
        // document.getElementById('password').value = '1234';
    });
</script>
</body>
</html>
