Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156D7C61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 04:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E3DD41DA1;
	Fri,  3 Feb 2023 04:36:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E3DD41DA1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uTsSB3UjPrui; Fri,  3 Feb 2023 04:36:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5E19A41D99;
	Fri,  3 Feb 2023 04:36:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E19A41D99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E7B5C0032;
	Fri,  3 Feb 2023 04:36:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B85ABC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 04:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D90340370
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 04:36:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D90340370
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 85U9sp8PFFi1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 04:36:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53EC240111
Received: from out30-100.freemail.mail.aliyun.com
 (out30-100.freemail.mail.aliyun.com [115.124.30.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53EC240111
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 04:36:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R501e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VanP3zA_1675398963; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VanP3zA_1675398963) by smtp.aliyun-inc.com;
 Fri, 03 Feb 2023 12:36:04 +0800
Message-ID: <1675398932.095303-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 19/33] virtio_net: introduce virtnet_tx_reset()
Date: Fri, 3 Feb 2023 12:35:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-20-xuanzhuo@linux.alibaba.com>
 <20230202121745-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230202121745-mutt-send-email-mst@kernel.org>
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

On Thu, 2 Feb 2023 12:23:56 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Feb 02, 2023 at 07:00:44PM +0800, Xuan Zhuo wrote:
> > Introduce virtnet_tx_reset() to release the buffers inside virtio ring.
> >
> > This is needed for xsk disable. When disable xsk, we need to relese the
>
> typo
>
> > buffer from xsk, so this function is needed.
> >
> > This patch reuse the virtnet_tx_resize.
>
> reuses
>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>
> > ---
> >  drivers/net/virtio/main.c       | 21 ++++++++++++++++++---
> >  drivers/net/virtio/virtio_net.h |  1 +
> >  2 files changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index fb82035a0b7f..049a3bb9d88d 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -1806,8 +1806,8 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
> >  	return err;
> >  }
> >
> > -static int virtnet_tx_resize(struct virtnet_info *vi,
> > -			     struct send_queue *sq, u32 ring_num)
> > +static int __virtnet_tx_reset(struct virtnet_info *vi,
> > +			      struct send_queue *sq, u32 ring_num)
> >  {
> >  	bool running = netif_running(vi->dev);
> >  	struct netdev_queue *txq;
> > @@ -1833,7 +1833,11 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
> >
> >  	__netif_tx_unlock_bh(txq);
> >
> > -	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
> > +	if (ring_num)
> > +		err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
> > +	else
> > +		err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> > +
> >  	if (err)
> >  		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
> >
>
> This __virtnet_tx_reset is a really weird API.
>
> Suggest just splitting the common parts:
>
> __virtnet_tx_pause
> __virtnet_tx_resume
>
> we can then implement virtnet_tx_resize and virtnet_tx_reset
> using these two.

Good idea.

Thanks.

>
>
> > @@ -1847,6 +1851,17 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
> >  	return err;
> >  }
> >
> > +static int virtnet_tx_resize(struct virtnet_info *vi,
> > +			     struct send_queue *sq, u32 ring_num)
> > +{
> > +	return __virtnet_tx_reset(vi, sq, ring_num);
> > +}
> > +
> > +int virtnet_tx_reset(struct virtnet_info *vi, struct send_queue *sq)
> > +{
> > +	return __virtnet_tx_reset(vi, sq, 0);
> > +}
> > +
> >  /*
> >   * Send command via the control virtqueue and check status.  Commands
> >   * supported by the hypervisor, as indicated by feature bits, should
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > index af3e7e817f9e..b46f083a630a 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -273,4 +273,5 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> >  			struct net_device *dev,
> >  			unsigned int *xdp_xmit,
> >  			struct virtnet_rq_stats *stats);
> > +int virtnet_tx_reset(struct virtnet_info *vi, struct send_queue *sq);
> >  #endif
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
