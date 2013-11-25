From: Richard Yao <ryao@gentoo.org>
Subject: Re: QEMU dies on any attempt to load a Linux kernel module when using
	a 9P rootfs
Date: Mon, 25 Nov 2013 16:50:26 -0500
Message-ID: <5293C622.4070304@gentoo.org>
References: <5293718E.4090508@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1673153733307896833=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5293718E.4090508@gentoo.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: kernel@gentoo.org, v9fs-developer@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1673153733307896833==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tcbTtsEcf5oip1IxKJVhRMaGABlBN2isl"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tcbTtsEcf5oip1IxKJVhRMaGABlBN2isl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I figured out the problem. There is zerocopy IO is being done via DMA to
a buffer allocated with valloc(). Right now, I am running a hack-fix
locally so I can get some other stuff done first. I will propose a
proper fix to the list in a few days.

On 11/25/2013 10:49 AM, Richard Yao wrote:
> I booted a Gentoo Linux installation in QEMU with a 9P rootfs as follow=
s:
>=20
> sudo qemu-kvm -cpu host -m 1024 -kernel
> /mnt/test/usr/src/linux-3.13-rc1/arch/x86/boot/bzImage -append
> 'root=3D/dev/root rootfstype=3D9p rootflags=3Dtrans=3Dvirtio,version=3D=
9p2000.L ro
> console=3DttyS0' -serial stdio -fsdev
> local,id=3Droot,path=3D/mnt/test,security_model=3Dnone -device
> virtio-9p-pci,fsdev=3Droot,mount_tag=3D/dev/root
>=20
> The system boots fine, but attempting to load any module will fail:
>=20
> localhost ~ # modprobe crc32
> qemu-system-x86_64: virtio: trying to map MMIO memory
>=20
> The behavior is consistent no matter what combination of things that I
> try. So far, I have tried Linux 3.10.7-gentoo (Gentoo patchset) and
> Linux 3.13-rc1. I have tried QEMU 1.4.2, QEMU 1.6.1 and QEMU HEAD. I
> have also tried booting without KVM, but the behavior is the same:
>=20
> sudo qemu-kvm --no-kvm -m 1024 -kernel
> /mnt/test/usr/src/linux-3.13-rc1/arch/x86/boot/bzImage -append
> 'root=3D/dev/root rootfstype=3D9p rootflags=3Dtrans=3Dvirtio,version=3D=
9p2000.L ro
> console=3DttyS0' -serial stdio -fsdev
> local,id=3Droot,path=3D/mnt/test,security_model=3Dnone -device
> virtio-9p-pci,fsdev=3Droot,mount_tag=3D/dev/root
>=20
> Here is a backtrace of QEMU itself that I obtained using gdb:
>=20
> Breakpoint 1, virtqueue_map_sg (sg=3D0x7f695b797b98, addr=3D0x7f695b793=
b98,
> num_sg=3D3, is_write=3D1) at
> /usr/src/debug/app-emulation/qemu-9999/qemu-9999/hw/virtio/virtio.c:434=

> 434                 error_report("virtio: trying to map MMIO memory");
> (gdb) bt
> #0  virtqueue_map_sg (sg=3D0x7f695b797b98, addr=3D0x7f695b793b98, num_s=
g=3D3,
> is_write=3D1) at
> /usr/src/debug/app-emulation/qemu-9999/qemu-9999/hw/virtio/virtio.c:434=

> #1  0x00000000006eb666 in virtqueue_pop (vq=3D0x1b23740,
> elem=3D0x7f695b793b88) at
> /usr/src/debug/app-emulation/qemu-9999/qemu-9999/hw/virtio/virtio.c:500=

> #2  0x00000000004a74ee in handle_9p_output (vdev=3D0x7f695b1fd910,
> vq=3D0x1b23740) at
> /usr/src/debug/app-emulation/qemu-9999/qemu-9999/hw/9pfs/virtio-9p.c:32=
54
> #3  0x00000000006ec4b5 in virtio_queue_notify_vq (vq=3D0x1b23740) at
> /usr/src/debug/app-emulation/qemu-9999/qemu-9999/hw/virtio/virtio.c:720=

