Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BABC63797
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 09:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03C96820E5;
	Fri,  3 Feb 2023 09:02:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03C96820E5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNDGYCpIAMjf; Fri,  3 Feb 2023 09:02:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 78CC881E52;
	Fri,  3 Feb 2023 09:02:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78CC881E52
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C1F8C0071;
	Fri,  3 Feb 2023 09:02:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFC51C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7AEB820D7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:02:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7AEB820D7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H3lrrY0VEuap
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:02:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22E4D81E52
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22E4D81E52
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:02:11 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R431e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VaoDUkj_1675414924; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VaoDUkj_1675414924) by smtp.aliyun-inc.com;
 Fri, 03 Feb 2023 17:02:04 +0800
Message-ID: <1675414906.6582208-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 16/33] virtio_net: introduce virtnet_xdp_handler() to
 seprate the logic of run xdp
Date: Fri, 3 Feb 2023 17:01:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-17-xuanzhuo@linux.alibaba.com>
 <20230203035416-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230203035416-mutt-send-email-mst@kernel.org>
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

On Fri, 3 Feb 2023 03:55:26 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Feb 02, 2023 at 07:00:41PM +0800, Xuan Zhuo wrote:
> > At present, we have two long similar logic to perform XDP Progs. And in
> > the implementation of XSK, we will have this need.
> >
> > Therefore, this PATCH separates the code of executing XDP, which is
> > conducive to later maintenance and facilitates subsequent XSK for reuse.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> So you first add a new function then move users over.
> This means that it's hard during review to make sure
> nothing is lost in translation.
> Do the refactoring in a single patch instead.

I agree.

Thanks.

>
> > ---
> >  drivers/net/virtio/main.c       | 53 +++++++++++++++++++++++++++++++++
> >  drivers/net/virtio/virtio_net.h | 11 +++++++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index 5683cb576474..9d4b84b23ef7 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -478,6 +478,59 @@ static int virtnet_xdp_xmit(struct net_device *dev,
> >  	return ret;
> >  }
> >
> > +int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> > +			struct net_device *dev,
> > +			unsigned int *xdp_xmit,
> > +			struct virtnet_rq_stats *stats)
> > +{
> > +	struct xdp_frame *xdpf;
> > +	int err;
> > +	u32 act;
> > +
> > +	act = bpf_prog_run_xdp(xdp_prog, xdp);
> > +	stats->xdp_packets++;
> > +
> > +	switch (act) {
> > +	case XDP_PASS:
> > +		return VIRTNET_XDP_RES_PASS;
> > +
> > +	case XDP_TX:
> > +		stats->xdp_tx++;
> > +		xdpf = xdp_convert_buff_to_frame(xdp);
> > +		if (unlikely(!xdpf))
> > +			return VIRTNET_XDP_RES_DROP;
> > +
> > +		err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
> > +		if (unlikely(!err)) {
> > +			xdp_return_frame_rx_napi(xdpf);
> > +		} else if (unlikely(err < 0)) {
> > +			trace_xdp_exception(dev, xdp_prog, act);
> > +			return VIRTNET_XDP_RES_DROP;
> > +		}
> > +
> > +		*xdp_xmit |= VIRTIO_XDP_TX;
> > +		return VIRTNET_XDP_RES_CONSUMED;
> > +
> > +	case XDP_REDIRECT:
> > +		stats->xdp_redirects++;
> > +		err = xdp_do_redirect(dev, xdp, xdp_prog);
> > +		if (err)
> > +			return VIRTNET_XDP_RES_DROP;
> > +
> > +		*xdp_xmit |= VIRTIO_XDP_REDIR;
> > +		return VIRTNET_XDP_RES_CONSUMED;
> > +
> > +	default:
> > +		bpf_warn_invalid_xdp_action(dev, xdp_prog, act);
> > +		fallthrough;
> > +	case XDP_ABORTED:
> > +		trace_xdp_exception(dev, xdp_prog, act);
> > +		fallthrough;
> > +	case XDP_DROP:
> > +		return VIRTNET_XDP_RES_DROP;
> > +	}
> > +}
> > +
> >  static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
> >  {
> >  	return vi->xdp_enabled ? VIRTIO_XDP_HEADROOM : 0;
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > index 8bf31429ae28..af3e7e817f9e 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -22,6 +22,12 @@
> >  #include <net/net_failover.h>
> >  #include <net/xdp_sock_drv.h>
> >
> > +enum {
> > +	VIRTNET_XDP_RES_PASS,
> > +	VIRTNET_XDP_RES_DROP,
> > +	VIRTNET_XDP_RES_CONSUMED,
> > +};
> > +
> >  #define VIRTIO_XDP_FLAG	BIT(0)
> >
> >  struct virtnet_info {
> > @@ -262,4 +268,9 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> >  		stats->packets++;
> >  	}
> >  }
> > +
> > +int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> > +			struct net_device *dev,
> > +			unsigned int *xdp_xmit,
> > +			struct virtnet_rq_stats *stats);
> >  #endif
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
