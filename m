From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: TUN_F_UFO change breaks live migration
Date: Tue, 11 Nov 2014 10:58:49 +0000
Message-ID: <20141111105849.GA8482@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7398784654549280631=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, jelledejong@powercraft.nl, Ben Hutchings <ben@decadent.org.uk>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============7398784654549280631==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 3d0ad09412ffe00c9afa201d01effdb6023d09b4 ("drivers/net: Disable
UFO through virtio") breaks live migration of KVM guests from older to
newer host kernels:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3d0ad09412ffe00c9afa201d01effdb6023d09b4

The problem occurs when a guest running on a host kernel without commit
3d0ad0941 in tun.ko attempts to live migration to a host with commit
3d0ad0941.

Live migration fails in QEMU with the following error message:

  virtio-net: saved image requires TUN_F_UFO support

The old host tun.ko advertised support for TUN_F_UFO.  The new host
tun.ko does not and that's why QEMU aborts live migration.  QEMU cannot
change the features of a running virtio-net device.

tuxcrafter provided logs from two Debian hosts migrating from
3.2.60-1+deb7u3 to 3.2.63-2+deb7u1:

http://paste.debian.net/131264/

I haven't investigated enough to suggest a fix, just wanted to bring it
to your attention.  Soon a lot of people will be hitting this problem as
they upgrade their infrastructure and migrate guests - seems like a
critical issue.

Stefan

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUYevpAAoJEJykq7OBq3PIWvQIAIDTEdpko24A4kbzlsY9EVfC
ofewLlNTFe/K5jr9h0tUgqrq6w72j1tDylRKKQYiRZZJx9p9sNCucCh90xXdW1w7
t96QqWsNsR2gTiFuqpcdM07dI4IsYSHx+l3l7J3S5kTbXyvUW/yKYYofWcLnlvLX
fSmXQOJ6CLAzxJUA0I79VJg/hkndhGum8CDr30x7r9XPQDJDsCHCQMkn5KGrEsYO
j1Jiwbu+F7cmQyEU1Nk4OJPOhZ+SPwqZgNH3wRgc9WVF/FscIK2HqOF/kSJnFtVx
mvlsjkM9bur0lNwBOPttUNZqn8Wr+BGxGZaKh0p0FjoP8m4xm2rjzdUAbYk/FII=
=YypF
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

--===============7398784654549280631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7398784654549280631==--
