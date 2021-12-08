Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7478C433F5
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 20:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C7FE4021C;
	Wed,  8 Dec 2021 20:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z0S9yhjuzhi1; Wed,  8 Dec 2021 20:27:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F45D400FC;
	Wed,  8 Dec 2021 20:27:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E632C001E;
	Wed,  8 Dec 2021 20:27:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51C6FC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 40292403A8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:27:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DCXJiZIglNrz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:27:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D0B04035C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638995263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ev59STihuBF0lv3Z72rhNC+eAvsSVcdOYjBliasz+5Q=;
 b=S7OIkJtjmRR+GZZF0Zkou1Sc+hyHog3nR36GzbZq4qPi7YpgZuaR/3eTOiBxtoAjkRHuKE
 CZ+qNWjmZUSNfOyaXyN6naaQG0BXcPIV/SsfZOWVE0EKG1xLHMsx34wgLeNZpAPAcMCs52
 tZqZO1BLHbcFGD1jZoGdRDPihKkjHDk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-HMz2FPCHMa2DaclD6VznmA-1; Wed, 08 Dec 2021 15:27:42 -0500
X-MC-Unique: HMz2FPCHMa2DaclD6VznmA-1
Received: by mail-wm1-f72.google.com with SMTP id
 144-20020a1c0496000000b003305ac0e03aso3575381wme.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 12:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ev59STihuBF0lv3Z72rhNC+eAvsSVcdOYjBliasz+5Q=;
 b=yNQiqos/uV3mxz7jYlRhmvGeDUhsk7PocptYnw5iTWFK8pGaHx1yLb7OBk7prh/NsX
 Wg1KHLFaVtMNLOetbi9ZVMQCtET0IwEXY8PxcuG/iCbgGdWu7g0disNGZDshAIPbtwgR
 5Di/ZtFb4P04af0Taqrswuh9Si+Q0YNbH9MCzCdFvpiKMG+PaEM/p4l8Hqy772DdZJ0o
 94vIO48JhL8IjfjAv5yOjxge86Nc74xcsgIJV5ec1MOhYs8UKbg7mAjU4VbYaOh8Bk05
 HlaYKagpIc2HZEdypOv4+u/ZyYVsmYDE2ymGzKBtLgUp/coMiNJT/io9rizfkzWvunwN
 9lbQ==
X-Gm-Message-State: AOAM531alJZYzfe/c9bP67uigFOmYtz3tX5pEarroqt79UtAFNid9m5A
 dORrIV9qo3clNjlJlvofFiN24XI14EkcvqgE/hc+rDVE5HT5bkNaFcax2pqe+AdbzXmRjRHnalY
 BgSw9XAseJ2YD98FfclFeZxuEpRu/Up5Ywq+n1mXSkg==
X-Received: by 2002:a1c:8002:: with SMTP id b2mr1202110wmd.2.1638995260950;
 Wed, 08 Dec 2021 12:27:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+Ew/GMC+D59qHQoNdS7PwVTKJL+WtNoA4/cYkJjZFPRDqJ0hQUabJznSE72GBSSvH656KUw==
X-Received: by 2002:a1c:8002:: with SMTP id b2mr1202078wmd.2.1638995260690;
 Wed, 08 Dec 2021 12:27:40 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
 by smtp.gmail.com with ESMTPSA id e18sm3646611wrs.48.2021.12.08.12.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 12:27:40 -0800 (PST)
Date: Wed, 8 Dec 2021 15:27:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] virtio-mmio: harden interrupt
Message-ID: <20211208151801-mutt-send-email-mst@kernel.org>
References: <20211126044102.18374-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211126044102.18374-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Fri, Nov 26, 2021 at 12:41:02PM +0800, Jason Wang wrote:
> This patch tries to make sure the virtio interrupt handler for MMIO
> won't be called after a reset and before virtio_device_ready(). We
> can't use IRQF_NO_AUTOEN since we're using shared interrupt
> (IRQF_SHARED). So this patch tracks the interrupt enabling status in a
> new intr_soft_enabled variable and toggle it during in
> vm_disable/enable_interrupts(). The MMIO interrupt handler will check
> intr_soft_enabled before processing the actual interrupt.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - Silent compling warnings
>  drivers/virtio/virtio_mmio.c | 37 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 56128b9c46eb..c517afdd2cc5 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -90,6 +90,7 @@ struct virtio_mmio_device {
>  	/* a list of queues so we can dispatch IRQs */
>  	spinlock_t lock;
>  	struct list_head virtqueues;
> +	bool intr_soft_enabled;
>  };
>  
>  struct virtio_mmio_vq_info {
> @@ -100,7 +101,37 @@ struct virtio_mmio_vq_info {
>  	struct list_head node;
>  };
>  
> +/* disable irq handlers */
> +static void vm_disable_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	int irq = platform_get_irq(vm_dev->pdev, 0);
>  
> +	/*
> +	 * The below synchronize() guarantees that any
> +	 * interrupt for this line arriving after
> +	 * synchronize_irq() has completed is guaranteed to see
> +	 * intx_soft_enabled == false.
> +	 */
> +	WRITE_ONCE(vm_dev->intr_soft_enabled, false);
> +	synchronize_irq(irq);
> +}
> +
> +/* enable irq handlers */
> +static void vm_enable_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	int irq = platform_get_irq(vm_dev->pdev, 0);
> +
> +	disable_irq(irq);
> +	/*
> +	 * The above disable_irq() provides TSO ordering and
> +	 * as such promotes the below store to store-release.
> +	 */
> +	WRITE_ONCE(vm_dev->intr_soft_enabled, true);
> +	enable_irq(irq);
> +	return;
> +}
>  
>  /* Configuration interface */
>  
> @@ -262,6 +293,8 @@ static void vm_reset(struct virtio_device *vdev)
>  
>  	/* 0 status means a reset. */
>  	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);

There was a discussion about reading status to make sure it is clear.
The spec says we should, this can't hurt as a further hardening measure.
In fact, let's do it in the core maybe? Spec says it applies to all
devices ...

> +	/* Disable VQ/configuration callbacks. */
> +	vm_disable_cbs(vdev);
>  }
>  
>  
> @@ -288,6 +321,9 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
>  	unsigned long flags;
>  	irqreturn_t ret = IRQ_NONE;
>  
> +	if (!READ_ONCE(vm_dev->intr_soft_enabled))
> +		return IRQ_NONE;
> +

So if the write is seen before reset happened (should not happen, but we
are talking a buggy device) then it won't be acknowledged and device
will keep pulling the interrupt. I think as long as we are hardening
this, let's go the full mile and try to avoid DoS if we can, do the
check before invoking the callback, but do not skip the read.
Whether to still return IRQ_NONE is a good question.




>  	/* Read and acknowledge interrupts */
>  	status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
>  	writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
> @@ -529,6 +565,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
>  }
>  
>  static const struct virtio_config_ops virtio_mmio_config_ops = {
> +	.enable_cbs     = vm_enable_cbs,
>  	.get		= vm_get,
>  	.set		= vm_set,
>  	.generation	= vm_generation,
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
