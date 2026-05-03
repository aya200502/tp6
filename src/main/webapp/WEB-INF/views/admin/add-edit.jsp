<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty produit.idProduit ? 'Ajouter' : 'Modifier'} un Produit</title>
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
            max-width: 700px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        }

        .header {
            margin-bottom: 30px;
            border-bottom: 2px solid #667eea;
            padding-bottom: 15px;
        }

        .header h1 {
            color: #333;
            font-size: 28px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            font-size: 15px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            font-family: Arial, sans-serif;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.2);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .required {
            color: #d32f2f;
        }

        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
            transition: all 0.3s;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
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

        .info-box {
            background: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            color: #1565c0;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>${empty produit.idProduit ? '➕ Ajouter un Produit' : '✏️ Modifier le Produit'}</h1>
    </div>

    <div class="info-box">
        Les champs marqués avec <span class="required">*</span> sont obligatoires.
    </div>

    <form action="${pageContext.request.contextPath}/produits/${empty produit.idProduit ? 'ajouter' : 'modifier'}" method="post" onsubmit="return validateForm()">
        <c:if test="${not empty produit.idProduit}">
            <input type="hidden" name="idProduit" value="${produit.idProduit}">
        </c:if>

        <div class="form-group">
            <label for="nom">Nom du Produit <span class="required">*</span></label>
            <input type="text" id="nom" name="nom" value="${produit.nom}" placeholder="Ex: Laptop Dell" required>
        </div>

        <div class="form-group">
            <label for="prix">Prix (€) <span class="required">*</span></label>
            <input type="number" id="prix" name="prix" value="${produit.prix}" placeholder="Ex: 999.99" step="0.01" min="0" required>
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description" placeholder="Décrivez le produit en détail...">${produit.description}</textarea>
        </div>

        <div class="btn-group">
            <button type="submit" class="btn btn-primary">
                <span>${empty produit.idProduit ? '✓ Ajouter' : '✏️ Modifier'}</span>
            </button>
            <a href="${pageContext.request.contextPath}/produits" class="btn btn-secondary">
                <span>← Retour</span>
            </a>
        </div>
    </form>
</div>

<script>
    function validateForm() {
        const nom = document.getElementById('nom').value.trim();
        const prix = parseFloat(document.getElementById('prix').value);
        
        if (!nom) {
            alert('Veuillez entrer le nom du produit');
            document.getElementById('nom').focus();
            return false;
        }
        
        if (!prix || prix <= 0 || isNaN(prix)) {
            alert('Veuillez entrer un prix valide et positif');
            document.getElementById('prix').focus();
            return false;
        }
        
        if (nom.length < 2) {
            alert('Le nom doit contenir au moins 2 caractères');
            document.getElementById('nom').focus();
            return false;
        }
        
        return true;
    }

    // Auto-focus on nom field
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('nom').focus();
    });
</script>
</body>
</html>
