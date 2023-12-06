
#  First run the create_root_and_intermediate_certs.sh if you haven't already
#
#  Run this to create a key and cert
#  for a server with both
#  TLS Web Server Authentication, TLS Web Client Authentication extended attributes
#  signed by a test intermediate and root CA
#
#  Arguments: $1 = hostname of server to create the cert for
#             $2 = ip address of hostname to create the cert for

#create private key

openssl genrsa -out $1.key 2048


#create config file($1_csr.conf )
     
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
O = TEST-CERTS
OU = CERTS
CN = $1

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = $1
IP.1 =  $2

#create Certificate Signing Request(csr). It is a message sent from an applicant (an entity that is requesting a digital certificate) 
#to a Certificate Authority (CA) to apply for a digital identity certificate.

 openssl req -new -key $1.key -out $1.csr -config $1_csr.conf



    #Create the ff config file ($1_cert.conf)

authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth, clientAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = $1
IP.1 =  $2

#Creating certrification for our server
openssl x509 -req -in $1.csr -CA intermediateCA.crt -CAkey intermediateCA.key -CAcreateserial -out $1.crt -days 730 -sha256 -extfile $1_cert.conf




#"You should have a $1.key and $1.crt"
#"The cert is in PEM format and the key is in "
#"  PKCS8 unencrypted format."
# "These certs are ONLY for testing"
#  and should NOT be used in a production environment."

