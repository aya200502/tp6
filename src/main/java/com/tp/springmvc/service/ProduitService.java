package com.tp.springmvc.service;

import com.tp.springmvc.entity.Produit;
import java.util.List;
import java.util.Optional;

public interface ProduitService {
    void addProduit(Produit p);

    void deleteProduit(Long id);

    void updateProduit(Produit p);

    List<Produit> getAllProduits();

    Optional<Produit> getProduitById(Long id);
}
