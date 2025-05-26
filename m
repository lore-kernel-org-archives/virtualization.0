Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7DF1A5BA0
	for <virtualization@lists.linux.dev>; Mon, 26 May 2025 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290523; cv=none; b=PmnTklNfQEemfYzfCkRgWxX8MAek2k4y33yA7dyx38gJgSEgdSMPOa7p7XZYY4pdR5Mv10B8YXFT3BJ2+DHLnDIvZGqFSfc0EJthoL87ABWUzmdSujNFA+lYahCdabCTAd2KIWvDRqBCedK1TxQ69oNfKm+MiErIDIzdUIienb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290523; c=relaxed/simple;
	bh=jRt1NzH30NqS4mQDsggKXbb5eXmEodCx8akvdZH3Gaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q74bq1203TXIoUi/hGDn9FSnGnUv7QOJOah5KfrbLOvlVILRSrKHhkkrloZwMyMbXxSqiXtTp/kNTkx19eDsZ4SNWAMBBZtKYyLPlpQDBeHPxLGdV/C+tunMd66OZe4BOAwo4hM5E/LG2MRkvE5kWwDqlW5edXPs03j2eHZ3v68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYEL8nCA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYEL8nCA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748290520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ufOut4tD/bTOmC/82es8ca4enQOuTKFDnrKxCLymICQ=;
	b=gYEL8nCAdGDq8j3D6p72fxbmYWEIAv4XKR3gwDc3l0R7HX3R/fsQssnvb6aBx0aNBurlO/
	364+VEacLmjZRRmABVcmtS2zMADHAEtEhQ/4dNarBVU1Q2pVeBLHhR6tacfnk8/NI6oRuo
	/T+focBK0MipQAT3DeuweLC4bcjnE9E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-yP_E6M1LOoKYrP9jRspX8g-1; Mon, 26 May 2025 16:15:19 -0400
X-MC-Unique: yP_E6M1LOoKYrP9jRspX8g-1
X-Mimecast-MFC-AGG-ID: yP_E6M1LOoKYrP9jRspX8g_1748290518
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso1630598f8f.0
        for <virtualization@lists.linux.dev>; Mon, 26 May 2025 13:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748290518; x=1748895318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufOut4tD/bTOmC/82es8ca4enQOuTKFDnrKxCLymICQ=;
        b=Pw8u692JWCoXgRsLZYQgrKYa0Otwfe9cDf6V3nG4Kb5obuc8PcVh46CK5KNcRYW6Hn
         xV9/WqVRs7ZoScimUzewF2OtRPXYm8H6prduddaStOg6PgFUTOEC6N+laiRhanSaEWou
         burT80pX3wfAAQ+y9hshMFfoPPhIonFnB/dVSMsHaGIiU2SDm8AuAZtRcr4IKcy/jV0k
         id+j0ChoIbkuLzAcDIbKZvkkLj1DyFSZVJfOH2E397gVJAKgsBbAq5jm7C32SwcBQOMO
         fUJwjv2XMSCtLTx0O4eWhQrPelKfhHri2L39bAgjygv48nEsTwmvHoYjtgwpggWuMkFi
         /trw==
X-Forwarded-Encrypted: i=1; AJvYcCXdVv/eciVWiksqpyGiG0D1BpUI8wRpLNDgVPDkihmIu3LJ73VPmkNwvCgvmL0W5+e290K3Re4KE3oq38rVTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEtKlbftSVH5LYoJjJtcNj/jC71N3BQD1PBbmkbFffavmiQ/K0
	xiYOMm/dI7CHSEtvwiRIF5WLOcO1rqVXV7rZTaSJC3jdIoKXog6TI409lF4k17inuYFrQ9yGbPw
	ntY3/vZ8yyuPbUS/eCHk11dMJXs992r0QSH3ogy6WMe4NW+7gfmmONnMROWEN1+nZsxB8
X-Gm-Gg: ASbGncta9dMEeKPg9faFf6Q2fygKJO7aZBgHDBVd/EdbvngyfyYZ9YLxQlrXcOEh0UW
	+wBCJbKTv3r99ONiuNFFsoCUtGy0J4M7AmtjsexAjJ/yMpPdggVz7k+W10l5YJmN2SfSeBQMT45
	CDjIlyUKOtP13hO6gGYN96Zkr4IBd0WHJS1KjGBF7VseNnGhA65FhfLdNQIzQZnFqgF2ZwvOwQ0
	EK26gClQ1+GoYZrQUH8cdxd97PtmrTDamU810CZ62lLbWC2+3hxUWRCgQIdELVE84sIFTaOTJ01
	SrsFEQ==
X-Received: by 2002:a05:6000:18a8:b0:3a3:6478:e08 with SMTP id ffacd0b85a97d-3a4ca544f78mr9329426f8f.23.1748290518127;
        Mon, 26 May 2025 13:15:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG/JvPgGiGdVqTeUltNd6COhADsnVUnVtYzDv3Dw+oifQC5VCNzOu9cYfBt0Mr4CiS41W68Q==
X-Received: by 2002:a05:6000:18a8:b0:3a3:6478:e08 with SMTP id ffacd0b85a97d-3a4ca544f78mr9329398f8f.23.1748290517685;
        Mon, 26 May 2025 13:15:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4dc1172ecsm2946843f8f.48.2025.05.26.13.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 13:15:16 -0700 (PDT)
Date: Mon, 26 May 2025 16:15:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: stefanha@redhat.com, axboe@kernel.dk, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, stable@vger.kernel.org,
	lirongqing@baidu.com, kch@nvidia.com, xuanzhuo@linux.alibaba.com,
	pbonzini@redhat.com, jasowang@redhat.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v2] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250526155340-mutt-send-email-mst@kernel.org>
