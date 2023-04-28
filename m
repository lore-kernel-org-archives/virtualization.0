Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0B2C77B73
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 01:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C85141E30;
	Fri, 28 Apr 2023 01:54:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C85141E30
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ERG2HUcIyC3Z; Fri, 28 Apr 2023 01:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A2F4C402D4;
	Fri, 28 Apr 2023 01:54:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A2F4C402D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7ED5CC0036;
	Fri, 28 Apr 2023 01:54:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3417C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8D7441E2C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:54:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8D7441E2C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fIVzXk0YwjH
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:54:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E57FB402D4
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E57FB402D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:54:38 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R661e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vh9OEYK_1682646872; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vh9OEYK_1682646872) by smtp.aliyun-inc.com;
 Fri, 28 Apr 2023 09:54:33 +0800
Message-ID: <1682646856.5083742-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 12/15] virtio_net: small: avoid double
 counting in xdp scenarios
Date: Fri, 28 Apr 2023 09:54:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230427030534.115066-1-xuanzhuo@linux.alibaba.com>
 <20230427030534.115066-13-xuanzhuo@linux.alibaba.com>
 <20230427210802-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230427210802-mutt-send-email-mst@kernel.org>
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

On Thu, 27 Apr 2023 21:08:25 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Apr 27, 2023 at 11:05:31AM +0800, Xuan Zhuo wrote:
> > Avoid the problem that some variables(headroom and so on) will repeat
> > the calculation when process xdp.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
>
> this is "code duplication" not "double counting".

Will fix.

Thanks.


>
>
> > ---
> >  drivers/net/virtio_net.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index b8ec642899c9..f832ab8a3e6e 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1027,11 +1027,10 @@ static struct sk_buff *receive_small(struct net_device *dev,
> >  	struct sk_buff *skb;
> >  	struct bpf_prog *xdp_prog;
> >  	unsigned int xdp_headroom = (unsigned long)ctx;
> > -	unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
> > -	unsigned int headroom = vi->hdr_len + header_offset;
> > -	unsigned int buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> > -			      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >  	struct page *page = virt_to_head_page(buf);
> > +	unsigned int header_offset;
> > +	unsigned int headroom;
> > +	unsigned int buflen;
> >
> >  	len -= vi->hdr_len;
> >  	stats->bytes += len;
> > @@ -1059,6 +1058,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
> >  	rcu_read_unlock();
> >
> >  skip_xdp:
> > +	header_offset = VIRTNET_RX_PAD + xdp_headroom;
> > +	headroom = vi->hdr_len + header_offset;
> > +	buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> > +		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +
> >  	skb = build_skb(buf, buflen);
> >  	if (!skb)
> >  		goto err;
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
