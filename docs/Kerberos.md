# How does Kerberos work?

## Overview

Kerberos is an **authentication protocol,** which means it is a prescribed method for a user to **prove their identity** to a particular application service over a network.

The set of players in the protocol can be seen as:

* a client program acting on behalf of a user
* a centralized service, called the Authentication Server (AS)
* one or more application servers.

<img src="https://raw.githubusercontent.com/EshaMaharishi/kerberos_gist_images/master/i1.png" width="400">

Kerberos works by using the Authentication Server as a **middle-man** between clients and applications. The Authentication Server must have **a priori** knowledge of:

* all users in the system
* all application services in the system

to allow a **user known by the Authentication Server** to prove their identity to an **application service known by the Authentication Server.**

> #### What does "known by the Authentication Server" mean?
>
> During the system's set-up, the Authentication Server must be informed about all users in the system.
>
> This means for each user, an account is created on the Authentication Server and given a password chosen by the user. The  username, password, and the Kerberos version number are encrypted using an agreed-upon encryption scheme to produce a secret key for the user.
>
> Now, the user can use their username and password under the **same** encryption scheme to re-create their secret key from anywhere.
>
> The user can therefore send confidential messages to the Authentication Server over a network by encrypting the message with their secret key.
>
> Similarly, each application service must be issued a secret key that it can use to communicate with the Authentication Server over a network.

## The Basic Kerberos Protocol

_Note: in the diagrams below, colors are used to help clarify which segments are encrypted by which keys, since there are three keys involved, and it can get confusing._

When a client wants to prove its identity to an application, it sends a message containing the user's username (in cleartext) and a request  to authenticate to a particular application service (encrypted by the user's secret key) to the Authentication Server.

<img src="https://raw.githubusercontent.com/EshaMaharishi/kerberos_gist_images/master/i2.png" width="400">

The Authentication Server looks up the username to find the user's secret key and uses it to decrypt the request.

The Authentication Server then creates a **Kerberos ticket** containing:

* a session key
* the session key expiration time
* the user's identity.

The Authentication Server creates a response containing a cleartext version of the ticket AND a version of the ticket encrypted using the desired application service's secret key.

The Authentication Server then encrypts the entire response using the user's shared key and sends it to the client.

<img src="https://raw.githubusercontent.com/EshaMaharishi/kerberos_gist_images/master/i3.png" width="400">

Now the client sends the application server a request containing:

* the Kerberos ticket encrypted by the application service's secret key (received from the Authentication Server)
* an "authenticator" encrypted by the session key containing
  * the current time
  * a checksum
  * the user's identity

and sends it to the application server.

<img src="https://raw.githubusercontent.com/EshaMaharishi/kerberos_gist_images/master/i4.png" width="400">

Finally, the application server decrypts the Kerberos ticket using its own secret key, and decrypts the authenticator using the session key from the ticket.

The application server calculates the checksum for the request and checks if it matches the checksum in the authenticator.

If it does, then the application server knows the same session key was used to encrypt the authenticator as to decrypt it, so the sender must have known the session key in the ticket.

The application server then verifies the identity of the sender by checking that the identity in the ticket matches the identity in the authenticator.

The client can optionally include a request that the application server also prove its identity. In this case, the application server sends a response encrypted by the session key (thereby proving that the application server was able to decrypt the ticket using its secret key).

<img src="https://raw.githubusercontent.com/EshaMaharishi/kerberos_gist_images/master/i5.png" width="400">

## Single Sign-On (SSO) and Ticket Granting Tickets

If the system contains a set of application services which a user should be able to access, it is desirable for the user to be able to authenticate just once rather than once for each service.

A simple way to do this is to cache the user's password in memory, but a safer way is to use an extended version of the Kerberos protocol which caches only tickets and encryption keys for a limited time.

When the user logs in, an authentication request for the **ticket granting service** is issued to the Authentication Server. The ticket that is returned is called the **ticket granting ticket.**

<img src="https://raw.githubusercontent.com/EshaMaharishi/kerberos_gist_images/master/i6.png" width="400">

The version of the ticket granting ticket encrypted by the ticket granting service's secret key is cached on the client, along with the session key from the ticket granting ticket.

Now when the user accesses a new service (and therefore needs to authenticate to that service), a ticket for that service is requested from the Authentication Server _via_ the ticket granting service.

<img src="https://raw.githubusercontent.com/EshaMaharishi/kerberos_gist_images/master/i7_fixed.png" width="650">
<img src="https://raw.githubusercontent.com/EshaMaharishi/kerberos_gist_images/master/i8.png" width="650">

## Using the Session Key for Further Communication

As a by-product of the authentication protocol, the client and application server end up with a shared key that they can use to further exchange private encrypted messages.

## Sources

* Draws heavily from [USC/ISI Technical Report number ISI/RS-94-399](http://gost.isi.edu/publications/kerberos-neuman-tso.html)
* [Redmond Magazine](https://redmondmag.com/articles/2012/02/01/understanding-the-essentials-of-the-kerberos-protocol.aspx)
* [Blog post](http://www.roguelynn.com/words/explain-like-im-5-kerberos/) by Lynn Root

## Further Reading

* [Current Kerberos release from MIT](http://web.mit.edu/kerberos/)
* [Red Hat Enterprise Linux 3: Reference Guide, Chapter 18. Kerberos](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/3/html/Reference_Guide/s1-kerberos-works.html)
* [Set up Kerberos on FreeBSD](https://www.freebsd.org/doc/handbook/kerberos5.html)

## Related Topics

* [Public key cryptography and PGP](http://www.pgpi.org/doc/pgpintro/)
