Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEE0C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Nov 2022 14:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E05D140BEE;
	Fri, 11 Nov 2022 14:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E05D140BEE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fLjskABi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y864I7lTQUNC; Fri, 11 Nov 2022 14:24:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 262F4400E2;
	Fri, 11 Nov 2022 14:24:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 262F4400E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1415C0032;
	Fri, 11 Nov 2022 14:24:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6609C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 14:24:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9F48400FE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 14:24:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9F48400FE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ow5VB0xTczND
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 14:24:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A99DB400E2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A99DB400E2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668176685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SVqfSgndoYn6nljwqxh8png49zcUWLTBZKtADclQsL8=;
 b=fLjskABiRk5wOVgPPZm051TwSzZlX6Xh2VgR+oqV9/oJ3QrEV80FmvZMZQO8pyWoWNt9ol
 W3NyyytvlslAMVcZf3vHfefF34U6/NIHeklB6+W0Ik9yinVZrM8jSw2psaPqbtUeh9d1q4
 nlrCGFYTVAFmijhv7ydkhTwrvP48STc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-TAa94boDOQyR2cugvJpcFg-1; Fri, 11 Nov 2022 09:24:36 -0500
X-MC-Unique: TAa94boDOQyR2cugvJpcFg-1
Received: by mail-wr1-f71.google.com with SMTP id
 i14-20020adfa50e000000b0023652707418so1058035wrb.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 06:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVqfSgndoYn6nljwqxh8png49zcUWLTBZKtADclQsL8=;
 b=DqzCNp0ewtnIlcQzuvK19KuT93NzVrVU/dHYOT/wUjLjfhBo9liWFzNK0x+1u8pQKF
 4TgjRzIHyR0Eo2LCfPI6niMFWzeJ+F4ED1giv5KqyQ32Gvy45M+JAmeO5LKO5ZzlI+EW
 qNDnhRJMGqWvFq9u4nNa0vezDpnwBkG6ywvuhF92hhmT76EnWJ6yJA2R5b9S3323FGXI
 jiFO0na/y0OSiTYurL69XFiW9ZEl+2xBH9GEwcRnVs0fY+TVmA2rnmEiL6E8uWVV5PRB
 RvXlnJYHRFo5+7XE8YmpV2LCniVQ9H8CS3jXyaIldmPHK2OfZNVLWqb4RlCOVPSjRYOk
 Tpgg==
X-Gm-Message-State: ANoB5plc+UWRFmnuVKHrQp+l6Cx6L9OL2TogiheNK736aB2mbjJDv/f+
 rRcYYe5lFYBg/E19JdSwqDSjBFeJxj2b9c3jsW7cmKdAtc5l2aM23yC8bMDMEEOb5OEpo2t7qIL
 wKc2FPDLhJQ1B5ybwFtGiFp6ChZl23pLlqZ2JPfSH5w==
X-Received: by 2002:a5d:4f0c:0:b0:236:aab2:4eb2 with SMTP id
 c12-20020a5d4f0c000000b00236aab24eb2mr1408008wru.412.1668176675121; 
 Fri, 11 Nov 2022 06:24:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6svbicBf24lQXqjCq0mmtzyqJQDYqm+BEZjXuI1ywgBidZbSKrY8OtSg1fcpa3NRbT/Xp6Dw==
X-Received: by 2002:a5d:4f0c:0:b0:236:aab2:4eb2 with SMTP id
 c12-20020a5d4f0c000000b00236aab24eb2mr1407994wru.412.1668176674780; 
 Fri, 11 Nov 2022 06:24:34 -0800 (PST)
Received: from redhat.com ([2.52.3.250]) by smtp.gmail.com with ESMTPSA id
 l13-20020a5d674d000000b0022e3538d305sm2322967wrw.117.2022.11.11.06.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Nov 2022 06:24:34 -0800 (PST)
Date: Fri, 11 Nov 2022 09:24:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221111091708-mutt-send-email-mst@kernel.org>
References: <20221108125354.898722-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20221108125354.898722-1-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Nov 08, 2022 at 02:53:53PM +0200, Alvaro Karsz wrote:
> Implement the VIRTIO_BLK_F_LIFETIME feature for VirtIO block devices.
> 
> This commit introduces a new ioctl command, VBLK_LIFETIME.
> 
> VBLK_LIFETIME ioctl asks for the block device to provide lifetime
> information by sending a VIRTIO_BLK_T_GET_LIFETIME command to the device.
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
> ---
>  drivers/block/virtio_blk.c      | 99 +++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_blk.h | 29 ++++++++++
>  2 files changed, 124 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 19da5defd73..fbe437c5159 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -101,6 +101,18 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
>  	}
>  }
>  
> +static inline int virtblk_ioctl_result(struct virtblk_req *vbr)
> +{
> +	switch (vbr->status) {
> +	case VIRTIO_BLK_S_OK:
> +		return 0;
> +	case VIRTIO_BLK_S_UNSUPP:
> +		return -ENOTTY;
> +	default:
> +		return -EIO;
> +	}
> +}
> +
>  static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct virtio_blk *vblk = hctx->queue->queuedata;
> @@ -244,8 +256,8 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  		type = VIRTIO_BLK_T_SECURE_ERASE;
>  		break;
>  	case REQ_OP_DRV_IN:
> -		type = VIRTIO_BLK_T_GET_ID;
> -		break;
> +		/* REQ_OP_DRV_IN operation out header already set */
> +		return 0;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return BLK_STS_IOERR;

