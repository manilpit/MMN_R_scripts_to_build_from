# Load the mailR library
library(mailR)

# Set up email details
sender <- "your_email@example.com"            # Replace with your email address
recipients <- c("recipient1@example.com", "recipient2@example.com")  # Replace with recipient email addresses
subject <- "Automated Email from R"
body <- "This is a test email sent from R using the mailR package. This email demonstrates how to send emails programmatically."

# SMTP settings
smtp <- list(
  host.name = "smtp.example.com",  # Replace with your SMTP server address
  port = 465,                      # Replace with the SMTP port (usually 465 for SSL)
  user.name = "your_email@example.com",  # Your email address
  passwd = "your_password",        # Your email password (consider using environment variables for security)
  ssl = TRUE
)

# Send email
send.mail(
  from = sender,
  to = recipients,
  subject = subject,
  body = body,
  smtp = smtp,
  authenticate = TRUE,
  send = TRUE,
  debug = TRUE  # Set to TRUE for detailed output, FALSE to suppress
)

print("Email has been sent successfully.")
