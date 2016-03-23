dockmail
==========

A simple mail server in a box for use in different projects.

Based on https://github.com/lava/dockermail and https://github.com/mingzeke/dockermail

A secure, minimal-configuration mail server in a docker container.
This repository is tailored to small private servers or projects, where you own a domain and want to host your own mail.

This container uses postfix as MTA and dovecot as IMAP server.
All incoming mail to your domains is accepted.
For outgoing mail, only authenticated (logged in with username and password) clients can send messages via STARTTLS.

 - **mailserver**:  The SMTP and IMAP server. This container uses postfix as MTA and dovecot as IMAP server.
    All incoming mail to your own domains is accepted. For outgoing mail, only authenticated (logged in with username and password)
    clients can send messages via STARTTLS on port 587. In theory it works with all mail clients, but it was only tested with Thunderbird.

 - **mailpile**: An early-alpha but promising webmail interface. 
 	By default, the web interface will bind to `localhost:33411` - this container will be done later


Setup
=====
Create 2 folders: one for mail configuration (`/opt/dockermail/settings`), another for mail storage (`/opt/dockermail/vmail`).

1. Add all domains you want to receive mail for to the file `/opt/dockermail/settings/domains`, like this:

		example.org
		example.net

2. Add user aliases to the file `/opt/dockermail/settings/aliases`, like

		johndoe@example.org       john.doe@example.org
		john.doe@example.org      john.doe@example.org
		admin@forum.example.org   forum-admin@example.org
		@example.net              catch-all@example.net

	An IMAP mail account is created for each entry on the right hand side.
	Every mail sent to one of the addresses in the left column will be delivered to the corresponding account in the right column.

3. Add user passwords to the file `/opt/dockermail/settings/passwords` like this

		john.doe@example.org:{PLAIN}password123
		admin@example.org:{SHA256-CRYPT}$5$ojXGqoxOAygN91er$VQD/8dDyCYOaLl2yLJlRFXgl.NSrB3seZGXBRMdZAr6

	To get the hash values, you can either install dovecot locally or use `docker exec -it dockermail bash` to attach to the running container (step 7) and run `doveadm pw -s <scheme-name>` inside.

4. Create `/opt/dockermail/settings/myhostname` with the fully qualified domain of your server.


5. Build container

		build.sh

6. Run container and map ports 25 and 143 from the host to the container.
	 To store your mail outside the container, map `/opt/dockermail/vmail/` to
	 a directory on your host. (This is recommended, otherwise
	 you have to remember to backup your mail when you want to restart the container)

	 `docker run -name dockermail -d -p 25:25 -p 587:587 -p 143:143 -v /opt/dockermail/settings:/mail_settings -v /opt/dockermail/vmail:/vmail dockermail_made_special/2.11.1`