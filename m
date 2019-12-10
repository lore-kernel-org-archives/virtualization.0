From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/virtio: fix mmap page attributes
Date: Tue, 10 Dec 2019 10:27:14 +0100
Message-ID: <e8915378-df67-e6f4-f40c-599797e16e9c__43866.5921262995$1575970055$gmane$org@suse.de>
References: <20191210085759.14763-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5829291044382399884=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191210085759.14763-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, gurchetansingh@chromium.org, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5829291044382399884==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tXIp6XNLLIEce1SuAIUeV5SovceQlbU1x"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tXIp6XNLLIEce1SuAIUeV5SovceQlbU1x
Content-Type: multipart/mixed; boundary="byvtVeCFq7qEeSe2yUOBbH4fGZ9G4ZJeh";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 gurchetansingh@chromium.org
Message-ID: <e8915378-df67-e6f4-f40c-599797e16e9c@suse.de>
Subject: Re: [PATCH] drm/virtio: fix mmap page attributes
References: <20191210085759.14763-1-kraxel@redhat.com>
In-Reply-To: <20191210085759.14763-1-kraxel@redhat.com>

--byvtVeCFq7qEeSe2yUOBbH4fGZ9G4ZJeh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 10.12.19 um 09:57 schrieb Gerd Hoffmann:
> virtio-gpu uses cached mappings.  shmem helpers use writecombine though=
=2E
> So roll our own mmap function, wrapping drm_gem_shmem_mmap(), to tweak
> vm_page_prot accordingly.
>=20
> Reported-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/=
virtio/virtgpu_object.c
> index 017a9e0fc3bb..158610902054 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -75,6 +75,22 @@ static void virtio_gpu_free_object(struct drm_gem_ob=
ject *obj)
>  	drm_gem_shmem_free_object(obj);
>  }
> =20
> +static int virtio_gpu_gem_mmap(struct drm_gem_object *obj, struct vm_a=
rea_struct *vma)
> +{
> +	pgprot_t prot;
> +	int ret;
> +
> +	ret =3D drm_gem_shmem_mmap(obj, vma);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* virtio-gpu needs normal caching, so clear writecombine */
> +	prot =3D vm_get_page_prot(vma->vm_flags);
> +	prot =3D pgprot_decrypted(prot);
> +	vma->vm_page_prot =3D prot;
> +	return 0;
> +}

There's similar code in udl, [1] which still uses writecombine for
imported buffers. Virtio does not need this?

Aside from this, do you think we could handle all special cases within
shmem?

Best regards
Thomas

[1]
https://cgit.freedesktop.org/drm/drm-tip/tree/drivers/gpu/drm/udl/udl_gem=
=2Ec?id=3D28ecf94a6f1072fc4744c06f5b3d267297125b37#n20

> +
>  static const struct drm_gem_object_funcs virtio_gpu_gem_funcs =3D {
>  	.free =3D virtio_gpu_free_object,
>  	.open =3D virtio_gpu_gem_object_open,
> @@ -86,7 +102,7 @@ static const struct drm_gem_object_funcs virtio_gpu_=
gem_funcs =3D {
>  	.get_sg_table =3D drm_gem_shmem_get_sg_table,
>  	.vmap =3D drm_gem_shmem_vmap,
>  	.vunmap =3D drm_gem_shmem_vunmap,
> -	.mmap =3D &drm_gem_shmem_mmap,
> +	.mmap =3D &virtio_gpu_gem_mmap,
>  };
> =20
>  struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev=
,
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--byvtVeCFq7qEeSe2yUOBbH4fGZ9G4ZJeh--

--tXIp6XNLLIEce1SuAIUeV5SovceQlbU1x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl3vZPIACgkQaA3BHVML
eiOEEQgAm12FJOpXRZL0gz0A05Oagc66189UnZVFiMGYgvmaTb/glrD2qc1uZ0/z
kDVe8Amys5mv3I/QeEuoN9p9ZMpuxAdcKmeNlfroDSo5BJfJWQO9/PC5Lyz6sWEq
Snr9ukUlw2jwtSFA0GcbgzdbuVyaA6ZM4rkNuYAnadUPf/EswcgUxQlxWjZSQ1dY
4PnkqgrHk+LZwyza2haOM5AX/2zjGjdbGxPHWQ1LE4YSESqEOg4xOJ0AuYCc84aO
fU8klXGhkQ+MeTr55AG71Kc10y8cQwelz4V/f4AW05Kk6eHuumykaVUZPE2+AVtu
r+HKNLNv+FkXOrlmPdo3y0F/BFB8Fw==
=15RE
-----END PGP SIGNATURE-----

--tXIp6XNLLIEce1SuAIUeV5SovceQlbU1x--

--===============5829291044382399884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5829291044382399884==--
