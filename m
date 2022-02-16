Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42224C433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 08:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D06C54002B;
	Wed, 16 Feb 2022 08:44:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgsByzJ6K5ea; Wed, 16 Feb 2022 08:44:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E1E840117;
	Wed, 16 Feb 2022 08:44:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E753C0011;
	Wed, 16 Feb 2022 08:44:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DDFEC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C00A813E1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:44:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kMMKEtGzD8UZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:44:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C47F881991
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:44:51 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4cGnPS_1645001087; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4cGnPS_1645001087) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Feb 2022 16:44:47 +0800
Message-ID: <1645000956.0320733-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v5 17/22] virtio_net: support rx/tx queue reset
Date: Wed, 16 Feb 2022 16:42:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-18-xuanzhuo@linux.alibaba.com>
 <CACGkMEszV_sUt+7gpLJ=6S1Spa0RmY=Ck0_duEkGf6xKOPG+oQ@mail.gmail.com>
 <1644998173.7222953-3-xuanzhuo@linux.alibaba.com>
 <20220216033322-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220216033322-mutt-send-email-mst@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
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

On Wed, 16 Feb 2022 03:35:01 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Feb 16, 2022 at 03:56:13PM +0800, Xuan Zhuo wrote:
> > On Wed, 16 Feb 2022 12:14:11 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >
> > > > This patch implements the reset function of the rx, tx queues.
> > > >
> > > > Based on this function, it is possible to modify the ring num of the
> > > > queue. And quickly recycle the buffer in the queue.
> > > >
> > > > In the process of the queue disable, in theory, as long as virtio
> > > > supports queue reset, there will be no exceptions.
> > > >
> > > > However, in the process of the queue enable, there may be exceptions due to
> > > > memory allocation.  In this case, vq is not available, but we still have
> > > > to execute napi_enable(). Because napi_disable is similar to a lock,
> > > > napi_enable must be called after calling napi_disable.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 123 +++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 123 insertions(+)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 9a1445236e23..a4ffd7cdf623 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -251,6 +251,11 @@ struct padded_vnet_hdr {
> > > >         char padding[4];
> > > >  };
> > > >
> > > > +static void virtnet_sq_free_unused_bufs(struct virtnet_info *vi,
> > > > +                                       struct send_queue *sq);
> > > > +static void virtnet_rq_free_unused_bufs(struct virtnet_info *vi,
> > > > +                                       struct receive_queue *rq);
> > > > +
> > > >  static bool is_xdp_frame(void *ptr)
> > > >  {
> > > >         return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> > > > @@ -1369,6 +1374,9 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > >  {
> > > >         napi_enable(napi);
> > > >
> > > > +       if (vq->reset)
> > > > +               return;
> > > > +
> > > >         /* If all buffers were filled by other side before we napi_enabled, we
> > > >          * won't get another interrupt, so process any outstanding packets now.
> > > >          * Call local_bh_enable after to trigger softIRQ processing.
> > > > @@ -1413,6 +1421,10 @@ static void refill_work(struct work_struct *work)
> > > >                 struct receive_queue *rq = &vi->rq[i];
> > > >
> > > >                 napi_disable(&rq->napi);
> > > > +               if (rq->vq->reset) {
> > > > +                       virtnet_napi_enable(rq->vq, &rq->napi);
> > > > +                       continue;
> > > > +               }
> > > >                 still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> > > >                 virtnet_napi_enable(rq->vq, &rq->napi);
> > > >
> > > > @@ -1523,6 +1535,9 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
> > > >         if (!sq->napi.weight || is_xdp_raw_buffer_queue(vi, index))
> > > >                 return;
> > > >
> > > > +       if (sq->vq->reset)
> > > > +               return;
> > > > +
> > > >         if (__netif_tx_trylock(txq)) {
> > > >                 do {
> > > >                         virtqueue_disable_cb(sq->vq);
> > > > @@ -1769,6 +1784,114 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > >         return NETDEV_TX_OK;
> > > >  }
> > > >
> > > > +static int virtnet_rx_vq_disable(struct virtnet_info *vi,
> > > > +                                struct receive_queue *rq)
> > > > +{
> > > > +       int err;
> > > > +
> > > > +       napi_disable(&rq->napi);
> > > > +
> > > > +       err = virtio_reset_vq(rq->vq);
> > > > +       if (err)
> > > > +               goto err;
> > > > +
> > > > +       virtnet_rq_free_unused_bufs(vi, rq);
> > > > +
> > > > +       vring_release_virtqueue(rq->vq);
> > > > +
> > > > +       return 0;
> > > > +
> > > > +err:
> > > > +       virtnet_napi_enable(rq->vq, &rq->napi);
> > > > +       return err;
> > > > +}
> > > > +
> > > > +static int virtnet_tx_vq_disable(struct virtnet_info *vi,
> > > > +                                struct send_queue *sq)
> > > > +{
> > > > +       struct netdev_queue *txq;
> > > > +       int err, qindex;
> > > > +
> > > > +       qindex = sq - vi->sq;
> > > > +
> > > > +       txq = netdev_get_tx_queue(vi->dev, qindex);
> > > > +       __netif_tx_lock_bh(txq);
> > > > +
> > > > +       netif_stop_subqueue(vi->dev, qindex);
> > > > +       virtnet_napi_tx_disable(&sq->napi);
> > > > +
> > > > +       err = virtio_reset_vq(sq->vq);
> > > > +       if (err) {
> > > > +               virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> > > > +               netif_start_subqueue(vi->dev, qindex);
> > > > +
> > > > +               __netif_tx_unlock_bh(txq);
> > > > +               return err;
> > > > +       }
> > > > +       __netif_tx_unlock_bh(txq);
> > > > +
> > > > +       virtnet_sq_free_unused_bufs(vi, sq);
> > > > +
> > > > +       vring_release_virtqueue(sq->vq);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int virtnet_tx_vq_enable(struct virtnet_info *vi, struct send_queue *sq)
> > > > +{
> > > > +       int err;
> > > > +
> > > > +       err = virtio_enable_resetq(sq->vq);
> > > > +       if (!err)
> > > > +               netif_start_subqueue(vi->dev, sq - vi->sq);
> > > > +
> > > > +       virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> > > > +
> > > > +       return err;
> > > > +}
> > > > +
> > > > +static int virtnet_rx_vq_enable(struct virtnet_info *vi,
> > > > +                               struct receive_queue *rq)
> > > > +{
> > > > +       int err;
> > >
> > > So the API should be design in a consistent way.
> > >
> > > In rx_vq_disable() we do:
> > >
> > > reset()
> > > detach_unused_bufs()
> > > vring_release_virtqueue()
> > >
> > > here it's better to exactly the reverse
> > >
> > > vring_attach_virtqueue() // this is the helper I guess in patch 5,
> > > reverse of the vring_release_virtqueue()
> > > try_refill_recv() // reverse of the detach_unused_bufs()
> > > enable_reset() // reverse of the reset
> >
> > Such an api is ok
> >
> > 1. reset()
> > 2. detach_unused_bufs()
> > 3. vring_release_virtqueue()
> >    ---------------
> > 4. vring_attach_virtqueue()
> > 5. try_refill_recv()
> > 6. enable_reset()
> >
> >
> > But if, we just want to recycle the buffer without modifying the ring num. As
> > you mentioned before, in the case where the ring num is not modified, we don't
> > have to reallocate, but can use the original vring.
> >
> > 1. reset()
> > 2. detach_unused_bufs()
> >    ---------------
> > 3. vring_reset_virtqueue() // just reset, no reallocate
> > 4. try_refill_recv()
> > 5. enable_reset()
> >
> > Thanks.
>
> Further, can we queue the buffers instead of detach_unused_bufs
> and just requeue them instead of try_refill_recv?

I think this is a good note, for support set_ringparam, this will be more
friendly.

I think I can implement this after the support for AF_XDP is done.

Thanks.

>
> > >
> > > So did for the tx (no need for refill in that case).
> > >
> > > > +
> > > > +       err = virtio_enable_resetq(rq->vq);
> > > > +
> > > > +       virtnet_napi_enable(rq->vq, &rq->napi);
> > > > +
> > > > +       return err;
> > > > +}
> > > > +
> > > > +static int virtnet_rx_vq_reset(struct virtnet_info *vi, int i)
> > > > +{
> > > > +       int err;
> > > > +
> > > > +       err = virtnet_rx_vq_disable(vi, vi->rq + i);
> > > > +       if (err)
> > > > +               return err;
> > > > +
> > > > +       err = virtnet_rx_vq_enable(vi, vi->rq + i);
> > > > +       if (err)
> > > > +               netdev_err(vi->dev,
> > > > +                          "enable rx reset vq fail: rx queue index: %d err: %d\n", i, err);
> > > > +       return err;
> > > > +}
> > > > +
> > > > +static int virtnet_tx_vq_reset(struct virtnet_info *vi, int i)
> > > > +{
> > > > +       int err;
> > > > +
> > > > +       err = virtnet_tx_vq_disable(vi, vi->sq + i);
> > > > +       if (err)
> > > > +               return err;
> > > > +
> > > > +       err = virtnet_tx_vq_enable(vi, vi->sq + i);
> > > > +       if (err)
> > > > +               netdev_err(vi->dev,
> > > > +                          "enable tx reset vq fail: tx queue index: %d err: %d\n", i, err);
> > > > +       return err;
> > > > +}
> > > > +
> > > >  /*
> > > >   * Send command via the control virtqueue and check status.  Commands
> > > >   * supported by the hypervisor, as indicated by feature bits, should
> > > > --
> > > > 2.31.0
> > > >
> > >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
