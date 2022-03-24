Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F55C433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 11:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0E8060EAB;
	Thu, 24 Mar 2022 11:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YbynkHhTmnUD; Thu, 24 Mar 2022 11:03:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 32CB960E90;
	Thu, 24 Mar 2022 11:03:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14FBEC001A;
	Thu, 24 Mar 2022 11:03:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4191FC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2893260E92
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zvfzUvj4PZI5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:03:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1755060E90
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648119792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PYjq1ynKk1XjU7AutCMoihkQ2UvFoHsHLt+jhZb03Qw=;
 b=VtL9sjCK+puRvuMAJZ6zCSS76la0ZHVhJOZPckqxB9pfsk0xg4tbjTNjtDIxnvNl8h0dni
 qrcOxWXftGTMTANMeSxPqlu1z6Up86leFdwqBZm/g8B4J/T6zXvISA6n43NfySiXM3s2jd
 qGke4Vm+J43vN3x/+gCMvBz6zd3A9CQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-LV_VQYzpPvypITFRJZ0iPQ-1; Thu, 24 Mar 2022 07:03:11 -0400
X-MC-Unique: LV_VQYzpPvypITFRJZ0iPQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 i6-20020a05600c354600b0038be262d9d9so3889069wmq.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 04:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PYjq1ynKk1XjU7AutCMoihkQ2UvFoHsHLt+jhZb03Qw=;
 b=PXqyUPcfcUBz57Ll0vUOHWJmvOCxdcAxvm2fPQegBp/IAd0XpOMXgdlG9JmQx0k85t
 ibc2PJKiYxw1T9NmzYeLwsGBw3QTU66eg3ybp8kULkDKaDR0HqRTtF9PKo14tbjxUUWp
 xugyRojTWWE9Fumop0X8miyLJ6ijbzoezfCwOlw2TJHWlgRD4f5U+RchYEM2NGz+KHDp
 t/flJ5adKZY0K9qrk2225NJtBVh+DpYP/+IxoQYe/G2z59wr7dFWs8ufcHPC/fc+/TTz
 syGhpQ0VzAsxE6Y3SmdZtVEvmoy5KXRv6L3RVSjoMIFc7trbBZLgi4jqdoGw9Lkgd5pm
 le3Q==
X-Gm-Message-State: AOAM531b+HtIzjJcgtDXW/ueN28BGVAgSbMK5oCpCsV8smdg71f1cpxB
 Oav7oLUE72U55aMCjUpu/jvOfUiUVjUReqYVQznzOUttS43ojBtlu8LFxM5c6A9n8YJGFLGybEE
 6PuuHizuV45mJd8lgdb+pXnWbeGY/rkRDPyADmIRa4g==
X-Received: by 2002:a05:6000:1541:b0:204:18f1:f6b5 with SMTP id
 1-20020a056000154100b0020418f1f6b5mr4213203wry.485.1648119790290; 
 Thu, 24 Mar 2022 04:03:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUXsiKJYPEKCQrlyZYEBh9xhpuywKFuEOOoO4mOILC6M1EemI4TKKNXI52MftdYhlP1Wn3Pw==
X-Received: by 2002:a05:6000:1541:b0:204:18f1:f6b5 with SMTP id
 1-20020a056000154100b0020418f1f6b5mr4213178wry.485.1648119789964; 
 Thu, 24 Mar 2022 04:03:09 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c12c800b0038cc2b67c97sm1681308wmd.19.2022.03.24.04.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 04:03:06 -0700 (PDT)
Date: Thu, 24 Mar 2022 07:03:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/3] virtio: harden vring IRQ
Message-ID: <20220324064849-mutt-send-email-mst@kernel.org>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-4-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220324084004.14349-4-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: peterz@infradead.org, maz@kernel.org, keirf@google.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

On Thu, Mar 24, 2022 at 04:40:04PM +0800, Jason Wang wrote:
> This is a rework on the previous IRQ hardening that is done for
> virtio-pci where several drawbacks were found and were reverted:
> 
> 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
>    that is used by some device such as virtio-blk
> 2) done only for PCI transport
> 
> In this patch, we tries to borrow the idea from the INTX IRQ hardening
> in the reverted commit 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
> by introducing a global irq_soft_enabled variable for each
> virtio_device. Then we can to toggle it during
> virtio_reset_device()/virtio_device_ready(). A synchornize_rcu() is
> used in virtio_reset_device() to synchronize with the IRQ handlers. In
> the future, we may provide config_ops for the transport that doesn't
> use IRQ. With this, vring_interrupt() can return check and early if
> irq_soft_enabled is false. This lead to smp_load_acquire() to be used
> but the cost should be acceptable.

Maybe it should be but is it? Can't we use synchronize_irq instead?

> 
> To avoid breaking legacy device which can send IRQ before DRIVER_OK, a
> module parameter is introduced to enable the hardening so function
> hardening is disabled by default.

Which devices are these? How come they send an interrupt before there
are any buffers in any queues?

