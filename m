From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] drm/bochs: fix framebuffer setup.
Date: Thu, 27 Jun 2019 14:12:19 +0200
Message-ID: <f4cd0030-bc20-58e8-629a-4ab8cc6f6178__11264.9394360901$1561637558$gmane$org@suse.de>
References: <20190627081206.23135-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1258458859279634132=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190627081206.23135-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1258458859279634132==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="So3uojqyLOnLZacd1FQK5GGpDU33NWTel"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--So3uojqyLOnLZacd1FQK5GGpDU33NWTel
Content-Type: multipart/mixed; boundary="ukWlB5UqnUmelENCmH8H0mTJbHiVCxXNg";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>
Message-ID: <f4cd0030-bc20-58e8-629a-4ab8cc6f6178@suse.de>
Subject: Re: [PATCH v2] drm/bochs: fix framebuffer setup.
References: <20190627081206.23135-1-kraxel@redhat.com>
In-Reply-To: <20190627081206.23135-1-kraxel@redhat.com>

--ukWlB5UqnUmelENCmH8H0mTJbHiVCxXNg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 27.06.19 um 10:12 schrieb Gerd Hoffmann:
> The driver doesn't consider framebuffer pitch and offset, leading to a
> wrong display in case offset !=3D 0 or pitch !=3D width * bpp.  Fix it.=


Thanks

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs.h     |  2 +-
>  drivers/gpu/drm/bochs/bochs_hw.c  | 14 ++++++++++----
>  drivers/gpu/drm/bochs/bochs_kms.c |  3 ++-
>  3 files changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/boch=
s.h
> index cc35d492142c..2a65434500ee 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -86,7 +86,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>  void bochs_hw_setformat(struct bochs_device *bochs,
>  			const struct drm_format_info *format);
>  void bochs_hw_setbase(struct bochs_device *bochs,
> -		      int x, int y, u64 addr);
> +		      int x, int y, int stride, u64 addr);
>  int bochs_hw_load_edid(struct bochs_device *bochs);
> =20
>  /* bochs_mm.c */
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/b=
ochs_hw.c
> index 791ab2f79947..ebfea8744fe6 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -255,16 +255,22 @@ void bochs_hw_setformat(struct bochs_device *boch=
s,
>  }
> =20
>  void bochs_hw_setbase(struct bochs_device *bochs,
> -		      int x, int y, u64 addr)
> +		      int x, int y, int stride, u64 addr)
>  {
> -	unsigned long offset =3D (unsigned long)addr +
> +	unsigned long offset;
> +	unsigned int vx, vy, vwidth;
> +
> +	bochs->stride =3D stride;
> +	offset =3D (unsigned long)addr +
>  		y * bochs->stride +
>  		x * (bochs->bpp / 8);
> -	int vy =3D offset / bochs->stride;
> -	int vx =3D (offset % bochs->stride) * 8 / bochs->bpp;
> +	vy =3D offset / bochs->stride;
> +	vx =3D (offset % bochs->stride) * 8 / bochs->bpp;
> +	vwidth =3D stride * 8 / bochs->bpp;
> =20
>  	DRM_DEBUG_DRIVER("x %d, y %d, addr %llx -> offset %lx, vx %d, vy %d\n=
",
>  			 x, y, addr, offset, vx, vy);
> +	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, vwidth);
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
>  }
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/=
bochs_kms.c
> index 5904eddc83a5..bc19dbd531ef 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -36,7 +36,8 @@ static void bochs_plane_update(struct bochs_device *b=
ochs,
>  	bochs_hw_setbase(bochs,
>  			 state->crtc_x,
>  			 state->crtc_y,
> -			 gbo->bo.offset);
> +			 state->fb->pitches[0],
> +			 state->fb->offsets[0] + gbo->bo.offset);
>  	bochs_hw_setformat(bochs, state->fb->format);
>  }
> =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--ukWlB5UqnUmelENCmH8H0mTJbHiVCxXNg--

--So3uojqyLOnLZacd1FQK5GGpDU33NWTel
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl0UsqcACgkQaA3BHVML
eiPuOgf/dIeDhAhZVWHM4iWh7MvIVKAl2Y25KkHSRy8Dmvale9MbgzUuzMMnXSOz
92X0Wt8bA4Y/uRQftcdfWOHck6B77HWtxrsNES4K/YkRG9IdrumgEjjUoH4P4dhf
HGzKIRKOiNfi6V/xNX06N38+ai4yyUJ2ByQSkyiSekBh22sSmahYWTvc485TPKFt
kwftBvuFqIQ5ktp/XVgopbgun1EsIyI8TSbxqPw8y0FWM+uWrgl8b6DPEFZ1xCCh
pU8yiWanz//swDtvZYUCALDtmaDXlU0tw/INIRVO6zOChnG+CtLPt1hqASxuX1yl
JjAgMJlLNuttoXOgPbB35iCcshugUg==
=RTfy
-----END PGP SIGNATURE-----

--So3uojqyLOnLZacd1FQK5GGpDU33NWTel--

--===============1258458859279634132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1258458859279634132==--
