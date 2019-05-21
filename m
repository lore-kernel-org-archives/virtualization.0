From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/2] drm: Add drm_gem_vram_{pin/unpin}_reserved() and
	convert mgag200
Date: Tue, 21 May 2019 13:35:36 +0200
Message-ID: <0063a3e4-612c-99fc-9c3d-331b50f4a3dc__32953.8614417956$1558438556$gmane$org@suse.de>
References: <20190516162746.11636-1-tzimmermann@suse.de>
	<20190516162746.11636-2-tzimmermann@suse.de>
	<20190520161900.GB21222@phenom.ffwll.local>
	<20190521103546.ehrrboraeoe2e6fh@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0175929504897437416=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190521103546.ehrrboraeoe2e6fh@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0175929504897437416==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3xhGnAaM4AvxSzHzVvs3UqlPwWoQOErBw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3xhGnAaM4AvxSzHzVvs3UqlPwWoQOErBw
Content-Type: multipart/mixed; boundary="8axksfutt2h3XBOiLYx79LisoRB0ZYfWZ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: airlied@linux.ie, puck.chen@hisilicon.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 z.liuxinliang@hisilicon.com, hdegoede@redhat.com,
 kong.kongxinwei@hisilicon.com, ray.huang@amd.com, zourongrong@gmail.com,
 sam@ravnborg.org, christian.koenig@amd.com
Message-ID: <0063a3e4-612c-99fc-9c3d-331b50f4a3dc@suse.de>
Subject: Re: [PATCH 1/2] drm: Add drm_gem_vram_{pin/unpin}_reserved() and
 convert mgag200
References: <20190516162746.11636-1-tzimmermann@suse.de>
 <20190516162746.11636-2-tzimmermann@suse.de>
 <20190520161900.GB21222@phenom.ffwll.local>
 <20190521103546.ehrrboraeoe2e6fh@sirius.home.kraxel.org>
In-Reply-To: <20190521103546.ehrrboraeoe2e6fh@sirius.home.kraxel.org>

--8axksfutt2h3XBOiLYx79LisoRB0ZYfWZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 21.05.19 um 12:35 schrieb Gerd Hoffmann:
>   Hi,
>=20
>> I think would be good to have a lockdep_assert_held here for the ww_mu=
tex.
>>
>> Also general thing: _reserved is kinda ttm lingo, for dma-buf reservat=
ions
>> we call the structure tracking the fences+lock the "reservation", but =
the
>> naming scheme used is _lock/_unlock.
>>
>> I think would be good to be consistent with that, and use _locked here=
=2E
>> Especially for a very simplified vram helper like this one I expect th=
at's
>> going to lead to less wtf moments by driver writers :-)
>>
>> Maybe we should also do a large-scale s/reserve/lock/ within ttm, to a=
lign
>> more with what we now have in dma-buf.
>=20
> Given that mgag200 is the only user I think the best way forward is to
> improve the mgag200 cursor handling so we can just drop the _reserved
> variants ...
>=20
> When looking at mga_crtc_cursor_set() I suspect the easierst way to do
> that would be to simply pin the cursor bo's at driver_load time, then w=
e
> don't have to bother with pinning in mga_crtc_cursor_set() at all.

I've been thinking about converting ast and mgag200 to atomic mode
setting. For that, universal planes would be required. But this seems
incompatible with HW cursors.

With universal planes, cursor planes would probably have to be exported
as RGBA8 framebuffer, but the HW uses MMIO region and 16-color palette.
So there's got to be a translation step and a way of notifying userspace
if the palette overflows. In the current driver code,
drm_crtc_funcs.set_cursor() does this.

How is this done with universal planes? I know that there's
drm_framebuffer_funcs.dirty(), but it doesn't seem to be used much.

Best regards
Thomas


> Thomas, as you have test hardware, can you look into this?
>=20
> thanks,
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


--8axksfutt2h3XBOiLYx79LisoRB0ZYfWZ--

--3xhGnAaM4AvxSzHzVvs3UqlPwWoQOErBw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlzj4ogACgkQaA3BHVML
eiOUhwf8D+9COr5Ywx4A95XDifL+gCkJ2uMJtlmE5jWfXVoRi5bL+23URXoP5wWa
MbGUXIwo/4qYfTnGgcBFSPUgsb4mxibn2M78QDxnqbRTs9bCt7SLbbslGx2LpGth
kyAKwG7SdGOMVkt0KppjRlFWSwfLcMPI/DivfVZVC9IctFphPd5Anatu/uN411G8
ojHfFLTOsUXZSy1MuwM32jc1BCjBo/XoR6TOdAJSJdUbItV/j0WLRAviLqzwOXoH
V0GukfZSRS6dsxNLvn2V64wR0S/s9fnnQw2ziuXQbqZ2uHsxmXa0iPccqRgJLHhK
XZ4CgGJLwU0knEfNSdX4ob1DmcEmGw==
=SUcO
-----END PGP SIGNATURE-----

--3xhGnAaM4AvxSzHzVvs3UqlPwWoQOErBw--

--===============0175929504897437416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0175929504897437416==--
