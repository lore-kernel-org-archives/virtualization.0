Return-Path: <SRS0=XZyc=NX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5297C432BE
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 06:20:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7789560F23
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 06:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7789560F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30712401D8;
	Wed,  1 Sep 2021 06:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kyMlMOcD7G6; Wed,  1 Sep 2021 06:19:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8EA940003;
	Wed,  1 Sep 2021 06:19:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B89AC0010;
	Wed,  1 Sep 2021 06:19:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CF0DC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C75C4041E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Y7VgNlTob0r
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:19:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C3764041A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+olqZsf6bAX4osBZPKKIMT0l5hnOLxO3gzA9/z2x/Po=; b=dWxkNESFLdcE17ZkOOKTM/QcPX
 ET8iXU812Iuu9GGevlXcf6H8zI6o3A93cv/JjixVshao+iBbgaG1mTbj58jEb3LsqC2yKywqm/J9X
 Uo6BKxmvgTqq/tWPPimeZN0bZycd+6L5ZSw24HLIVUte7cg1wl0SFdz6uFs4p605JZsP/iPdBDF6b
 gtHseKQnIrXSv+++0NnBbfFLmcnILE6lDW+W1tOxMesbZQ0ouviPBIVXrFN5ivSIdEjrcoTSQqAn1
 PlFDP3f+XTWNBW7FNa/U4KaY/knxrf3Yhzngyx0YuFMViUQ6lXWXDXNZmU1eempVTSi8noHj9NMy7
 t7+FK/cQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mLJaJ-001whS-0n; Wed, 01 Sep 2021 06:19:00 +0000
Date: Wed, 1 Sep 2021 07:18:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] virtio-blk: avoid preallocating big SGL for data
Message-ID: <YS8bT23rdMfT/+AF@infradead.org>
References: <20210830233500.51395-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210830233500.51395-1-mgurtovoy@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 mst@redhat.com, israelr@nvidia.com, virtualization@lists.linux-foundation.org,
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

On Tue, Aug 31, 2021 at 02:35:00AM +0300, Max Gurtovoy wrote:
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
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 77e8468e8593..9a4c5d428b58 100644
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
> @@ -99,7 +105,7 @@ struct virtio_blk {
>  struct virtblk_req {
>  	struct virtio_blk_outhdr out_hdr;
>  	u8 status;
> -	struct scatterlist sg[];
> +	struct sg_table sg_table;

Please keep the sg flexible array member here instead of the pointer
arithmetics that is added instead below.

> +	err = sg_alloc_table_chained(&vbr->sg_table,
> +				     blk_rq_nr_phys_segments(req),
> +				     vbr->sg_table.sgl,
> +				     VIRTIO_BLK_INLINE_SG_CNT);
> +	if (err)
> +		return BLK_STS_RESOURCE;
> +

This will BUG() for requests without segments (fush and discard).  You
probably want a separate helper to actually map data in the, extending
the big switch on the op.  While we're at it, the blk_mq_start_request
should also move as close as possible to the actual sending of the
request to the host.

You'll also need to select SG_POOL now that you're using these
functions.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
