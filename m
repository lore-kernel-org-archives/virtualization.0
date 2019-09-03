From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/5] drm/qxl: use drm_gem_object_funcs callbacks
Date: Tue, 3 Sep 2019 08:52:27 +0200
Message-ID: <61b2c31a-6d0a-c42d-a456-ea13b17c9aec__10297.2325332061$1567493565$gmane$org@suse.de>
References: <20190902124126.7700-1-kraxel@redhat.com>
	<20190902124126.7700-5-kraxel@redhat.com>
	<0a9d97c7-26a4-bee6-e9a2-120abbd5277c@suse.de>
	<20190903062417.a4gpgaollk5jruas@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6868157641012300855=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190903062417.a4gpgaollk5jruas@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6868157641012300855==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sTjO2c2Xh1w2ytuKOwUgkevjL9602HtnZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sTjO2c2Xh1w2ytuKOwUgkevjL9602HtnZ
Content-Type: multipart/mixed; boundary="iawTWFCrY3WzO9gNZyPaM2AqQcrXu2JUN";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Dave Airlie
 <airlied@redhat.com>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>
Message-ID: <61b2c31a-6d0a-c42d-a456-ea13b17c9aec@suse.de>
Subject: Re: [PATCH 4/5] drm/qxl: use drm_gem_object_funcs callbacks
References: <20190902124126.7700-1-kraxel@redhat.com>
 <20190902124126.7700-5-kraxel@redhat.com>
 <0a9d97c7-26a4-bee6-e9a2-120abbd5277c@suse.de>
 <20190903062417.a4gpgaollk5jruas@sirius.home.kraxel.org>
In-Reply-To: <20190903062417.a4gpgaollk5jruas@sirius.home.kraxel.org>

--iawTWFCrY3WzO9gNZyPaM2AqQcrXu2JUN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 03.09.19 um 08:24 schrieb Gerd Hoffmann:
> On Mon, Sep 02, 2019 at 04:34:49PM +0200, Thomas Zimmermann wrote:
>> This patch seems unrelated.
>=20
> Well, patch 5/5 depends on it because it hooks the
> drm_gem_ttm_print_info helper into the new
> qxl_object_funcs added by this patch.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>


>=20
>> Am 02.09.19 um 14:41 schrieb Gerd Hoffmann:
>>> Switch qxl to use drm_gem_object_funcs callbacks
>>> instead of drm_driver callbacks.
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>  drivers/gpu/drm/qxl/qxl_drv.c    |  8 --------
>>>  drivers/gpu/drm/qxl/qxl_object.c | 12 ++++++++++++
>>>  2 files changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_=
drv.c
>>> index 2b726a51a302..996d428fa7e6 100644
>>> --- a/drivers/gpu/drm/qxl/qxl_drv.c
>>> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
>>> @@ -258,16 +258,8 @@ static struct drm_driver qxl_driver =3D {
>>>  #endif
>>>  	.prime_handle_to_fd =3D drm_gem_prime_handle_to_fd,
>>>  	.prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
>>> -	.gem_prime_pin =3D qxl_gem_prime_pin,
>>> -	.gem_prime_unpin =3D qxl_gem_prime_unpin,
>>> -	.gem_prime_get_sg_table =3D qxl_gem_prime_get_sg_table,
>>>  	.gem_prime_import_sg_table =3D qxl_gem_prime_import_sg_table,
>>> -	.gem_prime_vmap =3D qxl_gem_prime_vmap,
>>> -	.gem_prime_vunmap =3D qxl_gem_prime_vunmap,
>>>  	.gem_prime_mmap =3D qxl_gem_prime_mmap,
>>> -	.gem_free_object_unlocked =3D qxl_gem_object_free,
>>> -	.gem_open_object =3D qxl_gem_object_open,
>>> -	.gem_close_object =3D qxl_gem_object_close,
>>>  	.fops =3D &qxl_fops,
>>>  	.ioctls =3D qxl_ioctls,
>>>  	.irq_handler =3D qxl_irq_handler,
>>> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/q=
xl_object.c
>>> index 548dfe6f3b26..29aab7b14513 100644
>>> --- a/drivers/gpu/drm/qxl/qxl_object.c
>>> +++ b/drivers/gpu/drm/qxl/qxl_object.c
>>> @@ -77,6 +77,17 @@ void qxl_ttm_placement_from_domain(struct qxl_bo *=
qbo, u32 domain, bool pinned)
>>>  	}
>>>  }
>>> =20
>>> +static const struct drm_gem_object_funcs qxl_object_funcs =3D {
>>> +	.free =3D qxl_gem_object_free,
>>> +	.open =3D qxl_gem_object_open,
>>> +	.close =3D qxl_gem_object_close,
>>> +	.pin =3D qxl_gem_prime_pin,
>>> +	.unpin =3D qxl_gem_prime_unpin,
>>> +	.get_sg_table =3D qxl_gem_prime_get_sg_table,
>>> +	.vmap =3D qxl_gem_prime_vmap,
>>> +	.vunmap =3D qxl_gem_prime_vunmap,
>>> +};
>>> +
>>>  int qxl_bo_create(struct qxl_device *qdev,
>>>  		  unsigned long size, bool kernel, bool pinned, u32 domain,
>>>  		  struct qxl_surface *surf,
>>> @@ -100,6 +111,7 @@ int qxl_bo_create(struct qxl_device *qdev,
>>>  		kfree(bo);
>>>  		return r;
>>>  	}
>>> +	bo->tbo.base.funcs =3D &qxl_object_funcs;
>>>  	bo->type =3D domain;
>>>  	bo->pin_count =3D pinned ? 1 : 0;
>>>  	bo->surface_id =3D 0;
>>>
>>
>> --=20
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
>> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
>> HRB 21284 (AG N=C3=BCrnberg)
>>
>=20
>=20
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--iawTWFCrY3WzO9gNZyPaM2AqQcrXu2JUN--

--sTjO2c2Xh1w2ytuKOwUgkevjL9602HtnZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl1uDa8ACgkQaA3BHVML
eiPQoQf/Wl/J5K/3RKwGAJERCr8fOCYgY7SYWZoF4BJknAUMFttOVdQ/V3lvJIrR
4Tr1l5MNfKwJGdOoQuSBvJU+WD3Nq/xQHLvc+2ZqHF3FYASr1EBp88Kj8CHLMdnP
tsLXP3aE7YQ0eo2XRJnc8lyoOKf0gCLox/wAs+PPQQ8DjGkvg9VoF+a4WaxoTUg2
s5zvfkuTnQRiSY0AGo9uHl3usBtDb/wE0lM4ZJBlciorkd9dU0vAM4y2uk7QbHJS
s5gaYaD0eyyd662jyADWR0y/ii2LSZh1Yjb3SqrbCWHkY6HAnW41iregzvydB3fP
ihmam6WVMv6BKWwDv0OMpnhO9SFktg==
=BJVE
-----END PGP SIGNATURE-----

--sTjO2c2Xh1w2ytuKOwUgkevjL9602HtnZ--

--===============6868157641012300855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6868157641012300855==--
