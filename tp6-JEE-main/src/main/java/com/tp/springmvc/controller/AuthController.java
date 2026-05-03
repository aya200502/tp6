package com.tp.springmvc.controller;

import com.tp.springmvc.entity.User;
import com.tp.springmvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Controller
@RequestMapping("/")
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("")
    public String index() {
        return "redirect:/login";
    }

    @GetMapping("login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("login")
    public String login(@RequestParam String login,
            @RequestParam String password,
            HttpSession session,
            Model model) {
        Optional<User> user = userService.findByLoginAndPassword(login, password);

        if (user.isPresent()) {
            session.setAttribute("user", user.get());
            return "redirect:/produits";
        } else {
            model.addAttribute("erreur", "Login ou mot de passe invalide");
            return "login";
        }
    }

    @GetMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("error")
    public String error() {
        return "error";
    }
}