> #4  0x00000000006edf65 in virtio_queue_host_notifier_read (n=3D0x1b2379=
0)
> at /usr/src/debug/app-emulation/qemu-9999/qemu-9999/hw/virtio/virtio.c:=
1116
> #5  0x00000000005d3c9c in qemu_iohandler_poll (pollfds=3D0x1aae200, ret=
=3D1)
> at /usr/src/debug/app-emulation/qemu-9999/qemu-9999/iohandler.c:143
> #6  0x00000000005d4702 in main_loop_wait (nonblocking=3D0) at
> /usr/src/debug/app-emulation/qemu-9999/qemu-9999/main-loop.c:484
> #7  0x000000000066c583 in main_loop () at
> /usr/src/debug/app-emulation/qemu-9999/qemu-9999/vl.c:2014
> #8  0x00000000006730d1 in main (argc=3D17, argv=3D0x7fffa93167c8,
> envp=3D0x7fffa9316858) at
> /usr/src/debug/app-emulation/qemu-9999/qemu-9999/vl.c:4366
>=20
> I spoke with Alexander Graf about this in IRC. He suggested that the
> guest is passing QEMU a bad address and gave me a small patch to use to=

> get the VM to stop when this happens so that I could attach gdb and pok=
e
> around. Sadly, I was on my way out to dinner when he gave that to me an=
d
> I subsequently lost the patch to the Debian's paste bin's garbage
> collection. I have tried debugging without it by booting qemu with `-s
> -S`, setting break points for the kernel module initialization routines=

> and running the system, but the breakpoints are not triggering.
>=20
> If I could get another copy of the patch that Alexander gave me, I woul=
d
> be able to move forward. Unfortunately, he is not on IRC right now. I
> cannot debug any further with my current knowledge, so I am sending wha=
t
> I know so far to the relevant mailing lists. It would be greatly
> appreciated if someone would point me in the right direction (or even
> better, send me a patch to fix what is wrong).
>=20
> P.S. As a side note, there appears to be regression between 3.10.7 and
> 3.13-rc1. In specific, the rootfs will fail to mount unless I use
> mount_tag=3D/dev/root and pass root=3D/dev/root. With 3.10.7, I could u=
se an
> arbitrary name.
>=20



--tcbTtsEcf5oip1IxKJVhRMaGABlBN2isl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSk8YkAAoJECDuEZm+6ExkalgP/1pJFwJhN9hxLZAeElJmq61V
Oe8ufZpr84/nGlbU9VeR5ncYV2PXnaOFg2gH4oW88CeD5kKsYmF0ugt6iiB9mXP+
/QOyo5lx6ZpVqlaX0aNpvuEsZtpymcRoOSQjEgO8yDAgU4N4H7S7WDcmY1uDStMC
2TejdnquDTpD9vVJ2+uTATYtIWqQD9BjBExSmm+USv0xycqu5k/YGEd7e8DgAILh
EqIgWDi9QnywWJNmicjA8vz0T2gH6UsUBoEfga41Fx8nPu/XlnaAWyRfxfZ7XpKO
Ej2eFFi5q5UzDtEdA5ILjxSJwi5GzUl90cm623R+Yz3k82N8N7uBMmXVWlJW4GmH
IfWfqvNJ4mWo0fx+sg1L0GSlHNsMsF+Zb9oZXxp+GeZkl9hgd1bWGN9rrNZfeY5v
SfMXoEm4/PWyJGMV0Wp0M3fY9HX9p6bNmURMF8IrEq3uqY7CMzn7xNMi1GTVR6JQ
sNUy2QkQkshj61ZbjGc6YX67y7ttkkYQ7bcvIEfpNQ4TqW2hSmyz5v2btqpJMZXq
XOl4fsex7sztz7oYXx28qR87FuBFh1CX9AmFrEQwTKGJPilMKREhHgd03mZrYAyu
4VKB/JVy6BTeYj8E09fAWVfR5dTbXHeX33aia1CqpL+ISsKSgbyDTxR6FhBIQTmv
iAQALIBOj/LT4tszhQIN
=V23r
-----END PGP SIGNATURE-----

--tcbTtsEcf5oip1IxKJVhRMaGABlBN2isl--

--===============1673153733307896833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1673153733307896833==--