References: <20250526144007.124570-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250526144007.124570-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mDzi-6eZfYnEaeowpObZrAEuV2tKYTZW5WimcUv-Rpw_1748290518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 26, 2025 at 02:40:33PM +0000, Parav Pandit wrote:
> When the PCI device is surprise-removed, requests may not complete on
> the device as the VQ is marked as broken. As a result, disk deletion
> hangs.
> 
> Fix it by aborting the requests when the VQ is broken.
> 
> With this fix now fio completes swiftly.
> An alternative of IO timeout has been considered, however
> when the driver knows about unresponsive block device, swiftly clearing
> them enables users and upper layers to react quickly.
> 
> Verified with multiple device unplug iterations with pending requests in
> virtio used ring and some pending with the device.
> 
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> Cc: stable@vger.kernel.org
> Reported-by: Li RongQing <lirongqing@baidu.com>
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>


Thanks!
I like the patch. Yes something to improve:

> ---
> v1->v2:
> - Addressed comments from Stephan
> - fixed spelling to 'waiting'
> - Addressed comments from Michael
> - Dropped checking broken vq from queue_rq() and queue_rqs()
>   because it is checked in lower layer routines in virtio core
> 
> v0->v1:
> - Fixed comments from Stefan to rename a cleanup function
> - Improved logic for handling any outstanding requests
>   in bio layer
> - improved cancel callback to sync with ongoing done()
> ---
>  drivers/block/virtio_blk.c | 83 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 7cffea01d868..12f31e6c00cb 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1554,6 +1554,87 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return err;
>  }
>  
> +static bool virtblk_request_cancel(struct request *rq, void *data)


> +{
> +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> +	struct virtio_blk *vblk = data;
> +	struct virtio_blk_vq *vq;
> +	unsigned long flags;
> +
> +	vq = &vblk->vqs[rq->mq_hctx->queue_num];
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +
> +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;

My undertanding is that this is only safe to call when device
is not accessing the vq anymore? Right? otherwise device can
overwrite the status?

But I am not sure I understand what guarantees this.
Is there an assumption here that if vq is broken
and we are on remove path then device is already gone?
It seems to hold but
I'd prefer something that makes this guarantee at the API
level.



> +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> +		blk_mq_complete_request(rq);
> +
> +	spin_unlock_irqrestore(&vq->lock, flags);
> +	return true;
> +}
> +
> +static void virtblk_broken_device_cleanup(struct virtio_blk *vblk)
> +{
> +	struct request_queue *q = vblk->disk->queue;
> +
> +	if (!virtqueue_is_broken(vblk->vqs[0].vq))
> +		return;

can marking vqs broken be in progress such that 0
is already broken but another one is not, yet?
if not pls add a comment explainging why.

> +
> +	/* Start freezing the queue, so that new requests keeps waiting at the
> +	 * door of bio_queue_enter(). We cannot fully freeze the queue because
> +	 * freezed queue is an empty queue and there are pending requests, so
> +	 * only start freezing it.
> +	 */
> +	blk_freeze_queue_start(q);
> +
> +	/* When quiescing completes, all ongoing dispatches have completed
> +	 * and no new dispatch will happen towards the driver.
> +	 * This ensures that later when cancel is attempted, then are not
> +	 * getting processed by the queue_rq() or queue_rqs() handlers.
> +	 */
> +	blk_mq_quiesce_queue(q);
> +
> +	/*
> +	 * Synchronize with any ongoing VQ callbacks, effectively quiescing
> +	 * the device and preventing it from completing further requests
> +	 * to the block layer. Any outstanding, incomplete requests will be
> +	 * completed by virtblk_request_cancel().


I think what you really mean is:
finish processing in callbacks, that might have started before vqs were marked as
broken.



> +	 */
> +	virtio_synchronize_cbs(vblk->vdev);




> +
> +	/* At this point, no new requests can enter the queue_rq() and
> +	 * completion routine will not complete any new requests either for the
> +	 * broken vq. Hence, it is safe to cancel all requests which are
> +	 * started.
> +	 */
> +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_request_cancel, vblk);
> +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> +
> +	/* All pending requests are cleaned up. Time to resume so that disk
> +	 * deletion can be smooth. Start the HW queues so that when queue is
> +	 * unquiesced requests can again enter the driver.
> +	 */
> +	blk_mq_start_stopped_hw_queues(q, true);
> +
> +	/* Unquiescing will trigger dispatching any pending requests to the
> +	 * driver which has crossed bio_queue_enter() to the driver.
> +	 */
> +	blk_mq_unquiesce_queue(q);
> +
> +	/* Wait for all pending dispatches to terminate which may have been
> +	 * initiated after unquiescing.
> +	 */
> +	blk_mq_freeze_queue_wait(q);
> +
> +	/* Mark the disk dead so that once queue unfreeze, the requests
> +	 * waiting at the door of bio_queue_enter() can be aborted right away.
> +	 */
> +	blk_mark_disk_dead(vblk->disk);
> +
> +	/* Unfreeze the queue so that any waiting requests will be aborted. */
> +	blk_mq_unfreeze_queue_nomemrestore(q);
> +}
> +
>  static void virtblk_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk = vdev->priv;
> @@ -1561,6 +1642,8 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
>  
> +	virtblk_broken_device_cleanup(vblk);
> +
>  	del_gendisk(vblk->disk);
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  
> -- 
> 2.34.1

