From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for May 14 (vhost_scsi)
Date: Wed, 15 May 2013 09:55:58 +1000
Message-ID: <20130515095558.918f2b29ba318a477eb5dde2__45763.9253036634$1368576178$gmane$org@canb.auug.org.au>
References: <20130514141739.46eb9b42c95cb02947610379@canb.auug.org.au>
	<51928D84.2040305@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4906404883722691862=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51928D84.2040305@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-next@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Nicholas A. Bellinger" <nab@risingtidesystems.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============4906404883722691862==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__15_May_2013_09_55_58_+1000_ylBDgaB6c8OvGGEA"

--Signature=_Wed__15_May_2013_09_55_58_+1000_ylBDgaB6c8OvGGEA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Adding Michael to cc]

On Tue, 14 May 2013 12:16:20 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> on x86_64:
>=20
> ERROR: "memcpy_fromiovec" [drivers/vhost/vhost_scsi.ko] undefined!
>=20
>=20
> It needs to depend on NET since net/core/ provides that function.
>=20
> --=20
> ~Randy

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__15_May_2013_09_55_58_+1000_ylBDgaB6c8OvGGEA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRks8OAAoJEECxmPOUX5FEmZYQAI8MJATooxMhrJVWJ8Qnzn0V
TjJ9LftxyAXDCa1lfGZzI29I6y8fPNIt5YnwbBIWxfIqGKVzoCS7i83wdKjKm3/q
8CXkMAuErner+EsisdzZ+0HcRVnkRi6cy0nIw5Sa6D1c+wnB6R4b0SBPe7YzA5pL
qJdJtmJpa47fDEHdPmMTV+TddZdWz3W/AryxZlm8JwQJKiCYs2xB3Z2+goNJudgJ
MbUOyiKO6s71Dk5VIEfOzPdHSolybHPerhK+l4uo4Rnua85tsgLp8BqGtzn5to8H
QTsJ+ImVpRVOwxyRxhkP6OJiOZi7rDxRX9m5GT9x+TKITGO/D3wfDwBQ/0+EMjve
f0BUZdsTio/XV9IM+/UlfP1GHVZKMnJ12pwZqj6fVAqVLNQrZgk0PsYeYUeYpXvW
B9IBgbfNqzB2o93IpRRYTbY1z8tZDiJs05VfEzkZcf2UQ+m6njVSPGvxwIKgmy5F
EIVGOBDhBXHIJe5fNinUekBcqhpwAhy2FUmTJ7DrU3pjwZ8bRTG9siN7nieMMWe1
0rS11B6+5Ykvbag/WOVFrSUaiVE0LjL+tPZgskXfNH593xfp0XzVBzTjHsZXBFFb
Qkg69o4tIfaMgY5G2e39O63MipbTyO89MYDP+MG+cr/Cdwf4nhlEd5Yi71KXXyoK
96nhx+Fp87kXHI18F64R
=qIRq
-----END PGP SIGNATURE-----

--Signature=_Wed__15_May_2013_09_55_58_+1000_ylBDgaB6c8OvGGEA--

--===============4906404883722691862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4906404883722691862==--
