Return-Path: <SRS0=XZyc=NX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB555C43214
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 14:50:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5339A61057
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 14:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5339A61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F66B8272C;
	Wed,  1 Sep 2021 14:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KoXreQarAU1X; Wed,  1 Sep 2021 14:50:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B839680BC0;
	Wed,  1 Sep 2021 14:50:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B1D6C0010;
	Wed,  1 Sep 2021 14:50:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF283C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 14:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D66EB40283
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 14:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cBQaREbHfO9G
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 14:50:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 372F040158
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630507839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KehK5Jbs4kdvorQdCoG9AAvx7Kx9GawvZqLACA7tl6w=;
 b=OkcTL/Jia3KrqI2GjR8Nchkb2/s8A/HXUGw8eURyc94S2tADArGckblBrGBCtlDbwIHOW2
 FN0LN5oabQqajoMI5sSPxCbYNxKcViG2w8u0+rBpZzdlVSF6y+B6mD9kiIsaPei2GVXQrT
 NVsfhiEBetpFHYiXU0Uu0pQDnlHuGts=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-5Ssrgv75OJORa1dGZagS0Q-1; Wed, 01 Sep 2021 10:50:38 -0400
X-MC-Unique: 5Ssrgv75OJORa1dGZagS0Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 z17-20020a05640240d100b003cac681f4f4so1390956edb.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Sep 2021 07:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KehK5Jbs4kdvorQdCoG9AAvx7Kx9GawvZqLACA7tl6w=;
 b=V9jbAnl6A/8qWDsiwHESfMnuf5raFVfD+53T5oGDBWiTygVCaEGqUBNE3U2CEYOF2U
 LP4VBqTbz1dKb37QW06yI+OnpYPAUftgK+oTp3lnBm19m9d11lsRuTwuXNOAFPAp+t8L
 aHwo8Xm2oevz5SNxK90VmmTP3OgK8n7SqfCbJy/UJWG50J5QuUCxsuQKrc7E5tN0hHTl
 XaeeTSJxqaomfCihsOdMsPG86OEqBE0UGjTCsjuiS7dMyypc1JaFR+cMudcPq9IAK1nC
 x61TjAERRc8Xf6DiB/1Ma+qIYUiqbIFMh/DBKjH/EzI2iOeHaKX7YNVfMeXXvFKBD//D
 yERg==
X-Gm-Message-State: AOAM533aucqsUw2mMlC3C3sq0+dw0+iPXJfQ84Akn1XV0WoJqiAzudMG
 Sy6q9bIeFTY0c4F6cTjYL/44DnvDuMFcUQ/fZ0OBBMFMfULUXr5kVvcoVlzFYZ4PsS3Im4l4moS
 5aDL5/1dccs7SUroeXUa3dI3rMiLz0M0KEHCcIz6i6g==
X-Received: by 2002:aa7:c857:: with SMTP id g23mr36031403edt.219.1630507836844; 
 Wed, 01 Sep 2021 07:50:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2XabI56x5N4e12tynXmUzwNYlCnkVvW+5e6SKLFqAQFwy9xHy9UkCtXbluxMdfmB+xkCIWw==
X-Received: by 2002:aa7:c857:: with SMTP id g23mr36031377edt.219.1630507836544; 
 Wed, 01 Sep 2021 07:50:36 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
 by smtp.gmail.com with ESMTPSA id i6sm114434ejd.57.2021.09.01.07.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Sep 2021 07:50:35 -0700 (PDT)
Date: Wed, 1 Sep 2021 10:50:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: avoid preallocating big SGL for data
Message-ID: <20210901102623-mutt-send-email-mst@kernel.org>
References: <20210901131434.31158-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210901131434.31158-1-mgurtovoy@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 israelr@nvidia.com, virtualization@lists.linux-foundation.org,
 hch@infradead.org, nitzanc@nvidia.com, stefanha@redhat.com, oren@nvidia.com
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

On Wed, Sep 01, 2021 at 04:14:34PM +0300, Max Gurtovoy wrote:
> No need to pre-allocate a big buffer for the IO SGL anymore. If a device
> has lots of deep queues, preallocation for the sg list can consume
> substantial amounts of memory. For HW virtio-blk device, nr_hw_queues
> can be 64 or 128 and each queue's depth might be 128. This means the
> resulting preallocation for the data SGLs is big.
> 
> Switch to runtime allocation for SGL for lists longer than 2 entries.
> This is the approach used by NVMe drivers so it should be reasonable for
> virtio block as well. Runtime SGL allocation has always been the case
> for the legacy I/O path so this is nothing new.
> 
> The preallocated small SGL depends on SG_CHAIN so if the ARCH doesn't
> support SG_CHAIN, use only runtime allocation for the SGL.
> 
> Re-organize the setup of the IO request to fit the new sg chain
> mechanism.
> 
> No performance degradation was seen (fio libaio engine with 16 jobs and
> 128 iodepth):
> 
> IO size      IOPs Rand Read (before/after)         IOPs Rand Write (before/after)
> --------     ---------------------------------    ----------------------------------
> 512B          318K/316K                                    329K/325K
> 
> 4KB           323K/321K                                    353K/349K
> 
> 16KB          199K/208K                                    250K/275K
> 
> 128KB         36K/36.1K                                    39.2K/41.7K
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>

