From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 40/44] drm/cirrus: Don't use drm_device->dev_private
Date: Mon, 6 Apr 2020 13:58:54 +0200
Message-ID: <a7bb7d54-2c71-b087-8347-888a5019aacc@suse.de>
References: <20200403135828.2542770-1-daniel.vetter@ffwll.ch>
 <20200403135828.2542770-41-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8823516398673950948=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200403135828.2542770-41-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8823516398673950948==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dD9lAIfGQLeukxuvp6esfQcqRLXqsbd6O"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dD9lAIfGQLeukxuvp6esfQcqRLXqsbd6O
Content-Type: multipart/mixed; boundary="p7Xmz135DVUfuKl4aSOJzeqQjGKxCkWvv";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
 DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org, Gerd Hoffmann
 <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>,
 Dave Airlie <airlied@redhat.com>, Sam Ravnborg <sam@ravnborg.org>
Message-ID: <a7bb7d54-2c71-b087-8347-888a5019aacc@suse.de>
Subject: Re: [PATCH 40/44] drm/cirrus: Don't use drm_device->dev_private
References: <20200403135828.2542770-1-daniel.vetter@ffwll.ch>
 <20200403135828.2542770-41-daniel.vetter@ffwll.ch>
In-Reply-To: <20200403135828.2542770-41-daniel.vetter@ffwll.ch>

--p7Xmz135DVUfuKl4aSOJzeqQjGKxCkWvv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 03.04.20 um 15:58 schrieb Daniel Vetter:
> Upcasting using a container_of macro is more typesafe, faster and
> easier for the compiler to optimize.
>=20
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Noralf Tr=C3=B8nnes" <noralf@tronnes.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/gpu/drm/cirrus/cirrus.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/c=
irrus.c
> index 4b65637147ba..744a8e337e41 100644
> --- a/drivers/gpu/drm/cirrus/cirrus.c
> +++ b/drivers/gpu/drm/cirrus/cirrus.c
> @@ -59,6 +59,8 @@ struct cirrus_device {
>  	void __iomem		       *mmio;
>  };
> =20
> +#define to_cirrus(_dev) container_of(_dev, struct cirrus_device, dev)
> +

Maybe to_cirrus_device() ? I had the same comment for vbox and I think
it applies to all patches.

Best regards
Thomas

>  /* ------------------------------------------------------------------ =
*/
>  /*
>   * The meat of this driver. The core passes us a mode and we have to p=
rogram
> @@ -311,7 +313,7 @@ static int cirrus_mode_set(struct cirrus_device *ci=
rrus,
>  static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
>  			       struct drm_rect *rect)
>  {
> -	struct cirrus_device *cirrus =3D fb->dev->dev_private;
> +	struct cirrus_device *cirrus =3D to_cirrus(fb->dev);
>  	void *vmap;
>  	int idx, ret;
> =20
> @@ -436,7 +438,7 @@ static void cirrus_pipe_enable(struct drm_simple_di=
splay_pipe *pipe,
>  			       struct drm_crtc_state *crtc_state,
>  			       struct drm_plane_state *plane_state)
>  {
> -	struct cirrus_device *cirrus =3D pipe->crtc.dev->dev_private;
> +	struct cirrus_device *cirrus =3D to_cirrus(pipe->crtc.dev);
> =20
>  	cirrus_mode_set(cirrus, &crtc_state->mode, plane_state->fb);
>  	cirrus_fb_blit_fullscreen(plane_state->fb);
> @@ -445,7 +447,7 @@ static void cirrus_pipe_enable(struct drm_simple_di=
splay_pipe *pipe,
>  static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
>  			       struct drm_plane_state *old_state)
>  {
> -	struct cirrus_device *cirrus =3D pipe->crtc.dev->dev_private;
> +	struct cirrus_device *cirrus =3D to_cirrus(pipe->crtc.dev);
>  	struct drm_plane_state *state =3D pipe->plane.state;
>  	struct drm_crtc *crtc =3D &pipe->crtc;
>  	struct drm_rect rect;
> @@ -573,7 +575,6 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>  		return PTR_ERR(cirrus);
> =20
>  	dev =3D &cirrus->dev;
> -	dev->dev_private =3D cirrus;
> =20
>  	cirrus->vram =3D devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0)=
,
>  				    pci_resource_len(pdev, 0));
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--p7Xmz135DVUfuKl4aSOJzeqQjGKxCkWvv--

--dD9lAIfGQLeukxuvp6esfQcqRLXqsbd6O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl6LGX4ACgkQaA3BHVML
eiO7Xwf/RXZYBWOH9u7qutpw+M6TiyzhA0dsQU23i/2TA0BaluPl8zMzZFE7VC5c
p9V9PyLkNptBgMVrQrm4FMTz/e+ndZYipHRX2OoFjoCXzuWC21ovliQ+0YKg7DXP
W27P4t/q0dgCHAl/7DxWB/R/fcCMEwnYDYg34epY7Evz52MMRsysVAgGhbQU/wK8
HRdX1NfZw3dIIH9B7Qn+dPZSGeXhuBGq8+fkJ3BqNccctOy7JCJVVfNUwHmD4+WF
uNwDAWarsUjxdtOWzihAqcJDQnNbmrTI2m8UtFyoVetcC9S8saYUcwmHeRptOCCA
2opfja1lF05o3eVbMAbzxmoT7FRI0A==
=Exn2
-----END PGP SIGNATURE-----

--dD9lAIfGQLeukxuvp6esfQcqRLXqsbd6O--

--===============8823516398673950948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8823516398673950948==--
