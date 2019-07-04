From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/5] Unmappable DRM client buffers for fbdev emulation
Date: Thu, 4 Jul 2019 09:43:04 +0200
Message-ID: <aa1b7431-21c5-4c99-bfb6-6c5e4946bec3__44525.4034757213$1562226207$gmane$org@suse.de>
References: <20190703083302.2609-1-tzimmermann@suse.de>
	<a2e3baa8-f8e8-4628-e18f-cb3119194afb@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6960975757685124165=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a2e3baa8-f8e8-4628-e18f-cb3119194afb@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, airlied@redhat.com, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com, sean@poorly.run, sam@ravnborg.org, yc_chen@aspeedtech.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6960975757685124165==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hxi2okYtZStdIFvdjCHLQgyWclcyNW79y"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hxi2okYtZStdIFvdjCHLQgyWclcyNW79y
Content-Type: multipart/mixed; boundary="hfdGTlsffKKizT7nPpSMYbx5Ik0yiU9kz";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, airlied@redhat.com,
 daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com,
 maxime.ripard@bootlin.com, sean@poorly.run, sam@ravnborg.org,
 yc_chen@aspeedtech.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <aa1b7431-21c5-4c99-bfb6-6c5e4946bec3@suse.de>
Subject: Re: [PATCH 0/5] Unmappable DRM client buffers for fbdev emulation
References: <20190703083302.2609-1-tzimmermann@suse.de>
 <a2e3baa8-f8e8-4628-e18f-cb3119194afb@tronnes.org>
In-Reply-To: <a2e3baa8-f8e8-4628-e18f-cb3119194afb@tronnes.org>

--hfdGTlsffKKizT7nPpSMYbx5Ik0yiU9kz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 03.07.19 um 21:27 schrieb Noralf Tr=C3=B8nnes:
>=20
>=20
> Den 03.07.2019 10.32, skrev Thomas Zimmermann:
>> DRM client buffers are permanently mapped throughout their lifetime. T=
his
>> prevents us from using generic framebuffer emulation for devices with
>> small dedicated video memory, such as ast or mgag200. With fb buffers
>> permanently mapped, such devices often won't have enougth space left t=
o
>> display other content (e.g., X11).
>>
>> This patch set introduces unmappable DRM client buffers for framebuffe=
r
>> emulation with shadow buffers. While the shadow buffer remains in syst=
em
>> memory permanently, the respective buffer object will only be mapped b=
riefly
>> during updates from the shadow buffer. Hence, the driver can relocate =
he
>> buffer object among memory regions as needed.
>>
>> The default behoviour for DRM client buffers is still to be permanentl=
y
>> mapped.
>>
>> The patch set converts ast and mgag200 to generic framebuffer emulatio=
n
>> and removes a large amount of framebuffer code from these drivers. For=

>> bochs, a problem was reported where the driver could not display the c=
onsole
>> because it was pinned in system memory. [1] The patch set fixes this b=
ug
>> by converting bochs to use the shadow fb.
>>
>> The patch set has been tested on ast and mga200 HW.
>>
>=20
> I've been thinking, this enables dirty tracking in DRM userspace for
> these drivers since the dirty callback is now set on all framebuffers.
> Is this OK? Should we add a drm_fbdev_generic_shadow_setup() that sets =
a
> flag enabling the shadow buffer instead?

Fbdev emulation is special wrt framebuffer setup and there's no way to
distinguish a regular FB from the fbdev's FB. I've been trying
drm_fbdev_generic_shadow_setup(), but ended up duplicating
functionality. The problem was that we cannot get state-flag arguments
into drm_fb_helper_generic_probe().

There already is struct mode_config.prefer_shadow. It signals shadow FB
rendering to userspace. The easiest solution is to add
prefer_shadow_fbdev as well. If either flag is true, fbdev emulation
would enable shadow buffering.

I'm not sure if we should check for the dirty() callback at all.

Best regards
Thomas

> Really nice diffstat by the way :-)
>=20
> Noralf.
>=20
>> [1] https://lists.freedesktop.org/archives/dri-devel/2019-June/224423.=
html
>>
>> Thomas Zimmermann (5):
>>   drm/client: Support unmapping of DRM client buffers
>>   drm/fb-helper: Unmap BO for shadow-buffered framebuffer console
>>   drm/ast: Replace struct ast_fbdev with generic framebuffer emulation=

>>   drm/bochs: Use shadow buffer for bochs framebuffer console
>>   drm/mgag200: Replace struct mga_fbdev with generic framebuffer
>>     emulation
>>
>>  drivers/gpu/drm/ast/Makefile           |   2 +-
>>  drivers/gpu/drm/ast/ast_drv.c          |  22 +-
>>  drivers/gpu/drm/ast/ast_drv.h          |  17 --
>>  drivers/gpu/drm/ast/ast_fb.c           | 341 ------------------------=
-
>>  drivers/gpu/drm/ast/ast_main.c         |  30 ++-
>>  drivers/gpu/drm/ast/ast_mode.c         |  21 --
>>  drivers/gpu/drm/bochs/bochs_kms.c      |   2 +-
>>  drivers/gpu/drm/drm_client.c           |  71 ++++-
>>  drivers/gpu/drm/drm_fb_helper.c        |  14 +-
>>  drivers/gpu/drm/mgag200/Makefile       |   2 +-
>>  drivers/gpu/drm/mgag200/mgag200_drv.h  |  19 --
>>  drivers/gpu/drm/mgag200/mgag200_fb.c   | 309 ----------------------
>>  drivers/gpu/drm/mgag200/mgag200_main.c |  61 +++--
>>  drivers/gpu/drm/mgag200/mgag200_mode.c |  27 --
>>  include/drm/drm_client.h               |   3 +
>>  15 files changed, 154 insertions(+), 787 deletions(-)
>>  delete mode 100644 drivers/gpu/drm/ast/ast_fb.c
>>  delete mode 100644 drivers/gpu/drm/mgag200/mgag200_fb.c
>>
>> --
>> 2.21.0
>>
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


--hfdGTlsffKKizT7nPpSMYbx5Ik0yiU9kz--

--hxi2okYtZStdIFvdjCHLQgyWclcyNW79y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl0drggACgkQaA3BHVML
eiP3wQf/awo09QJefBTfUFH8v1yPLXevN1p91ORAudax8lsLso/3Qpkva5M8GlYM
tQT2fKjH+2OeZEklujvg3sYVkZKxuGr6YFr/5+r5xjdjGxMMCOrSpCZXslr9hoxW
tAJ9dNblfcHicIyFY5kCPn2H4aTpw8ceRJjJGke9euW6r5mKRnxHwl/gb959bWzz
U7k2rcItYJBwYxdth9c5dSLKz/th9gPyp7pfeEG6EwY5Ljak6rdbY9yRC/Q16zEy
/FJcZ0QM4JDMxUpOgMG/k99hHmwzNOuVCC1WkzyViD/BtlvGTSr9qkuADfIjsFrA
XWOWZykV3F+A2frIgxqpTGquXQIwSw==
=51m9
-----END PGP SIGNATURE-----

--hxi2okYtZStdIFvdjCHLQgyWclcyNW79y--

--===============6960975757685124165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6960975757685124165==--