Could you use something to give confidence intervals maybe?
As it is it looks like a 1-2% regression for 512B and 4KB.



> ---
> 
> changes from V2:
>  - initialize vbr->out_hdr.sector during virtblk_setup_cmd
> 
> changes from V1:
>  - Kconfig update (from Christoph)
>  - Re-order cmd setup (from Christoph)
>  - use flexible sg pointer in the cmd (from Christoph)
>  - added perf numbers to commit msg (from Feng Li)
> 
> ---
>  drivers/block/Kconfig      |   1 +
>  drivers/block/virtio_blk.c | 155 +++++++++++++++++++++++--------------
>  2 files changed, 100 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 63056cfd4b62..ca25a122b8ee 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -395,6 +395,7 @@ config XEN_BLKDEV_BACKEND
>  config VIRTIO_BLK
>  	tristate "Virtio block driver"
>  	depends on VIRTIO
> +	select SG_POOL
>  	help
>  	  This is the virtual block driver for virtio.  It can be used with
>            QEMU based VMMs (like KVM or Xen).  Say Y or M.
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 9332fc4e9b31..bdd6d415bd20 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -24,6 +24,12 @@
>  /* The maximum number of sg elements that fit into a virtqueue */
>  #define VIRTIO_BLK_MAX_SG_ELEMS 32768
>  
> +#ifdef CONFIG_ARCH_NO_SG_CHAIN
> +#define VIRTIO_BLK_INLINE_SG_CNT	0
> +#else
> +#define VIRTIO_BLK_INLINE_SG_CNT	2
> +#endif
> +
>  static int virtblk_queue_count_set(const char *val,
>  		const struct kernel_param *kp)
>  {
> @@ -93,6 +99,7 @@ struct virtio_blk {
>  struct virtblk_req {
>  	struct virtio_blk_outhdr out_hdr;
>  	u8 status;
> +	struct sg_table sg_table;
>  	struct scatterlist sg[];
>  };
>  
> @@ -178,15 +185,94 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
>  	return 0;
>  }
>  
> -static inline void virtblk_request_done(struct request *req)
> +static void virtblk_unmap_data(struct request *req, struct virtblk_req *vbr)
>  {
> -	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> +	if (blk_rq_nr_phys_segments(req))
> +		sg_free_table_chained(&vbr->sg_table,
> +				      VIRTIO_BLK_INLINE_SG_CNT);
> +}
> +
> +static int virtblk_map_data(struct blk_mq_hw_ctx *hctx, struct request *req,
> +		struct virtblk_req *vbr)
> +{
> +	int err;
> +
> +	if (!blk_rq_nr_phys_segments(req))
> +		return 0;
> +
> +	vbr->sg_table.sgl = vbr->sg;
> +	err = sg_alloc_table_chained(&vbr->sg_table,
> +				     blk_rq_nr_phys_segments(req),
> +				     vbr->sg_table.sgl,
> +				     VIRTIO_BLK_INLINE_SG_CNT);
> +	if (unlikely(err))
> +		return -ENOMEM;
>  
> +	return blk_rq_map_sg(hctx->queue, req, vbr->sg_table.sgl);
> +}
> +
> +static void virtblk_cleanup_cmd(struct request *req)
> +{
>  	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
>  		kfree(page_address(req->special_vec.bv_page) +
>  		      req->special_vec.bv_offset);
>  	}
> +}
> +
> +static int virtblk_setup_cmd(struct virtio_device *vdev, struct request *req,
> +		struct virtblk_req *vbr)
> +{
> +	bool unmap = false;
> +	u32 type;
> +
> +	vbr->out_hdr.sector = 0;
> +
> +	switch (req_op(req)) {
> +	case REQ_OP_READ:
> +		type = VIRTIO_BLK_T_IN;
> +		vbr->out_hdr.sector = cpu_to_virtio64(vdev,
> +						      blk_rq_pos(req));
> +		break;
> +	case REQ_OP_WRITE:
> +		type = VIRTIO_BLK_T_OUT;
> +		vbr->out_hdr.sector = cpu_to_virtio64(vdev,
> +						      blk_rq_pos(req));
> +		break;
> +	case REQ_OP_FLUSH:
> +		type = VIRTIO_BLK_T_FLUSH;
> +		break;
> +	case REQ_OP_DISCARD:
> +		type = VIRTIO_BLK_T_DISCARD;
> +		break;
> +	case REQ_OP_WRITE_ZEROES:
> +		type = VIRTIO_BLK_T_WRITE_ZEROES;
> +		unmap = !(req->cmd_flags & REQ_NOUNMAP);
> +		break;
> +	case REQ_OP_DRV_IN:
> +		type = VIRTIO_BLK_T_GET_ID;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return BLK_STS_IOERR;
> +	}
>  
> +	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
> +	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
> +
> +	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES) {
> +		if (virtblk_setup_discard_write_zeroes(req, unmap))
> +			return BLK_STS_RESOURCE;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline void virtblk_request_done(struct request *req)
> +{
> +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> +
> +	virtblk_unmap_data(req, vbr);
> +	virtblk_cleanup_cmd(req);
>  	blk_mq_end_request(req, virtblk_result(vbr));
>  }
>  
> @@ -244,57 +330,23 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	int qid = hctx->queue_num;
>  	int err;
>  	bool notify = false;
> -	bool unmap = false;
> -	u32 type;
>  
>  	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
>  
> -	switch (req_op(req)) {
> -	case REQ_OP_READ:
> -	case REQ_OP_WRITE:
> -		type = 0;
> -		break;
> -	case REQ_OP_FLUSH:
> -		type = VIRTIO_BLK_T_FLUSH;
> -		break;
> -	case REQ_OP_DISCARD:
> -		type = VIRTIO_BLK_T_DISCARD;
> -		break;
> -	case REQ_OP_WRITE_ZEROES:
> -		type = VIRTIO_BLK_T_WRITE_ZEROES;
> -		unmap = !(req->cmd_flags & REQ_NOUNMAP);
> -		break;
> -	case REQ_OP_DRV_IN:
> -		type = VIRTIO_BLK_T_GET_ID;
> -		break;
> -	default:
> -		WARN_ON_ONCE(1);
> -		return BLK_STS_IOERR;
> -	}
> -
> -	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, type);
> -	vbr->out_hdr.sector = type ?
> -		0 : cpu_to_virtio64(vblk->vdev, blk_rq_pos(req));
> -	vbr->out_hdr.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(req));
> +	err = virtblk_setup_cmd(vblk->vdev, req, vbr);
> +	if (unlikely(err))
> +		return err;
>  
>  	blk_mq_start_request(req);
>  
> -	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES) {
> -		err = virtblk_setup_discard_write_zeroes(req, unmap);
> -		if (err)
> -			return BLK_STS_RESOURCE;
> -	}
> -
> -	num = blk_rq_map_sg(hctx->queue, req, vbr->sg);
> -	if (num) {
> -		if (rq_data_dir(req) == WRITE)
> -			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_OUT);
> -		else
> -			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_IN);
> +	num = virtblk_map_data(hctx, req, vbr);
> +	if (unlikely(num < 0)) {
> +		virtblk_cleanup_cmd(req);
> +		return BLK_STS_RESOURCE;
>  	}
>  
>  	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> -	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
> +	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg_table.sgl, num);
>  	if (err) {
>  		virtqueue_kick(vblk->vqs[qid].vq);
>  		/* Don't stop the queue if -ENOMEM: we may have failed to
> @@ -303,6 +355,8 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		if (err == -ENOSPC)
>  			blk_mq_stop_hw_queue(hctx);
>  		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> +		virtblk_unmap_data(req, vbr);
> +		virtblk_cleanup_cmd(req);
>  		switch (err) {
>  		case -ENOSPC:
>  			return BLK_STS_DEV_RESOURCE;
> @@ -681,16 +735,6 @@ static const struct attribute_group *virtblk_attr_groups[] = {
>  	NULL,
>  };
>  
> -static int virtblk_init_request(struct blk_mq_tag_set *set, struct request *rq,
> -		unsigned int hctx_idx, unsigned int numa_node)
> -{
> -	struct virtio_blk *vblk = set->driver_data;
> -	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> -
> -	sg_init_table(vbr->sg, vblk->sg_elems);
> -	return 0;
> -}
> -
>  static int virtblk_map_queues(struct blk_mq_tag_set *set)
>  {
>  	struct virtio_blk *vblk = set->driver_data;
> @@ -703,7 +747,6 @@ static const struct blk_mq_ops virtio_mq_ops = {
>  	.queue_rq	= virtio_queue_rq,
>  	.commit_rqs	= virtio_commit_rqs,
>  	.complete	= virtblk_request_done,
> -	.init_request	= virtblk_init_request,
>  	.map_queues	= virtblk_map_queues,
>  };
>  
> @@ -783,7 +826,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
>  	vblk->tag_set.cmd_size =
>  		sizeof(struct virtblk_req) +
> -		sizeof(struct scatterlist) * sg_elems;
> +		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
>  	vblk->tag_set.driver_data = vblk;
>  	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
>  
> -- 
> 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
