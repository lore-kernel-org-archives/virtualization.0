Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898D7C433FE
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 04:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 425D283104;
	Wed, 16 Feb 2022 04:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vp0IGcW2r-FC; Wed, 16 Feb 2022 04:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B5B8182572;
	Wed, 16 Feb 2022 04:14:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E0DDC001A;
	Wed, 16 Feb 2022 04:14:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0030C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCD4F41671
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PFSJNoTTcXi5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 107DB41632
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644984881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5w2uW0K8wt8YIL54HfUFFaak3oCnnb6qVxJPmyS2e8=;
 b=Rx8pLQgeT3++vehtBYta7eiuke3GuBoQpf5JAiRzPArW/rtLoh6624IgEs6WpBRiaDjzZq
 qDwm7P3Xzak5lU0j4sIFosoUWCnML8UB3dUVKCZMWvTvflOXdYGDssfrJ6Tj/1h6fHCqyg
 OuJg87O7tJHMiadL/5ZUIioRWwDH1kU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-x7EkNJB1M8yoLYmrJQnYtw-1; Tue, 15 Feb 2022 23:14:37 -0500
X-MC-Unique: x7EkNJB1M8yoLYmrJQnYtw-1
Received: by mail-lj1-f197.google.com with SMTP id
 bx17-20020a05651c199100b00244b2f9b56cso438438ljb.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 20:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G5w2uW0K8wt8YIL54HfUFFaak3oCnnb6qVxJPmyS2e8=;
 b=XVaOwGPk/zExf0PgoFeror8bmHv7MMvJlXlDXxSqn/POEyPQFSh5+dCixfc2PKW+p4
 9uhbKwofGsafPCTgOjeVbTvug1N+6pJE1ol16keCN+SlyJ3eYZYhzoW1NgF43ktowVJp
 YMn1zrTE8i7dqfRfnNPFHlN96yaP+qq/quVZMp8IruKqy8LCu+pc0g54fYTlbn9KxpQi
 Ztc6SGhQYZTkwUeXRQFtgKRfTDMWhujd4WJgGZ8K/S3NlKbNdcTcZ0OsZYf1MGdukHwk
 vTZxp3RGhnIw1wpYwzuk7PHqJhh03MH+PXhOvza4GHzV+I/0KkqqpWRPc/f7Z5iSvMsP
 tq1w==
X-Gm-Message-State: AOAM5332UaSoTJLVZzAZHe9JJkkuKAQ7hm0hw59J+1mBOgufHvtFgO0q
 JJdN9kjCca4O4PTbI0ObmjtKN8/PGO2Qk79fAzYqRIGeSw7egtx5dD2KLApJjMueJ2XZS73XQcW
 frFbT7qbLyY6nhGj8JyIpRGNebSEjw0ZpyI2yLYUUMkZoKR3UeMgq/yPrXw==
X-Received: by 2002:a05:6512:6c4:b0:437:9409:984c with SMTP id
 u4-20020a05651206c400b004379409984cmr643934lff.199.1644984876365; 
 Tue, 15 Feb 2022 20:14:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/SqMXMDdMcIvR51eq7JJhxSJJb6Pttay4oaaNdt54PJd6gjA9wLfdB4T2eVF9iBibNdyuf8KnPMvEU6ZpUOE=
X-Received: by 2002:a05:6512:6c4:b0:437:9409:984c with SMTP id
 u4-20020a05651206c400b004379409984cmr643915lff.199.1644984876132; Tue, 15 Feb
 2022 20:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-15-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220214081416.117695-15-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Feb 2022 12:14:25 +0800
Message-ID: <CACGkMEufh3sbGx4wFCkpiXNR0w0WoCC=TNeLHE+QkqrhyXH6Bw@mail.gmail.com>
Subject: Re: [PATCH v5 14/22] virtio_pci: queue_reset: support
 VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> This patch implements virtio pci support for QUEUE RESET.
