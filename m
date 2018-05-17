From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 02/24] drm/cirrus: cirrus_framebuffer -> drm_framebuffer
Date: Thu, 17 May 2018 16:25:26 +0200
Message-ID: <20180517142526.GC26515__48751.4222776101$1526567027$gmane$org@ulmo>
References: <CAPj87rPKDwBK7qoOoY2zXoS6T02toATPRsk=39m_OBr=s1kXTw@mail.gmail.com>
	<20180330141138.28987-1-daniels@collabora.com>
	<20180330141138.28987-2-daniels@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6517437163772672686=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180330141138.28987-2-daniels@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Stone <daniels@collabora.com>
Cc: Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============6517437163772672686==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 03:11:16PM +0100, Daniel Stone wrote:
> Now cirrus_framebuffer is just an empty wrapper around drm_framebuffer,
> we can drop it.
>=20
> Signed-off-by: Daniel Stone <daniels@collabora.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/gpu/drm/cirrus/cirrus_drv.h   |  9 ++-------
>  drivers/gpu/drm/cirrus/cirrus_fbdev.c | 20 ++++++++++----------
>  drivers/gpu/drm/cirrus/cirrus_main.c  | 20 ++++++++++----------
>  drivers/gpu/drm/cirrus/cirrus_mode.c  | 12 +++---------
>  4 files changed, 25 insertions(+), 36 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr9kNMACgkQ3SOs138+
s6E9OA/+JGGLwbqIsvfoNHUUC51iA0/sUIB59LI8WC6rHqpDJkxwJ1Dd23n0SQH0
ne/+ermGq/T9dFTd1Sz9lS7VV80RMx7ZgdCu4KS2STHuQOaTl9jzSwQ58wsAHEMb
6l/fx4r7yQkyIwUn+ElkOWGYIgJnHIxfiTzsCY0MCGadvZEe1HwCaIOWe22Ns37L
i6FierSZVGogsXGTGcw4hn//rYnzsKbbB4vYylIuZvG2yJToUubcxhkgxLyLrlAE
weHkoNzDiS8YcpZ8HVgbob8bGNgT2wu/OUdiz8xEL9kmmx8zzxBWShUfawEKcfGI
JfQE4lDO+A5yofw0RO4j1Zgu1UfcSO7zIZutkcNU5XL9iBAosp1zMt1Rj1ZsXSpN
JwAA2if3Pj85GV5LKJpUKPOxwsGMZSVZsLmljYxqBNvMRF/EiLXsMUqogbAmZIc6
rdWw9Pwe6bVV2lDDpIBIYdgEG+U5Hx/4USg0cfdKPTLI5AN2prcDO/+Jy2tvQbVJ
2eQE545mMWxGe+vs7gidUr9VkhhHqcj+vXaxrq612BYJ2sxQzZtB5g1y1veKhhqB
1LT9ySZuuukAnEGQIQe4p/lTYV1Tk09lgdxTTrI29VxPfIKfbUzqUsJm3dxGODBj
2s5SYLdU0ybd17dcSMfU5guzSBPZE00b4pIyLqq2MAevS6BuPEU=
=3sUC
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--

--===============6517437163772672686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6517437163772672686==--
