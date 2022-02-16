Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EE8C433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 07:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BF4282EBA;
	Wed, 16 Feb 2022 07:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W-GXc3_-jgVf; Wed, 16 Feb 2022 07:21:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0476082948;
	Wed, 16 Feb 2022 07:21:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAE2BC001A;
	Wed, 16 Feb 2022 07:21:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 484ABC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 07:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 311A7415FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 07:21:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c8nd85s8vk2I
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 07:21:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDA51415F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 07:21:46 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R741e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4cGXqR_1644996102; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4cGXqR_1644996102) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Feb 2022 15:21:43 +0800
Message-ID: <1644996081.960291-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v5 22/22] virtio_net: support set_ringparam
Date: Wed, 16 Feb 2022 15:21:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-23-xuanzhuo@linux.alibaba.com>
 <CACGkMEsQB0XCZb39QVsv9VM0qJpc__jucgUCGV9LU5kPTze6Hg@mail.gmail.com>
In-Reply-To: <CACGkMEsQB0XCZb39QVsv9VM0qJpc__jucgUCGV9LU5kPTze6Hg@mail.gmail.com>
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

On Wed, 16 Feb 2022 12:14:39 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Feb 14, 2022 at 4:15 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Support set_ringparam based on virtio queue reset.
> >
> > The rx,tx_pending required to be passed must be power of 2.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 50 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f9bb760c6dbd..bf460ea87354 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2308,6 +2308,55 @@ static void virtnet_get_ringparam(struct net_device *dev,
> >         ring->tx_pending = virtqueue_get_vring_size(vi->sq[0].vq);
> >  }
> >
> > +static int virtnet_set_ringparam(struct net_device *dev,
> > +                                struct ethtool_ringparam *ring,
> > +                                struct kernel_ethtool_ringparam *kernel_ring,
> > +                                struct netlink_ext_ack *extack)
> > +{
> > +       struct virtnet_info *vi = netdev_priv(dev);
> > +       u32 rx_pending, tx_pending;
> > +       int i, err;
> > +
> > +       if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> > +               return -EINVAL;
> > +
> > +       rx_pending = virtqueue_get_vring_size(vi->rq[0].vq);
> > +       tx_pending = virtqueue_get_vring_size(vi->sq[0].vq);
> > +
> > +       if (ring->rx_pending == rx_pending &&
> > +           ring->tx_pending == tx_pending)
> > +               return 0;
> > +
> > +       if (ring->rx_pending > virtqueue_get_vring_max_size(vi->rq[0].vq))
> > +               return -EINVAL;
> > +
> > +       if (ring->tx_pending > virtqueue_get_vring_max_size(vi->sq[0].vq))
> > +               return -EINVAL;
> > +
> > +       if (!is_power_of_2(ring->rx_pending))
> > +               return -EINVAL;
> > +
> > +       if (!is_power_of_2(ring->tx_pending))
> > +               return -EINVAL;
>
> We'd better leave those checks to the virtio core where it knows
> packed virtqueue doesn't have this limitation.

OK.

>
> > +
> > +       for (i = 0; i < vi->max_queue_pairs; i++) {
> > +               if (ring->tx_pending != tx_pending) {
> > +                       virtio_set_max_ring_num(vi->vdev, ring->tx_pending);
>
> The name is kind of confusing, I guess it should not be the maximum
> ring. And this needs to be done after the reset, and it would be even
> better to disallow such change when virtqueue is not resetted.

OK.

Thanks.

>
> > +                       err = virtnet_tx_vq_reset(vi, i);
> > +                       if (err)
> > +                               return err;
> > +               }
> > +
> > +               if (ring->rx_pending != rx_pending) {
> > +                       virtio_set_max_ring_num(vi->vdev, ring->rx_pending);
> > +                       err = virtnet_rx_vq_reset(vi, i);
> > +                       if (err)
> > +                               return err;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> >
> >  static void virtnet_get_drvinfo(struct net_device *dev,
> >                                 struct ethtool_drvinfo *info)
> > @@ -2541,6 +2590,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
> >         .get_drvinfo = virtnet_get_drvinfo,
> >         .get_link = ethtool_op_get_link,
> >         .get_ringparam = virtnet_get_ringparam,
> > +       .set_ringparam = virtnet_set_ringparam,
> >         .get_strings = virtnet_get_strings,
> >         .get_sset_count = virtnet_get_sset_count,
> >         .get_ethtool_stats = virtnet_get_ethtool_stats,
> > --
> > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
