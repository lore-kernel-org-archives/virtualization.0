From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 03/24] drm/virtio: Place GEM BOs in drm_framebuffer
Date: Thu, 17 May 2018 16:29:25 +0200
Message-ID: <20180517142925.GD26515__4149.84005406058$1526567268$gmane$org@ulmo>
References: <CAPj87rPKDwBK7qoOoY2zXoS6T02toATPRsk=39m_OBr=s1kXTw@mail.gmail.com>
	<20180330141138.28987-1-daniels@collabora.com>
	<20180330141138.28987-3-daniels@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6851584507730219442=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180330141138.28987-3-daniels@collabora.com>
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


--===============6851584507730219442==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 03:11:17PM +0100, Daniel Stone wrote:
> Since drm_framebuffer can now store GEM objects directly, place them
> there rather than in our own subclass. As this makes the framebuffer
> create_handle and destroy functions the same as the GEM framebuffer
> helper, we can reuse those.
>=20
> Signed-off-by: Daniel Stone <daniels@collabora.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 30 +++++---------------------=
----
>  drivers/gpu/drm/virtio/virtgpu_drv.h     |  1 -
>  drivers/gpu/drm/virtio/virtgpu_fb.c      |  8 ++++----
>  drivers/gpu/drm/virtio/virtgpu_plane.c   |  4 ++--
>  4 files changed, 11 insertions(+), 32 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr9kcUACgkQ3SOs138+
s6Fy4RAAvzRxuFMyCxYyVxjsD6OhSUNSaErf5ao/69II/JWneaX6dTHPNeDA9LhQ
H9rg+6kHuptKipKZK83euuek4cSkbJvhHqbNGGmnqV8w9EUciER0BZGS/xbhvx7/
TjPLC8hi8bqAeaQXHO0ZHPQDphL346F/Ie9mztIRTQnhKtiPcccKlVTrkzmCrZvD
pO6LtRRIrZEtv+7F8yBZSd+iKm6GqVJd8G32/CTJy1EzUE83Twkk3P1d0v3iU3A/
mR/aya1iFUM/S2D3xCwsamB7JKoLKpXU1oX8qWVWSBR4aEOQTsCxq5SpkZFLSdF8
WFcWUDCtBLDQO9XZn+eqcbX3ISqpLRqE0Y8+vrFVCMNxC3/zeEjBFfd0ERFvSgEF
HdNe4U4U2QGh7802hXPKsNoXyId5g6yuKXWy71RXk0fdysIoah6WADrHoeDj6wPR
e73wfqNqzzkTizP8pAwvr84tQc/xc4uVZHdzkvEv04+nRRed2yCTsgHB9nC2zh6k
HjaxJioncCGyhgOSiZy1JD4iipgVDNzfe16J71LJylmRsGGYlQAyF3MVyU9kI2Uw
LqU2es1cWdofNx/a+QNtP3kGLjxP3iVHhDrcuEYRFLfUyPGh64jMw/9u3EVEvog0
uDc1VpJkPLdoyghWgpwVelb28s+vtUhJ1KoiIpOJqAZkXhrOLZQ=
=sFV2
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--

--===============6851584507730219442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6851584507730219442==--
