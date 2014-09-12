From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-gpu/2d: add hardware spec include
	file
Date: Fri, 12 Sep 2014 06:51:41 -0600
Message-ID: <5412EC5D.6060403@redhat.com>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>		<1410448173-12960-2-git-send-email-kraxel@redhat.com>		<5411BD74.80608@redhat.com>	<1410518696.30411.9.camel@nilsson.home.kraxel.org>
	<5412EB89.1080405@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6038340944424756724=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5412EB89.1080405@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6038340944424756724==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TeNLwOdQXvuX5P3ljuKsVGcONHXE0HSEV"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TeNLwOdQXvuX5P3ljuKsVGcONHXE0HSEV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2014 06:48 AM, Eric Blake wrote:

> So if you need more ideas and a good read, check out
> the comments in how gnulib does it (the link mentions GPLv3+, but that
> file is also shipped as LGPLv2+ so it is compatible with qemu):
>=20
> git.savannah.gnu.org/cgit/gnulib.git/tree/lib/verify.h

Just to be clear,

http://git.savannah.gnu.org/cgit/gnulib.git/tree/lib/verify.h

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--TeNLwOdQXvuX5P3ljuKsVGcONHXE0HSEV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJUEuxdAAoJEKeha0olJ0Nq+WAH/RxNFVltrQdSQhKIQIwzKfoX
4D+k4ADNPXKOkAZsuAdoQtZIfbX8U9TxTVFd4LlrypZCYD52bfjEyZEaJ1CPjITf
ACJMXtSYYp7uvhiTwY/x3ujLDQtCHAiX39UPz0dxSPfHSLbMlCt4NJpUb6Wx5o1h
wc9nVol2yg0J28NHJ6voPtOSrDXMEq5/GkMg9DSQqXQ/f2zsnHGP0YoLI1xfrvmV
jNF+G5NPJ7ONG5zKGWIq2eu9pMNxCft3853IL0Qpl5mLtvgmM1512cWRC8LESMp0
JicXSuPTAmFAGLxlbjXOB2AmRAu4kLedYeBHAI87sQp7MuAgGIfqeUf3tPronRQ=
=w6fT
-----END PGP SIGNATURE-----

--TeNLwOdQXvuX5P3ljuKsVGcONHXE0HSEV--

--===============6038340944424756724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6038340944424756724==--
