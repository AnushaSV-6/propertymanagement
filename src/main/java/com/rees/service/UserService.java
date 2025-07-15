package com.rees.service;

import com.rees.dao.UserDAO;
import com.rees.model.User;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Timestamp;
import java.util.Random;

@Service

public class UserService {

	@Autowired
	private UserDAO userDAO;
	@Autowired
	private EmailService emailService;

	// LOGIN: Validate using BCrypt
	public User findByEmailAndPassword(String email, String rawPassword) {
		User user = userDAO.findByEmail(email);
		if (user != null && BCrypt.checkpw(rawPassword, user.getPassword())) {
			return user;
		}
		return null;
	}

	public boolean checkPassword(String rawPassword, String hashedPassword) {
		return BCrypt.checkpw(rawPassword, hashedPassword);
	}

	public User findByEmail(String email) {
		return userDAO.findByEmail(email);
	}

	public String resetPassword(String email) {
		User user = userDAO.findByEmail(email);
		if (user == null) {
			return "No account found with this email.";
		}

		String newRawPassword = generateRandomPassword();
		String newEncryptedPassword = BCrypt.hashpw(newRawPassword, BCrypt.gensalt());

		userDAO.updatePassword(user.getUserId(), newEncryptedPassword);
		boolean emailSent = emailService.sendResetEmail(user.getName(), email, newRawPassword);

		// Return success or failure message based on email sent status
		if (emailSent) {
			return "New Password has been sent to your registered email.";
		} else {
			return "Error sending email. Please try again later.";
		}
	}

	public String registerUser(String name, String email, String phone) {
		// Check if user already exists with email or phone
		if (userDAO.existsByEmail(email)) {
			return "User already exists with this email.";
		}
		if (userDAO.existsByPhone(phone)) {
			return "Phone number already registered.";
		}

		String userId = generateUserId();
		String rawPassword = generateRandomPassword();
		String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());

		// 3. Create user object and save
		User user = new User();
		user.setUserId(userId);
		user.setName(name);
		user.setEmail(email);
		user.setPhone(phone);
		user.setPassword(hashedPassword);
		user.setCreatedAt(new Timestamp(System.currentTimeMillis()));
		if (user.getRole() == null) {
			user.setRole(User.Role.ADMIN); // Or any default
		}
		if (user.getStatus() == null) {
			user.setStatus(User.Status.ACTIVE);
		}

		// Save the user to the database
		userDAO.save(user);

		// Send the welcome email with the temporary password
		boolean emailSent = emailService.sendWelcomeEmail(name, email, rawPassword);

		// Return success or failure message based on email sent status
		if (emailSent) {
			return "Password has been sent to your registered email.";
		} else {
			return "Error sending email. Please try again later.";
		}
	}

	private String generateUserId() {
		int random = new Random().nextInt(9000) + 1000;
		return "CU" + random;
	}

	private String generateRandomPassword() {
		String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		StringBuilder sb = new StringBuilder();
		Random rand = new Random();
		for (int i = 0; i < 8; i++) {
			sb.append(chars.charAt(rand.nextInt(chars.length())));
		}
		return sb.toString();
	}

}
