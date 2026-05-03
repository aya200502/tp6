package com.tp.springmvc.controller;

import com.tp.springmvc.entity.Produit;
import com.tp.springmvc.entity.User;
import com.tp.springmvc.service.ProduitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/produits")
public class ProduitController {

    @Autowired
    private ProduitService produitService;

    private User getUser(HttpSession session) {
        return (User) session.getAttribute("user");
    }

    @GetMapping("")
    public String listProduits(@RequestParam(required = false) Long id,
            HttpSession session,
            Model model) {
        User user = getUser(session);
        if (user == null) {
            return "redirect:/login";
        }

        List<Produit> produits;
        if (id != null) {
            Optional<Produit> produit = produitService.getProduitById(id);
            produits = produit.map(List::of).orElseGet(List::of);
        } else {
            produits = produitService.getAllProduits();
        }

        model.addAttribute("listeProduits", produits);
        model.addAttribute("user", user);
        model.addAttribute("produit", new Produit());

        if ("admin".equals(user.getRole())) {
            return "admin/index";
        } else {
            return "user/list";
        }
    }

    @GetMapping("ajouter")
    public String showAddForm(HttpSession session, Model model) {
        User user = getUser(session);
        if (user == null || !"admin".equals(user.getRole())) {
            return "redirect:/login";
        }

        model.addAttribute("produit", new Produit());
        model.addAttribute("listeProduits", produitService.getAllProduits());
        return "admin/index";
    }

    @PostMapping("ajouter")
    public String addProduit(@ModelAttribute Produit produit,
            HttpSession session) {
        User user = getUser(session);
        if (user == null || !"admin".equals(user.getRole())) {
            return "redirect:/login";
        }
        produitService.addProduit(produit);
        return "redirect:/produits";
    }

    @GetMapping("editer/{id}")
    public String showEditForm(@PathVariable Long id,
            HttpSession session,
            Model model) {
        User user = getUser(session);
        if (user == null || !"admin".equals(user.getRole())) {
            return "redirect:/login";
        }

        Optional<Produit> produit = produitService.getProduitById(id);
        if (produit.isPresent()) {
            model.addAttribute("produit", produit.get());
            model.addAttribute("listeProduits", produitService.getAllProduits());
            return "admin/index";
        }
        return "redirect:/produits";
    }

    @PostMapping("modifier")
    public String updateProduit(@ModelAttribute Produit produit,
            HttpSession session) {
        User user = getUser(session);
        if (user == null || !"admin".equals(user.getRole())) {
            return "redirect:/login";
        }
        produitService.updateProduit(produit);
        return "redirect:/produits";
    }

    @GetMapping("supprimer/{id}")
    public String deleteProduit(@PathVariable Long id,
            HttpSession session) {
        User user = getUser(session);
        if (user == null || !"admin".equals(user.getRole())) {
            return "redirect:/login";
        }
        produitService.deleteProduit(id);
        return "redirect:/produits";
    }
}
