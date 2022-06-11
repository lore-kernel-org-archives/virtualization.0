Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039CFC43334
	for <virtualization@archiver.kernel.org>; Sat, 11 Jun 2022 05:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D82761281;
	Sat, 11 Jun 2022 05:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zMMmrH3ZBULy; Sat, 11 Jun 2022 05:12:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CD8A860D53;
	Sat, 11 Jun 2022 05:12:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B038C0039;
	Sat, 11 Jun 2022 05:12:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDE9FC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 05:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97547402DC
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 05:12:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5U6xmnIdWwOR
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 05:12:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 588EA40104
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 05:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654924364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yUCbvKH6onKTyOKHCunwnVi2szEiTppWSk5/UcL3S3M=;
 b=XBkd9UmKwIJfqbiQeRkJlDcrjnYDwmCKE4qD7LIdq6K/OlE6w61vCLgAYJfnYbT/5aSwIs
 9qca5yMzgumnJepi1X+Fq8/LrDwBuuEc8ov3/bcXMJlh7O7IoUOQZEvItTuFDC+tfq+Fyu
 rYu7TWH3ZmExTXc5L92HPQ+QXoT4uPY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-kQU4Jz-kN-GfVqIa79cRBw-1; Sat, 11 Jun 2022 01:12:43 -0400
X-MC-Unique: kQU4Jz-kN-GfVqIa79cRBw-1
Received: by mail-ed1-f71.google.com with SMTP id
 v8-20020a056402348800b004315c52b92cso746076edc.19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 22:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yUCbvKH6onKTyOKHCunwnVi2szEiTppWSk5/UcL3S3M=;
 b=Xb9akipmNPH8HFU9IBXAQHp53lvpABNbTZeSE6a3oRG4WNaf+BzyM226PJUq5yThCk
 iyGofBbMWsZtU6OF4Q6QwrsjzpLNkKSzrxyIy9kI6AjsiVzJWAEU4EK+yAlJAQNooK2K
 hBDkuUGh1aTUW4CAkb70UTX63frOYVO/IcagaBb9w6VegxNkAnFePoJy++6JRclBIXh8
 N7KEKh2C3X4OTsPNINke15WhlmSctyVe4u0Im7Y/X4vikghPTCWVVy8YOiUVEW/JzFrO
 q4LgKXgzsFlK4GysSvWp6nKBN4bZJ9dbV62QsHTBeuxapEWrjXSq8jwFxH/OhaX50LDs
 Kkdw==
X-Gm-Message-State: AOAM53221bwMyXbnl5BGyKz68EgrNf1Zvk+RcV87JibUnTAAnJup6gc/
 fb1x82lP+/C9aXUO+3xHe34Z2eN7Oc+3002pKyut2AXSBlZRB4msR1oa8I3GFJkOskymTyaMTDL
 LvKY/i/3agEp/jH6UL15c75huImtl30SKCmJszcFvmg==
X-Received: by 2002:a05:6402:304b:b0:433:5d15:e798 with SMTP id
 bs11-20020a056402304b00b004335d15e798mr4780309edb.20.1654924362015; 
 Fri, 10 Jun 2022 22:12:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGnGxl+zilkLRjutqMnHCrUea4zBk6Y/Z99Z9zh0yRM8Uo3fx8LU379qeQxmbJMEpv+fonVg==
X-Received: by 2002:a05:6402:304b:b0:433:5d15:e798 with SMTP id
 bs11-20020a056402304b00b004335d15e798mr4780292edb.20.1654924361821; 
 Fri, 10 Jun 2022 22:12:41 -0700 (PDT)
Received: from redhat.com ([212.116.178.142]) by smtp.gmail.com with ESMTPSA id
 fe6-20020a1709072a4600b00704a5c530ccsm505729ejc.162.2022.06.10.22.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jun 2022 22:12:41 -0700 (PDT)
Date: Sat, 11 Jun 2022 01:12:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V6 8/9] virtio: harden vring IRQ
Message-ID: <20220611010747-mutt-send-email-mst@kernel.org>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-9-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220527060120.20964-9-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, lulu@redhat.com,
 paulmck@kernel.org, linux-s390@vger.kernel.org, peterz@infradead.org,
 maz@kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 eperezma@redhat.com, Vineeth Vijayan <vneethv@linux.ibm.com>,
 tglx@linutronix.de
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

On Fri, May 27, 2022 at 02:01:19PM +0800, Jason Wang wrote:
> This is a rework on the previous IRQ hardening that is done for
> virtio-pci where several drawbacks were found and were reverted:
> 
> 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
>    that is used by some device such as virtio-blk
> 2) done only for PCI transport
> 
> The vq->broken is re-used in this patch for implementing the IRQ
> hardening. The vq->broken is set to true during both initialization
> and reset. And the vq->broken is set to false in
> virtio_device_ready(). Then vring_interrupt() can check and return
> when vq->broken is true. And in this case, switch to return IRQ_NONE
> to let the interrupt core aware of such invalid interrupt to prevent
> IRQ storm.
> 
> The reason of using a per queue variable instead of a per device one
> is that we may need it for per queue reset hardening in the future.
> 
> Note that the hardening is only done for vring interrupt since the
> config interrupt hardening is already done in commit 22b7050a024d7
> ("virtio: defer config changed notifications"). But the method that is
> used by config interrupt can't be reused by the vring interrupt
> handler because it uses spinlock to do the synchronization which is
> expensive.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Jason, I am really concerned by all the fallout.
I propose adding a flag to suppress the hardening -
this will be a debugging aid and a work around for
users if we find more buggy drivers.

