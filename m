From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v5 00/20] Share TTM code among DRM framebuffer drivers
Date: Wed, 15 May 2019 16:33:33 +0200
Message-ID: <ff2c6cf6-d8c3-74fc-bfb8-9194e1b447fd@suse.de>
References: <20190508082630.15116-1-tzimmermann@suse.de>
	<05884df3-207a-6c2f-226e-d01266f17b77@suse.de>
	<20190515142235.qfwnvsrhnogj67hz@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2010611782141212123=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190515142235.qfwnvsrhnogj67hz@sirius.home.kraxel.org>
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
Cc: airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2010611782141212123==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5MooHqqMgfDJdS5xCvjd1qmQABAaLslo5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5MooHqqMgfDJdS5xCvjd1qmQABAaLslo5
Content-Type: multipart/mixed; boundary="3sen9ayRg5RP5Cj5P7nHsNzZ0X7qx18y4";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: airlied@linux.ie, puck.chen@hisilicon.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 z.liuxinliang@hisilicon.com, hdegoede@redhat.com,
 kong.kongxinwei@hisilicon.com, ray.huang@amd.com, zourongrong@gmail.com,
 sam@ravnborg.org, christian.koenig@amd.com
Message-ID: <ff2c6cf6-d8c3-74fc-bfb8-9194e1b447fd@suse.de>
Subject: Re: [PATCH v5 00/20] Share TTM code among DRM framebuffer drivers
References: <20190508082630.15116-1-tzimmermann@suse.de>
 <05884df3-207a-6c2f-226e-d01266f17b77@suse.de>
 <20190515142235.qfwnvsrhnogj67hz@sirius.home.kraxel.org>
In-Reply-To: <20190515142235.qfwnvsrhnogj67hz@sirius.home.kraxel.org>

--3sen9ayRg5RP5Cj5P7nHsNzZ0X7qx18y4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 15.05.19 um 16:22 schrieb Gerd Hoffmann:
> On Wed, May 15, 2019 at 09:05:54AM +0200, Thomas Zimmermann wrote:
>> Hi,
>>
>> most of this patch set still needs reviews.
>>
>> If it's too large for merging or reviewing at once, I could move the
>> driver changes into separate patch sets. The vbox driver's changes hav=
e
>> been accepted by Hans already. So only keeping the core changes plus
>> vbox would be an option.
>=20
> Looks all good to me.  bochs survived my testing, vbox is reviewed and
> IIRC you've tested two of the other three drivers.  So all but one
> driver is covered.
>=20
> I'll go push this to drm-misc-next in a moment.

Thank you so much!

Best regards
Thomas

>=20
>>> Future directions: with these changes, the respective drivers can als=
o
>>> share some of their mode-setting or fbdev code. GEM VRAM's PRIME help=
ers
>>> allow for using the generic fbcon emulation.
>=20
> Using generic fbcon should be easy now.
>=20
> cheers,
>   Gerd
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


--3sen9ayRg5RP5Cj5P7nHsNzZ0X7qx18y4--

--5MooHqqMgfDJdS5xCvjd1qmQABAaLslo5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlzcIz0ACgkQaA3BHVML
eiMaewgAukXMNv/FOsACWjHl4S7Y0MTebic21ZC6m8kY4/DL1XaszAV1oGNu3+sH
GmpbXCqd2LhBlNg4rTy/01JR9WFS2xhCuwc1GbAVsWlCwIXaLzlpwizaGbgw95dO
3Z3Rwg+g5tIwjbFl04bMAoEI0DHArucVYhwjc9mig4ZOhFuI5nHTbRDjaTdrKUcC
NtP4VY41fXkiUwXvP7bDRPOjA0iBstgKW1+LGnuyydXOYKdxo3AR3W7vFOTy1sjN
4bJQMz8hH7a3bxaZ/rlToqwWOmw/SeugXCzbI7o1HKRI0bFNqx3ljq4MJfRhIaVE
hKts0Zp6VTzsPqH2udXvaU1t8twtoQ==
=863U
-----END PGP SIGNATURE-----

--5MooHqqMgfDJdS5xCvjd1qmQABAaLslo5--

--===============2010611782141212123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2010611782141212123==--
