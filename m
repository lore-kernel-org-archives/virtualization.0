From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4] virtio_blk: add DISCARD and WRIET ZEROES commands
	support
Date: Fri, 1 Jun 2018 09:59:35 +0100
Message-ID: <20180601085935.GA8196@stefanha-x1.localdomain>
References: <1527558144-3825-1-git-send-email-changpeng.liu@intel.com>
	<20180531103047.GB27838@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B6DCEE5@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0689878702956804789=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B6DCEE5@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "cavery@redhat.com" <cavery@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============0689878702956804789==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2018 at 11:53:26PM +0000, Liu, Changpeng wrote:
>=20
>=20
> > -----Original Message-----
> > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > Sent: Thursday, May 31, 2018 6:31 PM
> > To: Liu, Changpeng <changpeng.liu@intel.com>
> > Cc: virtualization@lists.linux-foundation.org; cavery@redhat.com;
> > jasowang@redhat.com; pbonzini@redhat.com; Wang, Wei W
> > <wei.w.wang@intel.com>
> > Subject: Re: [PATCH v4] virtio_blk: add DISCARD and WRIET ZEROES comman=
ds
> > support
> >=20
> > On Tue, May 29, 2018 at 09:42:24AM +0800, Changpeng Liu wrote:
> > >  	num =3D blk_rq_map_sg(hctx->queue, req, vbr->sg);
> > >  	if (num) {
> > > -		if (rq_data_dir(req) =3D=3D WRITE)
> > > +		if (rq_data_dir(req) =3D=3D WRITE || type =3D=3D VIRTIO_BLK_T_DISC=
ARD
> > ||
> > > +		    type =3D=3D VIRTIO_BLK_T_WRITE_ZEROES)
> > >  			vbr->out_hdr.type |=3D cpu_to_virtio32(vblk->vdev,
> > VIRTIO_BLK_T_OUT);
> >=20
> > The VIRTIO specification says:
> >=20
> >   The type of the request is either a read (VIRTIO_BLK_T_IN), a write
> >   (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
> >   (VIRTIO_BLK_T_WRITE_ZEROES) or a flush (VIRTIO_BLK_T_FLUSH).
> >=20
> > But this patch actually uses VIRTIO_BLK_T_DISCARD | VIRTIO_BLK_T_OUT or
> > VIRTIO_BLK_T_WRITE_ZEROES | VIRTIO_BLK_T_OUT.  "either A or B" is
> > exclusive, it does not mean "A and B".
> Hi Stefan,
>=20
> For the new add DISCARD and WRITE ZEROES commands, I defined the=20
> type code to 11 and 13, so the last bit always is 1, there is no differen=
ce
> in practice.

Then the code is misleading.  This is clearer:

  if (type =3D=3D VIRTIO_BLK_T_DISCARD || type =3D=3D VIRTIO_BLK_T_WRITE_ZE=
ROES)
      /* Do nothing, type already set */
  else if (rq_data_dir(req) =3D=3D WRITE)
      vbr->out_hdr.type |=3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_OUT);
  ...

> But I believe the specification says VIRTIO_BLK_T_OUT means direction, so
> OR the two bits together should compliance with the specification.

I cannot find that in the specification:

  http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#=
x1-2020002

and it would contradict the "The type of the request is either ... or
=2E.." wording that I quoted from the spec above.

If you do find something in the spec, please let me know and we can
figure out how to make the spec consistent.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbEQr3AAoJEJykq7OBq3PI2XMH/iB/mERqql7IYn40XKBgbETK
6+jn86N2pt1ZdU7R+Mxbz8TwEAKYM3Yed6zosVeEfG0X53/Pi/6I9iu+vck8QNUP
Uq/fAu2PfZ6vmK3vKYBcliE3UdGu9kGGFuDg9cV+u4m2270P32yrKw+wbNRuLfzb
GX4YwO+vOJw3KWvDWTJycL5MGu81GPEejEz8IWKlNmBszOHd0SGfqy+pJ409Fj3a
SK9CdDDucKNATEAlqrw+kPfpFEP0fcGoKGX2YrLDn0JYU/+z+lEvjK8sgyUFIK6b
IiAkJa3G7GNs3+mc2xScuDMa71xYDREP11jmtZMFWdLKhf2F3VzVq4dlaUqfz8Y=
=SIVn
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

--===============0689878702956804789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0689878702956804789==--
