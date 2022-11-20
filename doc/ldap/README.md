1. install ldap
```
sudo apt install slapd ldap-utils -y
```
configure password with `admin`

2. configure ldap
```
sudo dpkg-reconfigure slapd
```
configure Domain with `shin.ps.confluent.io`, organisation with `confluent`

3. ensure the port 389 is accessible for the ldap server

4. login with
```
bastion-0.shin.ps.confluent.io

cn=admin,dc=shin,dc=ps,dc=confluent,dc=io
```
with password `admin`

5. copy ldap users to ldap server `bastion-0.shin.ps.confluent.io` from `terraform/resources/ldap-users`
```
scp -rp resources/ldap-users bastion-0.shin.ps.confluent.io:.
```

6. execute the following command to add these users in the ldap server
```
ldapadd -x -D "cn=admin,dc=shin,dc=ps,dc=confluent,dc=io" -w admin -f ldap-users/01-base.ldif
ldapadd -x -D "cn=admin,dc=shin,dc=ps,dc=confluent,dc=io" -w admin -f ldap-users/02-users.ldif
```
