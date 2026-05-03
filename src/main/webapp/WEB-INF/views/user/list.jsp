<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Produits</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #667eea;
            padding-bottom: 15px;
        }

        .header h1 {
            color: #333;
            font-size: 28px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-info span {
            color: #666;
            font-weight: 500;
        }

        .logout-btn {
            background: #d32f2f;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background: #c62828;
        }

        .search-section {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .search-section h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
        }

        .search-section form {
            display: flex;
            gap: 10px;
        }

        .search-section input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .search-section button {
            padding: 10px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s;
        }

        .search-section button:hover {
            background: #5568d3;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 22px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #667eea;
            color: white;
            font-weight: bold;
        }

        tr:hover {
            background: #f5f5f5;
        }

        .price-column {
            font-weight: bold;
            color: #667eea;
            font-size: 16px;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
            font-size: 16px;
        }

        .product-card {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .card {
            background: #f9f9f9;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            transition: all 0.3s;
            display: flex;
            flex-direction: column;
        }

        .card:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transform: translateY(-5px);
        }

        .card-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .card-desc {
            color: #666;
            font-size: 14px;
            margin-bottom: 15px;
            flex-grow: 1;
        }

        .card-price {
            font-size: 20px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 10px;
        }

        .card-id {
            color: #999;
            font-size: 12px;
        }

        .view-toggle {
            margin-bottom: 15px;
            display: flex;
            gap: 10px;
        }

        .view-toggle button {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
            background: #e0e0e0;
            color: #333;
        }

        .view-toggle button.active {
            background: #667eea;
            color: white;
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .user-info {
                width: 100%;
                justify-content: space-between;
            }

            .search-section form {
                flex-direction: column;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 8px;
            }

            .product-card {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>📦 Liste des Produits</h1>
        <div class="user-info">
            <span>👤 ${user.login}</span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Déconnexion</a>
        </div>
    </div>

    <div class="search-section">
        <h2>🔍 Rechercher un Produit</h2>
        <form action="${pageContext.request.contextPath}/produits" method="get">
            <input type="text" name="id" placeholder="Entrez l'ID du produit...">
            <button type="submit">Rechercher</button>
        </form>
    </div>

    <h2>📋 Tous les Produits</h2>
    <c:if test="${empty listeProduits}">
        <div class="no-data">
            ℹ️ Aucun produit disponible pour le moment.
        </div>
    </c:if>

    <c:if test="${not empty listeProduits}">
        <table>
            <thead>
                <tr>
                    <th>#ID</th>
                    <th>Nom</th>
                    <th>Description</th>
                    <th>Prix</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${listeProduits}">
                    <tr>
                        <td>${p.idProduit}</td>
                        <td>${p.nom}</td>
                        <td>${p.description}</td>
                        <td class="price-column">€${p.prix}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // You can add any dynamic JavaScript functionality here
        console.log('User list page loaded successfully');
    });
</script>
</body>
</html>
