From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/virtio: fix vblank handling
Date: Wed, 5 Feb 2020 08:39:13 +0100
Message-ID: <08af7a9d-4d5b-3b5d-ce0d-e4cfa8700ead@suse.de>
References: <20200205065312.15790-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n7BqPTALHhmC9nv5EOlXhgd7PvwNLTub7"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200205065312.15790-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: olvaffe@gmail.com, gurchetansingh@chromium.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n7BqPTALHhmC9nv5EOlXhgd7PvwNLTub7
Content-Type: multipart/mixed; boundary="8jyV62oj2H4d51KvhrWXToHiPqQnXYFsY";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: olvaffe@gmail.com, gurchetansingh@chromium.org,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <08af7a9d-4d5b-3b5d-ce0d-e4cfa8700ead@suse.de>
Subject: Re: [PATCH] drm/virtio: fix vblank handling
References: <20200205065312.15790-1-kraxel@redhat.com>
In-Reply-To: <20200205065312.15790-1-kraxel@redhat.com>

--8jyV62oj2H4d51KvhrWXToHiPqQnXYFsY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 05.02.20 um 07:53 schrieb Gerd Hoffmann:
> virtio has its own commit fail function.  Add the
> drm_atomic_helper_fake_vblank() call there.
>=20
> Fixes: 2a735ad3d211 ("drm/virtio: Remove sending of vblank event")

Thanks for fixing the fallout.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm=
/virtio/virtgpu_display.c
> index ecf4ba7cc32b..7b0f0643bb2d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -324,6 +324,7 @@ static void vgdev_atomic_commit_tail(struct drm_ato=
mic_state *state)
>  	drm_atomic_helper_commit_modeset_enables(dev, state);
>  	drm_atomic_helper_commit_planes(dev, state, 0);
> =20
> +	drm_atomic_helper_fake_vblank(state);
>  	drm_atomic_helper_commit_hw_done(state);
> =20
>  	drm_atomic_helper_wait_for_vblanks(dev, state);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--8jyV62oj2H4d51KvhrWXToHiPqQnXYFsY--

--n7BqPTALHhmC9nv5EOlXhgd7PvwNLTub7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl46cScACgkQaA3BHVML
eiP5QQgAuCOwZJoU/TXyWVpYlSmyHRDS14CnhHE94aQmrU9D8k1UsJUt/bqr+7NK
PAKWbLWuZoeeHc1evbbqPypqdh47ndG9kT03/eEzLmKALmHqq1lcPj8evj9T1f3l
5lol2uJoEFrf1OmB4Cmt5vwvg51X/ohqkzy8mi7EIeacSnDxIXeNtrSje9KCpBYU
AXSz5WaFTq+uWpYIMKcrjfP9R/st/ULzHusI+Sa5gjjso2dIG62tvUSPJQZkxVfz
iH0JO3doGIaLNGlWINQ+LEYB6tbIjgH9L+wzhegov0B4GUP0Trg0cH9oK52WcTRk
UoySz2Jccy/g7FqHWhjT/zislQfZug==
=eo1s
-----END PGP SIGNATURE-----

--n7BqPTALHhmC9nv5EOlXhgd7PvwNLTub7--
