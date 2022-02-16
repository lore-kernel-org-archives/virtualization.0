Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFBAC433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 07:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1300082813;
	Wed, 16 Feb 2022 07:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m8qI_4CFVvlT; Wed, 16 Feb 2022 07:54:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9BBE481CD0;
	Wed, 16 Feb 2022 07:54:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C0CEC001A;
	Wed, 16 Feb 2022 07:54:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3133C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 07:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2C574099A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 07:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zDLmTzF2zyYQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 07:54:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBF4840995
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 07:54:55 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4c7G.H_1644998091; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4c7G.H_1644998091) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Feb 2022 15:54:52 +0800
Message-ID: <1644998063.772229-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v5 19/22] virtio: add helper virtio_set_max_ring_num()
Date: Wed, 16 Feb 2022 15:54:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-20-xuanzhuo@linux.alibaba.com>
 <CACGkMEsdySbtHN4SNSmX8sD6Y7S=dj3oxq5a3EBhRG1qUeT24A@mail.gmail.com>
In-Reply-To: <CACGkMEsdySbtHN4SNSmX8sD6Y7S=dj3oxq5a3EBhRG1qUeT24A@mail.gmail.com>
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

On Wed, 16 Feb 2022 12:14:04 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Feb 14, 2022 at 4:15 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Added helper virtio_set_max_ring_num() to set the upper limit of ring
> > num when creating a virtqueue.
> >
> > Can be used to limit ring num before find_vqs() call. Or change ring num
> > when re-enable reset queue.
>
> Do we have a chance that RX and TX may want different ring size? If
> yes, it might be even better to have per vq limit via find_vqs()?
>
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c  |  6 ++++++
> >  include/linux/virtio.h        |  1 +
> >  include/linux/virtio_config.h | 30 ++++++++++++++++++++++++++++++
> >  3 files changed, 37 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 1a123b5e5371..a77a82883e44 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -943,6 +943,9 @@ static struct virtqueue *vring_create_virtqueue_split(
> >         size_t queue_size_in_bytes;
> >         struct vring vring;
> >
> > +       if (vdev->max_ring_num && num > vdev->max_ring_num)
> > +               num = vdev->max_ring_num;
> > +
> >         /* We assume num is a power of 2. */
> >         if (num & (num - 1)) {
> >                 dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
> > @@ -1692,6 +1695,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >         dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
> >         size_t ring_size_in_bytes, event_size_in_bytes;
> >
> > +       if (vdev->max_ring_num && num > vdev->max_ring_num)
> > +               num = vdev->max_ring_num;
> > +
> >         ring_size_in_bytes = num * sizeof(struct vring_packed_desc);
> >
> >         ring = vring_alloc_queue(vdev, ring_size_in_bytes,
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 1153b093c53d..45525beb2ec4 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -127,6 +127,7 @@ struct virtio_device {
> >         struct list_head vqs;
> >         u64 features;
> >         void *priv;
> > +       u16 max_ring_num;
> >  };
> >
> >  static inline struct virtio_device *dev_to_virtio(struct device *_dev)
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index cd7f7f44ce38..d7cb2d0341ee 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -200,6 +200,36 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
> >         return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
> >  }
> >
> > +/**
> > + * virtio_set_max_ring_num - set max ring num
> > + * @vdev: the device
> > + * @num: max ring num. Zero clear the limit.
> > + *
> > + * When creating a virtqueue, use this value as the upper limit of ring num.
> > + *
> > + * Returns 0 on success or error status
> > + */
> > +static inline
> > +int virtio_set_max_ring_num(struct virtio_device *vdev, u16 num)
> > +{
>
> Having a dedicated helper for a per device parameter usually means the
> use cases are greatly limited. For example, this seems can only be
> used when DRIVER_OK is not set?
>
> And in patch 17 this function is called even if we only modify the RX
> size, this is probably another call for a more flexible API as I
> suggest like exporting vring allocation/deallocation helper and extend
> find_vqs()?
>

I understand.

Thanks.

> Thanks
>
>
> > +       if (!num) {
> > +               vdev->max_ring_num = num;
> > +               return 0;
> > +       }
> > +
> > +       if (!virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> > +               if (!is_power_of_2(num)) {
> > +                       num = __rounddown_pow_of_two(num);
> > +
> > +                       if (!num)
> > +                               return -EINVAL;
> > +               }
> > +       }
> > +
> > +       vdev->max_ring_num = num;
> > +       return 0;
> > +}
> > +
> >  static inline
> >  struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
> >                                         vq_callback_t *c, const char *n)
> > --
> > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
