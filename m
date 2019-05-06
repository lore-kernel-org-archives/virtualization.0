From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 00/19] Share TTM code among DRM framebuffer drivers
Date: Mon, 6 May 2019 15:09:20 +0200
Message-ID: <fcb3efd9-64f2-ca35-e36e-83b7055f8055__11714.4882607803$1557148255$gmane$org@suse.de>
References: <20190506082649.942-1-tzimmermann@suse.de>
	<20190506122233.76pya5kpdfgp4f25@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1646271414280843359=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190506122233.76pya5kpdfgp4f25@sirius.home.kraxel.org>
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
Cc: noralf@tronnes.org, airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, daniel@ffwll.ch, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1646271414280843359==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R0V7UPedplzMBC5x807KDQl1LFbTsyJ0R"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R0V7UPedplzMBC5x807KDQl1LFbTsyJ0R
Content-Type: multipart/mixed; boundary="bzAKT4Op81rZaT9HYHvgihWOqNQhhDyog";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: daniel@ffwll.ch, airlied@linux.ie, christian.koenig@amd.com,
 ray.huang@amd.com, hdegoede@redhat.com, noralf@tronnes.org,
 sam@ravnborg.org, z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
 kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <fcb3efd9-64f2-ca35-e36e-83b7055f8055@suse.de>
Subject: Re: [PATCH v4 00/19] Share TTM code among DRM framebuffer drivers
References: <20190506082649.942-1-tzimmermann@suse.de>
 <20190506122233.76pya5kpdfgp4f25@sirius.home.kraxel.org>
In-Reply-To: <20190506122233.76pya5kpdfgp4f25@sirius.home.kraxel.org>

--bzAKT4Op81rZaT9HYHvgihWOqNQhhDyog
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 06.05.19 um 14:22 schrieb Gerd Hoffmann:
>> GEM VRAM could implement PRIME helpers, which would allow for using
>> the generic fbcon.
>=20
> bochs_gem_prime_*() functions with this series applied look like you ca=
n
> just rename them & move over to vram helpers.
>=20
> It's not a full prime implementation, specifically actual export/import=

> isn't there.  But pin+vmap (needed by generic fbcon) is implemented.

I did have a patch to do this, but then I read that prime requires DMA
for buffer sharing and bochs works only because it's emulated. If bochs'
implementation is complete enough to be useful for other drivers, I'll
add it to the patch set.

Best regards
Thomas

> cheers,
>   Gerd
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--bzAKT4Op81rZaT9HYHvgihWOqNQhhDyog--

--R0V7UPedplzMBC5x807KDQl1LFbTsyJ0R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlzQMgAACgkQaA3BHVML
eiP/ZQf9GtIUWbuoOBBjRwFV0Pxtj2papD2kR7EJgmRANl/jUOXPD2OUIdnV6K7C
P8YH+cVr6lw1+EM7QUMhiGFxBKxihZJ88dSt2cgOzXwAFJ0TGucip7/rCird+gZ9
RvhsuagnnSGBw5kfHNDNttri1dnOK4QebTQpsde11Bo1rgOeyNJToRRzamEhhWAy
pwMmSU2u98ZISYdsYRCd+RbwoN2e/jR0n2TqKLD0fCuZTO1JwaZosqKtJceiYo6r
9RppDELgeeMv1YbJrdkfEm7iQ2zqhZNRaQQLsiVgujiouHJpOzs0Z85KgmTcPHtV
C9xA8k11J5gpwQIQ9oSd/brvkqKZ1g==
=49yC
-----END PGP SIGNATURE-----

--R0V7UPedplzMBC5x807KDQl1LFbTsyJ0R--

--===============1646271414280843359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1646271414280843359==--
