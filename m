From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/6] drm: Add drm_simple_encoder_{init,create}()
Date: Fri, 7 Feb 2020 15:02:00 +0100
Message-ID: <86073cfa-496d-53d7-e4c4-9736128109fa@suse.de>
References: <20200207084135.4524-1-tzimmermann@suse.de>
 <20200207084135.4524-3-tzimmermann@suse.de>
 <20200207133720.GZ43062@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0986752664680281404=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200207133720.GZ43062@phenom.ffwll.local>
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
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, alexander.deucher@amd.com, spice-devel@lists.freedesktop.org, sam@ravnborg.org, emil.velikov@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0986752664680281404==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D9yXtwD7gGzdg2h5hIuwn2r8uxzLi9QfJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D9yXtwD7gGzdg2h5hIuwn2r8uxzLi9QfJ
Content-Type: multipart/mixed; boundary="V29EbvTwsuwyC9VZXdBdBOTohQtHfHr12";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, kraxel@redhat.com,
 alexander.deucher@amd.com, spice-devel@lists.freedesktop.org,
 sam@ravnborg.org, emil.velikov@collabora.com
Message-ID: <86073cfa-496d-53d7-e4c4-9736128109fa@suse.de>
Subject: Re: [PATCH 2/6] drm: Add drm_simple_encoder_{init,create}()
References: <20200207084135.4524-1-tzimmermann@suse.de>
 <20200207084135.4524-3-tzimmermann@suse.de>
 <20200207133720.GZ43062@phenom.ffwll.local>
In-Reply-To: <20200207133720.GZ43062@phenom.ffwll.local>

--V29EbvTwsuwyC9VZXdBdBOTohQtHfHr12
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 07.02.20 um 14:37 schrieb Daniel Vetter:
> On Fri, Feb 07, 2020 at 09:41:31AM +0100, Thomas Zimmermann wrote:
>> The simple-encoder helpers initialize an encoder with an empty
>> implementation. This covers the requirements of most of the existing
>> DRM drivers. A call to drm_simple_encoder_create() allocates and
>> initializes an encoder instance, a call to drm_simple_encoder_init()
>> initializes a pre-allocated instance.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>=20
> This has quick a bit midlayer taste to it ... I think having this as a
> helper would be cleaner ...

How would such a helper roughly look like?

Best regards
Thomas

