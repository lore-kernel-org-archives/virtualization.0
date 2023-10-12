Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE5BCDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 09:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 350D660FAB;
	Thu, 12 Oct 2023 09:21:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 350D660FAB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XbeKVQf7v90i; Thu, 12 Oct 2023 09:21:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9C16160E4B;
	Thu, 12 Oct 2023 09:21:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C16160E4B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BE46C0071;
	Thu, 12 Oct 2023 09:21:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98E96C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74C5A81E57
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:21:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74C5A81E57
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s91cal1yo0FM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:21:44 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 607C181CAF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:21:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 607C181CAF
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R271e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vu-2qJN_1697102496; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vu-2qJN_1697102496) by smtp.aliyun-inc.com;
 Thu, 12 Oct 2023 17:21:36 +0800
Message-ID: <1697102334.7060938-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 01/22] virtio_ring: virtqueue_set_dma_premapped
 support disable
Date: Thu, 12 Oct 2023 17:18:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
 <20231012051416-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231012051416-mutt-send-email-mst@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Thu, 12 Oct 2023 05:15:52 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Oct 11, 2023 at 05:27:07PM +0800, Xuan Zhuo wrote:
> > virtqueue_set_dma_premapped() adds a new parameter to disable the
> > virtqueue premapped mode.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c     |  2 +-
> >  drivers/virtio/virtio_ring.c | 11 ++++++++---
> >  include/linux/virtio.h       |  2 +-
> >  3 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index fe7f314d65c9..6b5f47ebf9b2 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -737,7 +737,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> >  		return;
> >
> >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> > -		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > +		if (virtqueue_set_dma_premapped(vi->rq[i].vq, true))
> >  			continue;
> >
> >  		vi->rq[i].do_dma = true;
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 51d8f3299c10..b3ded56722f4 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2784,7 +2784,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> >   * 0: success.
> >   * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
> >   */
> > -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >  	u32 num;
> > @@ -2803,8 +2803,13 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> >  		return -EINVAL;
> >  	}
> >
> > -	vq->premapped = true;
> > -	vq->do_unmap = false;
> > +	if (mode) {
> > +		vq->premapped = true;
> > +		vq->do_unmap = false;
> > +	} else {
> > +		vq->premapped = false;
> > +		vq->do_unmap = vq->use_dma_api;
> > +	}
> >
> >  	END_USE(vq);
> >
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 4cc614a38376..1cf7b004348b 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -81,7 +81,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
> >
> >  unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
> >
> > -int virtqueue_set_dma_premapped(struct virtqueue *_vq);
> > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode);
> >
> >  bool virtqueue_poll(struct virtqueue *vq, unsigned);
>
> Wait a sec I thought we never change premapped. If you make this
> dynamic don't you need a bunch of locking?
> Or maybe queue is empty when you change this?
> If yes pls add a bunch of BUG_ON checks to make sure this is not misused.


Actually, this api is called immediately after the vq init or vq reset.

We already have such a check.

Thanks.

/**
 * virtqueue_set_dma_premapped - set the vring premapped mode
 * @_vq: the struct virtqueue we're talking about.
 *
 * Enable the premapped mode of the vq.
 *
 * The vring in premapped mode does not do dma internally, so the driver must
 * do dma mapping in advance. The driver must pass the dma_address through
 * dma_address of scatterlist. When the driver got a used buffer from
 * the vring, it has to unmap the dma address.
 *
 * This function must be called immediately after creating the vq, or after vq
 * reset, and before adding any buffers to it.
 *
 * Caller must ensure we don't call this with other virtqueue operations
 * at the same time (except where noted).
 *
 * Returns zero or a negative error.
 * 0: success.
 * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
 */
int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
{
	struct vring_virtqueue *vq = to_vvq(_vq);
	u32 num;

	START_USE(vq);

	num = vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;

-->	if (num != vq->vq.num_free) {
		END_USE(vq);
		return -EINVAL;
	}

	if (!vq->use_dma_api) {
		END_USE(vq);
		return -EINVAL;
	}

	if (mode) {
		vq->premapped = true;
		vq->do_unmap = false;
	} else {
		vq->premapped = false;
		vq->do_unmap = vq->use_dma_api;
	}

	END_USE(vq);

	return 0;
}
EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);


>
>
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
