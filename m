From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: bochs_hw_init fails to request framebuffer on EFI boot with plymouth
 visible
Date: Fri, 10 Jan 2020 17:32:11 +0100
Message-ID: <20200110163211.GB29736@mail-itl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7745235062308584373=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============7745235062308584373==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: bochs_hw_init fails to request framebuffer on EFI boot with plymouth
 visible

Hi,

This is the context of "bochs_drm: failed bochs_hw_init() results in
panic". When I boot the system, if plymouth is visible, it crashes. But
if I press ESC to hide it, it boots fine. bochs_drm is build as module
and _not_ included in the initramfs, so it is loaded only after root
filesystem is mounted. And before that, efifb works just fine, including
nice graphical disk passphrase prompt.

This particular setup is running Xen nested in KVM, but I can reproduce
the crash on plain Linux within KVM too, so that probably doesn't
matter.
Versions:
 - Linux 5.4.5
 - QEMU 4.2.0

Messages about bochs_drm init when it works:

[   33.802504] parport_pc parport_pc.956: Unable to set coherent dma mask: =
disabling DMA
[   33.873522] MCE: In-kernel MCE decoding enabled.
[   33.899895] parport_pc parport_pc.888: Unable to set coherent dma mask: =
disabling DMA
[   33.977738] parport_pc parport_pc.632: Unable to set coherent dma mask: =
disabling DMA
[   34.071587] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers:=
 bar 0: 0xc0000000 -> 0xc0ffffff
[   34.096014] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers:=
 bar 2: 0xc1087000 -> 0xc1087fff
[   34.149109] fb0: switching to bochsdrmfb from EFI VGA
[   34.170491] Console: switching to colour dummy device 80x25
[   34.178497] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
[   34.188729] [drm] Found bochs VGA, ID 0xb0c5.
[   34.189974] [drm] Framebuffer size 16384 kB @ 0xc0000000, mmio @ 0xc1087=
000.
[   34.200131] [TTM] Zone  kernel: Available graphics memory: 2004604 KiB
[   34.202006] [TTM] Initializing pool allocator
[   34.233679] [TTM] Initializing DMA pool allocator
[   34.246468] [drm] Found EDID data blob.
[   34.249477] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 =
on minor 0
[   34.276315] fbcon: bochs-drmdrmfb (fb0) is primary device
[   34.283968] Console: switching to colour frame buffer device 128x48
[   34.345742] ppdev: user-space parallel port driver
[   34.566261] bochs-drm 0000:00:02.0: fb0: bochs-drmdrmfb frame buffer dev=
ice


Messages about bochs_drm init when it crashes:

[   32.889058] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers:=
 bar 0: 0xc0000000 -> 0xc0ffffff
[   32.891801] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers:=
 bar 2: 0xc1087000 -> 0xc1087fff
[   32.921205] parport_pc parport_pc.956: Unable to set coherent dma mask: =
disabling DMA
[   32.927873] parport_pc parport_pc.888: Unable to set coherent dma mask: =
disabling DMA
[   32.946529] parport_pc parport_pc.632: Unable to set coherent dma mask: =
disabling DMA
[   32.951345] fb0: switching to bochsdrmfb from EFI VGA
[   32.963031] Console: switching to colour dummy device 80x25
[   32.979805] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
[   33.015380] MCE: In-kernel MCE decoding enabled.
[   33.030158] bochs-drm 0000:00:02.0: BAR 0: can't reserve [mem 0xc0000000=
-0xc0ffffff pref]
[   33.032576] [drm:bochs_hw_init [bochs_drm]] *ERROR* Cannot request frame=
buffer


Full logs: https://gist.github.com/marmarek/ca4fdcfd33d7e5258f15082fafa27bfc

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl4YpwsACgkQ24/THMrX
1ywSNgf/VhZ17Zg1EAO4EsXhTfcOqxG/Aj5J/hZeNMEAjfPXyMLMr2F0Rvr9XSsx
9uPkApVruutonI6JqfI/EmiObIS1wMwyaQDcgwEgnlWYuoVan0hELh2kICtP6ywU
HBmKYyKJ8xJ5kcViEoSbsgTsB0hNp8QLNOTDsEgof/FFksJaQsbI4TmaIAafrTjr
OS7TLZli/iwAWM1mB6PqfR9ihUkcVTZ9/rQOwnhaPz8kqIHgk83wZWCpDfvq8oP7
H3pQp7CFnq1PAZNqOJo5Wks0bcaCbxRq676xtGvcltPrWcv90LrmT2vlrZq+/4bJ
C3Up5SZuHixOmqJ0xPVcz9nSaSmKmQ==
=wKEj
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

--===============7745235062308584373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7745235062308584373==--