>
> Performing reset on a queue is divided into these steps:
>
> 1. reset_vq: reset one vq
> 2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> 3. release the ring of the vq by vring_release_virtqueue()
> 4. enable_reset_vq: re-enable the reset queue
>
> This patch implements reset_vq, enable_reset_vq in the pci scenario.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_pci_common.c |  8 ++--
>  drivers/virtio/virtio_pci_modern.c | 60 ++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 5a4f750a0b97..9ea319b1d404 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -255,9 +255,11 @@ static void vp_del_vq(struct virtqueue *vq)
>         struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
>         unsigned long flags;
>
> -       spin_lock_irqsave(&vp_dev->lock, flags);
> -       list_del(&info->node);
> -       spin_unlock_irqrestore(&vp_dev->lock, flags);
> +       if (!vq->reset) {
> +               spin_lock_irqsave(&vp_dev->lock, flags);
> +               list_del(&info->node);
> +               spin_unlock_irqrestore(&vp_dev->lock, flags);
> +       }
>
>         vp_dev->del_vq(info);
>         kfree(info);
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index bed3e9b84272..7d28f4c36fc2 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -34,6 +34,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>         if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
>                         pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
>                 __virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> +
> +       if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> +               __virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
>  }
>
>  /* virtio config->finalize_features() implementation */
> @@ -176,6 +179,59 @@ static void vp_reset(struct virtio_device *vdev)
>         vp_disable_cbs(vdev);
>  }
>
> +static int vp_modern_reset_vq(struct virtqueue *vq)
> +{
> +       struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +       struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> +       struct virtio_pci_vq_info *info;
> +       unsigned long flags;
> +
> +       if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
> +               return -ENOENT;
> +
> +       vp_modern_set_queue_reset(mdev, vq->index);
> +
> +       info = vp_dev->vqs[vq->index];
> +

Any reason that we don't need to disable irq here as the previous versions did?


> +       /* delete vq from irq handler */
> +       spin_lock_irqsave(&vp_dev->lock, flags);
> +       list_del(&info->node);
> +       spin_unlock_irqrestore(&vp_dev->lock, flags);
> +
> +       INIT_LIST_HEAD(&info->node);
> +
> +       vq->reset = VIRTQUEUE_RESET_STAGE_DEVICE;
> +
> +       return 0;
> +}
> +
> +static int vp_modern_enable_reset_vq(struct virtqueue *vq)
> +{
> +       struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +       struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> +       struct virtio_pci_vq_info *info;
> +       struct virtqueue *_vq;
> +
> +       if (vq->reset != VIRTQUEUE_RESET_STAGE_RELEASE)
> +               return -EBUSY;
> +
> +       /* check queue reset status */
> +       if (vp_modern_get_queue_reset(mdev, vq->index) != 1)
> +               return -EBUSY;
> +
> +       info = vp_dev->vqs[vq->index];
> +       _vq = vp_setup_vq(vq->vdev, vq->index, NULL, NULL, NULL,
> +                        info->msix_vector);

So we only care about moden devices, this means using vp_setup_vq()
with NULL seems tricky.

As replied in another thread, I would simply ask the caller to call
the vring reallocation helper. See the reply for patch 17.

Thanks


> +       if (IS_ERR(_vq)) {
> +               vq->reset = VIRTQUEUE_RESET_STAGE_RELEASE;
> +               return PTR_ERR(_vq);
> +       }
> +
> +       vp_modern_set_queue_enable(&vp_dev->mdev, vq->index, true);
> +
> +       return 0;
> +}
> +
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>  {
>         return vp_modern_config_vector(&vp_dev->mdev, vector);
> @@ -397,6 +453,8 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>         .set_vq_affinity = vp_set_vq_affinity,
>         .get_vq_affinity = vp_get_vq_affinity,
>         .get_shm_region  = vp_get_shm_region,
> +       .reset_vq        = vp_modern_reset_vq,
> +       .enable_reset_vq = vp_modern_enable_reset_vq,
>  };
>
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -415,6 +473,8 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>         .set_vq_affinity = vp_set_vq_affinity,
>         .get_vq_affinity = vp_get_vq_affinity,
>         .get_shm_region  = vp_get_shm_region,
> +       .reset_vq        = vp_modern_reset_vq,
> +       .enable_reset_vq = vp_modern_enable_reset_vq,
>  };
>
>  /* the PCI probing function */
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
