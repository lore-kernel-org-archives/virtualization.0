From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 3/6] drm/fb-helper: Instanciate shadow FB if configured
	in device's mode_config
Date: Sun, 7 Jul 2019 18:14:50 +0200
Message-ID: <59111691-5283-fb50-94a9-6960c425e81c__43575.1460537844$1562516455$gmane$org@suse.de>
References: <20190705092613.7621-1-tzimmermann@suse.de>
	<20190705092613.7621-4-tzimmermann@suse.de>
	<68f5783f-8022-3238-a6d9-c6a774b39633@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1213797090101706173=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <68f5783f-8022-3238-a6d9-c6a774b39633@tronnes.org>
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
--===============1213797090101706173==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xrnQnM9U0vnHwBglvDO2alPx0W8Zsc3qs"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xrnQnM9U0vnHwBglvDO2alPx0W8Zsc3qs
Content-Type: multipart/mixed; boundary="iCnlfK9L0EAkOjP9IGk8gypWQ2kKFJIyg";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, airlied@redhat.com,
 daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com,
 maxime.ripard@bootlin.com, sean@poorly.run, sam@ravnborg.org,
 yc_chen@aspeedtech.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <59111691-5283-fb50-94a9-6960c425e81c@suse.de>
Subject: Re: [PATCH v2 3/6] drm/fb-helper: Instanciate shadow FB if configured
 in device's mode_config
References: <20190705092613.7621-1-tzimmermann@suse.de>
 <20190705092613.7621-4-tzimmermann@suse.de>
 <68f5783f-8022-3238-a6d9-c6a774b39633@tronnes.org>
In-Reply-To: <68f5783f-8022-3238-a6d9-c6a774b39633@tronnes.org>

