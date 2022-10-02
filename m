Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464E4C433FE
	for <virtualization@archiver.kernel.org>; Sun,  2 Oct 2022 15:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C17A74042B;
	Sun,  2 Oct 2022 15:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C17A74042B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i9jHqvap
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cd_MdHN0aNIa; Sun,  2 Oct 2022 15:51:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EEF2940184;
	Sun,  2 Oct 2022 15:51:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEF2940184
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE752C0032;
	Sun,  2 Oct 2022 15:51:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6346C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Oct 2022 15:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7E9140925
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Oct 2022 15:51:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7E9140925
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i9jHqvap
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01MSsQtAIJwa
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Oct 2022 15:51:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0998340913
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0998340913
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Oct 2022 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664725861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xc5wXjX6YMHDc48LC9ROPqe1Trpb5RnwdSq8IG2ryzA=;
 b=i9jHqvapLNdX5wqwDtmgMMlU0p2AvIFHTlta8E+PcM7Zg8gwA3RqzcC68OWU0N9IhpR3kY
 SpKkJLSFTKdISYUYP6cmGDJFQ6CqBtFwODvQ6fyebA3Vc7Sv2c4dUANcMGqPymok5mRvsV
 VJzrDoM2kOS5I1VXzY9g8gXCYhzP2EA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-333-XxMSKXqJMWGL6GB6veWZzw-1; Sun, 02 Oct 2022 11:51:00 -0400
X-MC-Unique: XxMSKXqJMWGL6GB6veWZzw-1
Received: by mail-wm1-f69.google.com with SMTP id
 h133-20020a1c218b000000b003b3263d477eso5064409wmh.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 02 Oct 2022 08:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=Xc5wXjX6YMHDc48LC9ROPqe1Trpb5RnwdSq8IG2ryzA=;
 b=pbF17Qsm5VnOXkFYU/xZTzyp9UOBilEyEPaM+vvNKXmWfvzOeDjT9eNeJIlv9zVPGS
 tRkfxFf7RsGu1ngK0hY9YsjmDCyfvfoEPCyR6rOX8fegDf9C5/8A00O8lYH9ALhWJp5a
 z0zaDnZK/eYzxSMtPgy3rpYL+uOMjEuTaWCys/I7a8KlTt0wJhzXwPZuPk6xShMp4TZS
 P5gvrf10guqrXNSkVEbYhctvFiUDHJT5GVu9HlfWVP5YERhbrgSWePi+NZKGU9Fm/AAG
 hntFwiXmQYfMXhZnv9VuhhyfQlifCx8xRQ4cwcpJRl1epiDlObhtrS4k+sl06MsOI+Sf
 mg5A==
X-Gm-Message-State: ACrzQf0OCeBLPgBTzRKILA03KK58z9SimrW7HaXtjbEdbLEikJdJlBBQ
 fhyYB4CtQX0GG2pv80SDNSeiRDQXTvgbYLI/f4vaRP6STeijkM7ZpQeylfJacnIUY4eZpMSAhut
 reuaJ2RqL2yhL4ZbhrjgTeEBE7NRLh6uA22qb7B9EnA==
X-Received: by 2002:a05:600c:687:b0:3b4:7280:9b7 with SMTP id
 a7-20020a05600c068700b003b4728009b7mr4564505wmn.189.1664725859397; 
 Sun, 02 Oct 2022 08:50:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5owdchnkA0uNmm8BwwM3bwcyoaJD5N/yRbSjAp9gh2lCqpGxctsSJvp4lYlpUzkCGRGJ7ebA==
X-Received: by 2002:a05:600c:687:b0:3b4:7280:9b7 with SMTP id
 a7-20020a05600c068700b003b4728009b7mr4564494wmn.189.1664725859172; 
 Sun, 02 Oct 2022 08:50:59 -0700 (PDT)
Received: from redhat.com ([2.55.17.78]) by smtp.gmail.com with ESMTPSA id
 e13-20020a5d530d000000b0022aeba020casm7588579wrv.83.2022.10.02.08.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Oct 2022 08:50:58 -0700 (PDT)
Date: Sun, 2 Oct 2022 11:50:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] virtio-blk: simplify probe function
Message-ID: <20221002115024-mutt-send-email-mst@kernel.org>
References: <20221002154417.34583-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20221002154417.34583-1-mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Sun, Oct 02, 2022 at 06:44:17PM +0300, Max Gurtovoy wrote:
> Divide the extremely long probe function to small meaningful functions.
> This makes the code more readably and easy to maintain.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

