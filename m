Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405CDC6FD1D
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 02:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C626A60B5A;
	Wed, 15 Mar 2023 02:20:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C626A60B5A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jTqNNblVLQIx; Wed, 15 Mar 2023 02:20:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F03160B36;
	Wed, 15 Mar 2023 02:20:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F03160B36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EA5CC0071;
	Wed, 15 Mar 2023 02:20:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ADDCC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 02:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 630CC60B36
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 02:20:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 630CC60B36
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GWLGubeEoI_Z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 02:19:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5D46607F5
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5D46607F5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 02:19:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R501e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VduCST._1678846792; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VduCST._1678846792) by smtp.aliyun-inc.com;
 Wed, 15 Mar 2023 10:19:52 +0800
Message-ID: <1678846773.823149-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 2/2] virtio_net: free xdp shinfo frags when
 build_skb_from_xdp_buff() fails
Date: Wed, 15 Mar 2023 10:19:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
References: <20230315015223.89137-1-xuanzhuo@linux.alibaba.com>
 <20230315015223.89137-3-xuanzhuo@linux.alibaba.com>
 <0ebbc591-c1db-b11d-c7bd-c9869122caa7@huawei.com>
In-Reply-To: <0ebbc591-c1db-b11d-c7bd-c9869122caa7@huawei.com>
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

On Wed, 15 Mar 2023 10:14:34 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> On 2023/3/15 9:52, Xuan Zhuo wrote:
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
> > index 8ecf7a341d54..2396c28c0122 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1273,9 +1273,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> >
> >  		switch (act) {
> >  		case XDP_PASS:
> > +			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> > +			if (unlikely(!head_skb))
> > +				goto err_xdp_frags;
>
> LGTM.
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
>
> Note, "stats->drops++; dev_kfree_skb(head_skb);" is also done for the above case,
> I assume it is ok as other "goto err_xdp_frags" case also do that.


Yes. It's ok.

Thanks.


>
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
