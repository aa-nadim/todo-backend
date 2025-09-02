#!/bin/bash

# Create the certificates directory
mkdir -p nginx/certs

# Generate a self-signed certificate for development/testing
# Note: For production, you should use a proper SSL certificate from a CA like Let's Encrypt

# Generate private key
openssl genrsa -out nginx/certs/server.key 2048

# Generate certificate signing request
openssl req -new -key nginx/certs/server.key -out nginx/certs/server.csr -subj "/C=US/ST=State/L=City/O=Organization/CN=75.101.250.171"

# Generate self-signed certificate
openssl x509 -req -days 365 -in nginx/certs/server.csr -signkey nginx/certs/server.key -out nginx/certs/server.crt

# Set appropriate permissions
chmod 600 nginx/certs/server.key
chmod 644 nginx/certs/server.crt

# Clean up CSR file
rm nginx/certs/server.csr

echo "SSL certificates generated successfully!"
echo "Certificate: nginx/certs/server.crt"
echo "Private Key: nginx/certs/server.key"

# Optional: View certificate details
echo ""
echo "Certificate details:"
openssl x509 -in nginx/certs/server.crt -text -noout | grep -A 2 "Subject:"