From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/5] Unmappable DRM client buffers for fbdev emulation
Date: Thu, 4 Jul 2019 13:10:41 +0200
Message-ID: <5f9c7df7-3805-0e23-4201-be08d41da791__1961.03852228902$1562238673$gmane$org@suse.de>
References: <20190703083302.2609-1-tzimmermann@suse.de>
	<a2e3baa8-f8e8-4628-e18f-cb3119194afb@tronnes.org>
	<aa1b7431-21c5-4c99-bfb6-6c5e4946bec3@suse.de>
	<18d573b4-3cb8-dc4a-bee3-a8b9b0a18a28@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4473498186295515183=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <18d573b4-3cb8-dc4a-bee3-a8b9b0a18a28@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, airlied@redhat.com, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com, sean@poorly.run, sam@ravnborg.org, yc_chen@aspeedtech.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4473498186295515183==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2YlZXm381wi3QxEcCjh15mcEVBeNTERri"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2YlZXm381wi3QxEcCjh15mcEVBeNTERri
Content-Type: multipart/mixed; boundary="RwqlKBf3ad6kiFP0rwq0HbCY7flPMBW2n";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, airlied@redhat.com,
 daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com,
 maxime.ripard@bootlin.com, sean@poorly.run, sam@ravnborg.org,
 yc_chen@aspeedtech.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <5f9c7df7-3805-0e23-4201-be08d41da791@suse.de>
Subject: Re: [PATCH 0/5] Unmappable DRM client buffers for fbdev emulation
References: <20190703083302.2609-1-tzimmermann@suse.de>
 <a2e3baa8-f8e8-4628-e18f-cb3119194afb@tronnes.org>
 <aa1b7431-21c5-4c99-bfb6-6c5e4946bec3@suse.de>
 <18d573b4-3cb8-dc4a-bee3-a8b9b0a18a28@tronnes.org>
In-Reply-To: <18d573b4-3cb8-dc4a-bee3-a8b9b0a18a28@tronnes.org>

--RwqlKBf3ad6kiFP0rwq0HbCY7flPMBW2n
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 04.07.19 um 12:18 schrieb Noralf Tr=C3=B8nnes:
>=20
>=20
> Den 04.07.2019 09.43, skrev Thomas Zimmermann:
>> Hi
>>
>> Am 03.07.19 um 21:27 schrieb Noralf Tr=C3=B8nnes:
>>>
>>>
>>> Den 03.07.2019 10.32, skrev Thomas Zimmermann:
>>>> DRM client buffers are permanently mapped throughout their lifetime.=
 This
>>>> prevents us from using generic framebuffer emulation for devices wit=
h
>>>> small dedicated video memory, such as ast or mgag200. With fb buffer=
s
>>>> permanently mapped, such devices often won't have enougth space left=
 to
>>>> display other content (e.g., X11).
>>>>
>>>> This patch set introduces unmappable DRM client buffers for framebuf=
fer
>>>> emulation with shadow buffers. While the shadow buffer remains in sy=
stem
>>>> memory permanently, the respective buffer object will only be mapped=
 briefly
>>>> during updates from the shadow buffer. Hence, the driver can relocat=
e he
>>>> buffer object among memory regions as needed.
>>>>
>>>> The default behoviour for DRM client buffers is still to be permanen=
tly
>>>> mapped.
>>>>
>>>> The patch set converts ast and mgag200 to generic framebuffer emulat=
ion
>>>> and removes a large amount of framebuffer code from these drivers. F=
or
>>>> bochs, a problem was reported where the driver could not display the=
 console
>>>> because it was pinned in system memory. [1] The patch set fixes this=
 bug
>>>> by converting bochs to use the shadow fb.
>>>>
>>>> The patch set has been tested on ast and mga200 HW.
>>>>
>>>
>>> I've been thinking, this enables dirty tracking in DRM userspace for
>>> these drivers since the dirty callback is now set on all framebuffers=
=2E
>>> Is this OK? Should we add a drm_fbdev_generic_shadow_setup() that set=
s a
>>> flag enabling the shadow buffer instead?
>>
>> Fbdev emulation is special wrt framebuffer setup and there's no way to=

>> distinguish a regular FB from the fbdev's FB. I've been trying
>> drm_fbdev_generic_shadow_setup(), but ended up duplicating
>> functionality. The problem was that we cannot get state-flag arguments=

>> into drm_fb_helper_generic_probe().
>>
>> There already is struct mode_config.prefer_shadow. It signals shadow F=
B
>> rendering to userspace. The easiest solution is to add
>> prefer_shadow_fbdev as well. If either flag is true, fbdev emulation
>> would enable shadow buffering.
>=20
> How about something like this:

I had something like that in mind, but maybe without a separate
function. I'll post my variant as part of the patch set's next iteration.=


