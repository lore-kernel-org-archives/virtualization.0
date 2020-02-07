From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/6] drm: Add drm_simple_encoder_{init,create}()
Date: Fri, 7 Feb 2020 11:50:24 +0100
Message-ID: <cd78b79f-ff4e-9c8e-4d87-ce717a717559@suse.de>
References: <20200207084135.4524-1-tzimmermann@suse.de>
 <20200207084135.4524-3-tzimmermann@suse.de>
 <20200207103333.rxebukm4hukavlq5@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3433946686573690535=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200207103333.rxebukm4hukavlq5@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: airlied@linux.ie, maarten.lankhorst@linux.intel.com, mripard@kernel.org, virtualization@lists.linux-foundation.org, noralf@tronnes.org, dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com, spice-devel@lists.freedesktop.org, sam@ravnborg.org, emil.velikov@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3433946686573690535==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T0w1ckiulGikfr0Xhr6obHC3UuCzv4Cvb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T0w1ckiulGikfr0Xhr6obHC3UuCzv4Cvb
Content-Type: multipart/mixed; boundary="X5V3QFNtNcX9iXkOwABge6p9MixeZf7V0";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, noralf@tronnes.org, sam@ravnborg.org,
 alexander.deucher@amd.com, emil.velikov@collabora.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 spice-devel@lists.freedesktop.org
Message-ID: <cd78b79f-ff4e-9c8e-4d87-ce717a717559@suse.de>
Subject: Re: [PATCH 2/6] drm: Add drm_simple_encoder_{init,create}()
References: <20200207084135.4524-1-tzimmermann@suse.de>
 <20200207084135.4524-3-tzimmermann@suse.de>
 <20200207103333.rxebukm4hukavlq5@sirius.home.kraxel.org>
In-Reply-To: <20200207103333.rxebukm4hukavlq5@sirius.home.kraxel.org>

--X5V3QFNtNcX9iXkOwABge6p9MixeZf7V0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Gerd

Am 07.02.20 um 11:33 schrieb Gerd Hoffmann:
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
>=20
> How about using
>=20
> #define drm_simple_encoder_init(dev, type, name, ...) \
>         drm_encoder_init(dev, drm_simple_encoder_funcs_cleanup, type, n=
ame, __VA_ARGS__)
>=20
> instead ?

I'd prefer a function call for aesthetic reasons and for not having to
export the drm_simple_encoder_funcs_cleanup. drm_simple_encoder_create()
is also a function and probably cannot be turned into a macro. So having
a function for drm_simple_encoder_init seems consequent.

I guess you want to save a few lines in the implementation of
drm_simple_encoder_init() (?) If so, I'd rather try to share more
internal code among the various init and create functions.

Best regards
Thomas

>=20
> cheers,
>   Gerd
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--X5V3QFNtNcX9iXkOwABge6p9MixeZf7V0--

--T0w1ckiulGikfr0Xhr6obHC3UuCzv4Cvb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl49QPMACgkQaA3BHVML
eiPcOgf7Bi+fIF8jY2zA0Xv7Qud52dM7kca2Q2x3OHLeUyBs0vUUpB9AFONibBwx
jqhQIo6mQvyqw2rDUTXCpznw2qV5IrCJW+Rc31hQb+p9g1+BPZsf8oJjQlXam7Th
QV2nyw5SisqXgLP3XfUNWuKLE8zC6htCDHj0h/bnp0Ov7EWFt1PZ3Ymi/8NzdhxS
KupkfqeUuXD1lxNPH6x4fJh8KzC26BnvSItJGAyM2kK+Q8porJCbyJNfd2x3gDNX
csEODfagrVw2/m8f+eqyh6t33Z9dlvReB1jehSdSND2Af49j6aJd5D+ZT8alrrG2
bXN+qXJ6RRTYcVbr8yldee3jSlFNnQ==
=cFhv
-----END PGP SIGNATURE-----

--T0w1ckiulGikfr0Xhr6obHC3UuCzv4Cvb--

--===============3433946686573690535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3433946686573690535==--
