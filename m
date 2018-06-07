From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v6] virtio_blk: add DISCARD and WRIET ZEROES commands
	support
Date: Thu, 7 Jun 2018 14:10:03 +0100
Message-ID: <20180607131003.GN19032@stefanha-x1.localdomain>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5256345564569941600=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: pbonzini@redhat.com, cavery@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5256345564569941600==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NJSRbAqOy4NeGDns"
Content-Disposition: inline


--NJSRbAqOy4NeGDns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 12:19:00PM +0800, Changpeng Liu wrote:
> Existing virtio-blk protocol doesn't have DISCARD/WRITE ZEROES commands
> support, this will impact the performance when using SSD backend over
> file systems.
>=20
> Commit 88c85538 "virtio-blk: add discard and write zeroes features to
> specification"(see https://github.com/oasis-tcs/virtio-spec) extended
> existing virtio-blk protocol, adding extra DISCARD and WRITE ZEROES
> commands support.
>=20
> While here, using 16 bytes descriptor to describe one segment of DISCARD
> or WRITE ZEROES commands, each command may contain one or more decriptors.
>=20
> The following data structure shows the definition of one descriptor:
>=20
> struct virtio_blk_discard_write_zeroes {
>         le64 sector;
>         le32 num_sectors;
>         le32 unmap;
> };
>=20
> Field 'sector' means the start sector for DISCARD and WRITE ZEROES,
> filed 'num_sectors' means the number of sectors for DISCARD and WRITE
> ZEROES, if both DISCARD and WRITE ZEROES are supported, field 'unmap'
> maybe used for WRITE ZEROES command with DISCARD enabled.
>=20
> We also extended the virtio-blk configuration space to let backend
> device put DISCARD and WRITE ZEROES configuration parameters.
>=20
> struct virtio_blk_config {
>         [...]
>=20
>         le32 max_discard_sectors;
>         le32 max_discard_seg;
>         le32 discard_sector_alignment;
>         le32 max_write_zeroes_sectors;
>         le32 max_write_zeroes_seg;
>         u8 write_zeroes_may_unmap;
> }
>=20
> New feature bit [VIRTIO_BLK_F_DISCARD (13)]: Device can support discard
> command, maximum discard sectors size in field 'max_discard_sectors' and
> maximum discard segment number in field 'max_discard_seg'.
>=20
> New feature [VIRTIO_BLK_F_WRITE_ZEROES (14)]: Device can support write
> zeroes command, maximum write zeroes sectors size in field
> 'max_write_zeroes_sectors' and maximum write zeroes segment number in
> field 'max_write_zeroes_seg'.
>=20
> The parameters in the configuration space of the device field
> 'max_discard_sectors' and field 'discard_sector_alignment' are expressed =
in
> 512-byte units if the VIRTIO_BLK_F_DISCARD feature bit is negotiated. The
> field 'max_write_zeroes_sectors' is expressed in 512-byte units if the
> VIRTIO_BLK_F_WRITE_ZEROES feature bit is negotiated.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
> CHANGELOG:
> v6: don't set T_OUT bit to discard and write zeroes commands.

I don't see this in the patch...

> @@ -225,6 +260,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_=
ctx *hctx,
>  	int qid =3D hctx->queue_num;
>  	int err;
>  	bool notify =3D false;
> +	bool unmap =3D false;
>  	u32 type;
> =20
>  	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> @@ -237,6 +273,13 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw=
_ctx *hctx,
>  	case REQ_OP_FLUSH:
>  		type =3D VIRTIO_BLK_T_FLUSH;
>  		break;
> +	case REQ_OP_DISCARD:
> +		type =3D VIRTIO_BLK_T_DISCARD;
> +		break;
> +	case REQ_OP_WRITE_ZEROES:
> +		type =3D VIRTIO_BLK_T_WRITE_ZEROES;
> +		unmap =3D !(req->cmd_flags & REQ_NOUNMAP);
> +		break;
>  	case REQ_OP_SCSI_IN:
>  	case REQ_OP_SCSI_OUT:
>  		type =3D VIRTIO_BLK_T_SCSI_CMD;
> @@ -256,6 +299,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw=
_ctx *hctx,
> =20
>  	blk_mq_start_request(req);
> =20
> +	if (type =3D=3D VIRTIO_BLK_T_DISCARD || type =3D=3D VIRTIO_BLK_T_WRITE_=
ZEROES) {
> +		err =3D virtblk_setup_discard_write_zeroes(req, unmap);
> +		if (err)
> +			return BLK_STS_RESOURCE;
> +	}
> +
>  	num =3D blk_rq_map_sg(hctx->queue, req, vbr->sg);
>  	if (num) {
>  		if (rq_data_dir(req) =3D=3D WRITE)

=2E..since we still do blk_rq_map_sg() here and num should be !=3D 0.

--NJSRbAqOy4NeGDns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGS6rAAoJEJykq7OBq3PIjIwH/jiYKfZVAMfWqwKw40scuEwm
mofo6gZ4PVx8AdK63+HhqItoHgikPlTmBM81KLgd3y4sTSthNWMgDKLnymr2oBx6
/F2OODRwe7d5zwvoESn4jg/lMpRej45Ld5SpnuHAB8x/SG2O8k6mV8Q1CBncy9dr
jYs3cesn39O0dh+JnJYyot6WfQxH797+NvHGfT0IVPaYQH/IGXMOLD9yFmDpROIU
moA0gNrRX8tLcW1d/LzmFvLXWezrLG22XkveQ8V4Rn5+uCgd+Zd1MOljCpEKEfcX
UaYuyA/Jl+vLbQpTtUKDP+EO/9euoYAzNsHUpf3alrZ4LsIpN37M2petcXHWAWg=
=1lv5
-----END PGP SIGNATURE-----

--NJSRbAqOy4NeGDns--

--===============5256345564569941600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5256345564569941600==--
