Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB719C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 12:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85C75610AF;
	Wed,  6 Apr 2022 12:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M529N0fbTBL8; Wed,  6 Apr 2022 12:04:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 03E5360A88;
	Wed,  6 Apr 2022 12:04:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8EDCC002C;
	Wed,  6 Apr 2022 12:04:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14511C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 12:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 124AB813EE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 12:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ehQb9kXI3suJ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 12:04:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E6B4813EA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649246696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubOv2fch/wckoTm8HS8GYp3/vOZS2zK/ygF8PnquGr8=;
 b=TtQZIt294Fm6w3r5v1ScDT/hpcxdqBtTW52KM9mvYMDnx8Wt1RVKVrGcfPCp7LCkXCFf2r
 mGCoL60BzuHBMD82dW83QJN3de7RyD4L2mt4GSXgGruOH69Cqe0wLzIYyhimBXl+r2z39J
 CaTZnM9mmuZjv19iEH0H8ymg6SXeigk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-2arKoI4LPXGMwrSN6yZ-xA-1; Wed, 06 Apr 2022 08:04:53 -0400
X-MC-Unique: 2arKoI4LPXGMwrSN6yZ-xA-1
Received: by mail-wm1-f70.google.com with SMTP id
 x8-20020a7bc768000000b0038e73173886so1223547wmk.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 05:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ubOv2fch/wckoTm8HS8GYp3/vOZS2zK/ygF8PnquGr8=;
 b=WJdCD+nM2QhrO3s6KnRD9KnmftGl7+1ESph/JudgRvrC7ca3fLTemXwiyIxnDkZmiS
 mGKA0kgePImW2hrq/yQH/VnoEmPuGaru2hXLux+aFvBGUPJ2FHQ35YexTwt1YGrKYZeh
 ZlWrRkQNouxrmPBQ81my2Ei5Az+T31v/gW85eXaAGXJDGni1CxwcZib6Evm0ULHyE3LO
 IN+hN9yRAKG84ggSeng44jatTjcZjB/CAqFb3eWVstsdJwJVuK/I9TtOKnvuZW8p9InI
 N16lzDWtCpKTEM/g9vXolSfXyzd0oHd2WW377sLgO0jyAuBrpD1JI+yUnZh+lk6YZ6gk
 TkIw==
X-Gm-Message-State: AOAM532HLK8nk2gi5jVd8CFjie4jVYyKvXkzW/ZLdoCihqYsE4ao41RL
 fWjpf41s0FQeql41bpDmNMRLh29+x6eSUZeGEYimgML0mEiyFzaYGFCqTiXQT46TxS2kPdPN8ny
 L7uu1lm8LLyhWZE8hqEtBnTd3dQLm67TSrxPzTTYm4Q==
X-Received: by 2002:adf:912f:0:b0:204:3be:1a5b with SMTP id
 j44-20020adf912f000000b0020403be1a5bmr6806920wrj.467.1649246691961; 
 Wed, 06 Apr 2022 05:04:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQR5ApoQJ3GQmL6XrNhmVtOvy3kWPmBXxQ5CQD1Yy517tuy3/gi8RA32uBI1lksiBw4nQHkQ==
X-Received: by 2002:adf:912f:0:b0:204:3be:1a5b with SMTP id
 j44-20020adf912f000000b0020403be1a5bmr6806890wrj.467.1649246691562; 
 Wed, 06 Apr 2022 05:04:51 -0700 (PDT)
Received: from redhat.com ([2.55.136.193]) by smtp.gmail.com with ESMTPSA id
 w1-20020a5d6081000000b002061b616b83sm5145435wrt.39.2022.04.06.05.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Apr 2022 05:04:50 -0700 (PDT)
Date: Wed, 6 Apr 2022 08:04:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 5/5] virtio: harden vring IRQ
Message-ID: <20220406080135-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-6-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220406083538.16274-6-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de
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

