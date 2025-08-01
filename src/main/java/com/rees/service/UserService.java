package com.rees.service;

import com.rees.dto.UserDTO;
import com.rees.mapper.UserMapper;
import com.rees.model.User;
import com.rees.repository.UserRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Optional;
import java.util.Random;

@Service
public class UserService {

	@Autowired
	private PasswordService passwordService;

	
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private EmailService emailService;

    public String registerUser(UserDTO userDTO) {
        if (userRepository.existsByEmail(userDTO.getEmail())) {
            return "Email already exists.";
        }

        if (userRepository.existsByPhone(userDTO.getPhone())) {
            return "Phone number already exists.";
        }

        String userId = generateUserId();
        String rawPassword = passwordService.generateRandomPassword();
        String encryptedPassword = passwordService.encryptPassword(rawPassword);

        User user = userMapper.toEntity(userDTO);
        user.setUserId(userId);
        user.setPassword(encryptedPassword);
        user.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        userRepository.save(user);

        boolean emailSent = emailService.sendWelcomeEmail(user.getName(), user.getEmail(), rawPassword);

        if (emailSent) {
            return "Password has been sent to your registered email.";
        } else {
            return "Error sending email. Please try again later.";
        }
    }

    public Optional<UserDTO> authenticateUser(String email, String rawPassword) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        return userOpt
                .filter(user -> passwordService.matchPassword(rawPassword, user.getPassword()))
                .map(userMapper::toDTO);
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public boolean existsByPhone(String phone) {
        return userRepository.existsByPhone(phone);
    }

    public Optional<UserDTO> findByEmail(String email) {
        return userRepository.findByEmail(email).map(userMapper::toDTO);
    }

    public String resetPassword(String email) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isEmpty()) {
            return "No user found with this email.";
        }

        User user = userOpt.get();
        String newPassword = passwordService.generateRandomPassword();
        String encryptedPassword = passwordService.encryptPassword(newPassword);
        user.setPassword(encryptedPassword);
        userRepository.save(user);

        boolean emailSent = emailService.sendResetEmail(user.getName(), user.getEmail(), newPassword);

        if (emailSent) {
            return "New Password has been sent to your registered email.";
        } else {
            return "Error sending email. Please try again.";
        }
    }

    private String generateUserId() {
        int random = new Random().nextInt(9000) + 1000;
        return "CU" + random;
    }
}