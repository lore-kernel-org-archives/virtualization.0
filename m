From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 00/19] Share TTM code among DRM framebuffer drivers
Date: Mon, 6 May 2019 15:05:42 +0200
Message-ID: <a0b3f173-5ea0-eb5f-f34c-e637b7f818f6__5326.80291669152$1557148040$gmane$org@suse.de>
References: <20190506082649.942-1-tzimmermann@suse.de>
	<20190506124344.hltulw6e3kkcg4w3@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0214329625199232361=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190506124344.hltulw6e3kkcg4w3@sirius.home.kraxel.org>
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
--===============0214329625199232361==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MIpqIrpQ0zrJ8hecbEz6MqUQizfrA1n5D"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MIpqIrpQ0zrJ8hecbEz6MqUQizfrA1n5D
Content-Type: multipart/mixed; boundary="OzOtIt5nCzzuHZsYwtuWC0oFJN1cbRR7R";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: airlied@linux.ie, puck.chen@hisilicon.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 z.liuxinliang@hisilicon.com, hdegoede@redhat.com,
 kong.kongxinwei@hisilicon.com, ray.huang@amd.com, zourongrong@gmail.com,
 sam@ravnborg.org, christian.koenig@amd.com
Message-ID: <a0b3f173-5ea0-eb5f-f34c-e637b7f818f6@suse.de>
Subject: Re: [PATCH v4 00/19] Share TTM code among DRM framebuffer drivers
References: <20190506082649.942-1-tzimmermann@suse.de>
 <20190506124344.hltulw6e3kkcg4w3@sirius.home.kraxel.org>
In-Reply-To: <20190506124344.hltulw6e3kkcg4w3@sirius.home.kraxel.org>

--OzOtIt5nCzzuHZsYwtuWC0oFJN1cbRR7R
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 06.05.19 um 14:43 schrieb Gerd Hoffmann:
> On Mon, May 06, 2019 at 10:26:30AM +0200, Thomas Zimmermann wrote:
>> Several simple framebuffer drivers copy most of the TTM code from each=

>> other. The implementation is always the same; except for the name of
>> some data structures.
>>
>> As recently discussed, this patch set provides generic memory-manageme=
nt
>> code for simple framebuffers with dedicated video memory. It further
>> converts the respective drivers to the generic code. The shared code
>> is basically the same implementation as the one copied among individua=
l
>> drivers.
>>
>> The patch set contains two major changes: first, it introduces
>> |struct drm_gem_vram_object| and helpers (GEM VRAM). It's a GEM object=

>> that is backed by VRAM. The type's purpose is somewhat similar to
>> |struct drm_gem_{cma, shmem}_object|: it provides an commom implementa=
tion
>> that handles all the basic cases. Second, the patch set introduces
>> |struct drm_vram_mm| and helpers (VRAM MM). It's an implementation of =
a
>> basic memory manager for VRAM.
>>
>> Both, GEM VRAM and VRAM MM, support buffer placement in VRAM and syste=
m
>> memory. Both can be used independedly from each other if desired by th=
e
>> DRM driver.
>=20
> Looks good to me overall, some small nits in replies to patches.
>=20
>> Currently ast, bochs, mgag200, vboxvideo and hisilicon/hibmc can use
>> these helpers.
>=20
> I've tested bochs on qemu, works fine.

Thank you!

> What is the testing status of the other drivers?

I've tested ast and mgag200 on hardware. I only compiled the others,
including bochs. I did verify that the code I replaced is basically the
same as in the new helpers.

Best regards
Thomas

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


--OzOtIt5nCzzuHZsYwtuWC0oFJN1cbRR7R--

--MIpqIrpQ0zrJ8hecbEz6MqUQizfrA1n5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlzQMSYACgkQaA3BHVML
eiNLewgAgc5Jbpd7qDr01e3bGhlRDe9vra/rHKk9s7XvWgGelqlP+Orgkh5t8gfZ
OFgzUPfU/7xTQfKoxTY7mt933BS1lCLnBsQmfBNbLWRLKmKFaVdd7VXLQi1YDkGu
mItR+IGt1LtbJjyZsgJgBhsuwwcaEawFRPOWInf/mK+BCu/WSIHoGu6hASjon4GP
e+qNiv24Wm/TbchUY61/KXfnQD5Lqrssm1V3eNWVn5korjXULrrEYf3U7tt10/Uv
QdE9AYLieTM+I+YaGaRN6FWUxfi59dggaI1XOBXJsLn9+24mMT0ni43/pkREsw0i
ufv4m/heWlGK+Q5H5h6XcgWcJWC8mQ==
=oJGA
-----END PGP SIGNATURE-----

--MIpqIrpQ0zrJ8hecbEz6MqUQizfrA1n5D--

--===============0214329625199232361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0214329625199232361==--
