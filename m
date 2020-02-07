From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] drm/bochs: downgrade pci_request_region failure from
 error to warning
Date: Fri, 7 Feb 2020 13:06:00 +0100
Message-ID: <04783a3f-daae-47a3-d2a7-d42f192daf23@suse.de>
References: <20200207115744.4559-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="foLTu5q3eMQh5VHpADh7fpioUUpykH1jb"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200207115744.4559-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: marmarek@invisiblethingslab.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--foLTu5q3eMQh5VHpADh7fpioUUpykH1jb
Content-Type: multipart/mixed; boundary="s3z0rAySyYq5LD1IVBxm1VB0rgaYv9rkq";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: marmarek@invisiblethingslab.com, David Airlie <airlied@linux.ie>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>
Message-ID: <04783a3f-daae-47a3-d2a7-d42f192daf23@suse.de>
Subject: Re: [PATCH v2] drm/bochs: downgrade pci_request_region failure from
 error to warning
References: <20200207115744.4559-1-kraxel@redhat.com>
In-Reply-To: <20200207115744.4559-1-kraxel@redhat.com>

--s3z0rAySyYq5LD1IVBxm1VB0rgaYv9rkq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 07.02.20 um 12:57 schrieb Gerd Hoffmann:
> Shutdown of firmware framebuffer has a bunch of problems.  Because
> of this the framebuffer region might still be reserved even after
> drm_fb_helper_remove_conflicting_pci_framebuffers() returned.

Out of curiosity: what's going wrong here?

Best regards
Thomas

>=20
> Don't consider pci_request_region() failure for the framebuffer
> region as fatal error to workaround this issue.
>=20
> Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs_hw.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/b=
ochs_hw.c
> index b615b7dfdd9d..a387efa9e559 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -157,8 +157,7 @@ int bochs_hw_init(struct drm_device *dev)
>  	}
> =20
>  	if (pci_request_region(pdev, 0, "bochs-drm") !=3D 0) {
> -		DRM_ERROR("Cannot request framebuffer\n");
> -		return -EBUSY;
> +		DRM_WARN("Cannot request framebuffer, boot framebuffer still active?=
\n");
>  	}
> =20
>  	bochs->fb_map =3D ioremap(addr, size);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--s3z0rAySyYq5LD1IVBxm1VB0rgaYv9rkq--

--foLTu5q3eMQh5VHpADh7fpioUUpykH1jb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl49UqkACgkQaA3BHVML
eiO04wf/dIsiLt9szHzZl+XV/01hNiujAAhN5F6zS8nASQnLENXF588S6Bk0ROvY
Bmv+EN6CL5mi3SjNl2qSAw2F5SmeRmbQptJjuBmSLbep0N5HUhk4lR0qyGDg7cT9
F9l7FJcZI1SCQXWICWqRNL/ziokpLbgAO+DDtYIlC0CcahdqE9yHt4kJZDmy5A08
q7qaPaC2z8BbOhRR1bNw++BY3vmZQrq0AevYBwuNMvfR1p/cY8jZzuAqvw9EyRZ0
JrpG9lbTPCMy79iEinfQTYe5mBz0nOJLeKyGfzi+TbRHDBJt1oih21ybv59S/lAP
I/vTF+HchjvBzuLvhk0aTDM28C+LLw==
=fkeZ
-----END PGP SIGNATURE-----

--foLTu5q3eMQh5VHpADh7fpioUUpykH1jb--