>=20
> The other bit is drm_encoder->possible_crtcs. If we do create a helper =
for
> these, lets at least try to make them not suck too badly :-) Otherwise =
I
> guess it would be time to officially document what exactly possible_crt=
cs
> =3D=3D 0 means from an uabi pov.
> -Daniel
>=20
>> ---
>>  drivers/gpu/drm/drm_encoder.c | 116 +++++++++++++++++++++++++++++++++=
+
>>  include/drm/drm_encoder.h     |  10 +++
>>  2 files changed, 126 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encod=
er.c
>> index ffe691a1bf34..1a65cab1f310 100644
>> --- a/drivers/gpu/drm/drm_encoder.c
>> +++ b/drivers/gpu/drm/drm_encoder.c
>> @@ -178,6 +178,122 @@ int drm_encoder_init(struct drm_device *dev,
>>  }
>>  EXPORT_SYMBOL(drm_encoder_init);
>> =20
>> +static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanu=
p =3D {
>> +	.destroy =3D drm_encoder_cleanup,
>> +};
>> +
>> +/**
>> + * drm_simple_encoder_init - Init a preallocated encoder
>> + * @dev: drm device
>> + * @funcs: callbacks for this encoder
>> + * @encoder_type: user visible type of the encoder
>> + * @name: printf style format string for the encoder name, or NULL
>> + *        for default name
>> + *
>> + * Initialises a preallocated encoder that has no further functionali=
ty. The
>> + * encoder will be released automatically.
>> + *
>> + * Returns:
>> + * Zero on success, error code on failure.
>> + */
>> +int drm_simple_encoder_init(struct drm_device *dev,
>> +			    struct drm_encoder *encoder,
>> +			    int encoder_type, const char *name, ...)
>> +{
>> +	char *namestr =3D NULL;
>> +	int ret;
>> +
>> +	if (name) {
>> +		va_list ap;
>> +
>> +		va_start(ap, name);
>> +		namestr =3D kvasprintf(GFP_KERNEL, name, ap);
>> +		va_end(ap);
>> +		if (!namestr)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	ret =3D __drm_encoder_init(dev, encoder,
>> +				 &drm_simple_encoder_funcs_cleanup,
>> +				 encoder_type, namestr);
>> +	if (ret)
>> +		goto err_kfree;
>> +
>> +	return 0;
>> +
>> +err_kfree:
>> +	if (name)
>> +		kfree(namestr);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(drm_simple_encoder_init);
>> +
>> +static void drm_encoder_destroy(struct drm_encoder *encoder)
>> +{
>> +	struct drm_device *dev =3D encoder->dev;
>> +
>> +	drm_encoder_cleanup(encoder);
>> +	devm_kfree(dev->dev, encoder);
>> +}
>> +
>> +static const struct drm_encoder_funcs drm_simple_encoder_funcs_destro=
y =3D {
>> +	.destroy =3D drm_encoder_destroy,
>> +};
>> +
>> +/**
>> + * drm_simple_encoder_create - Allocate and initialize an encoder
>> + * @dev: drm device
>> + * @encoder_type: user visible type of the encoder
>> + * @name: printf style format string for the encoder name, or NULL fo=
r
>> + *        default name
>> + *
>> + * Allocates and initialises an encoder that has no further functiona=
lity. The
>> + * encoder will be released automatically.
>> + *
>> + * Returns:
>> + * The encoder on success, a pointer-encoder error code on failure.
>> + */
>> +struct drm_encoder *drm_simple_encoder_create(struct drm_device *dev,=

>> +					      int encoder_type,
>> +					      const char *name, ...)
>> +{
>> +	char *namestr =3D NULL;
>> +	struct drm_encoder *encoder;
>> +	int ret;
>> +
>> +	encoder =3D devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
>> +	if (!encoder)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	if (name) {
>> +		va_list ap;
>> +
>> +		va_start(ap, name);
>> +		namestr =3D kvasprintf(GFP_KERNEL, name, ap);
>> +		va_end(ap);
>> +		if (!namestr) {
>> +			ret =3D -ENOMEM;
>> +			goto err_devm_kfree;
>> +		}
>> +	}
>> +
>> +	ret =3D __drm_encoder_init(dev, encoder,
>> +				 &drm_simple_encoder_funcs_destroy,
>> +				 encoder_type, namestr);
>> +	if (ret)
>> +		goto err_kfree;
>> +
>> +	return encoder;
>> +
>> +err_kfree:
>> +	if (name)
>> +		kfree(namestr);
>> +err_devm_kfree:
>> +	devm_kfree(dev->dev, encoder);
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL(drm_simple_encoder_create);
>> +
>>  /**
>>   * drm_encoder_cleanup - cleans up an initialised encoder
>>   * @encoder: encoder to cleanup
>> diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
>> index 5623994b6e9e..0214f6cf9de6 100644
>> --- a/include/drm/drm_encoder.h
>> +++ b/include/drm/drm_encoder.h
>> @@ -190,6 +190,16 @@ int drm_encoder_init(struct drm_device *dev,
>>  		     const struct drm_encoder_funcs *funcs,
>>  		     int encoder_type, const char *name, ...);
>> =20
>> +__printf(4, 5)
>> +int drm_simple_encoder_init(struct drm_device *dev,
>> +			    struct drm_encoder *encoder,
>> +			    int encoder_type, const char *name, ...);
>> +
>> +__printf(3, 4)
>> +struct drm_encoder *drm_simple_encoder_create(struct drm_device *dev,=

>> +					      int encoder_type,
>> +					      const char *name, ...);
>> +
>>  /**
>>   * drm_encoder_index - find the index of a registered encoder
>>   * @encoder: encoder to find index for
>> --=20
>> 2.25.0
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--V29EbvTwsuwyC9VZXdBdBOTohQtHfHr12--

--D9yXtwD7gGzdg2h5hIuwn2r8uxzLi9QfJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl49bdgACgkQaA3BHVML
eiMkRgf/bJVyraD20+VdzFSjY+qyJIFr2Z88P38vlnV3xIAqh3bgaEJDIqlbNDlh
vIIx99JRoC9KLh9vHd7Q5FGQjHt03TQyyRzCBd4cMBsdU4pDzrT5NMbiFF0B3xcl
J5EC71XHbNidgUVfqbhNQaRYYWPlOwMOiP0k7Ta+fHFv1HOiLGtFzxADUB+i4sP4
EP0mU+SX+SDbDARH5gPF1XBWeFmhO3t/moYYPYtK9QGtSVfy3xbIvxwDPGNfl3FE
CzQ+zcQDTC+TBXfrmFS/gjLiLqnQ7sSu5J1qro775rNapNhoIH2CoiUgDk4HHCbz
uGEPvP+MgtOAHZZt5BCOeKFffOaNQA==
=LwHY
-----END PGP SIGNATURE-----

--D9yXtwD7gGzdg2h5hIuwn2r8uxzLi9QfJ--

--===============0986752664680281404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0986752664680281404==--
