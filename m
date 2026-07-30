Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF5947042C
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453251; cv=none; b=u3zw/A20/U4gbkK7kE1G0wc+xfEHkAuQAtLebT9deZbQPPU43WqfWQES7X3ODZ9uHZvo/uGnhWjZmdrJgvm9azMKwMJ4o+xHFvPO2X6ie5iJ14loRSkflbxrMKgo+NSeAD6BMRaZuoKpnlMYlC0p5Ai3zNc+SG1REvdu/0UGXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453251; c=relaxed/simple;
	bh=EEUFYL23HwPB43lcPPdzpHoo82V4ls5Xt8PMeJUlkLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZiDZaorjSRxDz8YtMa+KHN4zf2odu2sH71VEGvAfftQJye/9cIOU5rxg+kCgSYNDZGlngqXjwCOmcQFGGj8Xz2QpC0d0PjlU4S7c/R9la9LWUKQFBwyjxsy99Ltg6CGtu58L9ft0BkZZKmgcXgBbyTniz5pN5XAo/m4uLk8RMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5yC71XH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5yC71XH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785453242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKpylt9BNItQ/yUkXHhBehnJEVudegSbEoMVeY2TqkQ=;
	b=Y5yC71XHJCQrJ+W01IC0pIGGviSZUPOpR7aaUcizDnDevSgfacovouVU2c+v1e5ap1xXry
	gG3SyR8wcLTf1+rAQvbOdupQs1D8xA9DRGPEt5Mt3O5u5ga6WMOlgIVAXI8yE+NSdA2pQT
	lFkPotRe9vkVmg8bF7gCYKjd0fHPEIE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-3lkkCgD3OU6zvE-smbIsKQ-1; Thu, 30 Jul 2026 19:14:00 -0400
X-MC-Unique: 3lkkCgD3OU6zvE-smbIsKQ-1
X-Mimecast-MFC-AGG-ID: 3lkkCgD3OU6zvE-smbIsKQ_1785453239
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-496c06ba017so1180265e9.0
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 16:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785453239; x=1786058039;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uKpylt9BNItQ/yUkXHhBehnJEVudegSbEoMVeY2TqkQ=;
        b=mnTmcybtXJh3jsr+cBuY0THNZOFQUZmNEOphNT8Kddg3b9Tx5up8Vz4SrC8OuBRaf7
         8wDPwd8M6zWGMcqcrxn8Yhvw9Dry8CY5VIK0EHQe4hciZwWalF/EjkZI9C7h/zmKAvQB
         GzrRzBlsVke2P9ZBVNwvHj5fPyGg+de/3hr4XXmDOCq1cMDt2L177FgLr7qISzvRmxcc
         KNLScvdP0kmcTpo3bWtJ0DeWtgCnlGEHQWVaeY18Nl9XY3yjsjtxqN3qKEE1MsfE5TfN
         ZUCSpmrgIc+xYngT5fnX+s2OUn5kGhLhmcJpTMozCaUrARZuUEP8xWC/U/BpxidgpKBa
         Z/Ug==
X-Forwarded-Encrypted: i=1; AHgh+Rq40dbe47ZF+DZXANnEMh7sZ1j5rUXq04y1il8cz+IZroX2Bn1/trqx3lyHMwSH4CE8s/wveZ+ZOzd3Hymgrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLarHAnNdDwv0Su5YtofBZ9IYk2im01KefhifSZyr1d7ssx390
	paexGiuX7aF2sWhkJ4EkLKytMHBpskfFfGOQkAqIP3sphjmviZ/h4nZ4me3/ZMI5o2dGA2HITFW
	WZY78OTGnsD3flpCkgbEwNiTDtH4FON8Hbk1bVSYApZiii7105jOz115iRzms+L9aJVjM6MWxaG
	nL
