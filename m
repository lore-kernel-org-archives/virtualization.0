Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E33C433EF
	for <virtualization@archiver.kernel.org>; Fri, 25 Mar 2022 22:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF53D8266A;
	Fri, 25 Mar 2022 22:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9NxRZ2MbTW1; Fri, 25 Mar 2022 22:32:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 45AF18246F;
	Fri, 25 Mar 2022 22:32:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2308EC002C;
	Fri, 25 Mar 2022 22:32:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B0B9C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 22:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60FEE402C3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 22:32:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qSvM8p6D0Saw
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 22:32:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 863FB4013D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 22:32:03 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V8BUW.L_1648247519; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V8BUW.L_1648247519) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 26 Mar 2022 06:32:00 +0800
Message-ID: <1648247490.285747-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v8 16/16] virtio_ring: introduce virtqueue_resize()
Date: Sat, 26 Mar 2022 06:31:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-17-xuanzhuo@linux.alibaba.com>
 <20220325062719-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220325062719-mutt-send-email-mst@kernel.org>
Cc: virtualization@lists.linux-foundation.org
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

On Fri, 25 Mar 2022 06:33:19 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Mar 14, 2022 at 05:34:55PM +0800, Xuan Zhuo wrote:
> > Introduce virtqueue_resize() to implement the resize of vring.
> > Based on these, the driver can dynamically adjust the size of the vring.
> > For example: ethtool -G.
> >
> > virtqueue_resize() implements resize based on the vq reset function. In
> > case of failure to allocate a new vring, it will give up resize and use
> > the original vring.
> >
> > During this process, if the re-enable reset vq fails, the vq can no
> > longer be used. Although the probability of this situation is not high.
> >
> > The parameter recycle is used to recycle the buffer that is no longer
> > used.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 67 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  3 ++
> >  2 files changed, 70 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index fb0abf9a2f57..b1dde086a8a4 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2528,6 +2528,73 @@ struct virtqueue *vring_create_virtqueue(
> >  }
> >  EXPORT_SYMBOL_GPL(vring_create_virtqueue);
> >
> > +/**
> > + * virtqueue_resize - resize the vring of vq
> > + * @vq: the struct virtqueue we're talking about.
> > + * @num: new ring num
> > + * @recycle: callback for recycle the useless buffer
> > + *
> > + * When it is really necessary to create a new vring, it will set the current vq
> > + * into the reset state. Then call the passed cb to recycle the buffer that is
> > + * no longer used. Only after the new vring is successfully created, the old
> > + * vring will be released.
> > + *
> > + * Caller must ensure we don't call this with other virtqueue operations
> > + * at the same time (except where noted).
> > + *
> > + * Returns zero or a negative error.
> > + * -ENOMEM: create new vring fail. But vq can still work
> > + * -EBUSY:  reset/re-enable vq fail. vq may cannot work
> > + * -ENOENT: not support resize
> > + * -E2BIG/-EINVAL: param num error
> > + */
> > +int virtqueue_resize(struct virtqueue *vq, u32 num,
> > +		     void (*recycle)(struct virtqueue *vq, void *buf))
> > +{
> > +	struct virtio_device *vdev = vq->vdev;
> > +	void *buf;
> > +	int err;
> > +
> > +	if (num > vq->num_max)
> > +		return -E2BIG;
> > +
> > +	if (!num)
> > +		return -EINVAL;
> > +
> > +	if (to_vvq(vq)->packed.vring.num == num)
> > +		return 0;
> > +
> > +	if (!vq->vdev->config->reset_vq)
> > +		return -ENOENT;
> > +
> > +	if (!vq->vdev->config->enable_reset_vq)
> > +		return -ENOENT;
> > +
> > +	err = vq->vdev->config->reset_vq(vq);
> > +	if (err) {
> > +		if (err != -ENOENT)
> > +			err = -EBUSY;
> > +		return err;
> > +	}
> > +
> > +	while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > +		recycle(vq, buf);
>
>
> So all this callback can do now is drop all buffers, and I think that is
> not great.  Can we store them and invoke the callback after queue is
> enabled?


OK, I will bring this feature in the next version.

Thanks.

>
>
> > +
> > +	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> > +		err = virtqueue_resize_packed(vq, num);
> > +	else
> > +		err = virtqueue_resize_split(vq, num);
> > +
> > +	if (err)
> > +		err = -ENOMEM;
> > +
> > +	if (vq->vdev->config->enable_reset_vq(vq))
> > +		return -EBUSY;
> > +
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_resize);
> > +
> >  /* Only available for split ring */
> >  struct virtqueue *vring_new_virtqueue(unsigned int index,
> >  				      unsigned int num,
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index d59adc4be068..c86ff02e0ca0 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -91,6 +91,9 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
> >  dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
> >  dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
> >
> > +int virtqueue_resize(struct virtqueue *vq, u32 num,
> > +		     void (*recycle)(struct virtqueue *vq, void *buf));
> > +
> >  /**
> >   * virtio_device - representation of a device using virtio
> >   * @index: unique position on the virtio bus
> > --
> > 2.31.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