--iCnlfK9L0EAkOjP9IGk8gypWQ2kKFJIyg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 07.07.19 um 16:37 schrieb Noralf Tr=C3=B8nnes:
>=20
>=20
> Den 05.07.2019 11.26, skrev Thomas Zimmermann:
>> Generic framebuffer emulation uses a shadow buffer for framebuffers wi=
th
>> dirty() function. If drivers want to use the shadow FB without such a
>> function, they can now set prefer_shadow or prefer_shadow_fbdev in the=
ir
>> mode_config structures. The former flag is exported to userspace, the =
latter
>> flag is fbdev-only.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>  drivers/gpu/drm/drm_fb_helper.c | 19 ++++++++++++++-----
>>  include/drm/drm_mode_config.h   |  5 +++++
>>  2 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_=
helper.c
>> index 7ba6a0255821..56ef169e1814 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -421,7 +421,9 @@ static void drm_fb_helper_dirty_work(struct work_s=
truct *work)
>>  				return;
>>  			drm_fb_helper_dirty_blit_real(helper, &clip_copy);
>>  		}
>> -		helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip_copy, 1);
>> +		if (helper->fb->funcs->dirty)
>> +			helper->fb->funcs->dirty(helper->fb, NULL, 0, 0,
>> +						 &clip_copy, 1);
>> =20
>>  		if (helper->buffer)
>>  			drm_client_buffer_vunmap(helper->buffer);
>> @@ -620,9 +622,6 @@ static void drm_fb_helper_dirty(struct fb_info *in=
fo, u32 x, u32 y,
>>  	struct drm_clip_rect *clip =3D &helper->dirty_clip;
>>  	unsigned long flags;
>> =20
>> -	if (!helper->fb->funcs->dirty)
>> -		return;
>=20
> drm_fb_helper_dirty() is called unconditionally by
> drm_fb_helper_sys_imageblit() et al, so we need check with
> drm_fbdev_use_shadow_fb() here.
>=20
>> -
>>  	spin_lock_irqsave(&helper->dirty_lock, flags);
>>  	clip->x1 =3D min_t(u32, clip->x1, x);
>>  	clip->y1 =3D min_t(u32, clip->y1, y);
>> @@ -2166,6 +2165,16 @@ static struct fb_deferred_io drm_fbdev_defio =3D=
 {
>>  	.deferred_io	=3D drm_fb_helper_deferred_io,
>>  };
>> =20
>> +static bool drm_fbdev_use_shadow_fb(struct drm_fb_helper *fb_helper)
>> +{
>> +	struct drm_device *dev =3D fb_helper->dev;
>> +	struct drm_framebuffer *fb =3D fb_helper->fb;
>> +
>> +	return dev->mode_config.prefer_shadow_fbdev |
>> +	       dev->mode_config.prefer_shadow |
>=20
> Use logical OR here
>=20
>> +	       !!fb->funcs->dirty;
>=20
> and you can drop the the double NOT here.
>=20
>> +}
>> +
>>  /**
>>   * drm_fb_helper_generic_probe - Generic fbdev emulation probe helper=

>>   * @fb_helper: fbdev helper structure
>> @@ -2213,7 +2222,7 @@ int drm_fb_helper_generic_probe(struct drm_fb_he=
lper *fb_helper,
>> =20
>>  	drm_fb_helper_fill_info(fbi, fb_helper, sizes);
>> =20
>> -	if (fb->funcs->dirty) {
>> +	if (drm_fbdev_use_shadow_fb(fb_helper)) {
>>  		struct fb_ops *fbops;
>>  		void *shadow;
>> =20
>> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_conf=
ig.h
>> index 759d462d028b..e1c751aca353 100644
>> --- a/include/drm/drm_mode_config.h
>> +++ b/include/drm/drm_mode_config.h
>> @@ -347,6 +347,8 @@ struct drm_mode_config_funcs {
>>   * @output_poll_work: delayed work for polling in process context
>>   * @preferred_depth: preferred RBG pixel depth, used by fb helpers
>>   * @prefer_shadow: hint to userspace to prefer shadow-fb rendering
>> + * @prefer_shadow_fbdev: hint to framebuffer emulation to prefer shad=
ow-fb \
>> +	rendering
>=20
> It's preferred to have the doc together with the struct member.

I just tried to follow the file's existing style, but OK, I don't mind.

> it's less likely to be forgotten when things change. And we don't use
> line cont. when the doc line is too long. Just continue on the next lin=
e
> after an asterix.
>=20
>>   * @cursor_width: hint to userspace for max cursor width
>>   * @cursor_height: hint to userspace for max cursor height
>>   * @helper_private: mid-layer private data
>> @@ -852,6 +854,9 @@ struct drm_mode_config {
>>  	/* dumb ioctl parameters */
>>  	uint32_t preferred_depth, prefer_shadow;
>> =20
>> +	/* fbdev parameters */
>=20
> No need for this comment.
>=20
> Doc can look like this, I've done s/framebuffer/fbdev/:
> 	/**
> 	 * @prefer_shadow_fbdev:
> 	 *
> 	 * Hint to fbdev emulation to prefer shadow-fb rendering.
> 	 */
>=20
>> +	uint32_t prefer_shadow_fbdev;
>=20
> Use bool here.
>=20
> With that:
>=20
> Reviewed-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
>=20
> I have tested this on 2 drivers that use generic fbdev: vc4 (no shadow
> buf) and mi0283qt which has a dirty callback.
>=20
> Tested-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>

Thanks for reviewing and testing the patches.

Best regards
Thomas

>=20
>> +
>>  	/**
>>  	 * @quirk_addfb_prefer_xbgr_30bpp:
>>  	 *
>>
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


--iCnlfK9L0EAkOjP9IGk8gypWQ2kKFJIyg--

--xrnQnM9U0vnHwBglvDO2alPx0W8Zsc3qs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl0iGn4ACgkQaA3BHVML
eiNNIggAthjAg3eHNki+tZpOoHKASavxIe/t/vQKl0A6bQF1Lp3K2ruEEEtejAfn
qgoOHuzj38Q5ZcxVPsXi//9/6dAybXGvDhjrP1diuSVqzQAkXjPMG0lyjL5ygjbe
KUXI7yRE2zpnLOvbzbzyDiTkA7VkuZNOxak/zxCb9kfUDXoDrfS1aTiqcznz7vo5
YXDBXlG2+WexebBhbqp9mIOzU33KaAjXNsIEN1VHCxCNBU1WO69uyCUk6DP6H1u7
08zZgDSObadLtxe/g9hwi4KmusX50aAPL0s7RkVQ5gecf7W6Hbpu7T28G6VYMLyg
ciZlUzHy9axBkKaYvNl8QrFt2AXeWw==
=Wx+J
-----END PGP SIGNATURE-----

--xrnQnM9U0vnHwBglvDO2alPx0W8Zsc3qs--

--===============1213797090101706173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1213797090101706173==--
