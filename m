From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible
Date: Wed, 15 Jan 2020 15:27:41 +0100
Message-ID: <20200115142741.GM2507@mail-itl>
References: <20200110163211.GB29736@mail-itl>
 <20200113071939.rtqb7yw45zi63fqy@sirius.home.kraxel.org>
 <20200115003356.GL2507@mail-itl>
 <20200115100821.qcdraolkoki6e5tz@sirius.home.kraxel.org>
 <20200115134119.GP1314@mail-itl>
 <20200115141353.3kse3uj2mg6ik6k5@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0708393496682375683=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200115141353.3kse3uj2mg6ik6k5@sirius.home.kraxel.org>
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


--===============0708393496682375683==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AA9g+nFNFPYNJKiL"
Content-Disposition: inline


--AA9g+nFNFPYNJKiL
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible

On Wed, Jan 15, 2020 at 03:13:53PM +0100, Gerd Hoffmann wrote:
>   Hi,
>=20
> > > And "grep -A1 0000:00:02.0 /proc/iomem" ?
> >=20
> >   c0000000-c0ffffff : 0000:00:02.0
> >   c1000000-c103ffff : 0000:00:04.0
>=20
> So no reservation left.  Whatever blocked the pci bar resource (efifb
> probably) is gone now.
>=20
> So the interesting question is why that reservation sticked long enough
> to prevent bochs-drm from initializing.  In theory efifb de-init should
> be completed when drm_fb_helper_remove_conflicting_pci_framebuffers()
> returns.

Maybe the fact that switching to text mode plymouth help, gives some
hint?

> Bisecting could help, or springkling printk's into efifb ...

That's a pretty broad range of commits...
I'll try adding some printks.

> > [46921.562805] fbcon: bochs-drmdrmfb (fb0) is primary device
> > [46921.562808] fbcon: Deferring console take-over
>=20
> I think that is just some eye candy which delays fbcon init until
> something is actually printed.
>=20
> Try "echo hello world > /dev/tty0".
> Maybe tapping enter (to make getty re-print the login prompt) works too.

Oh, yes, indeed it works.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--AA9g+nFNFPYNJKiL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl4fIV4ACgkQ24/THMrX
1yyQWAgAhyAtsKVWKV+RdLZhnbOkPAPWlCdF+2Z4ecNX1BJE6oxIXZWwkMX6wmnF
M3HxFkQdpkAuM5aoimSyBEWvjes1KWpuyCQeFv2GyqMZzTgZyKIL1zYFUsHUvtuE
FknTQt4waa31Ty6Ob3XWKHFrPJTYrcDUHf1mLHFwKPiixC7Yd/xU9v25M9YY0kKH
J5sbfgyLdXizDl1wAoGLrUtj7EngwZ3qbDcvIsQGf6fxLSsJ9CRM/UafKEG75Av0
fnFyIA+EhygNcCyxHFaFbUNES6afZJt8vq1Uq9KL1ijeZOktrvEDsZ22z71IMchZ
0A9B7k3yFXvvU8LEjBtUz8KdB7Vb+A==
=8tHz
-----END PGP SIGNATURE-----

--AA9g+nFNFPYNJKiL--

--===============0708393496682375683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0708393496682375683==--
