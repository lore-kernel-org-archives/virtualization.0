From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/cirrus: Let DRM core send VBLANK events
Date: Mon, 13 Jan 2020 10:01:48 +0100
Message-ID: <d74a1e5f-a815-979e-1bbb-412d195b3f75@suse.de>
References: <20200110115707.14080-1-tzimmermann@suse.de>
 <20200112230045.GE5340@dvetter-linux.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4490252473684219206=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200112230045.GE5340@dvetter-linux.ger.corp.intel.com>
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
Cc: airlied@redhat.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4490252473684219206==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jY7WS004tgx7Puz4NAFKwjlhGgaAvfBJl"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jY7WS004tgx7Puz4NAFKwjlhGgaAvfBJl
Content-Type: multipart/mixed; boundary="tZ44rcaTQAu6gRbI2zRXp47D62IdHvzXj";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: airlied@redhat.com, kraxel@redhat.com,
 virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org
Message-ID: <d74a1e5f-a815-979e-1bbb-412d195b3f75@suse.de>
Subject: Re: [PATCH] drm/cirrus: Let DRM core send VBLANK events
References: <20200110115707.14080-1-tzimmermann@suse.de>
 <20200112230045.GE5340@dvetter-linux.ger.corp.intel.com>
In-Reply-To: <20200112230045.GE5340@dvetter-linux.ger.corp.intel.com>

--tZ44rcaTQAu6gRbI2zRXp47D62IdHvzXj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 13.01.20 um 00:00 schrieb Daniel Vetter:
> On Fri, Jan 10, 2020 at 12:57:07PM +0100, Thomas Zimmermann wrote:
>> In drm_atomic_helper_fake_vblank() the DRM core sends out VBLANK
>> events if struct drm_crtc_state.no_vblank is enabled. Replace cirrus'
>> VBLANK events with the DRM core's functionality.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>  drivers/gpu/drm/cirrus/cirrus.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/=
cirrus.c
>> index 248c9f765c45..4a1729aa7e53 100644
>> --- a/drivers/gpu/drm/cirrus/cirrus.c
>> +++ b/drivers/gpu/drm/cirrus/cirrus.c
>> @@ -38,7 +38,6 @@
>>  #include <drm/drm_modeset_helper_vtables.h>
>>  #include <drm/drm_probe_helper.h>
>>  #include <drm/drm_simple_kms_helper.h>
>> -#include <drm/drm_vblank.h>
>> =20
>>  #define DRIVER_NAME "cirrus"
>>  #define DRIVER_DESC "qemu cirrus vga"
>> @@ -415,6 +414,8 @@ static void cirrus_pipe_enable(struct drm_simple_d=
isplay_pipe *pipe,
>>  {
>>  	struct cirrus_device *cirrus =3D pipe->crtc.dev->dev_private;
>> =20
>> +	crtc_state->no_vblank =3D true;
>=20
> Huh, nice untended use of this stuff ... We've added this for writeback=
,
> but I guess it can be used for anything that's a virtual connector ...

Oh, 'improved by accident'.

I'm not quite sure what you mean by virtual connector, but it should
work with any CRTC without VBLANK support. At least I've never seen any
problem with ast and udl. I'll update the docs accordingly.

Best regards
Thomas

>=20
> I've also spotted that you've done this same trick for ast & udl alread=
y.
> But I think before we roll this out massively we should make this
> official. Can you pls do a patch to update the kerneldoc for @no_vblank=

> that virtual hw can also use this stuff?
>=20
> Also, computing state values in atomic_commit code is kinda uncool and
> fraught with peril - design assumption is that with some very few
> exceptions (which are kinda awkward, would be nice to make state pointe=
rs
> const) all the core and helper codes that state structures stay unchang=
ed
> after atomic_check completed. This should be computed in atomic_check (=
like vc4
> does). Can you pls also include patches to update ast and udl in this
> series?
>=20
> Thanks, Daniel
>=20
>=20
>> +
>>  	cirrus_mode_set(cirrus, &crtc_state->mode, plane_state->fb);
>>  	cirrus_fb_blit_fullscreen(plane_state->fb);
>>  }
>> @@ -434,13 +435,6 @@ static void cirrus_pipe_update(struct drm_simple_=
display_pipe *pipe,
>> =20
>>  	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
>>  		cirrus_fb_blit_rect(pipe->plane.state->fb, &rect);
>> -
>> -	if (crtc->state->event) {
>> -		spin_lock_irq(&crtc->dev->event_lock);
>> -		drm_crtc_send_vblank_event(crtc, crtc->state->event);
>> -		crtc->state->event =3D NULL;
>> -		spin_unlock_irq(&crtc->dev->event_lock);
>> -	}
>>  }
>> =20
>>  static const struct drm_simple_display_pipe_funcs cirrus_pipe_funcs =3D=
 {
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


--tZ44rcaTQAu6gRbI2zRXp47D62IdHvzXj--

--jY7WS004tgx7Puz4NAFKwjlhGgaAvfBJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl4cMfwACgkQaA3BHVML
eiPQNgf/STEbPJQt7tAkYT5tkJgeX8JoJOZ51S0hL7NX+CyY3HVN0O5MfEDcwAdI
KzTcsb2J2P5HhOILb9Tk8aV5VCJ4si2sOCWSpqva2XlmVqm6u86rqyXW25yl33Ll
C8QqbBzf//3wzPVrpJrnQL9hVp0nPIlztENSgLuOJACviV5ThR486UYIZNj2G+Kw
RcihcjDXspr9dSPGtCcBFlQZ2hA5NTEVbbTSW53WYc+T0bLJNHMS/dcyWSX+RnWG
UvipHmIS5SGFyDNEIcZheURwy3DtzQz+KcV8weCaAC7qQG9JOkfQ6QEW4Ydi86Ky
0iVHMS7jEd3VZ13SoEbr5C+NWtxu8A==
=5sBw
-----END PGP SIGNATURE-----

--jY7WS004tgx7Puz4NAFKwjlhGgaAvfBJl--

--===============4490252473684219206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4490252473684219206==--
