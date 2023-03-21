Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B89C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 02:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5DB75400F3;
	Tue, 21 Mar 2023 02:20:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5DB75400F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VMebjauCSeJj; Tue, 21 Mar 2023 02:20:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A90CB40AB9;
	Tue, 21 Mar 2023 02:20:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A90CB40AB9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68FCBC0071;
	Tue, 21 Mar 2023 02:20:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73900C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 489D240AB9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:20:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 489D240AB9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kCDxKKLRMA52
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:20:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AEE2400F3
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0AEE2400F3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:20:16 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0VeL2P0w_1679365210; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeL2P0w_1679365210) by smtp.aliyun-inc.com;
 Tue, 21 Mar 2023 10:20:11 +0800
Message-ID: <1679364946.2946873-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Date: Tue, 21 Mar 2023 10:15:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Viktor Prutyanov <viktor@daynix.com>
References: <20230320115451.1232171-1-viktor@daynix.com>
In-Reply-To: <20230320115451.1232171-1-viktor@daynix.com>
Cc: mst@redhat.com, viktor@daynix.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, yan@daynix.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 20 Mar 2023 14:54:51 +0300, Viktor Prutyanov <viktor@daynix.com> wrote:
> According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
> indicates that the driver passes extra data along with the queue
> notifications.
>
> In a split queue case, the extra data is 16-bit available index. In a
> packed queue case, the extra data is 1-bit wrap counter and 15-bit
> available index.
>
> Add support for this feature for both MMIO and PCI.
>
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> ---
>  drivers/virtio/virtio_mmio.c       | 15 ++++++++++++++-
>  drivers/virtio/virtio_pci_common.c | 10 ++++++++++
>  drivers/virtio/virtio_pci_common.h |  4 ++++
>  drivers/virtio/virtio_pci_legacy.c |  2 +-
>  drivers/virtio/virtio_pci_modern.c |  2 +-
>  drivers/virtio/virtio_ring.c       | 17 +++++++++++++++++
>  include/linux/virtio_ring.h        |  2 ++
>  include/uapi/linux/virtio_config.h |  6 ++++++
>  8 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 3ff746e3f24a..05da5ad7fc93 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -285,6 +285,19 @@ static bool vm_notify(struct virtqueue *vq)
>  	return true;
>  }
>
> +static bool vm_notify_with_data(struct virtqueue *vq)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
> +	__le32 data = vring_fill_notification_data(vq);
> +
> +	writel(data, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +
> +	return true;
> +}
> +
> +#define VM_NOTIFY(vdev) (__virtio_test_bit((vdev), VIRTIO_F_NOTIFICATION_DATA) \
> +	? vm_notify_with_data : vm_notify)


Is this macro necessary, it is only used once. And I don't recognize that this
logic is necessary to use macro.

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
>  	if (!vq) {
>  		err = -ENOMEM;
>  		goto error_new_virtqueue;
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index a6c86f916dbd..bf7daad9ce65 100644
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
> +	__le32 data = vring_fill_notification_data(vq);
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

I also think that this is not necessary, although it has been used twice.


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
> index 41144b5246a8..8de0800efee7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2752,6 +2752,21 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(vring_del_virtqueue);
>
> +__le32 vring_fill_notification_data(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 next;
> +
> +	if (vq->packed_ring)
> +		next = (vq->packed.next_avail_idx & ~(1 << 15)) |
> +			((u16)vq->packed.avail_wrap_counter << 15);
> +	else
> +		next = virtio16_to_cpu(_vq->vdev, vq->split.vring.avail->idx);
> +
> +	return cpu_to_le32(((u32)next << 16) | _vq->index);
> +}
> +EXPORT_SYMBOL_GPL(vring_fill_notification_data);
> +
>  /* Manipulates transport-specific feature bits. */
>  void vring_transport_features(struct virtio_device *vdev)
>  {
> @@ -2771,6 +2786,8 @@ void vring_transport_features(struct virtio_device *vdev)
>  			break;
>  		case VIRTIO_F_ORDER_PLATFORM:
>  			break;
> +		case VIRTIO_F_NOTIFICATION_DATA:
> +			break;
>  		default:
>  			/* We don't understand this bit. */
>  			__virtio_clear_bit(vdev, i);
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 8b95b69ef694..3222324fb244 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -117,4 +117,6 @@ void vring_del_virtqueue(struct virtqueue *vq);
>  void vring_transport_features(struct virtio_device *vdev);
>
>  irqreturn_t vring_interrupt(int irq, void *_vq);
> +
> +__le32 vring_fill_notification_data(struct virtqueue *_vq);
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


Although this patch is not large, I think it can be split:

* add VIRTIO_F_NOTIFICATION_DATA
* pci support
* mmio support


This is beneficial to backport.

Thanks.

>  /*
>   * This feature indicates that the driver can reset a queue individually.
>   */
> --
> 2.35.1
>
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
