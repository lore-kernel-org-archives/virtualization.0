Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA1AC636CC
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 09:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEEF282071;
	Fri,  3 Feb 2023 09:09:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEEF282071
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p--NHDQHiajC; Fri,  3 Feb 2023 09:09:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6D21882025;
	Fri,  3 Feb 2023 09:09:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D21882025
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AC2AC0032;
	Fri,  3 Feb 2023 09:09:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36E9EC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 042D96125F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:09:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 042D96125F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ig3MlreZ9dam
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:09:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0ECB960E84
Received: from out30-100.freemail.mail.aliyun.com
 (out30-100.freemail.mail.aliyun.com [115.124.30.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0ECB960E84
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:09:31 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VaoDXEV_1675415365; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VaoDXEV_1675415365) by smtp.aliyun-inc.com;
 Fri, 03 Feb 2023 17:09:26 +0800
Message-ID: <1675415352.3250086-8-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 06/33] virtio_ring: introduce virtqueue_reset()
Date: Fri, 3 Feb 2023 17:09:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-7-xuanzhuo@linux.alibaba.com>
 <20230203040041-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230203040041-mutt-send-email-mst@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Fri, 3 Feb 2023 04:05:38 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Feb 02, 2023 at 07:00:31PM +0800, Xuan Zhuo wrote:
> > Introduce virtqueue_reset() to release all buffer inside vq.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 50 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  2 ++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index e32046fd15a5..7dfce7001f9f 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2735,6 +2735,56 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> >
> > +/**
> > + * virtqueue_reset - reset the vring of vq
>
> ..., detach and recycle all unused buffers
>
> 	after all this is why we are doing this reset, right?
>
> > + * @_vq: the struct virtqueue we're talking about.
> > + * @recycle: callback for recycle the useless buffer
>
> not useless :) unused:
>
> 	callback to recycle unused buffers


I agree. Will fix.

Thanks.

>
> I know we have the same confusion in virtqueue_resize, I will fix
> that.
>
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
> > +		    void (*recycle)(struct virtqueue *vq, void *buf))
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	struct virtio_device *vdev = vq->vq.vdev;
> > +	void *buf;
> > +	int err;
> > +
> > +	if (!vq->we_own_ring)
> > +		return -EPERM;
> > +
> > +	if (!vdev->config->disable_vq_and_reset)
> > +		return -ENOENT;
> > +
> > +	if (!vdev->config->enable_vq_after_reset)
> > +		return -ENOENT;
> > +
> > +	err = vdev->config->disable_vq_and_reset(_vq);
> > +	if (err)
> > +		return err;
> > +
> > +	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
> > +		recycle(_vq, buf);
> > +
> > +	if (vq->packed_ring)
> > +		virtqueue_reinit_packed(vq);
> > +	else
> > +		virtqueue_reinit_split(vq);
> > +
> > +	if (vdev->config->enable_vq_after_reset(_vq))
> > +		return -EBUSY;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_reset);
> > +
> >  /* Only available for split ring */
> >  struct virtqueue *vring_new_virtqueue(unsigned int index,
> >  				      unsigned int num,
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 3ebb346ebb7c..3ca2edb1aef3 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -105,6 +105,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
> >
> >  int virtqueue_resize(struct virtqueue *vq, u32 num,
> >  		     void (*recycle)(struct virtqueue *vq, void *buf));
> > +int virtqueue_reset(struct virtqueue *vq,
> > +		    void (*recycle)(struct virtqueue *vq, void *buf));
> >
> >  /**
> >   * struct virtio_device - representation of a device using virtio
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
