Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80636C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 11:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D24040396;
	Tue, 14 Mar 2023 11:28:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D24040396
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ELK0-OhRFyKv; Tue, 14 Mar 2023 11:28:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 99033403C7;
	Tue, 14 Mar 2023 11:28:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99033403C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 711D6C0035;
	Tue, 14 Mar 2023 11:28:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B0FBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 11:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62ACC61093
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 11:28:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62ACC61093
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cHOzP5jM9TWU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 11:28:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96F9661063
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96F9661063
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 11:28:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VdsByGS_1678793285; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdsByGS_1678793285) by smtp.aliyun-inc.com;
 Tue, 14 Mar 2023 19:28:06 +0800
Message-ID: <1678793273.5523777-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v1 2/2] virtio_net: free xdp shinfo frags when
 build_skb_from_xdp_buff() fails
Date: Tue, 14 Mar 2023 19:27:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
References: <20230314104939.67212-1-xuanzhuo@linux.alibaba.com>
 <20230314104939.67212-3-xuanzhuo@linux.alibaba.com>
 <faf3772c-b494-54bd-b29a-6cc3068985d5@huawei.com>
In-Reply-To: <faf3772c-b494-54bd-b29a-6cc3068985d5@huawei.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Heng Qi <hengqi@linux.alibaba.com>,
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

On Tue, 14 Mar 2023 19:19:19 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> On 2023/3/14 18:49, Xuan Zhuo wrote:
> > build_skb_from_xdp_buff() may return NULL, in this case
> > we need to free the frags of xdp shinfo.
> >
> > Fixes: fab89bafa95b ("virtio-net: support multi-buffer xdp")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 8ecf7a341d54..d36183be0481 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1273,9 +1273,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> >
> >  		switch (act) {
> >  		case XDP_PASS:
> > +			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> > +			if (!head_skb)
>
> It is a error case, perhaps add a unlikely() for it.

Yes. Will fix.

Thanks.


>
> > +				goto err_xdp_frags;
> > +
> >  			if (unlikely(xdp_page != page))
> >  				put_page(page);
> > -			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> >  			rcu_read_unlock();
> >  			return head_skb;
> >  		case XDP_TX:
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
