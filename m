From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
Date: Tue, 6 Nov 2018 15:40:48 +0000
Message-ID: <20181106154048.GB31579__8728.37207648463$1541518730$gmane$org@stefanha-x1.localdomain>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
	<20181102142446-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7712902398610934796=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181102142446-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc: den@virtuozzo.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============7712902398610934796==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2018 at 02:26:00PM -0400, Michael S. Tsirkin wrote:
> On Fri, Nov 02, 2018 at 06:21:22PM +0000, Vitaly Mayatskikh wrote:
> > vhost_blk is a host-side kernel mode accelerator for virtio-blk. The
> > driver allows VM to reach a near bare-metal disk performance. See IOPS
> > numbers below (fio --rw=3Drandread --bs=3D4k).
> >=20
> > This implementation uses kiocb interface. It is slightly slower than
> > going directly through bio, but is simpler and also works with disk
> > images placed on a file system.
> >=20
> > # fio num-jobs
> > # A: bare metal over block
> > # B: bare metal over file
> > # C: virtio-blk over block
> > # D: virtio-blk over file
> > # E: vhost-blk bio over block
> > # F: vhost-blk kiocb over block
> > # G: vhost-blk kiocb over file
> > #
> > #  A     B     C    D    E     F     G
> >=20
> > 1  171k  151k  148k 151k 195k  187k  175k
> > 2  328k  302k  249k 241k 349k  334k  296k
> > 3  479k  437k  179k 174k 501k  464k  404k
> > 4  622k  568k  143k 183k 620k  580k  492k
> > 5  755k  697k  136k 128k 737k  693k  579k
> > 6  887k  808k  131k 120k 830k  782k  640k
> > 7  1004k 926k  126k 131k 926k  863k  693k
> > 8  1099k 1015k 117k 115k 1001k 931k  712k
> > 9  1194k 1119k 115k 111k 1055k 991k  711k
> > 10 1278k 1207k 109k 114k 1130k 1046k 695k
> > 11 1345k 1280k 110k 108k 1119k 1091k 663k
> > 12 1411k 1356k 104k 106k 1201k 1142k 629k
> > 13 1466k 1423k 106k 106k 1260k 1170k 607k
> > 14 1517k 1486k 103k 106k 1296k 1179k 589k
> > 15 1552k 1543k 102k 102k 1322k 1191k 571k
> > 16 1480k 1506k 101k 102k 1346k 1202k 566k
> >=20
> > Vitaly Mayatskikh (1):
> >   Add vhost_blk driver
>=20
>=20
> Thanks!
> Before merging this, I'd like to get some acks from userspace that it's
> actually going to be used - e.g. QEMU block maintainers.

I have CCed Kevin, who is the overall QEMU block layer maintainer.

Also CCing Denis since I think someone was working on a QEMU userspace
multiqueue virtio-blk device for maximum performance.

Previously vhost_blk.ko implementations were basically the same thing as
the QEMU x-data-plane=3Don (dedicated thread using Linux AIO), except they
were using a kernel thread and maybe submitted bios.

The performance differences weren't convincing enough that it seemed
worthwhile maintaining another code path which loses live migration, I/O
throttling, image file formats, etc (all the things that QEMU's block
layer supports).

Two changes since then:

1. x-data-plane=3Don has been replaced with a full trip down QEMU's block
layer (-object iothread,id=3Diothread0 -device
virtio-blk-pci,iothread=3Diothread0,...).  It's slower and not truly
multiqueue (yet!).

So from this perspective vhost_blk.ko might be more attractive again, at
least until further QEMU block layer work eliminates the multiqueue and
performance overheads.

2. SPDK has become available for users who want the best I/O performance
and are willing to sacrifice CPU cores for polling.

If you want better performance and don't care about QEMU block layer
features, could you use SPDK?  People who are the target market for
vhost_blk.ko would probably be willing to use SPDK and it already
exists...

=46rom the QEMU userspace perspective, I think the best way to integrate
vhost_blk.ko is to transparently switch to it when possible.  If the
user enables QEMU block layer features that are incompatible with
vhost_blk.ko, then it should fall back to the QEMU block layer
transparently.

I'm not keen on yet another code path with it's own set of limitations
and having to educate users about how to make the choice.  But if it can
be integrated transparently as an "accelerator", then it could be
valuable.

Stefan

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb4bYAAAoJEJykq7OBq3PIE4kH/364LD6soxAHsmgryCsOkfUV
pfJcVPMKdozURNuGEOx3Qm97tF0Ic3ex7kROww+d/P2rJk3d8y9GRvX8FUu4PbwT
fayJe4/uK34y2OAPFRiVGnC1TsiHoJ0yn1W4FFYXzykYRv3Nx2X9Pdj51N56OK0I
Mj4acUDOFcmJqXxqYIN0ixUC4ouhbo7qEZqV7Bfsakoah6f4zZQc7SlAQh5ls3I7
XOD8Ayh7ogQOtZvbrxz5LCPrOk1D+O7GcUU60xgwz5jwW19nFiSSZwUb4f7W5LVM
qzMGW8rD9tPUXA/A2laa8j8IDqrkLHkSHJ2kovGrdUH+cKTuWL8jDUAUQZKSNME=
=AaME
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

--===============7712902398610934796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7712902398610934796==--
