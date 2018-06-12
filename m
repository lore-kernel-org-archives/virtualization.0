From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v6] virtio_blk: add DISCARD and WRIET ZEROES commands
	support
Date: Tue, 12 Jun 2018 17:05:43 +0100
Message-ID: <20180612160543.GA16327@stefanha-x1.localdomain>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
	<20180607131003.GN19032@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B6DED4D@SHSMSX103.ccr.corp.intel.com>
	<20180608102027.GB31164@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B6DF62C@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1361588892852794699=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B6DF62C@SHSMSX103.ccr.corp.intel.com>
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


--===============1361588892852794699==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 03:37:00AM +0000, Liu, Changpeng wrote:
>=20
>=20
> > -----Original Message-----
> > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > Sent: Friday, June 8, 2018 6:20 PM
> > To: Liu, Changpeng <changpeng.liu@intel.com>
> > Cc: virtualization@lists.linux-foundation.org; cavery@redhat.com;
> > jasowang@redhat.com; pbonzini@redhat.com; Wang, Wei W
> > <wei.w.wang@intel.com>
> > Subject: Re: [PATCH v6] virtio_blk: add DISCARD and WRIET ZEROES comman=
ds
> > support
> >=20
> > On Thu, Jun 07, 2018 at 11:07:06PM +0000, Liu, Changpeng wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > > > Sent: Thursday, June 7, 2018 9:10 PM
> > > > To: Liu, Changpeng <changpeng.liu@intel.com>
> > > > Cc: virtualization@lists.linux-foundation.org; cavery@redhat.com;
> > > > jasowang@redhat.com; pbonzini@redhat.com; Wang, Wei W
> > > > <wei.w.wang@intel.com>
> > > > Subject: Re: [PATCH v6] virtio_blk: add DISCARD and WRIET ZEROES co=
mmands
> > > > support
> > > >
> > > > On Wed, Jun 06, 2018 at 12:19:00PM +0800, Changpeng Liu wrote:
> > > > > Existing virtio-blk protocol doesn't have DISCARD/WRITE ZEROES co=
mmands
> > > > > support, this will impact the performance when using SSD backend =
over
> > > > > file systems.
> > > > >
> > > > > Commit 88c85538 "virtio-blk: add discard and write zeroes feature=
s to
> > > > > specification"(see https://github.com/oasis-tcs/virtio-spec) exte=
nded
> > > > > existing virtio-blk protocol, adding extra DISCARD and WRITE ZERO=
ES
> > > > > commands support.
> > > > >
> > > > > While here, using 16 bytes descriptor to describe one segment of =
DISCARD
> > > > > or WRITE ZEROES commands, each command may contain one or more
> > > > decriptors.
> > > > >
> > > > > The following data structure shows the definition of one descript=
or:
> > > > >
> > > > > struct virtio_blk_discard_write_zeroes {
> > > > >         le64 sector;
> > > > >         le32 num_sectors;
> > > > >         le32 unmap;
> > > > > };
> > > > >
> > > > > Field 'sector' means the start sector for DISCARD and WRITE ZEROE=
S,
> > > > > filed 'num_sectors' means the number of sectors for DISCARD and W=
RITE
> > > > > ZEROES, if both DISCARD and WRITE ZEROES are supported, field 'un=
map'
> > > > > maybe used for WRITE ZEROES command with DISCARD enabled.
> > > > >
> > > > > We also extended the virtio-blk configuration space to let backend
> > > > > device put DISCARD and WRITE ZEROES configuration parameters.
> > > > >
> > > > > struct virtio_blk_config {
> > > > >         [...]
> > > > >
> > > > >         le32 max_discard_sectors;
> > > > >         le32 max_discard_seg;
> > > > >         le32 discard_sector_alignment;
> > > > >         le32 max_write_zeroes_sectors;
> > > > >         le32 max_write_zeroes_seg;
> > > > >         u8 write_zeroes_may_unmap;
> > > > > }
> > > > >
> > > > > New feature bit [VIRTIO_BLK_F_DISCARD (13)]: Device can support d=
iscard
> > > > > command, maximum discard sectors size in field 'max_discard_secto=
rs' and
> > > > > maximum discard segment number in field 'max_discard_seg'.
> > > > >
> > > > > New feature [VIRTIO_BLK_F_WRITE_ZEROES (14)]: Device can support =
write
> > > > > zeroes command, maximum write zeroes sectors size in field
> > > > > 'max_write_zeroes_sectors' and maximum write zeroes segment numbe=
r in
> > > > > field 'max_write_zeroes_seg'.
> > > > >
> > > > > The parameters in the configuration space of the device field
> > > > > 'max_discard_sectors' and field 'discard_sector_alignment' are ex=
pressed in
> > > > > 512-byte units if the VIRTIO_BLK_F_DISCARD feature bit is negotia=
ted. The
> > > > > field 'max_write_zeroes_sectors' is expressed in 512-byte units i=
f the
> > > > > VIRTIO_BLK_F_WRITE_ZEROES feature bit is negotiated.
> > > > >
> > > > > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > > > > ---
> > > > > CHANGELOG:
> > > > > v6: don't set T_OUT bit to discard and write zeroes commands.
> > > >
> > > > I don't see this in the patch...
> > > Yeah, do noting with DISCARD/WRITE ZEROES means no need to OR BLK_T_O=
UT
> > again.
> > > >
> > > > > @@ -225,6 +260,7 @@ static blk_status_t virtio_queue_rq(struct
> > > > blk_mq_hw_ctx *hctx,
> > > > >  	int qid =3D hctx->queue_num;
> > > > >  	int err;
> > > > >  	bool notify =3D false;
> > > > > +	bool unmap =3D false;
> > > > >  	u32 type;
> > > > >
> > > > >  	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> > > > > @@ -237,6 +273,13 @@ static blk_status_t virtio_queue_rq(struct
> > > > blk_mq_hw_ctx *hctx,
> > > > >  	case REQ_OP_FLUSH:
> > > > >  		type =3D VIRTIO_BLK_T_FLUSH;
> > > > >  		break;
> > > > > +	case REQ_OP_DISCARD:
> > > > > +		type =3D VIRTIO_BLK_T_DISCARD;
> > > > > +		break;
> > > > > +	case REQ_OP_WRITE_ZEROES:
> > > > > +		type =3D VIRTIO_BLK_T_WRITE_ZEROES;
> > > > > +		unmap =3D !(req->cmd_flags & REQ_NOUNMAP);
> > > > > +		break;
> > > > >  	case REQ_OP_SCSI_IN:
> > > > >  	case REQ_OP_SCSI_OUT:
> > > > >  		type =3D VIRTIO_BLK_T_SCSI_CMD;
> > > > > @@ -256,6 +299,12 @@ static blk_status_t virtio_queue_rq(struct
> > > > blk_mq_hw_ctx *hctx,
> > > > >
> > > > >  	blk_mq_start_request(req);
> > > > >
> > > > > +	if (type =3D=3D VIRTIO_BLK_T_DISCARD || type =3D=3D
> > > > VIRTIO_BLK_T_WRITE_ZEROES) {
> > > > > +		err =3D virtblk_setup_discard_write_zeroes(req, unmap);
> > > > > +		if (err)
> > > > > +			return BLK_STS_RESOURCE;
> > > > > +	}
> > > > > +
> > > > >  	num =3D blk_rq_map_sg(hctx->queue, req, vbr->sg);
> > > > >  	if (num) {
> > > > >  		if (rq_data_dir(req) =3D=3D WRITE)
> > > >
> > > > ...since we still do blk_rq_map_sg() here and num should be !=3D 0.
> > > No, while here, we should keep the original logic for READ/WRITE comm=
ands.
> >=20
> > My question is: why does the changelog say "don't set T_OUT" but the
> > code *will* set it because blk_rq_map_sg() returns !=3D 0 and
> > rq_data_dir(req) =3D=3D WRITE?
> Since the last bit of DISCARD/WRITE ZEROES commands are already 1, so I s=
aid we don't need to set
> T_OUT bit to DISCARD/WRITE ZEROES commands again. But the original logic =
for WRITE, T_OUT is still
> needed, so just keep the original code here is fine.

Okay, I understand what you meant now.  Thanks!

Stefan

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbH+9XAAoJEJykq7OBq3PI2esIAKu4cX3sVo0cYI/9ldufNcVI
7TpQEWC8bb/OQJjAxyWObMHyJTVijYCy+0eG7/Ytyv9mFuaKY5gYYJ4m2/SQIwaU
ySZujOlY2oVtGGxIAbQfSSxLhSUcFnIGuSZ4NJ5wLJ3z5kg6RtTAjEmHNZ3nxyQm
Nc80XQK89M/jCjWfwcusgTWcdnSg4B4cycziqeSqEnf/VkY+s2BVZ/fVljsbL/Fs
XQpHKua0XS4not3RMEE3K6/Z7JR3R78aRvQ1st1QH+/y+mmva61MX4KnuzdcaD2W
MzSSMJt/RAZSmP5voGNNwqFud0Xio6n/WO+eL6L67VDSDRXS1obLPs25PmNAGL4=
=TLmW
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

--===============1361588892852794699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1361588892852794699==--
