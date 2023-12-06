#To generate the rootCA.crt and rootCA.key files, you need to follow a series of steps to create your own Certificate Authority (CA). Here's a step-by-step guide:

openssl req -x509 -sha256 -days 3560 -nodes -newkey rsa:2048 -subj "/CN=ROOT-CA/C=US/ST=Minnesota/L=Bloomington/O=TEST-CA/OU=CERTS" -keyout rootCA.key -out rootCA.crt 

#Generate Root Key (intermediateCA.key.key)
#Use the following OpenSSL command to generate a private key for your root CA. You will be prompted to enter a passphrase.

openssl genrsa -out intermediateCA.key 2048

#create the following config file (intermediateCA_csr.conf )
 
[ req ]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C = US
ST = Minneosta
L = Bloomington
O = TEST-CA
OU = CERTS
CN = INTERMEDIATE-CA

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = INTERMEDIATE-CA

#create Certificate Signing Request(csr). It is a message sent from an applicant (an entity that is requesting a digital certificate) 
#to a Certificate Authority (CA) to apply for a digital identity certificate.

openssl req -new -key intermediateCA.key -out intermediateCA.csr -config intermediateCA_csr.conf

#create the following config file (intermediateCA_cert.conf  )

authorityKeyIdentifier=keyid,issuer
basicConstraints=critical,CA:TRUE
keyUsage = critical, digitalSignature, cRLSign, keyCertSign
subjectAltName = @alt_names

[alt_names]
DNS.1 = INTERMEDIATE-CA


#create intermidiate certificate (intermediateCA.crt)
 openssl x509 -req -in intermediateCA.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out intermediateCA.crt -days 3649 -sha256 -extfile intermediateCA_cert.conf   




#You should have a rootCA.key, rootCA.crt"
#intermediateCA.key and intermediateCA.crt."
#These certs are ONLY for testing and signing "
#other test certs and should NOT be used"
#in a production environment."