hmm what does this have to do with lifetime?

> @@ -459,12 +471,16 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
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


Does this have something to do with lifetime?

> @@ -508,6 +524,80 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  	return ret;
>  }
>  
> +/* Get lifetime information from device */
> +static int virtblk_ioctl_lifetime(struct virtio_blk *vblk, unsigned long arg)
> +{
> +	struct request_queue *q = vblk->disk->queue;
> +	struct request *req = NULL;
> +	struct virtblk_req *vbr;
> +	struct virtio_blk_lifetime lifetime;
> +	int ret;
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
> +		return -ENOTTY;
> +
> +	memset((void *)&lifetime, 0, sizeof(lifetime));

You don't need the cast to void *.

> +
> +	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> +
> +	/* Write the correct type */
> +	vbr = blk_mq_rq_to_pdu(req);
> +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_LIFETIME);
> +
> +	ret = blk_rq_map_kern(q, req, (void *)&lifetime, sizeof(lifetime), GFP_KERNEL);

Neither here.

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
> +	if (copy_to_user((void __user *)arg, (void *)&lifetime,


Nor here.

> +			 sizeof(lifetime))) {
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
> +			     unsigned int cmd, unsigned long arg)
> +{
> +	struct virtio_blk *vblk = bd->bd_disk->private_data;
> +	int ret;
> +
> +	mutex_lock(&vblk->vdev_mutex);
> +
> +	switch (cmd) {
> +	case VBLK_LIFETIME:
> +		ret = virtblk_ioctl_lifetime(vblk, arg);
> +		break;
> +	default:
> +		ret = -ENOTTY;
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
>  	struct virtio_blk *vblk = disk->private_data;
> @@ -520,6 +610,7 @@ static void virtblk_free_disk(struct gendisk *disk)
>  static const struct block_device_operations virtblk_fops = {
>  	.owner  	= THIS_MODULE,
>  	.getgeo		= virtblk_getgeo,
> +	.ioctl		= virtblk_ioctl,
>  	.free_disk	= virtblk_free_disk,
>  };
>  
> @@ -1239,7 +1330,7 @@ static unsigned int features_legacy[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
>  }
>  ;
>  static unsigned int features[] = {
> @@ -1247,7 +1338,7 @@ static unsigned int features[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
>  };
>  
>  static struct virtio_driver virtio_blk = {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index 58e70b24b50..1190904d39c 100644
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
> @@ -206,6 +210,27 @@ struct virtio_blk_discard_write_zeroes {
>  	__le32 flags;
>  };
>  
> +/* Get lifetime information struct for each request */
> +struct virtio_blk_lifetime {
> +	/* specifies the percentage of reserved blocks that are consumed.
> +	 * optional values following virtio spec:
> +	 * 0 - undefined
> +	 * 1 - normal, < 80% of reserved blocks are consumed
> +	 * 2 - warning, 80% of reserved blocks are consumed
> +	 * 3 - urgent, 90% of reserved blocks are consumed
> +	 */
> +	__le16 pre_eol_info;
> +	/* this field refers to wear of SLC cells and is provided in increments of 10used,
> +	 * and so on, thru to 11 meaning estimated lifetime exceeded. All values above 11
> +	 * are reserved
> +	 */
> +	__le16 device_lifetime_est_typ_a;
> +	/* this field refers to wear of MLC cells and is provided with the same semantics as
> +	 * device_lifetime_est_typ_a
> +	 */


block comments have wrong format I think.

> +	__le16 device_lifetime_est_typ_b;
> +};
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  struct virtio_scsi_inhdr {
>  	__virtio32 errors;
> @@ -219,4 +244,8 @@ struct virtio_scsi_inhdr {
>  #define VIRTIO_BLK_S_OK		0
>  #define VIRTIO_BLK_S_IOERR	1
>  #define VIRTIO_BLK_S_UNSUPP	2
> +
> +/* Virtblk ioctl commands */
> +#define VBLK_LIFETIME	_IOR('r', 0, struct virtio_blk_lifetime)
> +
>  #endif /* _LINUX_VIRTIO_BLK_H */
> -- 
> 2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
