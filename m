From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Interesting qemu/virt-manager bug about the "rotational"
 attribute on virtio-blk disks
Date: Thu, 23 Jul 2020 11:32:39 +0100
Message-ID: <20200723103239.GD186372@stefanha-x1.localdomain>
References: <20200716080614.GA18456@redhat.com>
 <20200716093344.7molwklwco4sdtvs@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0332307665544436917=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200716093344.7molwklwco4sdtvs@steredhat>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, qemu-discuss@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

--===============0332307665544436917==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline

--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 11:33:44AM +0200, Stefano Garzarella wrote:
> +Cc Michael, Stefan, virtualization@lists.linux-foundation.org
>=20
> On Thu, Jul 16, 2020 at 09:06:14AM +0100, Richard W.M. Jones wrote:
> >=20
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1857515
> >=20
> > A virtio-blk disk which is backed by a raw file on an SSD,
> > inside the guest shows rotational =3D 1.
> >=20
> > I assumed that qemu must have a "rotational" property for disks and
> > this would be communicated by virtio to the guest, but qemu and virtio
> > don't seem to have this.  Pretty surprising!  Is it called something
> > other than "rotational"?
> >=20
>=20
> I'm not sure if we need to add this property in QEMU, but in Linux
> I found these flags (include/linux/blkdev.h) for the block queues:
>=20
>     #define QUEUE_FLAG_NONROT=096=09/* non-rotational device (SSD) */
>     #define QUEUE_FLAG_VIRT=09=09QUEUE_FLAG_NONROT /* paravirt device */
>=20
> xen-blkfront driver is the only one that sets the QUEUE_FLAG_VIRT,
> should we do the same in the virtio-blk driver regardless of the backend?

The ability to control this flag would be interesting for performance
experiments.

The problem with changing the default is that regressions can be
expected. Certain workloads benefit while others regress.

I suggest:
1. Make it controllable so that QUEUE_FLAG_NONROT can be set or clear
   (not hardcoded to a single value).
2. The device can communicate the optimal setting from the host. The
   SCSI protocol already conveys this information. Virtio-blk needs a
   feature bit and possibly config space field.
3. Make it migration-safe. It needs to be configured explicitly so the
   value doesn't change suddenly across migration.

Stefan

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZZ0cACgkQnKSrs4Gr
c8gW8wgAlPxsGR7dHsfx/U6xY5fFlSKncToyAC4LsXOrw6bdavJMNxH2sW0eq8EE
67nOr9dPqRvNqnJRT1a8KmKui8lk6Cka/gKZt9A/vTqTK9gbw1bXCV1jX5p09o0s
KZF0Huh1z2GQKW81YDkRAPU95xCTCMCTpHl7aCo4P0LxskZGU/H2HiJfm1PSpHla
NJPQlbhL0yElehVrqjDEKOyBgq0Q1Ot7r6i6f+MUSooD2hvbKc/6MubHFlmmlxzu
N5A8VWDL1CHp5jzv+Y1axKDWT3ThdC2DOLMtPb8PjTG5asBV02UQ6WbNRzDq0pkK
QT/qNd8eXFIlFSXJn4/bHcH/3/JxYA==
=wtiW
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--


--===============0332307665544436917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0332307665544436917==--