suppress_interrupt_hardening ?


> ---
>  drivers/s390/virtio/virtio_ccw.c       |  4 ++++
>  drivers/virtio/virtio.c                | 15 ++++++++++++---
>  drivers/virtio/virtio_mmio.c           |  5 +++++
>  drivers/virtio/virtio_pci_modern_dev.c |  5 +++++
>  drivers/virtio/virtio_ring.c           | 11 +++++++----
>  include/linux/virtio_config.h          | 20 ++++++++++++++++++++
>  6 files changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index c188e4f20ca3..97e51c34e6cf 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -971,6 +971,10 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
>  	ccw->flags = 0;
>  	ccw->count = sizeof(status);
>  	ccw->cda = (__u32)(unsigned long)&vcdev->dma_area->status;
> +	/* We use ssch for setting the status which is a serializing
> +	 * instruction that guarantees the memory writes have
> +	 * completed before ssch.
> +	 */
>  	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_STATUS);
>  	/* Write failed? We assume status is unchanged. */
>  	if (ret)
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index aa1eb5132767..95fac4c97c8b 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device *dev)
>   * */
>  void virtio_reset_device(struct virtio_device *dev)
>  {
> +	/*
> +	 * The below virtio_synchronize_cbs() guarantees that any
> +	 * interrupt for this line arriving after
> +	 * virtio_synchronize_vqs() has completed is guaranteed to see
> +	 * vq->broken as true.
> +	 */
> +	virtio_break_device(dev);

So make this conditional

> +	virtio_synchronize_cbs(dev);
> +
>  	dev->config->reset(dev);
>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);
> @@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *dev)
>  	dev->config_enabled = false;
>  	dev->config_change_pending = false;
>  
> +	INIT_LIST_HEAD(&dev->vqs);
> +	spin_lock_init(&dev->vqs_list_lock);
> +
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */
>  	virtio_reset_device(dev);
> @@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *dev)
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>  
> -	INIT_LIST_HEAD(&dev->vqs);
> -	spin_lock_init(&dev->vqs_list_lock);
> -
>  	/*
>  	 * device_add() causes the bus infrastructure to look for a matching
>  	 * driver.
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index c9699a59f93c..f9a36bc7ac27 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -253,6 +253,11 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
>  	/* We should never be setting status to 0. */
>  	BUG_ON(status == 0);
>  
> +	/*
> +	 * Per memory-barriers.txt, wmb() is not needed to guarantee
> +	 * that the the cache coherent memory writes have completed
> +	 * before writing to the MMIO region.
> +	 */
>  	writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
>  }
>  
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 4093f9cca7a6..a0fa14f28a7f 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -467,6 +467,11 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>  
> +	/*
> +	 * Per memory-barriers.txt, wmb() is not needed to guarantee
> +	 * that the the cache coherent memory writes have completed
> +	 * before writing to the MMIO region.
> +	 */
>  	vp_iowrite8(status, &cfg->device_status);
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_set_status);
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 9c231e1fded7..13a7348cedff 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1688,7 +1688,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->we_own_ring = true;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> -	vq->broken = false;
> +	vq->broken = true;
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;

and make this conditional

> @@ -2134,8 +2134,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  		return IRQ_NONE;
>  	}
>  
> -	if (unlikely(vq->broken))
> -		return IRQ_HANDLED;
> +	if (unlikely(vq->broken)) {
> +		dev_warn_once(&vq->vq.vdev->dev,
> +			      "virtio vring IRQ raised before DRIVER_OK");
> +		return IRQ_NONE;
> +	}
>  
>  	/* Just a hint for performance: so it's ok that this can be racy! */
>  	if (vq->event)
> @@ -2177,7 +2180,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->we_own_ring = false;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> -	vq->broken = false;
> +	vq->broken = true;
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;

and make this conditional

> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 25be018810a7..d4edfd7d91bb 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -256,6 +256,26 @@ void virtio_device_ready(struct virtio_device *dev)
>  	unsigned status = dev->config->get_status(dev);
>  
>  	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> +
> +	/*
> +	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> +	 * will see the driver specific setup if it sees vq->broken
> +	 * as false (even if the notifications come before DRIVER_OK).
> +	 */
> +	virtio_synchronize_cbs(dev);
> +	__virtio_unbreak_device(dev);
> +	/*
> +	 * The transport should ensure the visibility of vq->broken
> +	 * before setting DRIVER_OK. See the comments for the transport
> +	 * specific set_status() method.
> +	 *
> +	 * A well behaved device will only notify a virtqueue after
> +	 * DRIVER_OK, this means the device should "see" the coherenct
> +	 * memory write that set vq->broken as false which is done by
> +	 * the driver when it sees DRIVER_OK, then the following
> +	 * driver's vring_interrupt() will see vq->broken as false so
> +	 * we won't lose any notification.
> +	 */
>  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
