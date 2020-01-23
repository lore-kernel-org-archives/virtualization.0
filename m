From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 0/4] Use no_vblank property for drivers without VBLANK
Date: Thu, 23 Jan 2020 09:40:07 +0100
Message-ID: <1659c9ee-37ee-988a-6aaa-e115d1529fd6@suse.de>
References: <20200120122051.25178-1-tzimmermann@suse.de>
 <20200121093604.ruclkfho5gmflasq@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1998976094736861100=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200121093604.ruclkfho5gmflasq@sirius.home.kraxel.org>
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
Cc: david@lechnology.com, oleksandr_andrushchenko@epam.com, airlied@linux.ie, sean@poorly.run, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, hdegoede@redhat.com, laurent.pinchart@ideasonboard.com, xen-devel@lists.xenproject.org, sam@ravnborg.org, emil.velikov@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1998976094736861100==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pCIvLSsYBYOw52ijDqWub0Xa7Pbcuk34Z"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pCIvLSsYBYOw52ijDqWub0Xa7Pbcuk34Z
Content-Type: multipart/mixed; boundary="6GUilDKLRS1Nl4WmXujzoC8tlZiZqY5my";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: david@lechnology.com, oleksandr_andrushchenko@epam.com, airlied@linux.ie,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, hdegoede@redhat.com,
 laurent.pinchart@ideasonboard.com, xen-devel@lists.xenproject.org,
 sean@poorly.run, emil.velikov@collabora.com
Message-ID: <1659c9ee-37ee-988a-6aaa-e115d1529fd6@suse.de>
Subject: Re: [PATCH v3 0/4] Use no_vblank property for drivers without VBLANK
References: <20200120122051.25178-1-tzimmermann@suse.de>
 <20200121093604.ruclkfho5gmflasq@sirius.home.kraxel.org>
In-Reply-To: <20200121093604.ruclkfho5gmflasq@sirius.home.kraxel.org>

--6GUilDKLRS1Nl4WmXujzoC8tlZiZqY5my
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 21.01.20 um 10:36 schrieb Gerd Hoffmann:
> On Mon, Jan 20, 2020 at 01:20:47PM +0100, Thomas Zimmermann wrote:
>> Instead of faking VBLANK events by themselves, drivers without VBLANK
>> support can enable drm_crtc_vblank.no_vblank and let DRM do the rest.
>> The patchset makes this official and converts over drivers.
>>
>> The current implementation looks at the number of initialized CRTCs
>> wrt vblanking. If vblanking has been initialized for a CRTC, the drive=
r
>> is responsible for sending out VBLANK events. Otherwise, DRM will send=

>> out the event. The behaviour selected by initializing no_vblank as par=
t
>> of drm_atomic_helper_check_modeset().
>>
>> I went through all drivers, looking for those that call send out VBLAN=
K
>> events but do not call drm_vblank_init(). These are converted to the n=
ew
>> semantics. This affects tiny drivers; drivers for virtual hardware; an=
d
>> a few others, which do not support interrupts. Xen comes with its
>> own VBLANK logic and disables no_vblank explictly.
>=20
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>

Thanks a lot. v4 will mostly reorganize the patches so I'll keep your A-b=
=2E

Best regards
Thomas

>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--6GUilDKLRS1Nl4WmXujzoC8tlZiZqY5my--

--pCIvLSsYBYOw52ijDqWub0Xa7Pbcuk34Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl4pW+oACgkQaA3BHVML
eiNV0gf+IPPOumQscdtQTf7HiwBEYXRigNipidae4Be+fOxcgoEbdgq/mZcSPvx1
Qiutl89HQ0S/9aeZLmXTvJQETVw49f4d14OwPKVk9r6bPipVDuKb1u8893tO+Cfv
uDhBhXeIOVsQj6UQMsKHRXEP89f86srW8QdhPVhpKD0e/wTNDmQNJSr36UGrVHfu
37Qnl1ti99WI25Hv1s3OdZNodLgWmWoEShvzLmXeQimVffHPt3KpNnazmVXJjJXK
ODtGNmgXgg/XP9dV6UURzQSP5fhnHWbiE0KRoE6gSWwfMvQN88LNGRWoNX5sNrVq
388slhf1P3s3iCCsYvnxqKplejINQQ==
=QYNB
-----END PGP SIGNATURE-----

--pCIvLSsYBYOw52ijDqWub0Xa7Pbcuk34Z--

--===============1998976094736861100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1998976094736861100==--
