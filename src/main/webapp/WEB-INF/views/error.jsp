<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .error-container {
            background: white;
            border-radius: 10px;
            padding: 50px 40px;
            text-align: center;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            max-width: 500px;
        }

        .error-code {
            font-size: 72px;
            font-weight: bold;
            color: #f5576c;
            margin-bottom: 20px;
        }

        h1 {
            color: #333;
            margin-bottom: 15px;
            font-size: 28px;
        }

        .error-message {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
            font-size: 16px;
        }

        .back-link {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 30px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: transform 0.3s;
        }

        .back-link:hover {
            transform: translateY(-2px);
        }

        .emoji {
            font-size: 60px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="emoji">⚠️</div>
    <div class="error-code">${pageContext.response.status}</div>
    <h1>Erreur</h1>
    <p class="error-message">
        <% if (pageContext.getResponse().getStatus() == 404) { %>
            La page que vous recherchez n'existe pas.
        <% } else if (pageContext.getResponse().getStatus() == 500) { %>
            Une erreur serveur s'est produite. Veuillez réessayer plus tard.
        <% } else { %>
            Une erreur s'est produite. Veuillez réessayer.
        <% } %>
    </p>
    <a href="${pageContext.request.contextPath}/" class="back-link">← Retour à l'accueil</a>
</div>
</body>
</html>
