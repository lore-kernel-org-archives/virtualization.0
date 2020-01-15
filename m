From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible
Date: Wed, 15 Jan 2020 14:41:19 +0100
Message-ID: <20200115134119.GP1314@mail-itl>
References: <20200110163211.GB29736@mail-itl>
 <20200113071939.rtqb7yw45zi63fqy@sirius.home.kraxel.org>
 <20200115003356.GL2507@mail-itl>
 <20200115100821.qcdraolkoki6e5tz@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6210848139401305267=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200115100821.qcdraolkoki6e5tz@sirius.home.kraxel.org>
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


--===============6210848139401305267==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IjzautVOrq+IorBk"
Content-Disposition: inline


--IjzautVOrq+IorBk
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="cU9XODsizZBnwgll"
Content-Disposition: inline
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible


--cU9XODsizZBnwgll
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 11:08:21AM +0100, Gerd Hoffmann wrote:
>   Hi,
>=20
> > > No clue why, also doesn't reproduce here (standard fedora 31 5.4.7
> > > kernel).  I don't have an encrypted disk, so no passphrase prompt,
> > > maybe that makes a difference.
> >=20
> > Extra data point: it worked on 4.19.89.
> >=20
> > > How does /proc/iomem look after boot, specifically the 0000:00:02.0 p=
ci
> > > bars?
> >=20
> > grep 0000:00:02.0 /proc/iomem
> >   c0000000-c0ffffff : 0000:00:02.0
> >   c1087000-c1087fff : 0000:00:02.0
>=20
> And "grep -A1 0000:00:02.0 /proc/iomem" ?

  c0000000-c0ffffff : 0000:00:02.0
  c1000000-c103ffff : 0000:00:04.0
--
  c1087000-c1087fff : 0000:00:02.0
  fec00000-fec00fff : Reserved

Full iomem attached.

> Also: what happens if you "rmmod bochs-drm; modprobe bochs-drm"?

Looks promising, but I didn't get my console back:

[46921.550669] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers:=
 bar 0: 0xc0000000 -> 0xc0ffffff
[46921.550673] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers:=
 bar 2: 0xc1087000 -> 0xc1087fff
[46921.550675] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
[46921.553577] [drm] Found bochs VGA, ID 0xb0c5.
[46921.553579] [drm] Framebuffer size 16384 kB @ 0xc0000000, mmio @ 0xc1087=
000.
[46921.554733] [TTM] Zone  kernel: Available graphics memory: 1997204 KiB
[46921.554735] [TTM] Initializing pool allocator
[46921.554741] [TTM] Initializing DMA pool allocator
[46921.556460] [drm] Found EDID data blob.
[46921.557129] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 =
on minor 0
[46921.562805] fbcon: bochs-drmdrmfb (fb0) is primary device
[46921.562808] fbcon: Deferring console take-over
[46921.562813] bochs-drm 0000:00:02.0: fb0: bochs-drmdrmfb frame buffer dev=
ice


--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--cU9XODsizZBnwgll
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="iomem.txt"

00000000-00000fff : Reserved
00001000-0009ffff : System RAM
000a0000-000fffff : Reserved
  000a0000-000bffff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-007fffff : System RAM
00800000-00807fff : ACPI Non-volatile Storage
00808000-0080ffff : System RAM
00810000-008fffff : ACPI Non-volatile Storage
00900000-be762fff : System RAM
  01000000-01c00e30 : Kernel code
  01c00e31-0263093f : Kernel data
  02c93000-031fffff : Kernel bss
be763000-be774fff : ACPI Non-volatile Storage
be775000-be793fff : Reserved
be794000-be9d5fff : System RAM
be9d6000-beb1afff : Reserved
beb1b000-bfb9afff : System RAM
bfb9b000-bfbf2fff : Reserved
bfbf3000-bfbfafff : ACPI Tables
bfbfb000-bfbfefff : ACPI Non-volatile Storage
bfbff000-bff4ffff : System RAM
bff50000-bff6ffff : Reserved
bff70000-bfffffff : ACPI Non-volatile Storage
c0000000-febfffff : PCI Bus 0000:00
  c0000000-c0ffffff : 0000:00:02.0
  c1000000-c103ffff : 0000:00:04.0
  c1040000-c105ffff : 0000:00:04.0
  c1060000-c107ffff : 0000:00:04.0
  c1080000-c1083fff : 0000:00:04.0
  c1084000-c1084fff : 0000:00:07.0
  c1085000-c1085fff : 0000:00:06.0
  c1086000-c1086fff : 0000:00:05.0
    c1086000-c1086fff : ehci_hcd
  c1087000-c1087fff : 0000:00:02.0
fec00000-fec00fff : Reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fee00000-feefffff : Reserved
  fee00000-fee00fff : Local APIC
100000000-1403e1fff : System RAM
1403e2000-143ffffff : RAM buffer
800000000-87fffffff : PCI Bus 0000:00
  800000000-800003fff : 0000:00:06.0
    800000000-800003fff : virtio-pci-modern
  800004000-800007fff : 0000:00:07.0
    800004000-800007fff : virtio-pci-modern
fd00000000-ffffffffff : Reserved


--cU9XODsizZBnwgll--

--IjzautVOrq+IorBk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl4fFn8ACgkQ24/THMrX
1yzHZgf+I8ALNHuzSByjXKz1qozygLmfk6bvy7hFPLLlJY1exngAn8lUD9XRu/dJ
csx+SM7m9ZXyTDb25tANz6GVgERLnx10LVmiimaSup+8tlxLWk1m2AkTFq5FsagD
t9APSoZqeg4wUb4FNfCyR2gRLeW1JyTs2/WH1GpSl2KbpaBOSAGCItZMr3HrE2sN
i33x0uu5cplo/rup25MpjXxYvu++/EJHBlBMSdW+aJkaDnNC136XuMmRyJGhM0cJ
2IRLLM+i1MwKdrvtc39KMMIBe2AghgenAgjTk/tIY67NzbBko3P3P87ktpTHMkWC
lMXNlzfv1nYg31ThVHQwV36FLycYcw==
=YlUN
-----END PGP SIGNATURE-----

--IjzautVOrq+IorBk--

--===============6210848139401305267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6210848139401305267==--
