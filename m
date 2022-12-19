Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EFDC4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 10:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA6DA60B36;
	Mon, 19 Dec 2022 10:35:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA6DA60B36
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V4bAvjhW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0QJCrW5F_UA; Mon, 19 Dec 2022 10:35:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E0F2860B3D;
	Mon, 19 Dec 2022 10:35:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0F2860B3D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D78CC0032;
	Mon, 19 Dec 2022 10:35:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB316C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD8E64014A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:34:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD8E64014A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V4bAvjhW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1axfECCD9AsU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:34:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CB41400F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CB41400F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671446092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MExHpuuhQYCTJXGp5HCPC8JoK68/o4CTdhPI1nGGBCc=;
 b=V4bAvjhWlRbDjCH2TkC2oRixV55mUPsqyarXnBOGf+7Q+LfwgKhJWs6tISr7ma5tmODy5j
 7F5zWIsydmGWmDOl4BAP66sWwrG/kc3wjb69UIQfTT0U8JXge67ueWyW64y7Ku9ClBQH4+
 rhpYpEov3hiEx53njf0/LihkxgXieJo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-511-PqQDnpNpOga-SitUUGFy4A-1; Mon, 19 Dec 2022 05:34:51 -0500
X-MC-Unique: PqQDnpNpOga-SitUUGFy4A-1
Received: by mail-qv1-f72.google.com with SMTP id
 ob12-20020a0562142f8c00b004c6c72bf1d0so5346652qvb.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 02:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MExHpuuhQYCTJXGp5HCPC8JoK68/o4CTdhPI1nGGBCc=;
 b=kdFpyYwcbMGWqdVeqc0+kHLQ8cWyPBYVA4+WCz1zCjyHxdNSIGhX5I/jGpJjaHIUqk
 gNlVk/HbFiQ8fUHWAemtKB4FMynf+BfSkR575DnpBX9peNvgf/WYj0hh6zpo5RQW1/d6
 cRrpEkGwn9IrmxO1bE3+gmfKsVTMVUSEZXa4u+WPTOLBn2ZRKWF+LdNXlTqBDDGNURnJ
 cFA+ii3y2wpvgb/5aNqKj6MNnZ4Dv/Nl72PaCHj79vvaUZKf8lMH/wf5NVlMIbCnNv8O
 dQHd7c7EU/GAOhAHhxFHNaYcKEiVVsEcWlds1yKask+9rSsB8DauXFb+NdTpEFPc2R74
 ZsXQ==
X-Gm-Message-State: AFqh2koiQh7Q9/ih3u2z1LgW6kzA2IHp48CmiWQUOL3nRHjesFmZmtoR
 3VOSi0zeR4eWJGwlXPR7CbpmEVOjCn7a44+p1QjFe9ftsWgVgbPtwCc+EiTM7I/e0Vp6VXjCFZL
 r0WNOAIwqFuB+U3j3RppiuwHGBu8yCNqaZnzEfUgplA==
X-Received: by 2002:ac8:480a:0:b0:3a5:2704:d4c0 with SMTP id
 g10-20020ac8480a000000b003a52704d4c0mr12875347qtq.31.1671446091166; 
 Mon, 19 Dec 2022 02:34:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuU8Q0zFAvQQlpZtICL6HHlUyfxsvufzIKmgMnE08JzncxHu9djN+1BfC7kA6OtQWVeQzoTGA==
X-Received: by 2002:ac8:480a:0:b0:3a5:2704:d4c0 with SMTP id
 g10-20020ac8480a000000b003a52704d4c0mr12875314qtq.31.1671446090795; 
 Mon, 19 Dec 2022 02:34:50 -0800 (PST)
Received: from redhat.com ([45.144.113.29]) by smtp.gmail.com with ESMTPSA id
 bj30-20020a05620a191e00b006cbe3be300esm6823870qkb.12.2022.12.19.02.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 02:34:50 -0800 (PST)
