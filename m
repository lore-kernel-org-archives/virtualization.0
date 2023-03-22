Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE942C6FD1F
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 16:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 607E183F7F;
	Wed, 22 Mar 2023 16:33:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 607E183F7F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bakL+k0J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQ_3WJbB7kE3; Wed, 22 Mar 2023 16:33:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6D1BE83F79;
	Wed, 22 Mar 2023 16:33:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D1BE83F79
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28771C0071;
	Wed, 22 Mar 2023 16:33:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE1EAC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DFA56147D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7DFA56147D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bakL+k0J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EVrkmouRS3ES
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:33:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 578F760F47
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 578F760F47
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679502829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QJecVcfDeB9AvnVOUiaYBAYVyBvQZaycdzteebP5lRE=;
 b=bakL+k0JZXXRl8mqvtbEiCJ35d2npK4sUPXua5bZUQKCyjV1jbiW6eQ7yzTA878xERskOw
 xxXQBSp2UNjvHsP6mNJlgAKaXivKPnLYgOKPCgQy2/fAw1KvqpQFKxQ0Jwn6XJggh2UI7V
 b41vxSIdi3HZhND7/naHpfPQk2Pq0ns=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-j30hPs_eNG6TXWyimn6Qgg-1; Wed, 22 Mar 2023 12:33:45 -0400
X-MC-Unique: j30hPs_eNG6TXWyimn6Qgg-1
Received: by mail-ed1-f71.google.com with SMTP id
 r19-20020a50aad3000000b005002e950cd3so28270450edc.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 09:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679502824;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJecVcfDeB9AvnVOUiaYBAYVyBvQZaycdzteebP5lRE=;
 b=Sz7w8YGcaWrCV94kVhIZlkMEWbzWni/7HliRGUV+CazlfJ4JspGjKeTAdKtfZjx3LI
 A2Q0p0R3CJA2p2vEY2TAfLDcC2na9cf4L/01yCjZpnlvym8LFxBTmgbZwMls8HHBAIju
 9qp2URw/6TLIV+bEpZ1Kex/xJCGemvSgvoNEZofFFmI3yU7zzI3NGv2oEaJcwU55ryy2
 ZdM7ercwKl0UTC4pB9BNK9eURNoHtcK9cUyLZbbwkoHcl2v5mBJWfKihl6OuquBAiOys
 JgHsxQZb4Wjd38D+HUXX9FOCzU9cJH9zJXuKsQ0cvxC91nJIYvJacYqxsI8piiS7YT8k
 wk7A==
X-Gm-Message-State: AO0yUKW/oSFZMxzTu3wwdqG5eu1avgXNnMWLJiBgtpwO75wpFUqnRdb6
 BUbcTgkOJktIpbB45Bljre/cjKQSoL9kLqpzO2gCISCNHKkTLK//L2lHg14Kg6O0bDj+Ql5Yp7J
 4A4fbCmHdJwe1Z+MjYxmiMQqSRTu0S9jM/5oVMBJcog==
X-Received: by 2002:a05:6402:3450:b0:4fb:b09e:4c8b with SMTP id
 l16-20020a056402345000b004fbb09e4c8bmr8092736edc.37.1679502824581; 
 Wed, 22 Mar 2023 09:33:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set9M+G7IvOcKsPkF2PZ5p9jcvcsxbrb2dSSVjG1ks76FS99d2TgF6NfDxf1TfwbO/9JGUnupWg==
X-Received: by 2002:a05:6402:3450:b0:4fb:b09e:4c8b with SMTP id
 l16-20020a056402345000b004fbb09e4c8bmr8092708edc.37.1679502824236; 
 Wed, 22 Mar 2023 09:33:44 -0700 (PDT)
Received: from redhat.com ([2.52.143.71]) by smtp.gmail.com with ESMTPSA id
 g25-20020a50d0d9000000b00501c2a9e16dsm5065522edf.74.2023.03.22.09.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Mar 2023 09:33:43 -0700 (PDT)
