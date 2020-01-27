From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 15/15] drm/xen: Explicitly disable automatic sending of
 vblank event
Date: Mon, 27 Jan 2020 12:59:02 +0100
Message-ID: <514e72de-76d2-ae36-506b-57e5ba035926@suse.de>
References: <20200123092123.28368-1-tzimmermann@suse.de>
 <20200123092123.28368-16-tzimmermann@suse.de>
 <74d7bb19-642f-49da-8198-56ea0c0d1a4a@epam.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4073693629157655691=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <74d7bb19-642f-49da-8198-56ea0c0d1a4a@epam.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "kraxel@redhat.com" <kraxel@redhat.com>, "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org" <mripard@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "david@lechnology.com" <david@lechnology.com>, "noralf@tronnes.org" <noralf@tronnes.org>, "sean@poorly.run" <sean@poorly.run>, "sam@ravnborg.org" <sam@ravnborg.org>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "emil.velikov@collabora.com" <emil.velikov@collabora.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4073693629157655691==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vqjTbWA0zBV41FMiLSiqJ0uSdIBMqNRY9"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vqjTbWA0zBV41FMiLSiqJ0uSdIBMqNRY9
Content-Type: multipart/mixed; boundary="ArlxMdsqaLtIIvoCK6DR97iWgpsIhOC3Y";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
 "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "hdegoede@redhat.com" <hdegoede@redhat.com>,
 "david@lechnology.com" <david@lechnology.com>,
 "noralf@tronnes.org" <noralf@tronnes.org>, "sean@poorly.run"
 <sean@poorly.run>, "sam@ravnborg.org" <sam@ravnborg.org>,
 "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
 "emil.velikov@collabora.com" <emil.velikov@collabora.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Message-ID: <514e72de-76d2-ae36-506b-57e5ba035926@suse.de>
Subject: Re: [PATCH v4 15/15] drm/xen: Explicitly disable automatic sending of
 vblank event
References: <20200123092123.28368-1-tzimmermann@suse.de>
 <20200123092123.28368-16-tzimmermann@suse.de>
 <74d7bb19-642f-49da-8198-56ea0c0d1a4a@epam.com>
In-Reply-To: <74d7bb19-642f-49da-8198-56ea0c0d1a4a@epam.com>

--ArlxMdsqaLtIIvoCK6DR97iWgpsIhOC3Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 27.01.20 um 10:53 schrieb Oleksandr Andrushchenko:
> Sorry for jumping in late
>=20
> On 1/23/20 11:21 AM, Thomas Zimmermann wrote:
>> The atomic helpers automatically send out fake VBLANK events if no
>> vblanking has been initialized. This would apply to xen, but xen has
>> its own vblank logic. To avoid interfering with the atomic helpers,
>> disable automatic vblank events explictly.
>>
>> v4:
>> 	* separate commit from core vblank changes
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>=

>=20
>> ---
>>   drivers/gpu/drm/xen/xen_drm_front_kms.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm=
/xen/xen_drm_front_kms.c
>> index 4f34c5208180..efde4561836f 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
>> +++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
>> @@ -220,6 +220,18 @@ static bool display_send_page_flip(struct drm_sim=
ple_display_pipe *pipe,
>>   	return false;
>>   }
>>  =20
>> +static int display_check(struct drm_simple_display_pipe *pipe,
>> +			 struct drm_plane_state *plane_state,
>> +			 struct drm_crtc_state *crtc_state)
>> +{
>> +	/* Make sure that DRM helpers don't send VBLANK events
> Could you please put the comment on a separate line?

You mean to add an empty line between comment and code?

>> +	 * automatically. Xen has it's own logic to do so.
>> +	 */
>> +	crtc_state->no_vblank =3D false;
> And it is still confusing, e.g. comment says
> "Make sure that DRM helpers don't send VBLANK"
> and we set "no_vblank" flag to false...

I'll rephrase and add some more context.

Best regards
Thomas

>> +
>> +	return 0;
>> +}
>> +
>>   static void display_update(struct drm_simple_display_pipe *pipe,
>>   			   struct drm_plane_state *old_plane_state)
>>   {
>> @@ -284,6 +296,7 @@ static const struct drm_simple_display_pipe_funcs =
display_funcs =3D {
>>   	.enable =3D display_enable,
>>   	.disable =3D display_disable,
>>   	.prepare_fb =3D drm_gem_fb_simple_display_pipe_prepare_fb,
>> +	.check =3D display_check,
>>   	.update =3D display_update,
>>   };
>>  =20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--ArlxMdsqaLtIIvoCK6DR97iWgpsIhOC3Y--

--vqjTbWA0zBV41FMiLSiqJ0uSdIBMqNRY9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl4u0IYACgkQaA3BHVML
eiPmlwgAwCofNVRLKZmi9VADhSPulFVCsG1rDvFt2sRfI3lPDNUTYb6V1De8u0qQ
MeiCGF0wK8pYXObqGtNFpeF8h8/Aw0CMKPKy/GDCi1EjAzgqwtQ/t5Te2UtNODJb
GmamClhHyTtUs85rx00P/+YLRyG7hPDHpfAMJm8m+JyQUu6TpDy36UtBJ8WNXNNV
LXwSGPvmdvKX5powX98APbx9MIfc4Ub/+Mc/q3dG3//LorUl5PyreXt0eqDtVCB7
Da8NMzcPdMi/MOWEXAK+OgFignf/d4yY415sDALKSbFahWt6q+cU8Cw1tS0rtp+h
DsbKRXTLYvnW88m/xlL66cErXfL6tA==
=Ci8H
-----END PGP SIGNATURE-----

--vqjTbWA0zBV41FMiLSiqJ0uSdIBMqNRY9--

--===============4073693629157655691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4073693629157655691==--