Date: Mon, 19 Dec 2022 05:34:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v4] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221219053022-mutt-send-email-mst@kernel.org>
References: <20221219101307.131279-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20221219101307.131279-1-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Dec 19, 2022 at 12:13:06PM +0200, Alvaro Karsz wrote:
> Implement the VIRTIO_BLK_F_LIFETIME feature for Virtio block devices.
> 
> This commit introduces a new ioctl command, VIRTIO_BLK_IOCTL_GET_LIFETIME.
> 
> VIRTIO_BLK_IOCTL_GET_LIFETIME ioctl asks for the block device to provide
> lifetime information by sending a VIRTIO_BLK_T_GET_LIFETIME command to
> the device.
> 
> lifetime information fields:
> 
> - pre_eol_info: specifies the percentage of reserved blocks that are
> 		consumed.
> 		optional values following virtio spec:
> 		*) 0 - undefined.
> 		*) 1 - normal, < 80% of reserved blocks are consumed.
> 		*) 2 - warning, 80% of reserved blocks are consumed.
> 		*) 3 - urgent, 90% of reserved blocks are consumed.
> 
> - device_lifetime_est_typ_a: this field refers to wear of SLC cells and
> 			     is provided in increments of 10used, and so
> 			     on, thru to 11 meaning estimated lifetime
> 			     exceeded. All values above 11 are reserved.
> 
> - device_lifetime_est_typ_b: this field refers to wear of MLC cells and is
> 			     provided with the same semantics as
> 			     device_lifetime_est_typ_a.
> 
> The data received from the device will be sent as is to the user.
> No data check/decode is done by virtblk.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Since you repin it anyway, do you mind rebasing on top of my tree?