Date: Wed, 22 Mar 2023 12:33:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Viktor Prutyanov <viktor@daynix.com>
Subject: Re: [PATCH v4] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <20230322123121-mutt-send-email-mst@kernel.org>
References: <20230322141031.2211141-1-viktor@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20230322141031.2211141-1-viktor@daynix.com>
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

On Wed, Mar 22, 2023 at 05:10:31PM +0300, Viktor Prutyanov wrote:
> According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
> indicates that the driver passes extra data along with the queue
> notifications.
> 
> In a split queue case, the extra data is 16-bit available index. In a
> packed queue case, the extra data is 1-bit wrap counter and 15-bit
> available index.
> 
> Add support for this feature for MMIO, channel I/O and modern PCI
> transports.
> 
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> ---
>  v4: remove VP_NOTIFY macro and legacy PCI support, add
>     virtio_ccw_kvm_notify_with_data to virtio_ccw
>  v3: support feature in virtio_ccw, remove VM_NOTIFY, use avail_idx_shadow,
>     remove byte swap, rename to vring_notification_data
>  v2: reject the feature in virtio_ccw, replace __le32 with u32
> 
>  Tested with disabled VIRTIO_F_NOTIFICATION_DATA on qemu-system-s390x
>  (virtio-blk-ccw), qemu-system-riscv64 (virtio-blk-device,
>  virtio-rng-device), qemu-system-x86_64 (virtio-blk-pci, virtio-net-pci)
>  to make sure nothing is broken.
>  Tested with enabled VIRTIO_F_NOTIFICATION_DATA on 64-bit RISC-V Linux
>  and my hardware implementation of virtio-rng.

what did you test? virtio pci? mmio? guessing not ccw...

Cornelia could you hack up something to quickly test ccw?

