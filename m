From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: Re: bochs_drm: failed bochs_hw_init() results in panic
Date: Sat, 11 Jan 2020 01:07:45 +0100
Message-ID: <20200111000745.GF2507@mail-itl>
References: <20200110013328.GA12596@mail-itl>
 <20200110053553.4gqlagjdpfi6pg3b@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2746345514883671253=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200110053553.4gqlagjdpfi6pg3b@sirius.home.kraxel.org>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============2746345514883671253==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: bochs_drm: failed bochs_hw_init() results in panic

On Fri, Jan 10, 2020 at 06:35:53AM +0100, Gerd Hoffmann wrote:
> On Fri, Jan 10, 2020 at 02:33:28AM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > Hi,
> >=20
> > It looks like bochs_kms_fini() don't like being called if
> > bochs_kms_init() wasn't. Regardless of the reason for the
> > bochs_hw_init() failure (that's another story), it shouldn't cause a
> > panic. Any idea how to fix it?
>=20
> maybe this?

Yes, it prevents the panic, with a little fix. Thanks!
Of course(?) I don't have working framebuffer then, but I can interact
with the system in other ways, at least to diagnose what's wrong.

Now the messages looks like this:

[   29.800835] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers:=
 bar 0: 0xc0000000 -> 0xc0ffffff
[   29.800840] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers:=
 bar 2: 0xc1087000 -> 0xc1087fff
[   29.800842] checking generic (c0000000 1000000) vs hw (c0000000 1000000)
[   29.800843] fb0: switching to bochsdrmfb from EFI VGA
[   29.805542] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
[   29.805742] bochs-drm 0000:00:02.0: BAR 0: can't reserve [mem 0xc0000000=
-0xc0ffffff pref]
[   29.805749] [drm:bochs_hw_init [bochs_drm]] *ERROR* Cannot request frame=
buffer
[   29.805781] bochs-drm: probe of 0000:00:02.0 failed with error -16
[   30.129014] Trying to free nonexistent resource <00000000c0000000-000000=
00c0ffffff>

Is the last one an issue?


> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bo=
chs_kms.c
> index 3f0006c2470d..322be68a238a 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -192,6 +192,9 @@ int bochs_kms_init(struct bochs_device *bochs)
> =20
>  void bochs_kms_fini(struct bochs_device *bochs)
>  {
> +	if (!dev->mode_config.num_connector)

bochs->dev->...

> +		return;
> +
>  	drm_atomic_helper_shutdown(bochs->dev);
>  	drm_mode_config_cleanup(bochs->dev);
>  }
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl4ZEdEACgkQ24/THMrX
1yxgQAf7BNzQn/c4syB9SAklGnH8cluM8WfIbc8IsxTgdSly8M1RaEHY46mDrnlM
7fyI76EFobSydNSOocQVMCSzXtzMNVnEAhAOiu11JsUmXyziAugauVz19f3gcbpa
f+pJHqukT2H1lnTCcdmIK6muzKTHAWMmPgAG2ZM4YZvp3OF8ibDrjabOscLcEF/p
62HOJSwAHur1A1o31+oaM59eGsY5O9ZZ0DSlphbkAuq9A8A/kUlRytE8KTzd7pM0
5aKiIp7o7w0mEB7xCadwbhVNUFnkc1jwppkRru/wUt0cpYzJtx41fEM3tO9z1ln5
SenB6MgyRTl3fHSDJDpwTZvzg6cibg==
=Edtu
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--

--===============2746345514883671253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2746345514883671253==--
