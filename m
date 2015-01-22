From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 12/20] virtio: disallow late feature
	changes for virtio-1
Date: Thu, 22 Jan 2015 13:15:22 +1100
Message-ID: <20150122021522.GK27371@voom.fritz.box>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-13-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2557435167104069605=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-13-git-send-email-cornelia.huck@de.ibm.com>
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


--===============2557435167104069605==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Content-Disposition: inline


--2feizKym29CxAecD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:14PM +0100, Cornelia Huck wrote:
> For virtio-1 devices, the driver must not attempt to set feature bits
> after it set FEATURES_OK in the device status. Simply reject it in
> that case.
>=20
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2feizKym29CxAecD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwF06AAoJEGw4ysog2bOSPdYP+QHIgYaqV26xg08CZM4lAjF5
YOq0oRRvPQdNxrDlF7H4iJhVmBK7iWSt+JZhcAJA5zqpIdAScH4reg7RW3fMDioa
Dt+thuaDqbcpuBJCGnMD7hn27yq8sMRhwj73UfvTXAHhIBZ0JiJyyX6MB4INnz/K
AP+kcIwXtzUznz0zbnE85IAUEOzIYP8IXIy0sTu0s6vUIp0CVkLx4Poiz22tS6J5
uLd+Py6srsReSksV0yUgbtZN9pEcIiOrgnG9rufc3RDizVg72QckX9yOpcuUSebv
h80jVwwPuh2sNzXYEMz35AF889cgGHZDkWFX3a5Q3n52pRI7o3y1zkHEAaSxN593
yoqJY+ajQjVeSX9i4u/D2/AcwsCqIlE2sNsAAH+6sDG2AqQLM6I2k/878UUbAqIz
X7h2CFIhh9DNBbQGh8deWLmp5Gmr6PhVRftUvxeLWePDKXV1J0VmsL3RTSFWRMml
KBxwCzlxJheVHNelXZwc0ibHr4PM6Itw5bhudrU1T4HXwCH0nfhgUWrR4GnEM0YH
vnsvJIJGCJCyAO10klVqqsm041rptXbGEw8Hq5pT5zTNfNu0i9mFfhAIKAsw0ec3
WSoyNWu85U1xl4o2SwtN2f66gj+Si+S/73I4TGp6kMepJ2uDKNidyviTzF4JqcZu
S+h4giczg0lSMOPY4NsY
=qUlx
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--

--===============2557435167104069605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2557435167104069605==--
