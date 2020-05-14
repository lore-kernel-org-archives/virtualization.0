From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/9] drm/virtio: Call the right shmem helpers
Date: Thu, 14 May 2020 09:46:22 +0200
Message-ID: <68e36b4b-139c-22c4-3028-26c2b50628f7@suse.de>
References: <20200511093554.211493-1-daniel.vetter@ffwll.ch>
 <20200511093554.211493-5-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0135323606=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200511093554.211493-5-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@intel.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0135323606==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6x5A6hSUnuyBxeEIUE8YoQm0XtN6t7kCJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6x5A6hSUnuyBxeEIUE8YoQm0XtN6t7kCJ
Content-Type: multipart/mixed; boundary="qhdb2900SAJMcBGUSt4068I5n8riGKQ7j";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
 DRI Development <dri-devel@lists.freedesktop.org>
Cc: David Airlie <airlied@linux.ie>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org, Gerd Hoffmann
 <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>
Message-ID: <68e36b4b-139c-22c4-3028-26c2b50628f7@suse.de>
Subject: Re: [PATCH 4/9] drm/virtio: Call the right shmem helpers
References: <20200511093554.211493-1-daniel.vetter@ffwll.ch>
 <20200511093554.211493-5-daniel.vetter@ffwll.ch>
In-Reply-To: <20200511093554.211493-5-daniel.vetter@ffwll.ch>

--qhdb2900SAJMcBGUSt4068I5n8riGKQ7j
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 11.05.20 um 11:35 schrieb Daniel Vetter:
> drm_gem_shmem_get_sg_table is meant to implement
> obj->funcs->get_sg_table, for prime exporting. The one we want is
> drm_gem_shmem_get_pages_sgt, which also handles imported dma-buf, not
> just native objects.
>=20
> v2: Rebase, this stuff moved around in
>=20
> commit 2f2aa13724d56829d910b2fa8e80c502d388f106
> Author: Gerd Hoffmann <kraxel@redhat.com>
> Date:   Fri Feb 7 08:46:38 2020 +0100
>=20
>     drm/virtio: move virtio_gpu_mem_entry initialization to new functio=
n
>=20
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> Cc: David Airlie <airlied@linux.ie>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/=
virtio/virtgpu_object.c
> index 6ccbd01cd888..346cef5ce251 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -150,7 +150,7 @@ static int virtio_gpu_object_shmem_init(struct virt=
io_gpu_device *vgdev,
>  	if (ret < 0)
>  		return -EINVAL;
> =20
> -	shmem->pages =3D drm_gem_shmem_get_sg_table(&bo->base.base);
> +	shmem->pages =3D drm_gem_shmem_get_pages_sgt(&bo->base.base);
>  	if (!shmem->pages) {
>  		drm_gem_shmem_unpin(&bo->base.base);
>  		return -EINVAL;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--qhdb2900SAJMcBGUSt4068I5n8riGKQ7j--

--6x5A6hSUnuyBxeEIUE8YoQm0XtN6t7kCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl68904ACgkQaA3BHVML
eiPtXAf+KYC6fzY0k/WOjwie9brnUcYcOQ6oc2++J3WIgkgVwB1d05ZQAWXdGwg/
ysGvcW9AnKTmdrOKwWujlHuLbFnpev7ET52b5yR1fU9rSUaf9VnZz3CD5NZGTxYU
iNmIkXEZEWymeqrIXtyaNMz8Tv6yYinUVsiRfSlwHnLNHnNJXRNUGa21Sf6qEuPD
wrYkwh4Cw2bjN+ceb/pR5MwjfHhJ5krTunin9xE9SH3QKFhlUZsrbPJHZ+wIBCmh
f4RqFtTm8PY+4qV1HE424xZTel2b9KpJZFHn+h1yw96dGSDBtKXOFAO0JHkL26Uk
mSt7aov2kFJci703eiDYNHU/jiZ+LQ==
=74XA
-----END PGP SIGNATURE-----

--6x5A6hSUnuyBxeEIUE8YoQm0XtN6t7kCJ--

--===============0135323606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0135323606==--
