Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3E8C74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 09:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 010A7610E9;
	Tue, 21 Mar 2023 09:23:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 010A7610E9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NDBWYKfj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t9YPvjONXdlJ; Tue, 21 Mar 2023 09:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4257E60881;
	Tue, 21 Mar 2023 09:23:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4257E60881
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 125D3C0071;
	Tue, 21 Mar 2023 09:23:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D10D3C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A56BE81EE8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A56BE81EE8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NDBWYKfj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QgrsfGj_oVvu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:23:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FF6181EDD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9FF6181EDD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679390609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pn5brbGgNvIiwAbTr396tg4MWSNJ8Oc96gtsZGXUcYM=;
 b=NDBWYKfjlLIugD/7aSM/uSyMNmnVFDfb+c2GrNudcZo6PmuCrZhljGGOJQ5zKxrY7l3Ok4
 qSz/Nx8QmB8/XfkfIupuouv5CE23iJqJocAbmnsPRLQTNb/0wn6F1aFA3xT1Qdn2oWk0wB
 k3bnCOUbiPhjOFLLZlOsri8vct69quw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-eoN_3zTYONiIsjtB_dPzbQ-1; Tue, 21 Mar 2023 05:23:25 -0400
X-MC-Unique: eoN_3zTYONiIsjtB_dPzbQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 i3-20020a05600c354300b003edfa408811so2569407wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679390604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pn5brbGgNvIiwAbTr396tg4MWSNJ8Oc96gtsZGXUcYM=;
 b=iLN1Ui+M0yc0QQr3mARpyeQA91wT1fM7KqdYmpOkEQVRChLwO8L+CKvLziEqkDiFNC
 dYw6/rBNyN2HaH7aTDchWg59BK4PA+Nnt9n0vPr3lRbUgtCvZTAyoE9nfKocev+MTIFb
 7YL4ccD2AN2JMnnZP2qIEJy3GGWToAdymmYSiJzlXLfaT5XFHFIEWZT8KG0fA60rBAg5
 d//NarRimDyquTlD4KnZ/lyG+Mv2scRM7v57hroEINol8OimNWiShROfUSG2X4A2r7gh
 lgVnPTzPIqnVfEeWhWzeYqb4aV22po/7HVxvC5O5Z5zxykjLodDR54kHTlPCUJRoYabd
 CPRA==
X-Gm-Message-State: AO0yUKXjEThkuWit6424Y8cN1i9jM3fzdf65N5G7G9nh/cn0ON1nbFMW
 wptLqWaJGWemHobhBVZNqYJaS2XYS5t+x5oBw4t7wW4ZWbrBZIayBn6GIA5p4WtdcxVVQPizzqQ
 TAF9r2U9E6jViWDrnwY083UtJ28KjbCH6qoDLWOxMNQ==
X-Received: by 2002:a1c:6a08:0:b0:3ea:ed4d:38eb with SMTP id
 f8-20020a1c6a08000000b003eaed4d38ebmr1871986wmc.24.1679390604692; 
 Tue, 21 Mar 2023 02:23:24 -0700 (PDT)
X-Google-Smtp-Source: AK7set/5Sl5sP+nX8YGttWKA3yT06XBaU7ihGH43O5M3uoUtpcc9jFKpSMids9Me1PPqfY0eMN3yJA==
X-Received: by 2002:a1c:6a08:0:b0:3ea:ed4d:38eb with SMTP id
 f8-20020a1c6a08000000b003eaed4d38ebmr1871973wmc.24.1679390604390; 
 Tue, 21 Mar 2023 02:23:24 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 n1-20020a7bc5c1000000b003db03725e86sm13222630wmk.8.2023.03.21.02.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 02:23:24 -0700 (PDT)
Date: Tue, 21 Mar 2023 05:23:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Viktor Prutyanov <viktor@daynix.com>
Subject: Re: [PATCH v2] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <20230321050747-mutt-send-email-mst@kernel.org>
References: <20230320232115.1940587-1-viktor@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20230320232115.1940587-1-viktor@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, yan@daynix.com
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

On Tue, Mar 21, 2023 at 02:21:15AM +0300, Viktor Prutyanov wrote:
> According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
> indicates that the driver passes extra data along with the queue
> notifications.
> 
> In a split queue case, the extra data is 16-bit available index. In a
> packed queue case, the extra data is 1-bit wrap counter and 15-bit
> available index.
> 
> Add support for this feature for MMIO and PCI transports. Channel I/O
> transport will not accept this feature.
> 
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> ---
> 
>  v2: reject the feature in virtio_ccw, replace __le32 with u32
> 
>  drivers/s390/virtio/virtio_ccw.c   |  4 +---
>  drivers/virtio/virtio_mmio.c       | 15 ++++++++++++++-
>  drivers/virtio/virtio_pci_common.c | 10 ++++++++++
>  drivers/virtio/virtio_pci_common.h |  4 ++++
>  drivers/virtio/virtio_pci_legacy.c |  2 +-
>  drivers/virtio/virtio_pci_modern.c |  2 +-
>  drivers/virtio/virtio_ring.c       | 17 +++++++++++++++++
>  include/linux/virtio_ring.h        |  2 ++
>  include/uapi/linux/virtio_config.h |  6 ++++++
>  9 files changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index a10dbe632ef9..d72a59415527 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -789,9 +789,7 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
>  
>  static void ccw_transport_features(struct virtio_device *vdev)
>  {
> -	/*
> -	 * Currently nothing to do here.
> -	 */
> +	__virtio_clear_bit(vdev, VIRTIO_F_NOTIFICATION_DATA);
>  }
>  
>  static int virtio_ccw_finalize_features(struct virtio_device *vdev)
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 3ff746e3f24a..0e13da17fe0a 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -285,6 +285,19 @@ static bool vm_notify(struct virtqueue *vq)
>  	return true;
>  }
>  
> +static bool vm_notify_with_data(struct virtqueue *vq)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
> +	u32 data = vring_fill_notification_data(vq);
> +
> +	writel(data, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +
> +	return true;
> +}
> +
> +#define VM_NOTIFY(vdev) (__virtio_test_bit((vdev), VIRTIO_F_NOTIFICATION_DATA) \
> +	? vm_notify_with_data : vm_notify)
> +
>  /* Notify all virtqueues on an interrupt. */
>  static irqreturn_t vm_interrupt(int irq, void *opaque)
>  {
> @@ -397,7 +410,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
>  
>  	/* Create the vring */
>  	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
> -				 true, true, ctx, vm_notify, callback, name);
> +			true, true, ctx, VM_NOTIFY(vdev), callback, name);

