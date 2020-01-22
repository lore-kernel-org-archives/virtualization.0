From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 1/4] drm: Add drm_crtc_has_vblank()
Date: Wed, 22 Jan 2020 09:53:42 +0100
Message-ID: <3ad03b06-f9be-37c7-9cc7-044468cdf300@suse.de>
References: <20200120122051.25178-1-tzimmermann@suse.de>
 <20200120122051.25178-2-tzimmermann@suse.de>
 <20200122083139.GP43062@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5595625026014667621=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200122083139.GP43062@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: laurent.pinchart@ideasonboard.com, david@lechnology.com, oleksandr_andrushchenko@epam.com, airlied@linux.ie, sean@poorly.run, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, hdegoede@redhat.com, xen-devel@lists.xenproject.org, sam@ravnborg.org, emil.velikov@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5595625026014667621==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ukGbA0WF7ueGJSb0kAo69CYC5oJMXwLf5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ukGbA0WF7ueGJSb0kAo69CYC5oJMXwLf5
Content-Type: multipart/mixed; boundary="vrjq2MwPI2wsvdcv8O7Xzud45fILL1HN9";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: david@lechnology.com, oleksandr_andrushchenko@epam.com, airlied@linux.ie,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, hdegoede@redhat.com,
 kraxel@redhat.com, xen-devel@lists.xenproject.org,
 emil.velikov@collabora.com, sean@poorly.run,
 laurent.pinchart@ideasonboard.com
Message-ID: <3ad03b06-f9be-37c7-9cc7-044468cdf300@suse.de>
Subject: Re: [PATCH v3 1/4] drm: Add drm_crtc_has_vblank()
References: <20200120122051.25178-1-tzimmermann@suse.de>
 <20200120122051.25178-2-tzimmermann@suse.de>
 <20200122083139.GP43062@phenom.ffwll.local>
In-Reply-To: <20200122083139.GP43062@phenom.ffwll.local>

--vrjq2MwPI2wsvdcv8O7Xzud45fILL1HN9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 22.01.20 um 09:31 schrieb Daniel Vetter:
> On Mon, Jan 20, 2020 at 01:20:48PM +0100, Thomas Zimmermann wrote:
>> The new interface drm_crtc_has_vblank() return true if vblanking has
>> been initialized for a certain CRTC, or false otherwise. This function=

>> will be useful for initializing CRTC state.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>  drivers/gpu/drm/drm_vblank.c | 21 +++++++++++++++++++++
>>  include/drm/drm_vblank.h     |  1 +
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank=
=2Ec
>> index 1659b13b178c..c20102899411 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> @@ -501,6 +501,27 @@ int drm_vblank_init(struct drm_device *dev, unsig=
ned int num_crtcs)
>>  }
>>  EXPORT_SYMBOL(drm_vblank_init);
>> =20
>> +/**
>> + * drm_crtc_has_vblank - test if vblanking has been initialized for
>> + *                       a CRTC
>> + * @crtc: the CRTC
>> + *
>> + * Drivers may call this function to test if vblank support is
>> + * initialized for a CRTC. For most hardware this means that vblankin=
g
>> + * can also be enabled on the CRTC.
>> + *
>> + * Returns:
>> + * True if vblanking has been initialized for the given CRTC, false
>> + * otherwise.
>> + */
>> +bool drm_crtc_has_vblank(const struct drm_crtc *crtc)
>=20
> So making this specific to a CRTC sounds like a good idea. But it's not=

> the reality, drm_vblank.c assumes that either everything or nothing
> supports vblanks.
>=20
> The reason for dev->num_crtcs is historical baggage, it predates kms by=
 a
> few years. For kms drivers the only two valid values are either 0 or
> dev->mode_config.num_crtcs. Yes that's an entire different can of worms=

> that's been irking me since forever (ideally drm_vblank_init would some=
how
> loose the num_crtcs argument for kms drivers, but some drivers call thi=
s
> before they've done all the drm_crtc_init calls so it's complicated).

Maybe as a first step, drm_vblank_init() could use
dev->mode_config.num_crtcs if the supplied number of CRTCs is zero.

>=20
> Hence drm_dev_has_vblank as I suggested. That would also allow you to
> replace a bunch of if (dev->num_crtcs) checks in drm_vblank.c, which
> should help quite a bit in code readability.

OK, but I still don't understand why this interface is better overall.
We don't loose anything by passing in the crtc instead of the device
structure. And if there's ever a per-crtc vblank initialization, we'd
have the interface in place already. The tests with "if
(dev->num_crtcs)" could probably be removed in most places in any case.

We should also consider forking the vblank code for non-KMS drivers.
While working in this, I found the support for legacy drivers is getting
in the way at times. With such a fork, legacy drivers could continue
using struct drm_vblank_crtc, while modern drivers could maybe store
vblank state directly in struct drm_crtc.

Anyway, all this is for another patch. Unless you change your mind, I'll
replace drm_crtc_has_vblank() with drm_dev_has_vblank() for the
patchset's next iteration.

Best regards
Thomas

>=20
> Cheers, Daniel
>=20
>> +{
>> +	struct drm_device *dev =3D crtc->dev;
>> +
>> +	return crtc->index < dev->num_crtcs;
>> +}
>> +EXPORT_SYMBOL(drm_crtc_has_vblank);
>> +
>>  /**
>>   * drm_crtc_vblank_waitqueue - get vblank waitqueue for the CRTC
>>   * @crtc: which CRTC's vblank waitqueue to retrieve
>> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
>> index c16c44052b3d..531a6bc12b7e 100644
>> --- a/include/drm/drm_vblank.h
>> +++ b/include/drm/drm_vblank.h
>> @@ -206,6 +206,7 @@ struct drm_vblank_crtc {
>>  };
>> =20
>>  int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
>> +bool drm_crtc_has_vblank(const struct drm_crtc *crtc);
>>  u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
>>  u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
>>  				   ktime_t *vblanktime);
>> --=20
>> 2.24.1
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--vrjq2MwPI2wsvdcv8O7Xzud45fILL1HN9--

--ukGbA0WF7ueGJSb0kAo69CYC5oJMXwLf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl4oDZYACgkQaA3BHVML
eiMsSAf/eR0FZiJzOsVBcz3DBaFTiM5pFltivDonnJagTG6sWR9peCCPccGuKwtX
UOV3t89CfGkO086lBvh4drvJZ7YsarwPhgLn01E6EMNqzHzK2wuSFRD4jtWotaIY
DQVMAG8qMKOUb73KEAUkDw+KXohoezRHsMFPOETSpwizATfXhidEt6irGh7WjhNt
ECADQpwp4jecRk9EfDY5oHFP8BWMRb1lBipufQ3ozm37wmJws52/kiYxKssxc4A1
QLdCR0mkFMDQ3GN1hPWiAC8wIRTQWyxlrmJDUf08FeJxOX1PjQzl3UKVJ0N2eeAi
sASQ1s84N8wBT3YyIwAg9xuhg2O1Zg==
=Dldh
-----END PGP SIGNATURE-----

--ukGbA0WF7ueGJSb0kAo69CYC5oJMXwLf5--

--===============5595625026014667621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5595625026014667621==--
