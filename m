Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B127FC433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 08:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46B91831F8;
	Wed, 16 Feb 2022 08:08:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Au-46Lxy88S; Wed, 16 Feb 2022 08:08:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B13F383216;
	Wed, 16 Feb 2022 08:08:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F416C0011;
	Wed, 16 Feb 2022 08:08:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 765F6C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55CAF40298
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:08:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ACgZRn2Mo_fk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:08:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA03C40117
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:08:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R821e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4cKqy5_1644998885; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4cKqy5_1644998885) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Feb 2022 16:08:06 +0800
Message-ID: <1644998595.3309107-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v5 14/22] virtio_pci: queue_reset: support
 VIRTIO_F_RING_RESET
Date: Wed, 16 Feb 2022 16:03:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-15-xuanzhuo@linux.alibaba.com>
 <CACGkMEufh3sbGx4wFCkpiXNR0w0WoCC=TNeLHE+QkqrhyXH6Bw@mail.gmail.com>
In-Reply-To: <CACGkMEufh3sbGx4wFCkpiXNR0w0WoCC=TNeLHE+QkqrhyXH6Bw@mail.gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 16 Feb 2022 12:14:25 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > This patch implements virtio pci support for QUEUE RESET.
> >
> > Performing reset on a queue is divided into these steps:
> >
> > 1. reset_vq: reset one vq
> > 2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> > 3. release the ring of the vq by vring_release_virtqueue()
> > 4. enable_reset_vq: re-enable the reset queue
> >
> > This patch implements reset_vq, enable_reset_vq in the pci scenario.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_pci_common.c |  8 ++--
> >  drivers/virtio/virtio_pci_modern.c | 60 ++++++++++++++++++++++++++++++
> >  2 files changed, 65 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index 5a4f750a0b97..9ea319b1d404 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -255,9 +255,11 @@ static void vp_del_vq(struct virtqueue *vq)
> >         struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
> >         unsigned long flags;
> >
> > -       spin_lock_irqsave(&vp_dev->lock, flags);
> > -       list_del(&info->node);
> > -       spin_unlock_irqrestore(&vp_dev->lock, flags);
> > +       if (!vq->reset) {
> > +               spin_lock_irqsave(&vp_dev->lock, flags);
> > +               list_del(&info->node);
> > +               spin_unlock_irqrestore(&vp_dev->lock, flags);
> > +       }
> >
> >         vp_dev->del_vq(info);
> >         kfree(info);
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index bed3e9b84272..7d28f4c36fc2 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -34,6 +34,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
> >         if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
> >                         pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
> >                 __virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> > +
> > +       if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> > +               __virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
> >  }
> >
> >  /* virtio config->finalize_features() implementation */
> > @@ -176,6 +179,59 @@ static void vp_reset(struct virtio_device *vdev)
> >         vp_disable_cbs(vdev);
> >  }
> >
> > +static int vp_modern_reset_vq(struct virtqueue *vq)
> > +{
> > +       struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> > +       struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> > +       struct virtio_pci_vq_info *info;
> > +       unsigned long flags;
> > +
> > +       if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
> > +               return -ENOENT;
> > +
> > +       vp_modern_set_queue_reset(mdev, vq->index);
> > +
> > +       info = vp_dev->vqs[vq->index];
> > +
>
> Any reason that we don't need to disable irq here as the previous versions did?

Based on the spec, for the case of one interrupt per queue, there will be no
more interrupts after the reset queue operation. Whether the interrupt is turned
off or not has no effect. I turned off the interrupt before just to be safe.

And for irq sharing scenarios, I don't want to turn off shared interrupts for a
queue.

And the following list_del has been guaranteed to be safe, so I removed the code
for closing interrupts in the previous version.

Thanks.

>
>
> > +       /* delete vq from irq handler */
> > +       spin_lock_irqsave(&vp_dev->lock, flags);
> > +       list_del(&info->node);
> > +       spin_unlock_irqrestore(&vp_dev->lock, flags);
> > +
> > +       INIT_LIST_HEAD(&info->node);
> > +
> > +       vq->reset = VIRTQUEUE_RESET_STAGE_DEVICE;
> > +
> > +       return 0;
> > +}
> > +
> > +static int vp_modern_enable_reset_vq(struct virtqueue *vq)
> > +{
> > +       struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> > +       struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> > +       struct virtio_pci_vq_info *info;
> > +       struct virtqueue *_vq;
> > +
> > +       if (vq->reset != VIRTQUEUE_RESET_STAGE_RELEASE)
> > +               return -EBUSY;
> > +
> > +       /* check queue reset status */
> > +       if (vp_modern_get_queue_reset(mdev, vq->index) != 1)
> > +               return -EBUSY;
> > +
> > +       info = vp_dev->vqs[vq->index];
> > +       _vq = vp_setup_vq(vq->vdev, vq->index, NULL, NULL, NULL,
> > +                        info->msix_vector);
>
> So we only care about moden devices, this means using vp_setup_vq()
> with NULL seems tricky.
>
> As replied in another thread, I would simply ask the caller to call
> the vring reallocation helper. See the reply for patch 17.
>
> Thanks
>
>
> > +       if (IS_ERR(_vq)) {
> > +               vq->reset = VIRTQUEUE_RESET_STAGE_RELEASE;
> > +               return PTR_ERR(_vq);
> > +       }
> > +
> > +       vp_modern_set_queue_enable(&vp_dev->mdev, vq->index, true);
> > +
> > +       return 0;
> > +}
> > +
> >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> >  {
> >         return vp_modern_config_vector(&vp_dev->mdev, vector);
> > @@ -397,6 +453,8 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> >         .set_vq_affinity = vp_set_vq_affinity,
> >         .get_vq_affinity = vp_get_vq_affinity,
> >         .get_shm_region  = vp_get_shm_region,
> > +       .reset_vq        = vp_modern_reset_vq,
> > +       .enable_reset_vq = vp_modern_enable_reset_vq,
> >  };
> >
> >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > @@ -415,6 +473,8 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
> >         .set_vq_affinity = vp_set_vq_affinity,
> >         .get_vq_affinity = vp_get_vq_affinity,
> >         .get_shm_region  = vp_get_shm_region,
> > +       .reset_vq        = vp_modern_reset_vq,
> > +       .enable_reset_vq = vp_modern_enable_reset_vq,
> >  };
> >
> >  /* the PCI probing function */
> > --
> > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
