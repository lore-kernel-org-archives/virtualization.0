Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289C4C43219
	for <virtualization@archiver.kernel.org>; Thu, 24 Nov 2022 20:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8783040134;
	Thu, 24 Nov 2022 20:35:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8783040134
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X8SB/UQl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6M3GIISACpTa; Thu, 24 Nov 2022 20:35:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8564B40017;
	Thu, 24 Nov 2022 20:35:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8564B40017
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 436FFC0033;
	Thu, 24 Nov 2022 20:35:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2EE2C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 20:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 884BD41BEB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 20:35:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 884BD41BEB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X8SB/UQl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mdmH4-CFhkiu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 20:35:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D842241BE3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D842241BE3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669322114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZVhYS1B+yLpa7OQyqEAfjkSNSik0jqoCIyiTz3jGKuU=;
 b=X8SB/UQlGMRcuatj4Yw5tB67zAcZQXJttAUsYRmH68K+FVXuHkK6tbGeE0JyXOUgJEu7L8
 K7xC6V77igEBVvmrsUr2RMPQl1/y2tRWkOipdFQB1U7BLJNyDypnQqfScu48WbzGFfghXJ
 HpPV0UZoOaB6wiCErxTibonfpZkWrqg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-c6WJzx4uN1WVl0EY7x3cvw-1; Thu, 24 Nov 2022 15:35:10 -0500
X-MC-Unique: c6WJzx4uN1WVl0EY7x3cvw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D84A29AB3EE;
 Thu, 24 Nov 2022 20:35:10 +0000 (UTC)