> --
> v2:
> 	- Remove (void *) casting.
> 	- Fix comments format in virtio_blk.h.
> 	- Set ioprio value for legacy devices for REQ_OP_DRV_IN
> 	  operations.
> 
> v3:
> 	- Initialize struct virtio_blk_lifetime to 0 instead of memset.
> 	- Rename ioctl from VBLK_LIFETIME to VBLK_GET_LIFETIME.
> 	- Return EOPNOTSUPP insted of ENOTTY if ioctl is not supported.
> 	- Check if process is CAP_SYS_ADMIN capable in lifetime ioctl.
> 	- Check if vdev is not NULL before accessing it in lifetime ioctl.
> 
> v4:
> 	- Create a dedicated virtio_blk_ioctl.h header for the ioctl command
> 	  and add this file to MAINTAINERS.
> 	- Rename the ioctl to VIRTIO_BLK_IOCTL_GET_LIFETIME.
> 	- Document in virtio_blk_ioctl.h which backend device can supply
> 	  this lifetime information.
> --
> ---
>  MAINTAINERS                           |   1 +
>  drivers/block/virtio_blk.c            | 107 ++++++++++++++++++++++++--
>  include/uapi/linux/virtio_blk.h       |  28 +++++++
>  include/uapi/linux/virtio_blk_ioctl.h |  44 +++++++++++
>  4 files changed, 175 insertions(+), 5 deletions(-)
>  create mode 100644 include/uapi/linux/virtio_blk_ioctl.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f4d9dcb760..0368a903483 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21917,6 +21917,7 @@ F:	drivers/block/virtio_blk.c
>  F:	drivers/scsi/virtio_scsi.c
>  F:	drivers/vhost/scsi.c
>  F:	include/uapi/linux/virtio_blk.h
> +F:	include/uapi/linux/virtio_blk_ioctl.h
>  F:	include/uapi/linux/virtio_scsi.h
>  
>  VIRTIO CONSOLE DRIVER
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 68bd2f7961b..a0431d3ad07 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -9,6 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_blk.h>
> +#include <linux/virtio_blk_ioctl.h>
>  #include <linux/scatterlist.h>
>  #include <linux/string_helpers.h>
>  #include <linux/idr.h>
> @@ -101,6 +102,18 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
>  	}
>  }
>  
> +static inline int virtblk_ioctl_result(struct virtblk_req *vbr)
> +{
> +	switch (vbr->status) {
> +	case VIRTIO_BLK_S_OK:
> +		return 0;
> +	case VIRTIO_BLK_S_UNSUPP:
> +		return -EOPNOTSUPP;
> +	default:
> +		return -EIO;
> +	}
> +}
> +
>  static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct virtio_blk *vblk = hctx->queue->queuedata;
> @@ -218,6 +231,7 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  	u32 type;
>  
>  	vbr->out_hdr.sector = 0;
> +	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
>  
>  	switch (req_op(req)) {
>  	case REQ_OP_READ:
> @@ -244,15 +258,14 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  		type = VIRTIO_BLK_T_SECURE_ERASE;
>  		break;
>  	case REQ_OP_DRV_IN:
> -		type = VIRTIO_BLK_T_GET_ID;
> -		break;
> +		/* type is set in virtblk_get_id/virtblk_ioctl_lifetime */
> +		return 0;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return BLK_STS_IOERR;
>  	}
>  
>  	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
> -	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
>  
>  	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES ||
>  	    type == VIRTIO_BLK_T_SECURE_ERASE) {
> @@ -459,12 +472,16 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
>  	struct virtio_blk *vblk = disk->private_data;
>  	struct request_queue *q = vblk->disk->queue;
>  	struct request *req;
> +	struct virtblk_req *vbr;
>  	int err;
>  
>  	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> +	vbr = blk_mq_rq_to_pdu(req);
> +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
> +
>  	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
>  	if (err)
>  		goto out;
> @@ -508,6 +525,85 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  	return ret;
>  }
>  
> +/* Get lifetime information from device */
> +static int virtblk_ioctl_lifetime(struct virtio_blk *vblk, unsigned long arg)
> +{
> +	struct request_queue *q = vblk->disk->queue;
> +	struct request *req = NULL;
> +	struct virtblk_req *vbr;
> +	struct virtio_blk_lifetime lifetime = {};
> +	int ret;
> +

I would maybe add a comment

/*
 It's not clear whether exposing lifetime info to userspace
 has any security implications but out of abundance of caution
 we limit it to privileged users.
*/
  
> process like a database or key-value store accesses. Can the untrusted
> process read the lifetime information of the entire device?


> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;



> +
> +	/* The virtio_blk_lifetime struct fields follow virtio spec.
> +	 * There is no check/decode on values received from the device.
> +	 * The data is sent as is to the user.
> +	 */
> +
> +	/* This ioctl is allowed only if VIRTIO_BLK_F_LIFETIME
> +	 * feature is negotiated.
> +	 */
> +	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
> +		return -EOPNOTSUPP;
> +
> +	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> +
> +	/* Write the correct type */
> +	vbr = blk_mq_rq_to_pdu(req);
> +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_LIFETIME);
> +
> +	ret = blk_rq_map_kern(q, req, &lifetime, sizeof(lifetime), GFP_KERNEL);
> +	if (ret)
> +		goto out;
> +
> +	blk_execute_rq(req, false);
> +
> +	ret = virtblk_ioctl_result(blk_mq_rq_to_pdu(req));
> +	if (ret)
> +		goto out;
> +
> +	/* Pass the data to the user */
> +	if (copy_to_user((void __user *)arg, &lifetime, sizeof(lifetime))) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +out:
> +	blk_mq_free_request(req);
> +	return ret;
> +}
> +
> +static int virtblk_ioctl(struct block_device *bd, fmode_t mode,
> +			 unsigned int cmd, unsigned long arg)
> +{
> +	struct virtio_blk *vblk = bd->bd_disk->private_data;
> +	int ret;
> +
> +	mutex_lock(&vblk->vdev_mutex);
> +
> +	if (!vblk->vdev) {
> +		ret = -ENXIO;
> +		goto exit;
> +	}
> +
> +	switch (cmd) {
> +	case VIRTIO_BLK_IOCTL_GET_LIFETIME:
> +		ret = virtblk_ioctl_lifetime(vblk, arg);
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +exit:
> +	mutex_unlock(&vblk->vdev_mutex);
> +	return ret;
> +}
> +
>  static void virtblk_free_disk(struct gendisk *disk)
>  {
>  	struct virtio_blk *vblk = disk->private_data;
> @@ -520,6 +616,7 @@ static void virtblk_free_disk(struct gendisk *disk)
>  static const struct block_device_operations virtblk_fops = {
>  	.owner  	= THIS_MODULE,
>  	.getgeo		= virtblk_getgeo,
> +	.ioctl		= virtblk_ioctl,
>  	.free_disk	= virtblk_free_disk,
>  };
>  
> @@ -1239,7 +1336,7 @@ static unsigned int features_legacy[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
>  }
>  ;
>  static unsigned int features[] = {
> @@ -1247,7 +1344,7 @@ static unsigned int features[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
>  };
>  
>  static struct virtio_driver virtio_blk = {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index 58e70b24b50..b1360eab36a 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -40,6 +40,7 @@
>  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
>  #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
> +#define VIRTIO_BLK_F_LIFETIME	15 /* Storage lifetime information is supported */
>  #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
>  
>  /* Legacy feature bits */
> @@ -165,6 +166,9 @@ struct virtio_blk_config {
>  /* Get device ID command */
>  #define VIRTIO_BLK_T_GET_ID    8
>  
> +/* Get lifetime information command */
> +#define VIRTIO_BLK_T_GET_LIFETIME 10
> +
>  /* Discard command */
>  #define VIRTIO_BLK_T_DISCARD	11
>  
> @@ -206,6 +210,30 @@ struct virtio_blk_discard_write_zeroes {
>  	__le32 flags;
>  };
>  
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
> +	 * this field refers to wear of SLC cells and is provided in increments of 10used,
> +	 * and so on, thru to 11 meaning estimated lifetime exceeded. All values above 11
> +	 * are reserved
> +	 */
> +	__le16 device_lifetime_est_typ_a;
> +	/*
> +	 * this field refers to wear of MLC cells and is provided with the same semantics as
> +	 * device_lifetime_est_typ_a
> +	 */
> +	__le16 device_lifetime_est_typ_b;
> +};
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  struct virtio_scsi_inhdr {
>  	__virtio32 errors;
> diff --git a/include/uapi/linux/virtio_blk_ioctl.h b/include/uapi/linux/virtio_blk_ioctl.h
> new file mode 100644
> index 00000000000..f87afb6be00
> --- /dev/null
> +++ b/include/uapi/linux/virtio_blk_ioctl.h
> @@ -0,0 +1,44 @@
> +#ifndef _LINUX_VIRTIO_BLK_IOCTL_H
> +#define _LINUX_VIRTIO_BLK_IOCTL_H
> +/* This header is BSD licensed so anyone can use the definitions to implement
> + * compatible drivers/servers.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the name of IBM nor the names of its contributors
> + *    may be used to endorse or promote products derived from this software
> + *    without specific prior written permission.
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + */
> +
> +#include <linux/ioctl.h>
> +#include <linux/virtio_blk.h>
> +
> +/*
> + * The virtio_blk_lifetime fields can be reported by eMMC and UFS storage devices,
> + * which can predict and measure wear over time.
> + * eMMC/UFS storage devices are common in embedded systems, making this ioctl beneficial mostly
> + * for embedded systems using these type of storage as virtio-blk backend.
> + *
> + * Please note that virtio_blk_lifetime fields are little endian as defined in the virtio spec.
> + * Caller must convert the fields to the cpu endianness.
> + */
> +#define VIRTIO_BLK_IOCTL_GET_LIFETIME   _IOR('r', 0, struct virtio_blk_lifetime)
> +
> +#endif /* _LINUX_VIRTIO_BLK_IOCTL_H */
> -- 
> 2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
