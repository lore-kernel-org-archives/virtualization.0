From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 00/22] drm: Convert drivers to drm_simple_encoder_init()
Date: Mon, 9 Mar 2020 08:24:09 +0100
Message-ID: <f2db1418-5c97-dcef-667e-715d838dd42b@suse.de>
References: <20200305155950.2705-1-tzimmermann@suse.de>
 <20200306142212.GF4878@pendragon.ideasonboard.com>
 <bccc380a-8925-81a7-34fe-5a1744a766d0@suse.de>
 <20200307200813.GA15363@ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0o1gLC99UZ6MblS6ftokgGpAQCE791IVd"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200307200813.GA15363-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, hamohammed.sa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, hjc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sebastian.reichel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, xinliang.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, alison.wang-3arQi8VN3Tc@public.gmane.org, jsarha-l0cyMroinI0@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, virtualizatio
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0o1gLC99UZ6MblS6ftokgGpAQCE791IVd
Content-Type: multipart/mixed; boundary="kHuwg0qrcMYaHYPq8aj4tX3yyCOu5dGOV";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, hamohammed.sa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org,
 dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org,
 paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
 linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
 hjc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sebastian.reichel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org,
 krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 wens-jdAy2FN1RRM@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org,
 xinliang.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org,
 puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, alison.wang-3arQi8VN3Tc@public.gmane.org,
 jsarha-l0cyMroinI0@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jernej.skrabec-gGgVlfcn5nU@public.gmane.org,
 rodrigosiqueiramelo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bbrezillon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
 kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kieran.bingham+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org,
 kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Message-ID: <f2db1418-5c97-dcef-667e-715d838dd42b-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 00/22] drm: Convert drivers to drm_simple_encoder_init()
References: <20200305155950.2705-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
 <20200306142212.GF4878-N3hz7ZxfLydczECFQUw77jytWr6r+dGw0E9HWUfgJXw@public.gmane.org>
 <bccc380a-8925-81a7-34fe-5a1744a766d0-l3A5Bk7waGM@public.gmane.org>
 <20200307200813.GA15363-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20200307200813.GA15363-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>

--kHuwg0qrcMYaHYPq8aj4tX3yyCOu5dGOV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sam

Am 07.03.20 um 21:08 schrieb Sam Ravnborg:
> Hi Thomas.
>=20
> On Fri, Mar 06, 2020 at 04:18:52PM +0100, Thomas Zimmermann wrote:
>> Hi Laurent
>>
>> Am 06.03.20 um 15:22 schrieb Laurent Pinchart:
>>> Hi Thomas,
>>>
>>> Thank you for the patch.
>>>
>>> On Thu, Mar 05, 2020 at 04:59:28PM +0100, Thomas Zimmermann wrote:
>>>> A call to drm_simple_encoder_init() initializes an encoder without
>>>> further functionality. It only provides the destroy callback to
>>>> cleanup the encoder's state. Only few drivers implement more
>>>> sophisticated encoders than that. Most drivers implement such a
>>>> simple encoder and can use drm_simple_encoder_init() instead.
>>>>
>>>> The patchset converts drivers where the encoder's instance is
>>>> embedded in a larger data structure. The driver releases the
>>>> memory during cleanup. Each patch replaces drm_encoder_init() with
>>>> drm_simple_encoder_init() and removes the (now unused) driver's
>>>> encoder functions.
>>>>
>>>> While the patchset is fairly large, the indiviual patches are self-
>>>> contained and can be merged independently from each other. The
>>>> simple-encoder functionality is currently in drm-misc-next, where
>>>> these patches could go as well.
>>>
>>> I've reviewed the whole series, including verifying that the few
>>> instances of struct drm_encoder_funcs that were not declared const we=
re
>>> not modified somewhere to add more function pointers.
>>>
>>> Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>>
>> Thanks for the detailed review.
>>
>>>
>>> for all the patches.
>>>
>>> However, I'd like to note that drm_simple_encoder_init() is a bit of =
a
>>> misnommer here. Several of the encoders in those drivers to implement=

>>> additional functionality. They just expose them through
>>> drm_encoder_helper_funcs, not drm_encoder_funcs.
>>
>> True. It's called 'simple encoder' for the lack of a better name. It's=

>> part of the simple KMS helpers, so the name's at least consistent. OTO=
H
>> I always find drm_simple_display_pipe a bad name.
>>
>> We can still rename the simple-encoder function without much effort. I=
'm
>> open for suggestions.
>=20
> IMO this does not belong in drm_simple_kms - but in drm_encoder.
> This only occurs to me after looking a bit more on the patches,
> you would have loved to get this feedback earlier.

Well, the simple-encoder functionality used to be located in the encoder
code, but Daniel mentioned this is more of a helper and asked me to move
it out of the core. [1] So it ended up with the simple-KMS helpers.

Best regards
Thomas

[1] https://patchwork.freedesktop.org/patch/352370/?series=3D73130&rev=3D=
1

>=20
> Most users do not need their owm drm_encoder_funcs definition,
> and would be happy with the default as provided by drm_simple_*
>=20
> As the cleanup is handled automatically when the drm device
> is teared down (in mode_config_rest()) I considered if we could here
> use the drmm_ namespace - but that felt wrong.
>=20
> My proposal is the following:
> - Move the implementation to drm_encoder.c
> - Name it drm_encoder_init_nofuncs()
>=20
> The patches posted in this thread would be a little simpler
> as they would loose the added include file.
> And the three drivers using the current infrastructure would need a
> small update.
>=20
> I you decide to keep the current approach where the
> functions are in drm_simple_* then the full series is:
> Acked-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
>=20
> But I think moving it to drm_encoder.c would be the approach that would=

> make it simpler to understand/follow. So that get my (biased) vote.
>=20
> 	Sam
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--kHuwg0qrcMYaHYPq8aj4tX3yyCOu5dGOV--

--0o1gLC99UZ6MblS6ftokgGpAQCE791IVd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl5l7xwACgkQaA3BHVML
eiNvogf/X7mT5FK9zeyGvttt382VuO7LI5DPLmioQNnsCV8djdNkvDMa1QgoizMR
+rBcr2HpJvGPYJADgdIjElZ1PdBbA2uy3fD18UsA9J3We6dLqWwFJGd63FiVgUEk
3cz68wtYxo/158n1EKjdjRZLNrqmUpY7eIH8l5HmHzJiZA2BuxYNLPiasnn8/4fx
ZIueyDVkit4t0o+1uDVUp1IngcCZDbvnRr9AimBHcNCHKdeGw2HO2NvIzeUpagqO
0IR+FSMP2smmgs9rFvfxw+VeoL6yUnijkjohOH6eVrKrSWdmxIabreAxdLZDY0w+
sjNbM1FRdpTDm3H4Q3wBBcwxp06Hcw==
=AsaC
-----END PGP SIGNATURE-----

--0o1gLC99UZ6MblS6ftokgGpAQCE791IVd--
