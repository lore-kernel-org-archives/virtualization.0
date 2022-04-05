Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF2CC433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 08:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2617740861;
	Tue,  5 Apr 2022 08:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PTUnYfQfkWMN; Tue,  5 Apr 2022 08:57:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D24640928;
	Tue,  5 Apr 2022 08:57:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F078C001D;
	Tue,  5 Apr 2022 08:57:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73BA6C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 08:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B74F40928
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 08:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aQvcHAu3kOtw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 08:57:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54B8940861
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 08:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SWMNvfgC2cDhGmodQfW4rBVIZG0zkZ03Nrm5DRcv/5s=; b=2FMxWjEJREvdf3jbNunFlAQT+x
 9Bns4A8eQj3fAR4N74ofg3yIE4WpIQHLAL9p6XEJMk6poCM7XaYLSLDFjRDxO4Tk7HdMuiR92tCCV
 DzGjfPkOmZpYWeHAYa+1FKpLIvzzKJtGfBQThnfORkYyJ6lzwskz9PBoEibDs2A9gWSgESiSMM676
 t9FCOg4D13kwIUhvv2feqJw1sBAZG8Z1ExOP8LRR79ouexT9+/6yNOUz30Uyk0Qx1dVN9cuOpKHdy
 NCAidagNZlqSBWRTB7ohvSc9o+BKfvymcxtp+W/SKK7/cPSfBWmkm+X+xA37XXMUJPU3aEvTaaAsT
 rB1L1TiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nbezq-000GMm-HQ; Tue, 05 Apr 2022 08:57:06 +0000
Date: Tue, 5 Apr 2022 01:57:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH v4 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <YkwEYoeVSemLhivF@infradead.org>
References: <20220405053122.77626-1-suwan.kim027@gmail.com>
 <20220405053122.77626-3-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220405053122.77626-3-suwan.kim027@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: mgurtovoy@nvidia.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

On Tue, Apr 05, 2022 at 02:31:22PM +0900, Suwan Kim wrote:
> This patch supports mq_ops->queue_rqs() hook. It has an advantage of
> batch submission to virtio-blk driver. It also helps polling I/O because
> polling uses batched completion of block layer. Batch submission in
> queue_rqs() can boost polling performance.
> 
> In queue_rqs(), it iterates plug->mq_list, collects requests that
> belong to same HW queue until it encounters a request from other
> HW queue or sees the end of the list.
> Then, virtio-blk adds requests into virtqueue and kicks virtqueue
> to submit requests.
> 
> If there is an error, it inserts error request to requeue_list and
> passes it to ordinary block layer path.
> 
> For verification, I did fio test.
> (io_uring, randread, direct=1, bs=4K, iodepth=64 numjobs=N)
> I set 4 vcpu and 2 virtio-blk queues for VM and run fio test 5 times.
> It shows about 2% improvement.
> 
>                                  |   numjobs=2   |   numjobs=4
>       -----------------------------------------------------------
>         fio without queue_rqs()  |   291K IOPS   |   238K IOPS
>       -----------------------------------------------------------
>         fio with queue_rqs()     |   295K IOPS   |   243K IOPS
> 
> For polling I/O performance, I also did fio test as below.
> (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=4)
> I set 4 vcpu and 2 poll queues for VM.
> It shows about 2% improvement in polling I/O.
> 
>                                       |   IOPS   |  avg latency
>       -----------------------------------------------------------
>         fio poll without queue_rqs()  |   424K   |   613.05 usec
>       -----------------------------------------------------------
>         fio poll with queue_rqs()     |   435K   |   601.01 usec
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 110 +++++++++++++++++++++++++++++++++----
>  1 file changed, 99 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 712579dcd3cc..a091034bc551 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -92,6 +92,7 @@ struct virtio_blk {
>  struct virtblk_req {
>  	struct virtio_blk_outhdr out_hdr;
>  	u8 status;
> +	int sg_num;
>  	struct sg_table sg_table;
>  	struct scatterlist sg[];
>  };
> @@ -311,18 +312,13 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>  		virtqueue_notify(vq->vq);
>  }
>  
> -static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> -			   const struct blk_mq_queue_data *bd)
> +static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
> +					struct virtio_blk *vblk,
> +					struct request *req,
> +					struct virtblk_req *vbr)
>  {
> -	struct virtio_blk *vblk = hctx->queue->queuedata;
> -	struct request *req = bd->rq;
> -	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> -	unsigned long flags;
> -	int num;
> -	int qid = hctx->queue_num;
> -	bool notify = false;
>  	blk_status_t status;
> -	int err;
> +	int num;
>  
>  	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
>  	if (unlikely(status))
> @@ -335,9 +331,30 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		virtblk_cleanup_cmd(req);
>  		return BLK_STS_RESOURCE;
>  	}
> +	vbr->sg_num = num;

This can go into the nents field of vbr->sg_table.

> +	int err;
> +
> +	status = virtblk_prep_rq(hctx, vblk, req, vbr);
> +	if (unlikely(status))
> +		return status;
>  
>  	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> -	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg_table.sgl, num);
> +	err = virtblk_add_req(vblk->vqs[qid].vq, vbr,
> +				vbr->sg_table.sgl, vbr->sg_num);

And while we're at it - virtblk_add_req can lose the data_sg and
have_data arguments as they can be derived from vbr.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