> diff --git a/drivers/gpu/drm/drm_fb_helper.c
> b/drivers/gpu/drm/drm_fb_helper.c
> index 1984e5c54d58..723fe56aa5f5 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -415,7 +415,8 @@ static void drm_fb_helper_dirty_work(struct
> work_struct *work)
>  		/* Generic fbdev uses a shadow buffer */
>  		if (helper->buffer)
>  			drm_fb_helper_dirty_blit_real(helper, &clip_copy);
> -		helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip_copy, 1);
> +		if (helper->fb->funcs->dirty)
> +			helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip_copy, 1);
>  	}
>  }
>=20
> @@ -2209,7 +2210,7 @@ int drm_fb_helper_generic_probe(struct
> drm_fb_helper *fb_helper,
>  #endif
>  	drm_fb_helper_fill_info(fbi, fb_helper, sizes);
>=20
> -	if (fb->funcs->dirty) {
> +	if (fb->funcs->dirty || fb_helper->use_shadow) {
>  		struct fb_ops *fbops;
>  		void *shadow;
>=20
> @@ -2310,6 +2311,44 @@ static const struct drm_client_funcs
> drm_fbdev_client_funcs =3D {
>  	.hotplug	=3D drm_fbdev_client_hotplug,
>  };
>=20
> +static int _drm_fbdev_generic_setup(struct drm_device *dev, unsigned
> int preferred_bpp, bool use_shadow)
> +{
> +	struct drm_fb_helper *fb_helper;
> +	int ret;
> +
> +	WARN(dev->fb_helper, "fb_helper is already set!\n");
> +
> +	if (!drm_fbdev_emulation)
> +		return 0;
> +
> +	fb_helper =3D kzalloc(sizeof(*fb_helper), GFP_KERNEL);
> +	if (!fb_helper)
> +		return -ENOMEM;
> +
> +	ret =3D drm_client_init(dev, &fb_helper->client, "fbdev",
> &drm_fbdev_client_funcs);
> +	if (ret) {
> +		kfree(fb_helper);
> +		DRM_DEV_ERROR(dev->dev, "Failed to register client: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!preferred_bpp)
> +		preferred_bpp =3D dev->mode_config.preferred_depth;
> +	if (!preferred_bpp)
> +		preferred_bpp =3D 32;
> +	fb_helper->preferred_bpp =3D preferred_bpp;
> +
> +	fb_helper->use_shadow =3D use_shadow;
> +
> +	ret =3D drm_fbdev_client_hotplug(&fb_helper->client);
> +	if (ret)
> +		DRM_DEV_DEBUG(dev->dev, "client hotplug ret=3D%d\n", ret);
> +
> +	drm_client_register(&fb_helper->client);
> +
> +	return 0;
> +}
> +
>  /**
>   * drm_fbdev_generic_setup() - Setup generic fbdev emulation
>   * @dev: DRM device
> @@ -2338,38 +2377,13 @@ static const struct drm_client_funcs
> drm_fbdev_client_funcs =3D {
>   */
>  int drm_fbdev_generic_setup(struct drm_device *dev, unsigned int
> preferred_bpp)
>  {
> -	struct drm_fb_helper *fb_helper;
> -	int ret;
> +	return _drm_fbdev_generic_setup(dev, preferred_bpp, false);
> +}
> +EXPORT_SYMBOL(drm_fbdev_generic_setup);
>=20
> -	WARN(dev->fb_helper, "fb_helper is already set!\n");
> -
> -	if (!drm_fbdev_emulation)
> -		return 0;
> -
> -	fb_helper =3D kzalloc(sizeof(*fb_helper), GFP_KERNEL);
> -	if (!fb_helper)
> -		return -ENOMEM;
> -
> -	ret =3D drm_client_init(dev, &fb_helper->client, "fbdev",
> &drm_fbdev_client_funcs);
> -	if (ret) {
> -		kfree(fb_helper);
> -		DRM_DEV_ERROR(dev->dev, "Failed to register client: %d\n", ret);
> -		return ret;
> -	}
> -
> -	if (!preferred_bpp)
> -		preferred_bpp =3D dev->mode_config.preferred_depth;
> -	if (!preferred_bpp)
> -		preferred_bpp =3D 32;
> -	fb_helper->preferred_bpp =3D preferred_bpp;
> -
> -	ret =3D drm_fbdev_client_hotplug(&fb_helper->client);
> -	if (ret)
> -		DRM_DEV_DEBUG(dev->dev, "client hotplug ret=3D%d\n", ret);
> -
> -	drm_client_register(&fb_helper->client);
> -
> -	return 0;
> +int drm_fbdev_generic_shadow_setup(struct drm_device *dev, unsigned in=
t
> preferred_bpp)
> +{
> +	return _drm_fbdev_generic_setup(dev, preferred_bpp, true);
>  }
>  EXPORT_SYMBOL(drm_fbdev_generic_setup);
>=20
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index c8a8ae2a678a..39f063de8cbc 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -186,6 +186,8 @@ struct drm_fb_helper {
>  	 * See also: @deferred_setup
>  	 */
>  	int preferred_bpp;
> +
> +	bool use_shadow;
>  };
>=20
>  static inline struct drm_fb_helper *
>=20
>=20
>>
>> I'm not sure if we should check for the dirty() callback at all.
>>
>=20
> Hm, why do you think that?

Drivers may already come with their own shadow buffer. Cirrus is an
example of that. It uses shmem buffer objects as shadow fbs and
internally updates the device frame buffer in its dirty callback. Using
dirty() to select the shadow fbdev adds another buffer (and another
memcpy) for no reason.

Best regards
Thomas

> The thing with fbdev defio is that it only supports kmalloc and vmalloc=

> allocated memory (page->lru is avail.). This means that only the CMA
> drivers can use defio without shadow memory. To keep things simple
> everyone with a dirty() callback gets a shadow buffer.
>=20
> Noralf.
>=20
>> Best regards
>> Thomas
>>
>>> Really nice diffstat by the way :-)
>>>
>>> Noralf.
>>>
>>>> [1] https://lists.freedesktop.org/archives/dri-devel/2019-June/22442=
3.html
>>>>
>>>> Thomas Zimmermann (5):
>>>>   drm/client: Support unmapping of DRM client buffers
>>>>   drm/fb-helper: Unmap BO for shadow-buffered framebuffer console
>>>>   drm/ast: Replace struct ast_fbdev with generic framebuffer emulati=
on
>>>>   drm/bochs: Use shadow buffer for bochs framebuffer console
>>>>   drm/mgag200: Replace struct mga_fbdev with generic framebuffer
>>>>     emulation
>>>>
>>>>  drivers/gpu/drm/ast/Makefile           |   2 +-
>>>>  drivers/gpu/drm/ast/ast_drv.c          |  22 +-
>>>>  drivers/gpu/drm/ast/ast_drv.h          |  17 --
>>>>  drivers/gpu/drm/ast/ast_fb.c           | 341 ----------------------=
---
>>>>  drivers/gpu/drm/ast/ast_main.c         |  30 ++-
>>>>  drivers/gpu/drm/ast/ast_mode.c         |  21 --
>>>>  drivers/gpu/drm/bochs/bochs_kms.c      |   2 +-
>>>>  drivers/gpu/drm/drm_client.c           |  71 ++++-
>>>>  drivers/gpu/drm/drm_fb_helper.c        |  14 +-
>>>>  drivers/gpu/drm/mgag200/Makefile       |   2 +-
>>>>  drivers/gpu/drm/mgag200/mgag200_drv.h  |  19 --
>>>>  drivers/gpu/drm/mgag200/mgag200_fb.c   | 309 ----------------------=

>>>>  drivers/gpu/drm/mgag200/mgag200_main.c |  61 +++--
>>>>  drivers/gpu/drm/mgag200/mgag200_mode.c |  27 --
>>>>  include/drm/drm_client.h               |   3 +
>>>>  15 files changed, 154 insertions(+), 787 deletions(-)
>>>>  delete mode 100644 drivers/gpu/drm/ast/ast_fb.c
>>>>  delete mode 100644 drivers/gpu/drm/mgag200/mgag200_fb.c
>>>>
>>>> --
>>>> 2.21.0
>>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
>>

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--RwqlKBf3ad6kiFP0rwq0HbCY7flPMBW2n--

--2YlZXm381wi3QxEcCjh15mcEVBeNTERri
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl0d3rEACgkQaA3BHVML
eiPm+Af+OvNUALsoY8KQs6rDNvix4ePovOVG3hdYnr62xO4rv5t0JFkq4wztoOky
Ld2WCeR/bYz8kudKoO2A1KdQRpXVYYKndk1bccLpUPSiMld1nMxD1sT8wHzd5qtv
Bu14RLjwfIYznpN6exSoi1ZlcqQNd7GViZ/mL9OTUfgKy2/58hbIzVxSuy0DDnyL
PZJmpUpG8OtrwBFasgNGCjrxg+SIz021sDq+LJbFCg3+0eIW/77ZYAaybGeyfNKz
DxmZdqaEUBr44rodrrdFcCarl17B0YEsfqVj+VSyi0wnpQ1j72vXdktD533bDlsb
FqZCiDveYknwqqqDpRgAWB+ykHWKWA==
=Xs81
-----END PGP SIGNATURE-----

--2YlZXm381wi3QxEcCjh15mcEVBeNTERri--

--===============4473498186295515183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4473498186295515183==--
