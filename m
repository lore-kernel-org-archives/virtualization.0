Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4F33DEDF
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785704360; cv=none; b=TmMIWE915fad0hbVhYw5p+rqEwaKKCCE3I3y+IsnyknG8W9NplD0Dc5BFL27ed6OUOtcuP+lf7mPJ3jc4YYvMczeyhRkKYhO0+CE8IWaVq5aMa36bwxeN/8ccAHeqm8MRp5A+qUvaWEkHqPrkl/STcU/UKi4DQpbSgclMZUuU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785704360; c=relaxed/simple;
	bh=TufCBztkTKH3AfRWjBpjd3FHGRl2lwcK9tWuFaY9Wt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y4McxzUvqOI1SXElaGPjc7lwwyPamEQGVpuXdKXK+t2kvXaM14KjXDNuiVCT4RaykmnCjAsvSF3HMnPKU+eohmgBU3keaeOfAL+dVHvnK8htEdZa0xGJkCTxwALIYWjJ4RqnXTLt0JU1GSC1qCFAQ0SS7JOhr8ytX6o3nacopME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyOjv5OE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyOjv5OE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785704357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B6aw/MfyvAQ+UMZOr4YxAOduk77RukTa3bw+TseKJQI=;
	b=VyOjv5OED5W8WhTAD1SbcVW/tbYXfAKBKDQRioFIYsxyaFS6Y2O5gsZBy0kk/AtxOZ3Cx7
	vzQpLjtX48rI5jhaQ0rRMn7mz+w1HtFanPMC4eNVr+ss0/x3uQSnMtDLGdB77A23VRVLj1
	gYsTXVZ6N/J91iFf9z3+buJIB7teuWU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-HjbazkU4PQGSp5hSdCBCEA-1; Sun, 02 Aug 2026 16:59:14 -0400
X-MC-Unique: HjbazkU4PQGSp5hSdCBCEA-1
X-Mimecast-MFC-AGG-ID: HjbazkU4PQGSp5hSdCBCEA_1785704353
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso13056735e9.1
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 13:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785704353; x=1786309153;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6aw/MfyvAQ+UMZOr4YxAOduk77RukTa3bw+TseKJQI=;
        b=UkpWewl2lai47R9uHbkiiFt1q6TzUrI3N3/gQuJetbAD9H0fypm5UZ0c/AhCTozoIx
         AxdR4miSpCUm+MoKh98mvKiS4nvaRy/1YjNqYC5d7jV7wJMy5UmLDJ8+P5NoeT8WgYc8
         ZviRg2n3+bCu0sMzKBD7SulnB0DkbejqtPhjXOkiJ3cayYC2iKXYoK+KhzumG5KY0eiW
         nV+7c1TqLqr+fOnsZd4Z6Ssp4CouaqiXg91P1K6UNJD0J6hopxe6L4x30eoXHXR1A8je
         34tkURjKPTXbPnmILTWTtA82gZNPirJWi4wqNMte5VrIYzVwUoJFU65AzkM2himJQFr7
         e5oQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6+9jhDhgRpvh8lpgdUGAIhq89QuZLbdBtD84DLRySWvLnZPP4LwMM9roLdDtBkaF1oSXt6nD+igRjYP8wfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSypoI8OM8YlUpZ3tRtK9o5W+h6cBziYisLNbX7GxCXVCoRXSr
	+WPn7Jp8HOwQD4Vlae2K4AyK89fYIXH8NDUGE4ndvVsba53Buga08zZi7Ml6TllWLtUASYmmi4v
	9SuaeZ/ph5Q6HkQStPuH2C+gmq8eFOxwGYuUmS5beh0X+toyeiryUGfrembOg0U/cY7/w
X-Gm-Gg: AR+sD11f3IDYHxvhbz79U+HvLp3WXOvrkVMR+a5ILyEa3xg1hZ9SaUuwR19TmzOnRzy
	vclk0Kfa5Cw6i8/2tZev1uyB9kW/Bloyp8g09R7Qjn6oK/9SckTFbbec5eM9Sfs9STv/r0xJNa/
	3199PVKK21FarBVQ+W2fHwmmEd1/LbZwUvvBi70rxGtw+BIM+qT8v7OyLWtsrFtCXB1ohnbBgxm
	8bua7fVAuRjQpawdLQLoKxZ+Cit6mAC4nZh350d5iMwuzQ4LpwmoGvquhzApD2V7WxkrI7SWUY6
	YrbXCOReV7Lx7XfynxX1ZM7Ck3kb/bjGjtk/DWruzRSASaLvRRKNQQj+SWnmZY2YfS2gog9jJSe
	PFwA2k2hrLONVv8CrNN4TnA==