On Wed, Apr 06, 2022 at 04:35:38PM +0800, Jason Wang wrote:
> This is a rework on the previous IRQ hardening that is done for
> virtio-pci where several drawbacks were found and were reverted:
> 
> 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
>    that is used by some device such as virtio-blk
> 2) done only for PCI transport
> 
> In this patch, we tries to borrow the idea from the INTX IRQ hardening
> in the reverted commit 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
> by introducing a global device_ready variable for each
> virtio_device. Then we can to toggle it during
> virtio_reset_device()/virtio_device_ready(). A
> virtio_synchornize_vqs() is used in both virtio_device_ready() and
> virtio_reset_device() to synchronize with the vring callbacks. With
> this, vring_interrupt() can return check and early if driver_ready is
> false.
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
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c       | 11 +++++++++++
>  drivers/virtio/virtio_ring.c  |  9 ++++++++-
>  include/linux/virtio.h        |  2 ++
>  include/linux/virtio_config.h |  8 ++++++++
>  4 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 8dde44ea044a..2f3a6f8e3d9c 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -220,6 +220,17 @@ static int virtio_features_ok(struct virtio_device *dev)
>   * */
>  void virtio_reset_device(struct virtio_device *dev)
>  {
> +	if (READ_ONCE(dev->driver_ready)) {
> +		/*
> +		 * The below virtio_synchronize_vqs() guarantees that any
> +		 * interrupt for this line arriving after
> +		 * virtio_synchronize_vqs() has completed is guaranteed to see
> +		 * driver_ready == false.
> +		 */
> +		WRITE_ONCE(dev->driver_ready, false);
> +		virtio_synchronize_vqs(dev);
> +	}
> +
>  	dev->config->reset(dev);
>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cfb028ca238e..a4592e55c9f8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2127,10 +2127,17 @@ static inline bool more_used(const struct vring_virtqueue *vq)
>  	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
>  }
>  
> -irqreturn_t vring_interrupt(int irq, void *_vq)
> +irqreturn_t vring_interrupt(int irq, void *v)
>  {
> +	struct virtqueue *_vq = v;
> +	struct virtio_device *vdev = _vq->vdev;
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	if (!READ_ONCE(vdev->driver_ready)) {


I am not sure why we need READ_ONCE here, it's done under lock.


Accrdingly, same thing above for READ_ONCE and WRITE_ONCE.


> +		dev_warn_once(&vdev->dev, "virtio vring IRQ raised before DRIVER_OK");
> +		return IRQ_NONE;
> +	}
> +
>  	if (!more_used(vq)) {
>  		pr_debug("virtqueue interrupt with no work for %p\n", vq);
>  		return IRQ_NONE;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 5464f398912a..dfa2638a293e 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -95,6 +95,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>   * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
>   * @config_enabled: configuration change reporting enabled
>   * @config_change_pending: configuration change reported while disabled
> + * @driver_ready: whehter the driver is ready (e.g for vring callbacks)
>   * @config_lock: protects configuration change reporting
>   * @dev: underlying device.
>   * @id: the device type identification (used to match it with a driver).
> @@ -109,6 +110,7 @@ struct virtio_device {
>  	bool failed;
>  	bool config_enabled;
>  	bool config_change_pending;
> +	bool driver_ready;
>  	spinlock_t config_lock;
>  	spinlock_t vqs_list_lock; /* Protects VQs list access */
>  	struct device dev;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 08b73d9bbff2..c9e207bf2c9c 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -246,6 +246,14 @@ void virtio_device_ready(struct virtio_device *dev)
>  {
>  	unsigned status = dev->config->get_status(dev);
>  
> +	virtio_synchronize_vqs(dev);
> +        /*
> +         * The above virtio_synchronize_vqs() make sure


makes sure

> +         * vring_interrupt() will see the driver specific setup if it
> +         * see driver_ready as true.

sees

> +         */
> +	WRITE_ONCE(dev->driver_ready, true);
> +
>  	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
