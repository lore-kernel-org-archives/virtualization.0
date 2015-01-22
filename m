From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 03/20] virtio: feature bit
	manipulation helpers
Date: Thu, 22 Jan 2015 12:25:47 +1100
Message-ID: <20150122012547.GD27371@voom.fritz.box>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0963288585242589109=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-4-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============0963288585242589109==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:05PM +0100, Cornelia Huck wrote:
> Add virtio_{add,clear}_feature helper functions for manipulating a
> feature bits variable. This has some benefits over open coding:
> - add check that the bit is in a sane range
> - make it obvious at a glance what is going on
> - have a central point to change when we want to extend feature bits
>=20
> Convert existing code manipulating features to use the new helpers.
>=20
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwFGbAAoJEGw4ysog2bOSmwoP/AgqhAG/evVDtyoOhl75yFZM
UqERPUonXLJ/2dmfdi9hWlmMue3NwkBBww/5dqszl5rj6WrfCDI7vDpcRsAFs796
S1RmAFDk+i+Jy/TbwRkH8e8SS1Sue0U0qilJOXniTp8rVDcbSi9sKrwZhw985g0/
fWa1fJohNWYuPlgU5/KS2YswSMmpq1EodHn6rDxJyw83US/J/9dmWt42ipOtjn4d
ARAjRuZFpEuTd7SwQM3mOs9zR6G35bqzAjYEIIVwA6CrFDBIaRuFhlkZtlWylJ0x
7CTqzY7Skg6Ms5eULoMI07Aeneu0JhOTnuwfqu4cxnzwO7+JKTr/gRstU90T5sUe
jWFsPuEh91xt2/C0QHGWG866sIH3zNFgfwbso+2rvsYsGaUPCAVp/QSg++2yPw3a
qBv9DOJmxLAEk4ZH3jx8Rl2hzEk+r5QeGsY+JhEYD/AsbTIt4mk1R3W4lJMvbdTu
vwpmuH18pJU9k7hqwMBuyi7/07jnbpbuL/zUnaMhgnJ5sQSOkvk0MIahiQQzNPw+
gQ6HTG28DybgPYMcpJxh6QVdtjTpd7zzabs6aNL4rJpqlzjU+85aM0CluG8cLb5z
neia8U1y4kaPx0R24ilD7zoOul7dCJFL3LmqqDl+GD1FguJzoW7YwfivHqbJrtce
61ZcwCklHd01HPoyjBd5
=TbBz
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--

--===============0963288585242589109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0963288585242589109==--