This is subjective ... pls CC some reviewers. If Stefan or Paolo
ack this I will merge.

> ---
>  drivers/block/virtio_blk.c | 227 +++++++++++++++++++++----------------
>  1 file changed, 131 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 30255fcaf181..bdd44069bf6f 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -882,28 +882,13 @@ static const struct blk_mq_ops virtio_mq_ops = {
>  static unsigned int virtblk_queue_depth;
>  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>  
> -static int virtblk_probe(struct virtio_device *vdev)
> +static int virtblk_q_limits_set(struct virtio_device *vdev,
> +		struct request_queue *q)
>  {
> -	struct virtio_blk *vblk;
> -	struct request_queue *q;
> -	int err, index;
> -
> -	u32 v, blk_size, max_size, sg_elems, opt_io_size;
> -	u16 min_io_size;
>  	u8 physical_block_exp, alignment_offset;
> -	unsigned int queue_depth;
> -
> -	if (!vdev->config->get) {
> -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> -			__func__);
> -		return -EINVAL;
> -	}
> -
> -	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
> -			     GFP_KERNEL);
> -	if (err < 0)
> -		goto out;
> -	index = err;
> +	u16 min_io_size;
> +	u32 v, blk_size, max_size, sg_elems, opt_io_size;
> +	int err;
>  
>  	/* We need to know how many segments before we allocate. */
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
> @@ -917,73 +902,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	/* Prevent integer overflows and honor max vq size */
>  	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>  
> -	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
> -	if (!vblk) {
> -		err = -ENOMEM;
> -		goto out_free_index;
> -	}
> -
> -	mutex_init(&vblk->vdev_mutex);
> -
> -	vblk->vdev = vdev;
> -
> -	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
> -
> -	err = init_vq(vblk);
> -	if (err)
> -		goto out_free_vblk;
> -
> -	/* Default queue sizing is to fill the ring. */
> -	if (!virtblk_queue_depth) {
> -		queue_depth = vblk->vqs[0].vq->num_free;
> -		/* ... but without indirect descs, we use 2 descs per req */
> -		if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
> -			queue_depth /= 2;
> -	} else {
> -		queue_depth = virtblk_queue_depth;
> -	}
> -
> -	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
> -	vblk->tag_set.ops = &virtio_mq_ops;
> -	vblk->tag_set.queue_depth = queue_depth;
> -	vblk->tag_set.numa_node = NUMA_NO_NODE;
> -	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> -	vblk->tag_set.cmd_size =
> -		sizeof(struct virtblk_req) +
> -		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
> -	vblk->tag_set.driver_data = vblk;
> -	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
> -	vblk->tag_set.nr_maps = 1;
> -	if (vblk->io_queues[HCTX_TYPE_POLL])
> -		vblk->tag_set.nr_maps = 3;
> -
> -	err = blk_mq_alloc_tag_set(&vblk->tag_set);
> -	if (err)
> -		goto out_free_vq;
> -
> -	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, vblk);
> -	if (IS_ERR(vblk->disk)) {
> -		err = PTR_ERR(vblk->disk);
> -		goto out_free_tags;
> -	}
> -	q = vblk->disk->queue;
> -
> -	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
> -
> -	vblk->disk->major = major;
> -	vblk->disk->first_minor = index_to_minor(index);
> -	vblk->disk->minors = 1 << PART_BITS;
> -	vblk->disk->private_data = vblk;
> -	vblk->disk->fops = &virtblk_fops;
> -	vblk->index = index;
> -
> -	/* configure queue flush support */
> -	virtblk_update_cache_mode(vdev);
> -
> -	/* If disk is read-only in the host, the guest should obey */
> -	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
> -		set_disk_ro(vblk->disk, 1);
> -
>  	/* We can handle whatever the host told us to handle. */
>  	blk_queue_max_segments(q, sg_elems);
>  
> @@ -1011,12 +929,13 @@ static int virtblk_probe(struct virtio_device *vdev)
>  			dev_err(&vdev->dev,
>  				"virtio_blk: invalid block size: 0x%x\n",
>  				blk_size);
> -			goto out_cleanup_disk;
> +			return err;
>  		}
>  
>  		blk_queue_logical_block_size(q, blk_size);
> -	} else
> +	} else {
>  		blk_size = queue_logical_block_size(q);
> +	}
>  
>  	/* Use topology information if available */
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
> @@ -1075,19 +994,136 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
>  	}
>  
> +	return 0;
> +}
> +
> +static void virtblk_tagset_put(struct virtio_blk *vblk)
> +{
> +	put_disk(vblk->disk);
> +	blk_mq_free_tag_set(&vblk->tag_set);
> +}
> +
> +static void virtblk_tagset_free(struct virtio_blk *vblk)
> +{
> +	del_gendisk(vblk->disk);
> +	blk_mq_free_tag_set(&vblk->tag_set);
> +}
> +
> +static int virtblk_tagset_alloc(struct virtio_blk *vblk,
> +		unsigned int queue_depth)
> +{
> +	int err;
> +
> +	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
> +	vblk->tag_set.ops = &virtio_mq_ops;
> +	vblk->tag_set.queue_depth = queue_depth;
> +	vblk->tag_set.numa_node = NUMA_NO_NODE;
> +	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> +	vblk->tag_set.cmd_size =
> +		sizeof(struct virtblk_req) +
> +		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
> +	vblk->tag_set.driver_data = vblk;
> +	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
> +	vblk->tag_set.nr_maps = 1;
> +	if (vblk->io_queues[HCTX_TYPE_POLL])
> +		vblk->tag_set.nr_maps = 3;
> +
> +	err = blk_mq_alloc_tag_set(&vblk->tag_set);
> +	if (err)
> +		return err;
> +
> +	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, vblk);
> +	if (IS_ERR(vblk->disk)) {
> +		err = PTR_ERR(vblk->disk);
> +		goto out_free_tags;
> +	}
> +
> +	return 0;
> +
> +out_free_tags:
> +	blk_mq_free_tag_set(&vblk->tag_set);
> +	return err;
> +}
> +
> +static int virtblk_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_blk *vblk;
> +	int err, index;
> +	unsigned int queue_depth;
> +
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
> +			     GFP_KERNEL);
> +	if (err < 0)
> +		goto out;
> +	index = err;
> +
> +	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
> +	if (!vblk) {
> +		err = -ENOMEM;
> +		goto out_free_index;
> +	}
> +
> +	mutex_init(&vblk->vdev_mutex);
> +
> +	vblk->vdev = vdev;
> +
> +	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
> +
> +	err = init_vq(vblk);
> +	if (err)
> +		goto out_free_vblk;
> +
> +	/* Default queue sizing is to fill the ring. */
> +	if (!virtblk_queue_depth) {
> +		queue_depth = vblk->vqs[0].vq->num_free;
> +		/* ... but without indirect descs, we use 2 descs per req */
> +		if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
> +			queue_depth /= 2;
> +	} else {
> +		queue_depth = virtblk_queue_depth;
> +	}
> +
> +	err = virtblk_tagset_alloc(vblk, queue_depth);
> +	if (err)
> +		goto out_free_vq;
> +
> +	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
> +
> +	vblk->disk->major = major;
> +	vblk->disk->first_minor = index_to_minor(index);
> +	vblk->disk->minors = 1 << PART_BITS;
> +	vblk->disk->private_data = vblk;
> +	vblk->disk->fops = &virtblk_fops;
> +	vblk->index = index;
> +
> +	/* configure queue flush support */
> +	virtblk_update_cache_mode(vdev);
> +
> +	/* If disk is read-only in the host, the guest should obey */
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
> +		set_disk_ro(vblk->disk, 1);
> +
> +	err = virtblk_q_limits_set(vdev, vblk->disk->queue);
> +	if (err)
> +		goto out_tagset_put;
> +
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
>  	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>  	if (err)
> -		goto out_cleanup_disk;
> +		goto out_tagset_put;
>  
>  	return 0;
>  
> -out_cleanup_disk:
> -	put_disk(vblk->disk);
> -out_free_tags:
> -	blk_mq_free_tag_set(&vblk->tag_set);
> +out_tagset_put:
> +	virtblk_tagset_put(vblk);
>  out_free_vq:
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);
> @@ -1106,8 +1142,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
>  
> -	del_gendisk(vblk->disk);
> -	blk_mq_free_tag_set(&vblk->tag_set);
> +	virtblk_tagset_free(vblk);
>  
>  	mutex_lock(&vblk->vdev_mutex);
>  
> -- 
> 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
