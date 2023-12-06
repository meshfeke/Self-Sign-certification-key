# Self-Sign-certification-key
# Make your own CA and Certificates for testing
NOT TO BE USED IN PRODUCTION ENVIRONMENTS - test environments only.

This repo contains 2 shell scripts to:
- Create a root and intermediate certificate authority
- Create a server certificate signed by the intermediate authority that has both TLS Web Server Authentication, TLS Web Client Authentication extended attributes.

# Requirements
- A linux like environment that can run bash shell scripts
- openssl must be installed and available

# Usage
- Clone or download the scripts into the same directory on your system.
- Run create_root_and_intermediate_certs.sh to create the root and intermediate CAs. (You only have to do this ONCE - you can create multiple server certs and keys from the same root and intermediate CA.
- Second, run create_server_key_and_certificate.sh [hostname] [ip address] for the server/ip you want to create a certificate for. (Create as many separate server certs that you need.)

# Output
- rootCA.crt, rootCA.key
- intermediateCA.crt, intermediateCA.key
- [server].crt, [server].key
- as well as a bunch of .conf, .csr files...

  The crt files will be in PEM format.
  The key files will be in unencrypted PKCS8.  
  
# To Do
- I may add more options later to create in PKCS12/PFX/DER
- I may add more options later to create keys in PKCS1 encrypted/unencrypted

# Root certificates and intermediate CA certificates play crucial roles in the structure of a Public Key Infrastructure (PKI) and the validation of server certificates. Here's an overview of their purposes:

# Root Certificate:

- Authority: The root certificate represents the highest level of trust in a PKI. It is self-signed and forms the foundation of the certificate hierarchy.
- Trust Anchor: It is the starting point for trust in the entire PKI. The root certificate is pre-installed in web browsers and other client applications, establishing trust without requiring external verification.
- Issuance of Intermediate CAs: The root CA may issue intermediate CA certificates. These intermediate CAs inherit the trust of the root but can be used to issue end-entity (server or client) certificates.
  
# Intermediate CA Certificate:

- Chain of Trust: Intermediate CAs are used to create a hierarchical structure in a PKI. They are signed by a higher-level CA, either a root CA or another intermediate CA.
- Enhanced Security: By using intermediate CAs, security can be enhanced. The compromise of an intermediate CA does not directly compromise the root CA or other branches of the hierarchy.
- Flexible Certificate Management: Intermediate CAs can be used to manage and issue certificates for specific purposes or departments within an organization.
How They Work Together for Server Certificates:

# Server Certificate Issuance:

- Intermediate CA Issuance: The root CA issues an intermediate CA certificate.
- Server CSR Submission: The server generates a Certificate Signing Request (CSR) and submits it to the intermediate CA.
- Intermediate CA Signing: The intermediate CA signs the server CSR, creating a server certificate.
- Chain Formation: The server certificate, along with the intermediate CA certificate, forms a chain of trust back to the root CA.
  
# Verification Process:

When a client connects to a server, it receives the server certificate during the SSL/TLS handshake.
The client verifies the server certificate by checking its signature against the public key in the intermediate CA certificate.
The intermediate CA certificate is, in turn, verified against the root CA certificate, which is trusted because it is pre-installed in the client's trust store.