> 
> Note that the hardening is only done for vring interrupt since the
> config interrupt hardening is already done in commit 22b7050a024d7
> ("virtio: defer config changed notifications"). But the method that is
> used by config interrupt can't be reused by the vring interrupt
> handler because it uses spinlock to do the synchronization which is
> expensive.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


> ---
>  drivers/virtio/virtio.c       | 19 +++++++++++++++++++
>  drivers/virtio/virtio_ring.c  |  9 ++++++++-
>  include/linux/virtio.h        |  4 ++++
>  include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
>  4 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 8dde44ea044a..85e331efa9cc 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -7,6 +7,12 @@
>  #include <linux/of.h>
>  #include <uapi/linux/virtio_ids.h>
>  
> +static bool irq_hardening = false;
> +
> +module_param(irq_hardening, bool, 0444);
> +MODULE_PARM_DESC(irq_hardening,
> +		 "Disalbe IRQ software processing when it is not expected");
> +
>  /* Unique numbering for virtio devices. */
>  static DEFINE_IDA(virtio_index_ida);
>  
> @@ -220,6 +226,15 @@ static int virtio_features_ok(struct virtio_device *dev)
>   * */
>  void virtio_reset_device(struct virtio_device *dev)
>  {
> +	/*
> +	 * The below synchronize_rcu() guarantees that any
> +	 * interrupt for this line arriving after
> +	 * synchronize_rcu() has completed is guaranteed to see
> +	 * irq_soft_enabled == false.

News to me I did not know synchronize_rcu has anything to do
with interrupts. Did not you intend to use synchronize_irq?
I am not even 100% sure synchronize_rcu is by design a memory barrier
though it's most likely is ...

> +	 */
> +	WRITE_ONCE(dev->irq_soft_enabled, false);
> +	synchronize_rcu();
> +
>  	dev->config->reset(dev);
>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);

Please add comment explaining where it will be enabled.
Also, we *really* don't need to synch if it was already disabled,
let's not add useless overhead to the boot sequence.


> @@ -427,6 +442,10 @@ int register_virtio_device(struct virtio_device *dev)
>  	spin_lock_init(&dev->config_lock);
>  	dev->config_enabled = false;
>  	dev->config_change_pending = false;
> +	dev->irq_soft_check = irq_hardening;
> +
> +	if (dev->irq_soft_check)
> +		dev_info(&dev->dev, "IRQ hardening is enabled\n");
>  
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */

one of the points of hardening is it's also helpful for buggy
devices. this flag defeats the purpose.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 962f1477b1fa..0170f8c784d8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2144,10 +2144,17 @@ static inline bool more_used(const struct vring_virtqueue *vq)
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
> +	if (!virtio_irq_soft_enabled(vdev)) {
> +		dev_warn_once(&vdev->dev, "virtio vring IRQ raised before DRIVER_OK");
> +		return IRQ_NONE;
> +	}
> +
>  	if (!more_used(vq)) {
>  		pr_debug("virtqueue interrupt with no work for %p\n", vq);
>  		return IRQ_NONE;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 5464f398912a..957d6ad604ac 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -95,6 +95,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>   * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
>   * @config_enabled: configuration change reporting enabled
>   * @config_change_pending: configuration change reported while disabled
> + * @irq_soft_check: whether or not to check @irq_soft_enabled
> + * @irq_soft_enabled: callbacks enabled
>   * @config_lock: protects configuration change reporting
>   * @dev: underlying device.
>   * @id: the device type identification (used to match it with a driver).
> @@ -109,6 +111,8 @@ struct virtio_device {
>  	bool failed;
>  	bool config_enabled;
>  	bool config_change_pending;
> +	bool irq_soft_check;
> +	bool irq_soft_enabled;
>  	spinlock_t config_lock;
>  	spinlock_t vqs_list_lock; /* Protects VQs list access */
>  	struct device dev;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index dafdc7f48c01..9c1b61f2e525 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -174,6 +174,24 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
>  	return __virtio_test_bit(vdev, fbit);
>  }
>  
> +/*
> + * virtio_irq_soft_enabled: whether we can execute callbacks
> + * @vdev: the device
> + */
> +static inline bool virtio_irq_soft_enabled(const struct virtio_device *vdev)
> +{
> +	if (!vdev->irq_soft_check)
> +		return true;
> +
> +	/*
> +	 * Read irq_soft_enabled before reading other device specific
> +	 * data. Paried with smp_store_relase() in

paired

> +	 * virtio_device_ready() and WRITE_ONCE()/synchronize_rcu() in
> +	 * virtio_reset_device().
> +	 */
> +	return smp_load_acquire(&vdev->irq_soft_enabled);
> +}
> +
>  /**
>   * virtio_has_dma_quirk - determine whether this device has the DMA quirk
>   * @vdev: the device
> @@ -236,6 +254,13 @@ void virtio_device_ready(struct virtio_device *dev)
>  	if (dev->config->enable_cbs)
>                    dev->config->enable_cbs(dev);
>  
> +	/*
> +	 * Commit the driver setup before enabling the virtqueue
> +	 * callbacks. Paried with smp_load_acuqire() in
> +	 * virtio_irq_soft_enabled()
> +	 */
> +	smp_store_release(&dev->irq_soft_enabled, true);
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
