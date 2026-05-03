package com.tp.springmvc.controller;

import com.tp.springmvc.entity.Produit;
import com.tp.springmvc.entity.User;
import com.tp.springmvc.service.ProduitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/produits")
public class ProduitApiController {

    @Autowired
    private ProduitService produitService;

    @GetMapping("")
    public ResponseEntity<?> getAllProduits(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return ResponseEntity.status(401).body("Unauthorized");
        }
        return ResponseEntity.ok(produitService.getAllProduits());
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getProduit(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return ResponseEntity.status(401).body("Unauthorized");
        }
        Optional<Produit> produit = produitService.getProduitById(id);
        return produit.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping("")
    public ResponseEntity<?> createProduit(@RequestBody Produit produit, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            return ResponseEntity.status(403).body("Forbidden");
        }
        produitService.addProduit(produit);
        return ResponseEntity.ok(produit);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateProduit(@PathVariable Long id,
            @RequestBody Produit produitDetails,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            return ResponseEntity.status(403).body("Forbidden");
        }

        Optional<Produit> existingProduit = produitService.getProduitById(id);
        if (existingProduit.isPresent()) {
            Produit produit = existingProduit.get();
            produit.setNom(produitDetails.getNom());
            produit.setDescription(produitDetails.getDescription());
            produit.setPrix(produitDetails.getPrix());
            produitService.updateProduit(produit);
            return ResponseEntity.ok(produit);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteProduit(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            return ResponseEntity.status(403).body("Forbidden");
        }
        produitService.deleteProduit(id);
        return ResponseEntity.ok("Produit deleted successfully");
    }
}