X-Received: by 2002:a05:600c:6990:b0:495:4d00:2fc0 with SMTP id 5b1f17b1804b1-4980c673907mr169358195e9.12.1785704353039;
        Sun, 02 Aug 2026 13:59:13 -0700 (PDT)
X-Received: by 2002:a05:600c:6990:b0:495:4d00:2fc0 with SMTP id 5b1f17b1804b1-4980c673907mr169357715e9.12.1785704352602;
        Sun, 02 Aug 2026 13:59:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm25273135f8f.34.2026.08.02.13.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:59:12 -0700 (PDT)
Date: Sun, 2 Aug 2026 16:59:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
	axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio-blk: mark disk dead on ERS permanent
 failure
Message-ID: <20260802165703-mutt-send-email-mst@kernel.org>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
 <cover.virtio-blk-ers-v2.1785468000.git.liuxixin@kylinos.cn>
 <4740ae91d5be.v2.1785468000.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4740ae91d5be.v2.1785468000.git.liuxixin@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qHPxax8U-PnlpQ2Li9rBkIZTrRIN4AcPoZz8qgxTIl0_1785704353
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2026 at 11:19:00AM +0800, Xixin Liu wrote:
> After ERS reports pci_channel_io_perm_failure, virtio-pci must ask the
> virtio driver to tear down the block device, not only mark virtqueues
> broken.  Call the virtio driver shutdown hook from virtio-pci on
> perm_failure; virtio-blk implements shutdown with blk_mark_disk_dead().
> 
> Fail new requests early in virtio_queue_rq when virtqueues were removed
> during frozen reset_prepare (vqs == NULL).  A broken vq already fails in
> virtqueue_add; no separate disk_live() check is needed.
> 
> Assisted-by: DeepSeek:deepseek-v3
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
> ---
>  drivers/block/virtio_blk.c         | 31 ++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_pci_common.c | 10 +++++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..fda2d4f3c7c6 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -435,6 +435,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	blk_status_t status;
>  	int err;
>  
> +	/* VQs may be gone after frozen reset_prepare; avoid NULL deref. */
> +	if (unlikely(!vblk->vqs || !vblk->vdev)) {
> +		blk_mq_start_request(req);
> +		return BLK_STS_IOERR;
> +	}
> +
>  	status = virtblk_prep_rq(hctx, vblk, req, vbr);
>  	if (unlikely(status))
>  		return status;
> @@ -1561,6 +1567,30 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return err;
>  }
>  
> +
> +/* Stop I/O and mark the gendisk dead (ERS perm_failure or system shutdown). */
> +static void virtblk_shutdown(struct virtio_device *vdev)
> +{
> +	struct virtio_blk *vblk = vdev->priv;
> +	struct request_queue *q;
> +	unsigned int memflags;
> +
> +	if (!vblk || !vblk->disk)
> +		return;
> +
> +	virtio_break_device(vdev);
> +	flush_work(&vblk->config_work);
> +
> +	q = vblk->disk->queue;
> +	memflags = blk_mq_freeze_queue(q);
> +	blk_mq_quiesce_queue_nowait(q);
> +
> +	blk_mark_disk_dead(vblk->disk);
> +
> +	blk_mq_unquiesce_queue(q);
> +	blk_mq_unfreeze_queue(q, memflags);
> +}
> +
>  static void virtblk_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk = vdev->priv;

what happens with requests already outstanding in the queues?
e.g. does this leak memory?

> @@ -1684,6 +1714,7 @@ static struct virtio_driver virtio_blk = {
>  	.probe				= virtblk_probe,
>  	.remove				= virtblk_remove,
>  	.config_changed			= virtblk_config_changed,
> +	.shutdown			= virtblk_shutdown,
>  #ifdef CONFIG_PM_SLEEP
>  	.freeze				= virtblk_freeze,
>  	.restore			= virtblk_restore,
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index fff6b6e2d0c5..957b3282865c 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -849,7 +849,15 @@ static pci_ers_result_t virtio_pci_error_detected(struct pci_dev *pci_dev,
>  	case pci_channel_io_perm_failure:
>  		dev_warn(&pci_dev->dev,
>  			 "permanent failure, disconnecting device\n");
> -		virtio_break_device(&vp_dev->vdev);
> +		{
> +			struct virtio_driver *drv =
> +				drv_to_virtio(vp_dev->vdev.dev.driver);
> +
> +			if (drv && drv->shutdown)
> +				drv->shutdown(&vp_dev->vdev);
> +			else
> +				virtio_break_device(&vp_dev->vdev);
> +		}
>  		return PCI_ERS_RESULT_DISCONNECT;

So this is blk specifically, I am somewhat lost as to why
is blk treated differently from other drivers here.


>  	default:
>  		break;
> -- 
> 2.43.0