Received: from localhost (unknown [10.39.194.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81D31492B04;
 Thu, 24 Nov 2022 20:35:09 +0000 (UTC)
Date: Thu, 24 Nov 2022 15:35:05 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <Y3/VeeuG1GL5SRnJ@fedora>
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0022551724335099442=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0022551724335099442==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V0hkffa5bW0LQ3lU"
Content-Disposition: inline


--V0hkffa5bW0LQ3lU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 21, 2022 at 10:59:23AM +0200, Alvaro Karsz wrote:
> Implement the VIRTIO_BLK_F_LIFETIME feature for VirtIO block devices.
>=20
> This commit introduces a new ioctl command, VBLK_LIFETIME.

How about naming it VBLK_GET_LIFETIME? It's clearer what the ioctl does
and it follows the name of virtio-blk request type.

>=20
> VBLK_LIFETIME ioctl asks for the block device to provide lifetime
> information by sending a VIRTIO_BLK_T_GET_LIFETIME command to the device.
>=20
> lifetime information fields:
>=20
> - pre_eol_info: specifies the percentage of reserved blocks that are
> 		consumed.
> 		optional values following virtio spec:
> 		*) 0 - undefined.
> 		*) 1 - normal, < 80% of reserved blocks are consumed.
> 		*) 2 - warning, 80% of reserved blocks are consumed.
> 		*) 3 - urgent, 90% of reserved blocks are consumed.
>=20
> - device_lifetime_est_typ_a: this field refers to wear of SLC cells and
> 			     is provided in increments of 10used, and so
> 			     on, thru to 11 meaning estimated lifetime
> 			     exceeded. All values above 11 are reserved.
>=20
> - device_lifetime_est_typ_b: this field refers to wear of MLC cells and is
> 			     provided with the same semantics as
> 			     device_lifetime_est_typ_a.
>=20
> The data received from the device will be sent as is to the user.
> No data check/decode is done by virtblk.
>=20
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> --
> v2:
> 	- Remove (void *) casting.
> 	- Fix comments format in virtio_blk.h.
> 	- Set ioprio value for legacy devices for REQ_OP_DRV_IN
> 	  operations.
> --
> ---
>  drivers/block/virtio_blk.c      | 100 ++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_blk.h |  32 ++++++++++
>  2 files changed, 127 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 19da5defd73..9aa37677b65 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -101,6 +101,18 @@ static inline blk_status_t virtblk_result(struct vir=
tblk_req *vbr)
>  	}
>  }
> =20
> +static inline int virtblk_ioctl_result(struct virtblk_req *vbr)
> +{
> +	switch (vbr->status) {
> +	case VIRTIO_BLK_S_OK:
> +		return 0;
> +	case VIRTIO_BLK_S_UNSUPP:
> +		return -ENOTTY;

ENOTTY already has meaning for ioctl(2):

  ENOTTY fd is not associated with a character special device.

  ENOTTY The specified request does not apply to the kind of object that th=
e file descriptor fd references.

Use ENOTSUP instead?

> +	default:
> +		return -EIO;
> +	}
> +}
> +
>  static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_c=
tx *hctx)
>  {
>  	struct virtio_blk *vblk =3D hctx->queue->queuedata;
> @@ -218,6 +230,7 @@ static blk_status_t virtblk_setup_cmd(struct virtio_d=
evice *vdev,
>  	u32 type;
> =20
>  	vbr->out_hdr.sector =3D 0;
> +	vbr->out_hdr.ioprio =3D cpu_to_virtio32(vdev, req_get_ioprio(req));
> =20
>  	switch (req_op(req)) {
>  	case REQ_OP_READ:
> @@ -244,15 +257,14 @@ static blk_status_t virtblk_setup_cmd(struct virtio=
_device *vdev,
>  		type =3D VIRTIO_BLK_T_SECURE_ERASE;
>  		break;
>  	case REQ_OP_DRV_IN:
> -		type =3D VIRTIO_BLK_T_GET_ID;
> -		break;
> +		/* type is set in virtblk_get_id/virtblk_ioctl_lifetime */
> +		return 0;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return BLK_STS_IOERR;
>  	}
> =20
>  	vbr->out_hdr.type =3D cpu_to_virtio32(vdev, type);
> -	vbr->out_hdr.ioprio =3D cpu_to_virtio32(vdev, req_get_ioprio(req));
> =20
>  	if (type =3D=3D VIRTIO_BLK_T_DISCARD || type =3D=3D VIRTIO_BLK_T_WRITE_=
ZEROES ||
>  	    type =3D=3D VIRTIO_BLK_T_SECURE_ERASE) {
> @@ -459,12 +471,16 @@ static int virtblk_get_id(struct gendisk *disk, cha=
r *id_str)
>  	struct virtio_blk *vblk =3D disk->private_data;
>  	struct request_queue *q =3D vblk->disk->queue;
>  	struct request *req;
> +	struct virtblk_req *vbr;
>  	int err;
> =20
>  	req =3D blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
> =20
> +	vbr =3D blk_mq_rq_to_pdu(req);
> +	vbr->out_hdr.type =3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
> +
>  	err =3D blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL=
);
>  	if (err)
>  		goto out;
> @@ -508,6 +524,79 @@ static int virtblk_getgeo(struct block_device *bd, s=
truct hd_geometry *geo)
>  	return ret;
>  }
> =20
> +/* Get lifetime information from device */
> +static int virtblk_ioctl_lifetime(struct virtio_blk *vblk, unsigned long=
 arg)
> +{
> +	struct request_queue *q =3D vblk->disk->queue;
> +	struct request *req =3D NULL;
> +	struct virtblk_req *vbr;
> +	struct virtio_blk_lifetime lifetime;
> +	int ret;
> +
> +	/* The virtio_blk_lifetime struct fields follow virtio spec.
> +	 * There is no check/decode on values received from the device.
> +	 * The data is sent as is to the user.
> +	 */

In terms of security, any process with access to the block device node
is allowed to get the lifetime?

Usually only privileged processes have access to block device nodes, but
I wanted to check whether anyone can think of a scenario where this is
not okay.

For example, a virtio-blk device may have a partition that an untrusted
process like a database or key-value store accesses. Can the untrusted
process read the lifetime information of the entire device?

> +
> +	/* This ioctl is allowed only if VIRTIO_BLK_F_LIFETIME
> +	 * feature is negotiated.
> +	 */
> +	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
> +		return -ENOTTY;
> +
> +	memset(&lifetime, 0, sizeof(lifetime));
> +
> +	req =3D blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> +
> +	/* Write the correct type */
> +	vbr =3D blk_mq_rq_to_pdu(req);
> +	vbr->out_hdr.type =3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_LIFE=
TIME);
> +
> +	ret =3D blk_rq_map_kern(q, req, &lifetime, sizeof(lifetime), GFP_KERNEL=
);
> +	if (ret)
> +		goto out;
> +
> +	blk_execute_rq(req, false);
> +
> +	ret =3D virtblk_ioctl_result(blk_mq_rq_to_pdu(req));
> +	if (ret)
> +		goto out;
> +
> +	/* Pass the data to the user */
> +	if (copy_to_user((void __user *)arg, &lifetime, sizeof(lifetime))) {
> +		ret =3D -EFAULT;
> +		goto out;
> +	}

It's unusual for an ioctl to produce a struct that's not in CPU
endianness. I think the kernel should deal with endianness here.

> +
> +out:
> +	blk_mq_free_request(req);
> +	return ret;
> +}
> +
> +static int virtblk_ioctl(struct block_device *bd, fmode_t mode,
> +			     unsigned int cmd, unsigned long arg)
> +{
> +	struct virtio_blk *vblk =3D bd->bd_disk->private_data;
> +	int ret;
> +
> +	mutex_lock(&vblk->vdev_mutex);

We need to check that vblk->vdev is non-NULL before accessing it in
virtblk_ioctl_lifetime():

  if (!vblk->vdev) {
      mutex_unlock(&vblk->dev_mutex);
      return -ENXIO;
  }

Without the check I expect virtblk_ioctl_lifetime() to dereference a
NULL pointer.

> +
> +	switch (cmd) {
> +	case VBLK_LIFETIME:
> +		ret =3D virtblk_ioctl_lifetime(vblk, arg);
> +		break;
> +	default:
> +		ret =3D -ENOTTY;
> +		break;
> +	}
> +
> +	mutex_unlock(&vblk->vdev_mutex);
> +
> +	return ret;
> +}
> +
>  static void virtblk_free_disk(struct gendisk *disk)
>  {
>  	struct virtio_blk *vblk =3D disk->private_data;
> @@ -520,6 +609,7 @@ static void virtblk_free_disk(struct gendisk *disk)
>  static const struct block_device_operations virtblk_fops =3D {
>  	.owner  	=3D THIS_MODULE,
>  	.getgeo		=3D virtblk_getgeo,
> +	.ioctl		=3D virtblk_ioctl,
>  	.free_disk	=3D virtblk_free_disk,
>  };
> =20
> @@ -1239,7 +1329,7 @@ static unsigned int features_legacy[] =3D {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
>  }
>  ;
>  static unsigned int features[] =3D {
> @@ -1247,7 +1337,7 @@ static unsigned int features[] =3D {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
>  };
> =20
>  static struct virtio_driver virtio_blk =3D {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_=
blk.h
> index 58e70b24b50..c769930d269 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -40,6 +40,7 @@
>  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
>  #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
> +#define VIRTIO_BLK_F_LIFETIME	15 /* Storage lifetime information is supp=
orted */
>  #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
> =20
>  /* Legacy feature bits */
> @@ -165,6 +166,9 @@ struct virtio_blk_config {
>  /* Get device ID command */
>  #define VIRTIO_BLK_T_GET_ID    8
> =20
> +/* Get lifetime information command */
> +#define VIRTIO_BLK_T_GET_LIFETIME 10
> +
>  /* Discard command */
>  #define VIRTIO_BLK_T_DISCARD	11
> =20
> @@ -206,6 +210,30 @@ struct virtio_blk_discard_write_zeroes {
>  	__le32 flags;
>  };
> =20
> +/* Get lifetime information struct for each request */
> +struct virtio_blk_lifetime {
> +	/*
> +	 * specifies the percentage of reserved blocks that are consumed.
> +	 * optional values following virtio spec:
> +	 * 0 - undefined
> +	 * 1 - normal, < 80% of reserved blocks are consumed
> +	 * 2 - warning, 80% of reserved blocks are consumed
> +	 * 3 - urgent, 90% of reserved blocks are consumed
> +	 */
> +	__le16 pre_eol_info;
> +	/*
> +	 * this field refers to wear of SLC cells and is provided in increments=
 of 10used,
> +	 * and so on, thru to 11 meaning estimated lifetime exceeded. All value=
s above 11
> +	 * are reserved
> +	 */
> +	__le16 device_lifetime_est_typ_a;
> +	/*
> +	 * this field refers to wear of MLC cells and is provided with the same=
 semantics as
> +	 * device_lifetime_est_typ_a
> +	 */
> +	__le16 device_lifetime_est_typ_b;
> +};
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  struct virtio_scsi_inhdr {
>  	__virtio32 errors;
> @@ -219,4 +247,8 @@ struct virtio_scsi_inhdr {
>  #define VIRTIO_BLK_S_OK		0
>  #define VIRTIO_BLK_S_IOERR	1
>  #define VIRTIO_BLK_S_UNSUPP	2
> +
> +/* Virtblk ioctl commands */
> +#define VBLK_LIFETIME	_IOR('r', 0, struct virtio_blk_lifetime)
> +
>  #endif /* _LINUX_VIRTIO_BLK_H */
> --=20
> 2.32.0
>=20

--V0hkffa5bW0LQ3lU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmN/1XkACgkQnKSrs4Gr
c8jK5gf/RkeZK0IdX98KtQOVXgd5btlqMD2N6MRyTyPxaXFgCF57SMTnB0snmZwF
DbhNUgLfp4BaivwbhuLsLVC5zYgzWqwa70s92na51gQJFjbAdiTk4sVbmxYkXNEJ
boDu0dBzGa+MRQHLkmmdaHa0NiEM7IIPA23QQtAwGm9cDJrW9sLzxTFUtyjaSECm
oV9JPWLNYJjNEgdhj8fFUXEvTuoE+7HXoec0Z6G2e0ljnuwYSQi+UdzbBUA3VuPI
L45arldhy5Rdqy79LqC+QIy6ta6QgYN3lBfiLM2uAmWtIFQ30y/lUDavMaxslu5h
Cm5XGsFOPJEsj86ln5yqKAq64KrWcw==
=VfAO
-----END PGP SIGNATURE-----

--V0hkffa5bW0LQ3lU--


--===============0022551724335099442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0022551724335099442==--