>  drivers/s390/virtio/virtio_ccw.c   | 19 ++++++++++++++++---
>  drivers/virtio/virtio_mmio.c       | 14 +++++++++++++-
>  drivers/virtio/virtio_pci_modern.c | 13 ++++++++++++-
>  drivers/virtio/virtio_ring.c       | 17 +++++++++++++++++
>  include/linux/virtio_ring.h        |  2 ++
>  include/uapi/linux/virtio_config.h |  6 ++++++
>  6 files changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 954fc31b4bc7..3619676effb8 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -391,7 +391,7 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
>  	ccw_device_dma_free(vcdev->cdev, thinint_area, sizeof(*thinint_area));
>  }
>  
> -static bool virtio_ccw_kvm_notify(struct virtqueue *vq)
> +static inline bool virtio_ccw_do_kvm_notify(struct virtqueue *vq, u32 data)
>  {
>  	struct virtio_ccw_vq_info *info = vq->priv;
>  	struct virtio_ccw_device *vcdev;
> @@ -402,12 +402,22 @@ static bool virtio_ccw_kvm_notify(struct virtqueue *vq)
>  	BUILD_BUG_ON(sizeof(struct subchannel_id) != sizeof(unsigned int));
>  	info->cookie = kvm_hypercall3(KVM_S390_VIRTIO_CCW_NOTIFY,
>  				      *((unsigned int *)&schid),
> -				      vq->index, info->cookie);
> +				      data, info->cookie);
>  	if (info->cookie < 0)
>  		return false;
>  	return true;
>  }
>  
> +static bool virtio_ccw_kvm_notify(struct virtqueue *vq)
> +{
> +	return virtio_ccw_do_kvm_notify(vq, vq->index);
> +}
> +
> +static bool virtio_ccw_kvm_notify_with_data(struct virtqueue *vq)
> +{
> +	return virtio_ccw_do_kvm_notify(vq, vring_notification_data(vq));
> +}
> +
>  static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
>  				   struct ccw1 *ccw, int index)
>  {
> @@ -501,6 +511,9 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
>  	u64 queue;
>  	unsigned long flags;
>  	bool may_reduce;
> +	bool (*notify)(struct virtqueue *vq) = __virtio_test_bit(vdev,
> +		VIRTIO_F_NOTIFICATION_DATA) ?
> +		virtio_ccw_kvm_notify_with_data : virtio_ccw_kvm_notify;
>  
>  	/* Allocate queue. */
>  	info = kzalloc(sizeof(struct virtio_ccw_vq_info), GFP_KERNEL);
> @@ -524,7 +537,7 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
>  	may_reduce = vcdev->revision > 0;
>  	vq = vring_create_virtqueue(i, info->num, KVM_VIRTIO_CCW_RING_ALIGN,
>  				    vdev, true, may_reduce, ctx,
> -				    virtio_ccw_kvm_notify, callback, name);
> +				    notify, callback, name);
>  
>  	if (!vq) {
>  		/* For now, we fail if we can't get the requested size. */
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 3ff746e3f24a..7c16e622c33d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.cv
> @@ -285,6 +285,16 @@ static bool vm_notify(struct virtqueue *vq)
>  	return true;
>  }
>  
> +static bool vm_notify_with_data(struct virtqueue *vq)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
> +	u32 data = vring_notification_data(vq);
> +
> +	writel(data, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +
> +	return true;
> +}
> +
>  /* Notify all virtqueues on an interrupt. */
>  static irqreturn_t vm_interrupt(int irq, void *opaque)
>  {
> @@ -368,6 +378,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
>  	unsigned long flags;
>  	unsigned int num;
>  	int err;
> +	bool (*notify)(struct virtqueue *vq) = __virtio_test_bit(vdev,
> +		VIRTIO_F_NOTIFICATION_DATA) ? vm_notify_with_data : vm_notify;
>  
>  	if (!name)
>  		return NULL;
> @@ -397,7 +409,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
>  
>  	/* Create the vring */
>  	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
> -				 true, true, ctx, vm_notify, callback, name);
> +				 true, true, ctx, notify, callback, name);
>  	if (!vq) {
>  		err = -ENOMEM;
>  		goto error_new_virtqueue;
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 9e496e288cfa..9cc56f463dba 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -288,6 +288,15 @@ static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>  	return vp_modern_config_vector(&vp_dev->mdev, vector);
>  }
>  
> +static bool vp_notify_with_data(struct virtqueue *vq)
> +{
> +	u32 data = vring_notification_data(vq);
> +
> +	iowrite32(data, (void __iomem *)vq->priv);
> +
> +	return true;
> +}
> +
>  static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  				  struct virtio_pci_vq_info *info,
>  				  unsigned int index,
> @@ -301,6 +310,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	struct virtqueue *vq;
>  	u16 num;
>  	int err;
> +	bool (*notify)(struct virtqueue *vq) = __virtio_test_bit(&vp_dev->vdev,
> +		VIRTIO_F_NOTIFICATION_DATA) ? vp_notify_with_data : vp_notify;
>  
>  	if (index >= vp_modern_get_num_queues(mdev))
>  		return ERR_PTR(-EINVAL);
> @@ -321,7 +332,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	vq = vring_create_virtqueue(index, num,
>  				    SMP_CACHE_BYTES, &vp_dev->vdev,
>  				    true, true, ctx,
> -				    vp_notify, callback, name);
> +				    notify, callback, name);
>  	if (!vq)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4c3bb0ddeb9b..837875cc3190 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2752,6 +2752,21 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(vring_del_virtqueue);
>  
> +u32 vring_notification_data(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 next;
> +
> +	if (vq->packed_ring)
> +		next = (vq->packed.next_avail_idx & ~(1 << 15)) |
> +			vq->packed.avail_wrap_counter << 15;
> +	else
> +		next = vq->split.avail_idx_shadow;
> +
> +	return next << 16 | _vq->index;
> +}
> +EXPORT_SYMBOL_GPL(vring_notification_data);
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
> index 8b95b69ef694..2550c9170f4f 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -117,4 +117,6 @@ void vring_del_virtqueue(struct virtqueue *vq);
>  void vring_transport_features(struct virtio_device *vdev);
>  
>  irqreturn_t vring_interrupt(int irq, void *_vq);
> +
> +u32 vring_notification_data(struct virtqueue *_vq);
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
