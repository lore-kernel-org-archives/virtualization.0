From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 4/4] drm/simple-kms: Let DRM core send VBLANK events by
 default
Date: Thu, 16 Jan 2020 08:37:26 +0100
Message-ID: <33fdd33f-ce8d-70d3-544e-fac727d2686b@suse.de>
References: <20200115125226.13843-1-tzimmermann@suse.de>
 <20200115125226.13843-5-tzimmermann@suse.de>
 <20200116064107.GB8400@dvetter-linux.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5489304536102959506=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200116064107.GB8400@dvetter-linux.ger.corp.intel.com>
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
Cc: david@lechnology.com, oleksandr_andrushchenko@epam.com, airlied@linux.ie, sam@ravnborg.org, dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, virtualization@lists.linux-foundation.org, hdegoede@redhat.com, noralf@tronnes.org, xen-devel@lists.xenproject.org, emil.velikov@collabora.com, sean@poorly.run, laurent.pinchart@ideasonboard.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5489304536102959506==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2TF20vE0nUR867IpaGkbOHeyuGZJOixI9"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2TF20vE0nUR867IpaGkbOHeyuGZJOixI9
Content-Type: multipart/mixed; boundary="IhVePYMFhVozNgiM73xbi0VCK6gdDGe7Y";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: airlied@linux.ie, kraxel@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, hdegoede@redhat.com, david@lechnology.com,
 noralf@tronnes.org, sean@poorly.run, oleksandr_andrushchenko@epam.com,
 sam@ravnborg.org, laurent.pinchart@ideasonboard.com,
 emil.velikov@collabora.com, xen-devel@lists.xenproject.org,
 virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org
Message-ID: <33fdd33f-ce8d-70d3-544e-fac727d2686b@suse.de>
Subject: Re: [PATCH v2 4/4] drm/simple-kms: Let DRM core send VBLANK events by
 default
References: <20200115125226.13843-1-tzimmermann@suse.de>
 <20200115125226.13843-5-tzimmermann@suse.de>
 <20200116064107.GB8400@dvetter-linux.ger.corp.intel.com>
In-Reply-To: <20200116064107.GB8400@dvetter-linux.ger.corp.intel.com>

--IhVePYMFhVozNgiM73xbi0VCK6gdDGe7Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 16.01.20 um 07:41 schrieb Daniel Vetter:
> On Wed, Jan 15, 2020 at 01:52:26PM +0100, Thomas Zimmermann wrote:
>> In drm_atomic_helper_fake_vblank() the DRM core sends out VBLANK event=
s
>> if struct drm_crtc_state.no_vblank is enabled in the check() callbacks=
=2E
>>
>> For drivers that have neither an enable_vblank() callback nor a check(=
)
>> callback, the simple-KMS helpers enable VBLANK generation by default. =
This
>> simplifies bochs, udl, several tiny drivers, and drivers based upon MI=
PI
>> DPI helpers. The driver for Xen explicitly disables no_vblank, as it h=
as
>> its own logic for sending these events.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>=20
>> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm=
/drm_simple_kms_helper.c
>> index 15fb516ae2d8..4414c7a5b2ce 100644
>> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
>> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
>> @@ -146,10 +146,21 @@ static int drm_simple_kms_plane_atomic_check(str=
uct drm_plane *plane,
>>  	if (!plane_state->visible)
>>  		return 0;
>> =20
>> -	if (!pipe->funcs || !pipe->funcs->check)
>> -		return 0;
>> -
>> -	return pipe->funcs->check(pipe, plane_state, crtc_state);
>> +	if (pipe->funcs) {
>> +		if (pipe->funcs->check)
>> +			return pipe->funcs->check(pipe, plane_state,
>> +						  crtc_state);
>> +		if (pipe->funcs->enable_vblank)
>> +			return 0;
>> +	}
>> +
>> +	/* Drivers without VBLANK support have to fake VBLANK events. As
>> +	 * there's no check() callback to enable this, set the no_vblank
>> +	 * field by default.
>> +	 */
>=20
> The ->check callback is right above this comment ... I'm confused.

I guess that comment isn't overly precise. What it means is that
no_vblank would have to be set in check(), but the driver did not
specify a check() function. So it has neither vblank support nor any way
of setting no_vblank. Hence, the simple-kms helper sets no_vblank
automatically.

Maybe something to update for the patchset's v2.

>=20
>> +	crtc_state->no_vblank =3D true;
>=20
> That's kinda not what I meant with handling this automatically. Instead=

> something like this:
>=20
>=20
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/dr=
m/drm_atomic_state_helper.c
> index 7cf3cf936547..23d2f51fc1d4 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -149,6 +149,11 @@ void __drm_atomic_helper_crtc_duplicate_state(stru=
ct drm_crtc *crtc,
>  	/* Self refresh should be canceled when a new update is available */
>  	state->active =3D drm_atomic_crtc_effectively_active(state);
>  	state->self_refresh_active =3D false;
> +
> +	if (drm_dev_has_vblank(crtc->dev))
> +		state->no_vblank =3D true;
> +	else
> +		state->no_vblank =3D false;
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_crtc_duplicate_state);

I think the if/else branches are in the wrong order.

But generally speaking, is it really that easy? The xen driver already
has to work around simple-kms's auto-enabling of no_vblank (see patch
4). Maybe this settings interferes with other drivers as well. At least
the calls for sending fake vblanks should be removed from all affected
drivers.

Best regards
Thomas

> =20
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.=
c
> index 1659b13b178c..32cab3d3c872 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -81,6 +81,12 @@
>   */
>  #define DRM_REDUNDANT_VBLIRQ_THRESH_NS 1000000
> =20
> +/* FIXME roll this out here in this file */
> +bool drm_dev_has_vblank(dev)
> +{
> +	return dev->num_crtcs;
> +}
> +
>  static bool
>  drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
>  			  ktime_t *tvblank, bool in_vblank_irq);
>=20
>=20
> But maybe move the default value to some other/better place in the atom=
ic
> helpers, not sure what the best one is.
>=20
> Plus then in the documentation patch also highlight the link between
> crtc_state->no_vblank and drm_dev_has_vblank respectively
> drm_device.num_crtcs.
>=20
> That should plug this issue once for all across the board.
>=20
> There's still the fun between having the vblank callbacks and the
> drm_vblank setup, but that's a much older can of worms ...
> -Daniel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--IhVePYMFhVozNgiM73xbi0VCK6gdDGe7Y--

--2TF20vE0nUR867IpaGkbOHeyuGZJOixI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl4gErkACgkQaA3BHVML
eiN+vwf/XGyl88sc5pspPvxnC5r6X3M2RF8oBoWhQ3pFbMkf4/UqJarP8N+G5M/+
yMVhwkYswAe9KdUZeqSwGLEdesukkyAQHPICSPXo17YrQl3HVAAqqv6P7zhGrNcU
l1P5ESbAVbxQf6P2nlLbJK6+lYPvp3ojLRloeLVXEO+MGR5hWtogc9p/vulWcDnu
8dEb0apW53GmMovVFhOr0haenOhzUc1wUb9zQm5mX/TDbpsJg8MBf7kKDcAMnPr1
/gM2EDjuW4BlRdrAQRTnpwcOFZe/bwXwZ8m9s6/jLAF4aP6LTsbgMzZxIGc0v/Ku
QZ5C5SSX3z4d1WSPYDhqIt600yNvVA==
=Xk4o
-----END PGP SIGNATURE-----

--2TF20vE0nUR867IpaGkbOHeyuGZJOixI9--

--===============5489304536102959506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5489304536102959506==--
