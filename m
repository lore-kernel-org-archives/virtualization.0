Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33831C433F5
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 07:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFE736F60F;
	Thu, 17 Feb 2022 07:25:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vrhr7QkYMC0G; Thu, 17 Feb 2022 07:25:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B2666F525;
	Thu, 17 Feb 2022 07:25:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11068C002D;
	Thu, 17 Feb 2022 07:25:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2834C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1CE46F60F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:25:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pmOhgA09TqCq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:25:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCFBF6F525
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645082726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sNlRlH2sR1zEEfEZx3VUbIdvRvCNZdqDLBN9MKRUPII=;
 b=XaEap0WseHL/k1FU+1xsW7x8cl07ryMLVOVVmaILeQrJKjvgaLnpyjDE8OckkqtYKDBycX
 wupynFhNK1kUJSW8JIDjIjSBwNc5WGYz2q2wnvlNGSMZqvardPPUGr61PTUQbSF8x3ojPc
 4Q3ltUXq9yiVe7V7dEPVkPuh1khBnaA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-kOq6FcrkOMCzlod4eZUBMg-1; Thu, 17 Feb 2022 02:25:25 -0500
X-MC-Unique: kOq6FcrkOMCzlod4eZUBMg-1
Received: by mail-lf1-f69.google.com with SMTP id
 w25-20020a05651234d900b0044023ac3f64so1531238lfr.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 23:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sNlRlH2sR1zEEfEZx3VUbIdvRvCNZdqDLBN9MKRUPII=;
 b=6W9u9qYSASSYgNNhGJSVl/OX+KmZIslNMLlL3iEgpwK9Q3yanyGAi5vJ4DQHYgdMgS
 sSx4KRXD71mVg5gBGC5HnpgX5y3SfQGwJaPPng4KHskzzjZ9O1hSUobMwCbvvRZdGBUO
 boo3Vcfuv82MFuliCP1eNcdVOYiXl9Dd4mpu1eYjg+fvAuKC5LMH5PKjRGLpyDQkbvxp
 X2u1xtCN1Pzw8auW26Gvc/jD91u5fZT+3JFtmZUF8JnY1+6442L/huUiT9gFKfbxV6Xg
 KWGOxuCyAS7W5dFqXrRUW4IHWUWNv5wF2uQnb3AZyeS44WbucYMinyCH/dWLnu7/vHiq
 eSFA==
X-Gm-Message-State: AOAM530HuevKRgmG0yWD1swS8lElIn7qwNA3rfEW/jQD3XtV60R3pwbq
 CQ3TbPKbXX3HjZYMb2/X2CYszDoL+0ah3e4BUeQAkZhcRIhkEr0xAq4oARHfycolta20Umde7sB
 nIC6ls9kpdwVfjZNAtR5C6ei/X/t79MthAoWx3nhOvyUJzUrggAveR21v5w==
X-Received: by 2002:a05:6512:2205:b0:443:7f91:7aaa with SMTP id
 h5-20020a056512220500b004437f917aaamr1219249lfu.580.1645082723662; 
 Wed, 16 Feb 2022 23:25:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwR8xJrhWSFtYs+Sy66tR0N8p/P8you8W1THZDoS8h2O9oP1Ma/wA/ffCoJjTgZG+XZOmctzCbIL/u5foLKP5w=
X-Received: by 2002:a05:6512:2205:b0:443:7f91:7aaa with SMTP id
 h5-20020a056512220500b004437f917aaamr1219224lfu.580.1645082723354; Wed, 16
 Feb 2022 23:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-15-xuanzhuo@linux.alibaba.com>
 <CACGkMEufh3sbGx4wFCkpiXNR0w0WoCC=TNeLHE+QkqrhyXH6Bw@mail.gmail.com>
 <1644998595.3309107-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644998595.3309107-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Feb 2022 15:25:12 +0800
Message-ID: <CACGkMEtdQXEW9K4j13NMVOxsURCD8bWiBy3u7v5dUu8Ymgx_MA@mail.gmail.com>
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

