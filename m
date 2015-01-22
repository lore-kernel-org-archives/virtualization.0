From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 04/20] virtio: add feature checking
	helpers
Date: Thu, 22 Jan 2015 12:28:56 +1100
Message-ID: <20150122012856.GE27371__11079.8814720058$1421893512$gmane$org@voom.fritz.box>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-5-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1613079390782660915=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-5-git-send-email-cornelia.huck@de.ibm.com>
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


--===============1613079390782660915==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:06PM +0100, Cornelia Huck wrote:
> Add a helper function for checking whether a bit is set in the guest
> features for a vdev as well as one that works on a feature bit set.
>=20
> Convert code that open-coded this: It cleans up the code and makes it
> easier to extend the guest feature bits.
>=20
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwFJYAAoJEGw4ysog2bOSl8sP/jjhkGmjZqfK5w99SAcfEz+u
y/4Uf6cKyh37JevHBgedKZakuk0Y+G+b9xaxG3jd5FVwvJwo1icbp4T68uOQezzW
SLbBtFUjZ0cSWfIMmf//BonSTlihGvV2SiwCZ1syPYqh1rpiEFmG9tvDG6GBRqdV
/T6le+GsV0bMPwIalVIVuKYili5fTp4hXJc/aXhuvFFkUs/JNYSJ2wAOoDqWcmFu
qCua4Do5DsFdfqVdgZevcNPdwuN2VgZ5xO+tKEBwtb22Pngn4ELbzS/z6wf8hv50
D7GbD7CjNpuYsZu0JqcdDxQpJqawEXdCt5jmUUpv1kj0u0Tqblqd0vGvRTKVwd9V
tMW7B6mkLt+9U8sbe7gODwp5v+4AGW7Prl+/sBTiVzs7Cm1HtFW5EFWNreNjPsUJ
wwNzEKD3hFnWcHExvOprgTsw47bOKJ+Xq5Z5GCWZrg2sq7kWJ0hdc+qUJCS+djVs
sDVMQ7FqcKrEBbEMwY1i1rOMYNr89HVwGAcmto+X0F8b5dw80uSrqwt/hxU2lmlF
DEdMzjAsp/W3l4A3YL1qv1msrSrUxAAMv4zSAwkloV6HwDkfysYdP5KeSGkS4LS1
BplH9PC2X28Jduws3EmNYuVwisfC+BfROXxGBsR8kK351a5nMJ5DqwG+xVUc/oag
h2dUC2iAlHh/WOhXhKB8
=tryp
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--

--===============1613079390782660915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1613079390782660915==--
