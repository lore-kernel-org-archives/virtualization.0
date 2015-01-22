From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 05/20] virtio: support more feature
	bits
Date: Thu, 22 Jan 2015 12:43:43 +1100
Message-ID: <20150122014343.GG27371@voom.fritz.box>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5155462628865594555=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
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


--===============5155462628865594555==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:07PM +0100, Cornelia Huck wrote:
> With virtio-1, we support more than 32 feature bits. Let's extend both
> host and guest features to 64, which should suffice for a while.
>=20
> vhost and migration have been ignored for now.

[snip]

> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index f6c0379..08141c7 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -55,6 +55,12 @@
>  /* A guest should never accept this.  It implies negotiation is broken. =
*/
>  #define VIRTIO_F_BAD_FEATURE		30
> =20
> +/* v1.0 compliant. */
> +#define VIRTIO_F_VERSION_1              32

This is already in the kernel header, isn't it?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwFXOAAoJEGw4ysog2bOSTUEP/0VVHy2EKQ3QKkInp/T+PBZW
Qx9PQg7rB1+AgN1q7WhkRe1Ahh2Tn/m/nyR7WgyiKp7w4bnxsvTJzxaVeNKQ8CgQ
Z6gHv1zi6pC1BvooS6qCUlLPn4eu5O2e1QihHT5Tg0ZsA8+KPSevRe1cgzQimIMH
/Sb4wHr+i7pw4+yyBP8uDUPkRX0p3pNr/1mpdCtdc+f5bwHvkE38PYS/nTt2pGN0
9+VJc+/M2Xeirq7d7mkkUWZKIdSE8ZEulZgB6BTALCxmLbwuidrzoxnpYlCMVWAV
xEh8AXMz1lxf0kNhVHWzOYpwRS3krtCerndluSt8MkRgkXyXFO75bOAcxW74knXT
1sIqVrW8OBAP2eqZ99uI+VWeOO8Q+j+sprqFm/6Pyu+eeJMuYNouql2aIewjogD8
kbgnwVGfUW3YnvSeLgs3U9g5PoG0ce3PL3Sy6nCzRrwigKN90wAGyhAVSzT9MMFy
GxOHo5DlmG3c0I4p1lkbjzATGJnEIAUa5LfJ25rxJDl1mi+YEWFFLyy37N6EWbny
aDItPCRwpTpCKStyGynz/w6vvGtlJRCt/wN7d7K+cmgWlBR8IqmzbJIa/jAkvPoP
kIWKI9WF5MunRK/Gi/5WhFvaZ6CWONdkxO925EBbXWJnqxEf5M+zRw0DV2ycxEv3
u89nswdcv77vqWYHsNFA
=1trq
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--

--===============5155462628865594555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5155462628865594555==--
