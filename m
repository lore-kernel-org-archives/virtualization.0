From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: TUN_F_UFO change breaks live migration
Date: Tue, 11 Nov 2014 12:17:26 +0000
Message-ID: <1415708246.3398.88.camel__3131.5925335095$1415708272$gmane$org@decadent.org.uk>
References: <20141111105849.GA8482@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7812343358321557954=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141111105849.GA8482@stefanha-thinkpad.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org, jelledejong@powercraft.nl, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============7812343358321557954==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-BbxpgkpoprlH3rd/vMK6"


--=-BbxpgkpoprlH3rd/vMK6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2014-11-11 at 10:58 +0000, Stefan Hajnoczi wrote:
> Commit 3d0ad09412ffe00c9afa201d01effdb6023d09b4 ("drivers/net: Disable
> UFO through virtio") breaks live migration of KVM guests from older to
> newer host kernels:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?i=
d=3D3d0ad09412ffe00c9afa201d01effdb6023d09b4
>=20
> The problem occurs when a guest running on a host kernel without commit
> 3d0ad0941 in tun.ko attempts to live migration to a host with commit
> 3d0ad0941.
>=20
> Live migration fails in QEMU with the following error message:
>=20
>   virtio-net: saved image requires TUN_F_UFO support
>=20
> The old host tun.ko advertised support for TUN_F_UFO.  The new host
> tun.ko does not and that's why QEMU aborts live migration.  QEMU cannot
> change the features of a running virtio-net device.

Yes, this is known and was mentioned in the DSA.

> tuxcrafter provided logs from two Debian hosts migrating from
> 3.2.60-1+deb7u3 to 3.2.63-2+deb7u1:
>=20
> http://paste.debian.net/131264/
>=20
> I haven't investigated enough to suggest a fix, just wanted to bring it
> to your attention.  Soon a lot of people will be hitting this problem as
> they upgrade their infrastructure and migrate guests - seems like a
> critical issue.

You can work around this by making macvtap and tun still claim to
support UFO.  They continue to support it even if it's not advertised
because the tap features don't reliably get propagated to virtio
devices.

Ben.

--=20
Ben Hutchings
Experience is directly proportional to the value of equipment destroyed.
                                                         - Carolyn Scheppne=
r

--=-BbxpgkpoprlH3rd/vMK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVGH+W+e/yOyVhhEJAQrwlg/8CsJ3DzD8BmKE1Ug76G23AGDHvI42hJkV
f1fQiTYqkS0BpS3eDtbfOw0B13KjEdix6B3dvMWWg89kzH5wNMXgPUTqALBkDkEP
0Jo2+TIFAG5pxvYTrbgFfEQPcWxskezSs7LipJNf55l/bcMU4Yc6hE58dOZ0MkOW
rihiO5BFLA6kBf7cFR55frfmtwjNHYTCLCYBog5Gj8Wy0+S3obFXggUgQtd4sePv
Nqj7+pJ78kx0wHoGeJxeNPR1li27lBsGKbnHraHpVKNTf+bR5LJ71VRCuHZP+7XL
LSIdSvBIemYWuPLf2URFz08OSHc6a5ieVaGN1Bvfkba5DkwAEhcprIbNpUW+J3tU
RzvoVPi9mt7B5v5r5aJOwWd/2U21FlYEYg1hfd3JSsIMwFnhOX0y3257nnuZnNQX
p77ESD7DP8OXMp5ZDiMmxQ5vWSBOlT9vpY5hY+vtdP+FDMnhxb4Q5VN96cIZPgPt
7oY0BV0SKYU53wPLs7NOQn2UdlQcEelagnOLZB+BmPYzWmhjt2ArINzby7xTkf+S
kvCzQVlpNooFjIU3QAYDc1f6cSOj9dYpOG3W067DyuPaX89TKa+RcDMcUeNkQvS4
yadoFK5Ke3pAyMaq5OYGAXyujVlU+j+ceXxaWnwJfSWJl0R1o1BBXlmEjvGy8hJs
ONQF0bRl3oU=
=7P4l
-----END PGP SIGNATURE-----

--=-BbxpgkpoprlH3rd/vMK6--

--===============7812343358321557954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7812343358321557954==--
