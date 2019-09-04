From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 15/16] virtio-fs: add virtiofs filesystem
Date: Wed, 4 Sep 2019 19:16:30 +0100
Message-ID: <20190904181630.GB26826__18841.6565115162$1567621043$gmane$org@stefanha-x1.localdomain>
References: <20190903113640.7984-1-mszeredi@redhat.com>
	<20190903114203.8278-10-mszeredi@redhat.com>
	<20190903092222-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9214186462008971396=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190903092222-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============9214186462008971396==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 09:55:49AM -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 03, 2019 at 01:42:02PM +0200, Miklos Szeredi wrote:
> Endian-ness for fuse header also looks wrong.
[...]
> > +struct virtio_fs_forget {
> > +	struct fuse_in_header ih;
> > +	struct fuse_forget_in arg;
>=20
> These structures are all native endian.
>=20
> Passing them to host will make cross-endian setups painful to support,
> and hardware implementations impossible.
>=20
> How about converting everything to LE?

The driver dictates the endianness of the FUSE protocol session.  The
virtio-fs device specification states that the device looks at the first
request's fuse_in_header::opcode field to detect the guest endianness.

If it sees FUSE_INIT in its native endianness then no byte-swapping is
necessary.  If it sees FUSE_INIT in the opposite endianness then
byte-swapping is necessary on the device side.

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1v/34ACgkQnKSrs4Gr
c8i/Ngf/avxJID8kUoTNNjfyRoLArYmKGT1yBKp6x5LN822UCgyyHpur20MmX6XI
zFrzqnp+AlNkaQu9P9RKeh2mhdnZNjHx9KSg/UezvIHG055WKJ2WTw2SQDhuAY5q
Yz4+5Se2gV8OeNDIPoqBFXM+yLLJpXATZGrtKSoAQd5x8Q/ll6ctpzcM71rCDVla
2kbcqDNOBo+A45A8cfHLJ8a4ppNOKoFbWPp+DLsyHPiifbdFAxxMbG4SgsnN6i59
1n/+Y6Nz/92n6kL/czYdZ6kwovv9IUdO0DFzn/lQpgRYL3dLO/qS5G7/korqfnyf
JUECay8lk+EPxVOJPt9HFaen8QA2xw==
=sBLJ
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--

--===============9214186462008971396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9214186462008971396==--
