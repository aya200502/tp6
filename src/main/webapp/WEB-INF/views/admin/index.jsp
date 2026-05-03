<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Produits - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
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
            max-width: 1200px;
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

        .form-section {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .form-section h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }

        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            font-family: Arial, sans-serif;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 15px;
        }

        .form-row .form-group {
            margin-bottom: 0;
        }

        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn {
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
        }

        .btn-primary {
            background: #667eea;
            color: white;
        }

        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #757575;
            color: white;
        }

        .btn-secondary:hover {
            background: #616161;
        }

        .search-section {
            margin-bottom: 30px;
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

        .action-links {
            display: flex;
            gap: 10px;
        }

        .action-links a {
            padding: 8px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
            transition: all 0.3s;
        }

        .action-links a.edit {
            background: #4caf50;
            color: white;
        }

        .action-links a.edit:hover {
            background: #45a049;
        }

        .action-links a.delete {
            background: #d32f2f;
            color: white;
        }

        .action-links a.delete:hover {
            background: #c62828;
        }

        .no-data {
            text-align: center;
            padding: 30px;
            color: #999;
            font-size: 16px;
        }

        .price-column {
            font-weight: bold;
            color: #667eea;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }

            .header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .user-info {
                width: 100%;
                justify-content: space-between;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>📦 Gestion des Produits</h1>
        <div class="user-info">
            <span>👤 Bienvenue, <strong>${sessionScope.user.login}</strong></span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Déconnexion</a>
        </div>
    </div>

    <div class="form-section">
        <h2>➕ ${empty produit.idProduit ? 'Ajouter un Produit' : 'Modifier le Produit'}</h2>
        <form action="${empty produit.idProduit ? pageContext.request.contextPath.concat('/produits/ajouter') : pageContext.request.contextPath.concat('/produits/modifier')}" method="post" onsubmit="return validateProductForm()">
            <input type="hidden" name="idProduit" value="${produit.idProduit}" />
            
            <div class="form-row">
                <div class="form-group">
                    <label for="nom">Nom du Produit: *</label>
                    <input type="text" id="nom" name="nom" value="${produit.nom}" required placeholder="Ex: Laptop">
                </div>
                <div class="form-group">
                    <label for="prix">Prix (€): *</label>
                    <input type="number" id="prix" name="prix" value="${produit.prix}" step="0.01" required placeholder="Ex: 99.99">
                </div>
                <div class="form-group">
                    <label>&nbsp;</label>
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">${empty produit.idProduit ? '✓ Ajouter' : '✏️ Modifier'}</button>
                        <% if (request.getAttribute("produit") != null) { %>
                            <a href="${pageContext.request.contextPath}/produits" class="btn btn-secondary">✕ Annuler</a>
                        <% } %>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" placeholder="Décrivez le produit...">${produit.description}</textarea>
            </div>
        </form>
    </div>

    <div class="search-section">
        <h2>🔍 Rechercher un Produit</h2>
        <form action="${pageContext.request.contextPath}/produits" method="get">
            <input type="text" name="id" placeholder="Entrez l'ID du produit...">
            <button type="submit">Rechercher</button>
        </form>
    </div>

    <h2>📋 Liste des Produits</h2>
    <c:if test="${empty listeProduits}">
        <div class="no-data">
            ℹ️ Aucun produit disponible. <a href="${pageContext.request.contextPath}/produits/ajouter">Ajouter un produit</a>
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
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${listeProduits}">
                    <tr>
                        <td>${p.idProduit}</td>
                        <td>${p.nom}</td>
                        <td>${p.description}</td>
                        <td class="price-column">€${p.prix}</td>
                        <td>
                            <div class="action-links">
                                <a href="${pageContext.request.contextPath}/produits/editer/${p.idProduit}" class="edit">✏️ Modifier</a>
                                <a href="${pageContext.request.contextPath}/produits/supprimer/${p.idProduit}" class="delete" onclick="return confirm('Voulez-vous vraiment supprimer ce produit ?');">🗑️ Supprimer</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

<script>
    function validateProductForm() {
        const nom = document.getElementById('nom').value.trim();
        const prix = parseFloat(document.getElementById('prix').value);
        
        if (!nom) {
            alert('Veuillez entrer le nom du produit');
            return false;
        }
        if (!prix || prix <= 0) {
            alert('Veuillez entrer un prix valide');
            return false;
        }
        return true;
    }

    // Add click event for delete confirmation with better UX
    document.querySelectorAll('.action-links a.delete').forEach(link => {
        link.addEventListener('click', function(e) {
            if (!confirm('Êtes-vous sûr de vouloir supprimer ce produit ?\nCette action est irréversible.')) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>