On Wed, Feb 16, 2022 at 4:08 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 16 Feb 2022 12:14:25 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > This patch implements virtio pci support for QUEUE RESET.
> > >
> > > Performing reset on a queue is divided into these steps:
> > >
> > > 1. reset_vq: reset one vq
> > > 2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> > > 3. release the ring of the vq by vring_release_virtqueue()
> > > 4. enable_reset_vq: re-enable the reset queue
> > >
> > > This patch implements reset_vq, enable_reset_vq in the pci scenario.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_pci_common.c |  8 ++--
> > >  drivers/virtio/virtio_pci_modern.c | 60 ++++++++++++++++++++++++++++++
> > >  2 files changed, 65 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > index 5a4f750a0b97..9ea319b1d404 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -255,9 +255,11 @@ static void vp_del_vq(struct virtqueue *vq)
> > >         struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
> > >         unsigned long flags;
> > >
> > > -       spin_lock_irqsave(&vp_dev->lock, flags);
> > > -       list_del(&info->node);
> > > -       spin_unlock_irqrestore(&vp_dev->lock, flags);
> > > +       if (!vq->reset) {
> > > +               spin_lock_irqsave(&vp_dev->lock, flags);
> > > +               list_del(&info->node);
> > > +               spin_unlock_irqrestore(&vp_dev->lock, flags);
> > > +       }
> > >
> > >         vp_dev->del_vq(info);
> > >         kfree(info);
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > index bed3e9b84272..7d28f4c36fc2 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -34,6 +34,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
> > >         if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
> > >                         pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
> > >                 __virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> > > +
> > > +       if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> > > +               __virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
> > >  }
> > >
> > >  /* virtio config->finalize_features() implementation */
> > > @@ -176,6 +179,59 @@ static void vp_reset(struct virtio_device *vdev)
> > >         vp_disable_cbs(vdev);
> > >  }
> > >
> > > +static int vp_modern_reset_vq(struct virtqueue *vq)
> > > +{
> > > +       struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> > > +       struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> > > +       struct virtio_pci_vq_info *info;
> > > +       unsigned long flags;
> > > +
> > > +       if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
> > > +               return -ENOENT;
> > > +
> > > +       vp_modern_set_queue_reset(mdev, vq->index);
> > > +
> > > +       info = vp_dev->vqs[vq->index];
> > > +
> >
> > Any reason that we don't need to disable irq here as the previous versions did?
>
> Based on the spec, for the case of one interrupt per queue, there will be no
> more interrupts after the reset queue operation. Whether the interrupt is turned
> off or not has no effect. I turned off the interrupt before just to be safe.

So:

1) CPU0 -> get an interrupt
2) CPU1 -> vp_modern_reset_vq
2) CPU0 -> do_IRQ()

We still need to synchronize with the irq handler in this case?

Thanks

>
> And for irq sharing scenarios, I don't want to turn off shared interrupts for a
> queue.
>
> And the following list_del has been guaranteed to be safe, so I removed the code
> for closing interrupts in the previous version.
>
> Thanks.
>
> >
> >
> > > +       /* delete vq from irq handler */
> > > +       spin_lock_irqsave(&vp_dev->lock, flags);
> > > +       list_del(&info->node);
> > > +       spin_unlock_irqrestore(&vp_dev->lock, flags);
> > > +
> > > +       INIT_LIST_HEAD(&info->node);
> > > +
> > > +       vq->reset = VIRTQUEUE_RESET_STAGE_DEVICE;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int vp_modern_enable_reset_vq(struct virtqueue *vq)
> > > +{
> > > +       struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> > > +       struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> > > +       struct virtio_pci_vq_info *info;
> > > +       struct virtqueue *_vq;
> > > +
> > > +       if (vq->reset != VIRTQUEUE_RESET_STAGE_RELEASE)
> > > +               return -EBUSY;
> > > +
> > > +       /* check queue reset status */
> > > +       if (vp_modern_get_queue_reset(mdev, vq->index) != 1)
> > > +               return -EBUSY;
> > > +
> > > +       info = vp_dev->vqs[vq->index];
> > > +       _vq = vp_setup_vq(vq->vdev, vq->index, NULL, NULL, NULL,
> > > +                        info->msix_vector);
> >
> > So we only care about moden devices, this means using vp_setup_vq()
> > with NULL seems tricky.
> >
> > As replied in another thread, I would simply ask the caller to call
> > the vring reallocation helper. See the reply for patch 17.

Right.

Thanks.

> >
> > Thanks
> >
> >
> > > +       if (IS_ERR(_vq)) {
> > > +               vq->reset = VIRTQUEUE_RESET_STAGE_RELEASE;
> > > +               return PTR_ERR(_vq);
> > > +       }
> > > +
> > > +       vp_modern_set_queue_enable(&vp_dev->mdev, vq->index, true);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > >  {
> > >         return vp_modern_config_vector(&vp_dev->mdev, vector);
> > > @@ -397,6 +453,8 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > >         .set_vq_affinity = vp_set_vq_affinity,
> > >         .get_vq_affinity = vp_get_vq_affinity,
> > >         .get_shm_region  = vp_get_shm_region,
> > > +       .reset_vq        = vp_modern_reset_vq,
> > > +       .enable_reset_vq = vp_modern_enable_reset_vq,
> > >  };
> > >
> > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > @@ -415,6 +473,8 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
> > >         .set_vq_affinity = vp_set_vq_affinity,
> > >         .get_vq_affinity = vp_get_vq_affinity,
> > >         .get_shm_region  = vp_get_shm_region,
> > > +       .reset_vq        = vp_modern_reset_vq,
> > > +       .enable_reset_vq = vp_modern_enable_reset_vq,
> > >  };
> > >
> > >  /* the PCI probing function */
> > > --
> > > 2.31.0
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
