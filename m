Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91EDC636CC
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 07:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48850606EB;
	Mon, 20 Feb 2023 07:04:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48850606EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XTeU00fBCM6B; Mon, 20 Feb 2023 07:04:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CF62960DFF;
	Mon, 20 Feb 2023 07:04:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF62960DFF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A884DC0033;
	Mon, 20 Feb 2023 07:04:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D97EC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 528DA417B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:04:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 528DA417B0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 58D2CJLezuPH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:04:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D728F4176C
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D728F4176C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:04:42 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vc0rE5C_1676876677; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vc0rE5C_1676876677) by smtp.aliyun-inc.com;
 Mon, 20 Feb 2023 15:04:38 +0800
Message-ID: <1676876639.3591576-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 10/10] virtio_ring: introduce virtqueue_reset()
Date: Mon, 20 Feb 2023 15:03:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-11-xuanzhuo@linux.alibaba.com>
 <CACGkMEtYxLp93m25hFA=xn_kVCh6eHD92CZq=SWGgNDE3c41Jw@mail.gmail.com>
In-Reply-To: <CACGkMEtYxLp93m25hFA=xn_kVCh6eHD92CZq=SWGgNDE3c41Jw@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On Mon, 20 Feb 2023 13:38:30 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Introduce virtqueue_reset() to release all buffer inside vq.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 50 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  2 ++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 2ba60a14f557..2750a365439a 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2930,6 +2930,56 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> >
> > +/**
> > + * virtqueue_reset - detach and recycle all unused buffers
> > + * @_vq: the struct virtqueue we're talking about.
> > + * @recycle: callback to recycle unused buffers
> > + *
> > + * Caller must ensure we don't call this with other virtqueue operations
> > + * at the same time (except where noted).
> > + *
> > + * Returns zero or a negative error.
> > + * 0: success.
> > + * -EBUSY: Failed to sync with device, vq may not work properly
> > + * -ENOENT: Transport or device not supported
> > + * -EPERM: Operation not permitted
> > + */
> > +int virtqueue_reset(struct virtqueue *_vq,
> > +                   void (*recycle)(struct virtqueue *vq, void *buf))
> > +{
> > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > +       struct virtio_device *vdev = vq->vq.vdev;
> > +       void *buf;
> > +       int err;
> > +
> > +       if (!vq->we_own_ring)
> > +               return -EPERM;
> > +
> > +       if (!vdev->config->disable_vq_and_reset)
> > +               return -ENOENT;
> > +
> > +       if (!vdev->config->enable_vq_after_reset)
> > +               return -ENOENT;
> > +
> > +       err = vdev->config->disable_vq_and_reset(_vq);
> > +       if (err)
> > +               return err;
> > +
> > +       while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
> > +               recycle(_vq, buf);
> > +
> > +       if (vq->packed_ring)
> > +               virtqueue_reinit_packed(vq);
> > +       else
> > +               virtqueue_reinit_split(vq);
> > +
> > +       if (vdev->config->enable_vq_after_reset(_vq))
> > +               return -EBUSY;
> > +
> > +       return 0;
> > +}
>
> I don't get why not factor the similar logic from virtqueue_resize()?


I can do this, if you prefer this.

THanks.



>
> Thanks
>
>
> > +EXPORT_SYMBOL_GPL(virtqueue_reset);
> > +
> >  /* Only available for split ring */
> >  struct virtqueue *vring_new_virtqueue(unsigned int index,
> >                                       unsigned int num,
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index d0e707d744a0..cf4c157e4e75 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -106,6 +106,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
> >
> >  int virtqueue_resize(struct virtqueue *vq, u32 num,
> >                      void (*recycle)(struct virtqueue *vq, void *buf));
> > +int virtqueue_reset(struct virtqueue *vq,
> > +                   void (*recycle)(struct virtqueue *vq, void *buf));
> >
> >  /**
> >   * struct virtio_device - representation of a device using virtio
> > --
> > 2.32.0.3.g01195cf9f
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
