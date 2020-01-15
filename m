From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible
Date: Wed, 15 Jan 2020 01:33:56 +0100
Message-ID: <20200115003356.GL2507@mail-itl>
References: <20200110163211.GB29736@mail-itl>
 <20200113071939.rtqb7yw45zi63fqy@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0933172239616650811=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200113071939.rtqb7yw45zi63fqy@sirius.home.kraxel.org>
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


--===============0933172239616650811==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ICrdrp3pM9DyZLTK"
Content-Disposition: inline


--ICrdrp3pM9DyZLTK
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible

On Mon, Jan 13, 2020 at 08:19:39AM +0100, Gerd Hoffmann wrote:
> On Fri, Jan 10, 2020 at 05:32:11PM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > Hi,
> >=20
> > This is the context of "bochs_drm: failed bochs_hw_init() results in
> > panic". When I boot the system, if plymouth is visible, it crashes. But
> > if I press ESC to hide it, it boots fine. bochs_drm is build as module
> > and _not_ included in the initramfs, so it is loaded only after root
> > filesystem is mounted. And before that, efifb works just fine, including
> > nice graphical disk passphrase prompt.
>=20
> > [   32.951345] fb0: switching to bochsdrmfb from EFI VGA
> [ ... ]
> > [   33.030158] bochs-drm 0000:00:02.0: BAR 0: can't reserve [mem 0xc000=
0000-0xc0ffffff pref]
>=20
> Looks like efifb continues to claim the framebuffer resource
> (0xc0000000-0xc0ffffff) for some reason, so bochs-drm can't
> reserve it.
>=20
> No clue why, also doesn't reproduce here (standard fedora 31 5.4.7
> kernel).  I don't have an encrypted disk, so no passphrase prompt,
> maybe that makes a difference.

Extra data point: it worked on 4.19.89.

> How does /proc/iomem look after boot, specifically the 0000:00:02.0 pci
> bars?

grep 0000:00:02.0 /proc/iomem
  c0000000-c0ffffff : 0000:00:02.0
  c1087000-c1087fff : 0000:00:02.0

lspci -vvs 0000:00:02.0
00:02.0 VGA compatible controller: Device 1234:1111 (rev 02) (prog-if 00 [V=
GA controller])
        Subsystem: Red Hat, Inc. Device 1100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Region 0: Memory at c0000000 (32-bit, prefetchable) [size=3D16M]
        Region 2: Memory at c1087000 (32-bit, non-prefetchable) [size=3D4K]
        Expansion ROM at 000c0000 [disabled] [size=3D128K]
        Kernel modules: bochs_drm

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--ICrdrp3pM9DyZLTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl4eXfQACgkQ24/THMrX
1ywsAQf+IYTpUQhFVJQCqcY7225Z5cbDeotU/3S8l8yFrW+OtJna2CsBk4h3ePTU
+lP7zhQ2zRkl3+79XBqpcEt3Wy56Eh3o9jPN+yv7ANvy+3sy4WR4QyY19uc/CC6D
MXtuWFJZ/AG3b1YC+k1a6J45wP2mj0Un7GSugWYsCBPaC06+Jc4YVtUHsa87YdCu
L5qMWaHwTBMKkD2/KkQOjGRbWzO05xc/n5XDnLQv26zN6mk7aTBLxXAISo8HZlxj
I4xufIFHVvzqt7BtDoUtKQzA0B8/qsYJaDPnIoLCG1W32buE0kUWKDDSgmb5dqRI
AM078UOJb5ET+X1gTq2NniJHHtBorA==
=EAXg
-----END PGP SIGNATURE-----

--ICrdrp3pM9DyZLTK--

--===============0933172239616650811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0933172239616650811==--