X-Gm-Gg: AR+sD12nszYyWswEd5CFR0fhsYOex2Yj7P8xIvwRyRFwMqx2m85Pc4AspRl0xRIiNly
	yL6Ir57appPaWkdZ/fV/PJB1jDosQVOklJY7luOoLpo3izXHv+q0EDPgvwgVIid5RyXqJq/wTgO
	BrBkS6jbhZ3RY9L3oheKPOohtPdlwkgYfV2Gg8b40fRd8WMcrLeofZPFmiId2YF3xrt83hV+j8F
	faNG0vASWxBED+qTDLdoWwAxMcJGMAPmdiAQilxE6D6HWKGXgRgCBAgZxWKvLr5l0LXk8jfQxhD
	p/iPfF0bsHmpoqdF1ALcfCack6uP6RL2blhAdvI8GiBP3XRQ1gKyC++T7WnY6orz1sAYNwE6aBB
	FT+WUuIkdxtFpkkZo7X+miyI=
X-Received: by 2002:a05:600c:3151:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-49804ce5207mr34202785e9.3.1785453239297;
        Thu, 30 Jul 2026 16:13:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3151:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-49804ce5207mr34202555e9.3.1785453238844;
        Thu, 30 Jul 2026 16:13:58 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980630ec94sm4702545e9.4.2026.07.30.16.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:13:58 -0700 (PDT)
Date: Thu, 30 Jul 2026 19:13:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
	axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] virtio-blk: mark disk dead on ERS permanent
 failure
Message-ID: <20260730190926-mutt-send-email-mst@kernel.org>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
 <4740ae91d5be.1780449274.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4740ae91d5be.1780449274.git.liuxixin@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VtNvlNh24ucJEy14nm4leUMc-DKegXBelzUILVoHMU4_1785453239
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 12, 2026 at 06:00:00PM +0800, Xixin Liu wrote:
> After ERS reports pci_channel_io_perm_failure, virtio-pci must ask the
> virtio driver to tear down the block device — not only mark virtqueues
> broken.

Can you tell me was this written with use of AI? I ask because not many
people go out of their way to put in unicode dashes. Next step is what
emojis? Let's not go there pls.
And if yes pls disclose that as per Documentation.

>  Call the virtio driver shutdown hook from virtio-pci on
> perm_failure; virtio-blk implements shutdown with blk_mark_disk_dead().
> Fail new requests early in virtio_queue_rq when the disk is dead or
> virtqueues were removed during frozen reset_prepare.
> 
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
> ---
>  drivers/block/virtio_blk.c         | 39 +++++++++++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_pci_common.c | 10 +++++++++-
>  2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..4740ae91d5be 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -435,6 +435,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	blk_status_t status;
>  	int err;
>  
> +	/* Fail fast if ERS frozen tore down VQs or the disk was marked dead. */
> +	if (unlikely(!disk_live(vblk->disk) || !vblk->vqs || !vblk->vdev)) {
> +		blk_mq_start_request(req);
> +		return BLK_STS_IOERR;
> +	}
> +

Do we need this? virtqueue add will fail anyway.

>  	status = virtblk_prep_rq(hctx, vblk, req, vbr);
>  	if (unlikely(status))
>  		return status;
> @@ -1561,6 +1567,29 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return err;
>  }
>  
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
> +	flush_work(&vblk->config_work);
> +	virtio_break_device(vdev);

why not break first?

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
> @@ -1684,6 +1713,7 @@ static struct virtio_driver virtio_blk = {
>  	.probe				= virtblk_probe,
>  	.remove				= virtblk_remove,
>  	.config_changed			= virtblk_config_changed,
> +	.shutdown			= virtblk_shutdown,
>  #ifdef CONFIG_PM_SLEEP
>  	.freeze				= virtblk_freeze,
>  	.restore			= virtblk_restore,
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index e2dda946e70e..924ceead436b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -845,7 +845,15 @@ static pci_ers_result_t virtio_pci_error_detected(struct pci_dev *pci_dev,
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
>  	default:
>  		break;