I don't see why is this macro useful.



>  	if (!vq) {
>  		err = -ENOMEM;
>  		goto error_new_virtqueue;
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index a6c86f916dbd..535263abc2bd 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -43,6 +43,16 @@ bool vp_notify(struct virtqueue *vq)
>  	/* we write the queue's selector into the notification register to
>  	 * signal the other end */
>  	iowrite16(vq->index, (void __iomem *)vq->priv);
> +
> +	return true;
> +}
> +
> +bool vp_notify_with_data(struct virtqueue *vq)
> +{
> +	u32 data = vring_fill_notification_data(vq);
> +
> +	iowrite32(data, (void __iomem *)vq->priv);
> +
>  	return true;
>  }
>  
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 23112d84218f..9a7212dcbb32 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -105,6 +105,7 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
>  void vp_synchronize_vectors(struct virtio_device *vdev);
>  /* the notify function used when creating a virt queue */
>  bool vp_notify(struct virtqueue *vq);
> +bool vp_notify_with_data(struct virtqueue *vq);
>  /* the config->del_vqs() implementation */
>  void vp_del_vqs(struct virtio_device *vdev);
>  /* the config->find_vqs() implementation */
> @@ -114,6 +115,9 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  		struct irq_affinity *desc);
>  const char *vp_bus_name(struct virtio_device *vdev);
>  
> +#define VP_NOTIFY(vdev) (__virtio_test_bit((vdev), VIRTIO_F_NOTIFICATION_DATA) \
> +	? vp_notify : vp_notify_with_data)
> +
>  /* Setup the affinity for a virtqueue:
>   * - force the affinity for per vq vector
>   * - OR over all affinities for shared MSI
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2257f1b3d8ae..b98e994cae48 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -131,7 +131,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	vq = vring_create_virtqueue(index, num,
>  				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
>  				    true, false, ctx,
> -				    vp_notify, callback, name);
> +				    VP_NOTIFY(&vp_dev->vdev), callback, name);
>  	if (!vq)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 9e496e288cfa..7fcd8af5af7e 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -321,7 +321,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	vq = vring_create_virtqueue(index, num,
>  				    SMP_CACHE_BYTES, &vp_dev->vdev,
>  				    true, true, ctx,
> -				    vp_notify, callback, name);
> +				    VP_NOTIFY(&vp_dev->vdev), callback, name);
>  	if (!vq)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 723c4e29e1d3..5e9e1800bb6e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2699,6 +2699,21 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(vring_del_virtqueue);
>  
> +u32 vring_fill_notification_data(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 next;
> +
> +	if (vq->packed_ring)
> +		next = (vq->packed.next_avail_idx & ~(1 << 15)) |
> +			((u16)vq->packed.avail_wrap_counter << 15);

I don't think the cast is needed. Neither is () around << the second <<
here (first is needed because gcc chooses to complain: apparently it
considers bitwise and a math operation for some obscure reason).

> +	else
> +		next = virtio16_to_cpu(_vq->vdev, vq->split.vring.avail->idx);
> +
> +	return ((u32)next << 16) | _vq->index;

I don't think the cast is needed. Neither is () around << needed.

> +}
> +EXPORT_SYMBOL_GPL(vring_fill_notification_data);
> +

I'd inline this - it's on data path ...

>  /* Manipulates transport-specific feature bits. */
>  void vring_transport_features(struct virtio_device *vdev)
>  {

> @@ -2718,6 +2733,8 @@ void vring_transport_features(struct virtio_device *vdev)
>  			break;
>  		case VIRTIO_F_ORDER_PLATFORM:
>  			break;
> +		case VIRTIO_F_NOTIFICATION_DATA:
> +			break;
>  		default:
>  			/* We don't understand this bit. */
>  			__virtio_clear_bit(vdev, i);
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 8b8af1a38991..1f65d2f77012 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -101,4 +101,6 @@ void vring_del_virtqueue(struct virtqueue *vq);
>  void vring_transport_features(struct virtio_device *vdev);
>  
>  irqreturn_t vring_interrupt(int irq, void *_vq);
> +
> +u32 vring_fill_notification_data(struct virtqueue *_vq);
>  #endif /* _LINUX_VIRTIO_RING_H */
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 3c05162bc988..2c712c654165 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -99,6 +99,12 @@
>   */
>  #define VIRTIO_F_SR_IOV			37
>  
> +/*
> + * This feature indicates that the driver passes extra data (besides
> + * identifying the virtqueue) in its device notifications.
> + */
> +#define VIRTIO_F_NOTIFICATION_DATA	38
> +
>  /*
>   * This feature indicates that the driver can reset a queue individually.
>   */
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
