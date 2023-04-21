Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF93DC77B78
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 07:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D4FF84061;
	Fri, 21 Apr 2023 07:31:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D4FF84061
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FN_T0nZ_kVmg; Fri, 21 Apr 2023 07:31:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C5B488403E;
	Fri, 21 Apr 2023 07:31:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5B488403E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5509C007A;
	Fri, 21 Apr 2023 07:31:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4522C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76E9A61142
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:31:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76E9A61142
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pdq9dIjoWfVF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:31:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99D90610FC
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99D90610FC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:30:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R771e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VgbmRQT_1682062252; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgbmRQT_1682062252) by smtp.aliyun-inc.com;
 Fri, 21 Apr 2023 15:30:53 +0800
Message-ID: <1682061840.4864874-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 05/14] virtio_net: introduce xdp res enums
Date: Fri, 21 Apr 2023 15:24:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-6-xuanzhuo@linux.alibaba.com>
 <20230421025931-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230421025931-mutt-send-email-mst@kernel.org>
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

On Fri, 21 Apr 2023 03:00:15 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Apr 18, 2023 at 02:53:18PM +0800, Xuan Zhuo wrote:
> > virtnet_xdp_handler() is to process all the logic related to XDP. The
> > caller only needs to care about how to deal with the buf. So this commit
> > introduces new enums:
> >
> > 1. VIRTNET_XDP_RES_PASS: make skb by the buf
> > 2. VIRTNET_XDP_RES_DROP: xdp return drop action or some error, caller
> >    should release the buf
> > 3. VIRTNET_XDP_RES_CONSUMED: xdp consumed the buf, the caller doesnot to
> >    do anything
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>
> I am not excited about using virtio specific enums then translating
> to standard ones.


My fault, my expression is not very complete.

This is not a replacement, but just want to say, there are only three cases of
virtnet_xdp_handler. Caller only needs to handle this three cases. Instead
of paying attention to the detailed return results of XDP.

In addition, virtnet_xdp_handler returns XDP_TX, but in fact, the work of XDP_TX
is already done in Virtnet_xdp_handler. Caller does not need to do anything for
XDP_TX, giving people a feeling, XDP_TX does not need to be processed. I think
it is not good.

Thanks.



>
> > ---
> >  drivers/net/virtio_net.c | 42 ++++++++++++++++++++++++++--------------
> >  1 file changed, 27 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0fa64c314ea7..4dfdc211d355 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -301,6 +301,15 @@ struct padded_vnet_hdr {
> >  	char padding[12];
> >  };
> >
> > +enum {
> > +	/* xdp pass */
> > +	VIRTNET_XDP_RES_PASS,
> > +	/* drop packet. the caller needs to release the page. */
> > +	VIRTNET_XDP_RES_DROP,
> > +	/* packet is consumed by xdp. the caller needs to do nothing. */
> > +	VIRTNET_XDP_RES_CONSUMED,
> > +};
> > +
> >  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> >
> > @@ -803,14 +812,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> >
> >  	switch (act) {
> >  	case XDP_PASS:
> > -		return act;
> > +		return VIRTNET_XDP_RES_PASS;
> >
> >  	case XDP_TX:
> >  		stats->xdp_tx++;
> >  		xdpf = xdp_convert_buff_to_frame(xdp);
> >  		if (unlikely(!xdpf)) {
> >  			netdev_dbg(dev, "convert buff to frame failed for xdp\n");
> > -			return XDP_DROP;
> > +			return VIRTNET_XDP_RES_DROP;
> >  		}
> >
> >  		err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
> > @@ -818,19 +827,20 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> >  			xdp_return_frame_rx_napi(xdpf);
> >  		} else if (unlikely(err < 0)) {
> >  			trace_xdp_exception(dev, xdp_prog, act);
> > -			return XDP_DROP;
> > +			return VIRTNET_XDP_RES_DROP;
> >  		}
> > +
> >  		*xdp_xmit |= VIRTIO_XDP_TX;
> > -		return act;
> > +		return VIRTNET_XDP_RES_CONSUMED;
> >
> >  	case XDP_REDIRECT:
> >  		stats->xdp_redirects++;
> >  		err = xdp_do_redirect(dev, xdp, xdp_prog);
> >  		if (err)
> > -			return XDP_DROP;
> > +			return VIRTNET_XDP_RES_DROP;
> >
> >  		*xdp_xmit |= VIRTIO_XDP_REDIR;
> > -		return act;
> > +		return VIRTNET_XDP_RES_CONSUMED;
> >
> >  	default:
> >  		bpf_warn_invalid_xdp_action(dev, xdp_prog, act);
> > @@ -839,7 +849,7 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> >  		trace_xdp_exception(dev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_DROP:
> > -		return XDP_DROP;
> > +		return VIRTNET_XDP_RES_DROP;
> >  	}
> >  }
> >
> > @@ -987,17 +997,18 @@ static struct sk_buff *receive_small(struct net_device *dev,
> >  		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> >
> >  		switch (act) {
> > -		case XDP_PASS:
> > +		case VIRTNET_XDP_RES_PASS:
> >  			/* Recalculate length in case bpf program changed it */
> >  			delta = orig_data - xdp.data;
> >  			len = xdp.data_end - xdp.data;
> >  			metasize = xdp.data - xdp.data_meta;
> >  			break;
> > -		case XDP_TX:
> > -		case XDP_REDIRECT:
> > +
> > +		case VIRTNET_XDP_RES_CONSUMED:
> >  			rcu_read_unlock();
> >  			goto xdp_xmit;
> > -		default:
> > +
> > +		case VIRTNET_XDP_RES_DROP:
> >  			goto err_xdp;
> >  		}
> >  	}
> > @@ -1324,18 +1335,19 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> >  		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> >
> >  		switch (act) {
> > -		case XDP_PASS:
> > +		case VIRTNET_XDP_RES_PASS:
> >  			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> >  			if (unlikely(!head_skb))
> >  				goto err_xdp_frags;
> >
> >  			rcu_read_unlock();
> >  			return head_skb;
> > -		case XDP_TX:
> > -		case XDP_REDIRECT:
> > +
> > +		case VIRTNET_XDP_RES_CONSUMED:
> >  			rcu_read_unlock();
> >  			goto xdp_xmit;
> > -		default:
> > +
> > +		case VIRTNET_XDP_RES_DROP:
> >  			break;
> >  		}
> >  err_xdp_frags:
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
