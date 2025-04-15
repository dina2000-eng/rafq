/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();

// إعداد nodemailer
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "your-email@gmail.com", // بريدك الإلكتروني
    pass: "your-app-password", // كلمة المرور (أو App Password)
  },
});

// Cloud Function لتشغيلها بعد التسجيل
exports.sendWelcomeEmail = functions.auth.user().onCreate((user) => {
  const email = user.email;
  const displayName = user.displayName || "عزيزنا المستخدم";

  const mailOptions = {
    from: "Your App Name <your-email@gmail.com>",
    to: email,
    subject: "مرحبًا بك في تطبيق رفق!",
    text: `مرحبًا ${displayName}!

شكرًا لانضمامك إلى تطبيق رفق. نأمل أن نقدم لك تجربة رائعة ومفيدة.

تحياتنا،
فريق رفق 🌿`,
  };

  return transporter.sendMail(mailOptions)
      .then(() => console.log("Email sent to:", email))
      .catch((error) => console.error("Error sending email:", error));
});
