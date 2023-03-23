Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4794DC7619A
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 01:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C39DF41C14;
	Thu, 23 Mar 2023 01:50:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C39DF41C14
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rpqtUx1vmrNU; Thu, 23 Mar 2023 01:50:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB428417F5;
	Thu, 23 Mar 2023 01:50:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB428417F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A46C0C0035;
	Thu, 23 Mar 2023 01:50:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C199C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 01:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 563BA417F6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 01:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 563BA417F6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id prVPU95yLj5k
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 01:50:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 608A1417F5
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 608A1417F5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 01:50:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R501e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VeSND30_1679536210; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeSND30_1679536210) by smtp.aliyun-inc.com;
 Thu, 23 Mar 2023 09:50:11 +0800
Message-ID: <1679535924.6219428-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 2/8] virtio_net: mergeable xdp: introduce
 mergeable_xdp_prepare
Date: Thu, 23 Mar 2023 09:45:24 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230322030308.16046-3-xuanzhuo@linux.alibaba.com>
 <c7749936-c154-da51-ccfb-f16150d19c62@huawei.com>
In-Reply-To: <c7749936-c154-da51-ccfb-f16150d19c62@huawei.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

On Wed, 22 Mar 2023 19:52:48 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> On 2023/3/22 11:03, Xuan Zhuo wrote:
> > Separating the logic of preparation for xdp from receive_mergeable.
> >
> > The purpose of this is to simplify the logic of execution of XDP.
> >
> > The main logic here is that when headroom is insufficient, we need to
> > allocate a new page and calculate offset. It should be noted that if
> > there is new page, the variable page will refer to the new page.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 135 ++++++++++++++++++++++-----------------
> >  1 file changed, 77 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 4d2bf1ce0730..bb426958cdd4 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1162,6 +1162,79 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
> >  	return 0;
> >  }
> >
> > +static void *mergeable_xdp_prepare(struct virtnet_info *vi,
> > +				   struct receive_queue *rq,
> > +				   struct bpf_prog *xdp_prog,
> > +				   void *ctx,
> > +				   unsigned int *frame_sz,
> > +				   int *num_buf,
> > +				   struct page **page,
> > +				   int offset,
> > +				   unsigned int *len,
> > +				   struct virtio_net_hdr_mrg_rxbuf *hdr)
>
> The naming convention seems to be xdp_prepare_mergeable().

What convention?


>
> > +{
> > +	unsigned int truesize = mergeable_ctx_to_truesize(ctx);
> > +	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
> > +	struct page *xdp_page;
> > +	unsigned int xdp_room;
> > +
> > +	/* Transient failure which in theory could occur if
> > +	 * in-flight packets from before XDP was enabled reach
> > +	 * the receive path after XDP is loaded.
> > +	 */
> > +	if (unlikely(hdr->hdr.gso_type))
> > +		return NULL;
> > +
> > +	/* Now XDP core assumes frag size is PAGE_SIZE, but buffers
> > +	 * with headroom may add hole in truesize, which
> > +	 * make their length exceed PAGE_SIZE. So we disabled the
> > +	 * hole mechanism for xdp. See add_recvbuf_mergeable().
> > +	 */
> > +	*frame_sz = truesize;
> > +
> > +	/* This happens when headroom is not enough because
> > +	 * of the buffer was prefilled before XDP is set.
> > +	 * This should only happen for the first several packets.
> > +	 * In fact, vq reset can be used here to help us clean up
> > +	 * the prefilled buffers, but many existing devices do not
> > +	 * support it, and we don't want to bother users who are
> > +	 * using xdp normally.
> > +	 */
> > +	if (!xdp_prog->aux->xdp_has_frags &&
> > +	    (*num_buf > 1 || headroom < virtnet_get_headroom(vi))) {
> > +		/* linearize data for XDP */
> > +		xdp_page = xdp_linearize_page(rq, num_buf,
> > +					      *page, offset,
> > +					      VIRTIO_XDP_HEADROOM,
> > +					      len);
> > +
> > +		if (!xdp_page)
> > +			return NULL;
> > +	} else if (unlikely(headroom < virtnet_get_headroom(vi))) {
> > +		xdp_room = SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
> > +					  sizeof(struct skb_shared_info));
> > +		if (*len + xdp_room > PAGE_SIZE)
> > +			return NULL;
> > +
> > +		xdp_page = alloc_page(GFP_ATOMIC);
> > +		if (!xdp_page)
> > +			return NULL;
> > +
> > +		memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM,
> > +		       page_address(*page) + offset, *len);
>
> It seems the above 'else if' was not really tested even before this patch,
> as there is no "--*num_buf" if xdp_linearize_page() is not called, which
> may causes virtnet_build_xdp_buff_mrg() to comsume one more buffer than
> expected?

Why do you think so?

>
> Also, it seems better to split the xdp_linearize_page() to two functions
> as pskb_expand_head() and __skb_linearize() do, one to expand the headroom,
> the other one to do the linearizing.

No skb here.


>
>
> > +	} else {
> > +		return page_address(*page) + offset;
> > +	}
> > +
> > +	*frame_sz = PAGE_SIZE;
> > +
> > +	put_page(*page);
> > +
> > +	*page = xdp_page;
> > +
> > +	return page_address(xdp_page) + VIRTIO_XDP_HEADROOM;
> > +}
> > +
> >  static struct sk_buff *receive_mergeable(struct net_device *dev,
> >  					 struct virtnet_info *vi,
> >  					 struct receive_queue *rq,
> > @@ -1181,7 +1254,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> >  	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
> >  	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
> >  	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
> > -	unsigned int frame_sz, xdp_room;
> > +	unsigned int frame_sz;
> >  	int err;
> >
> >  	head_skb = NULL;
> > @@ -1211,65 +1284,11 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> >  		u32 act;
> >  		int i;
> >
> > -		/* Transient failure which in theory could occur if
> > -		 * in-flight packets from before XDP was enabled reach
> > -		 * the receive path after XDP is loaded.
> > -		 */
> > -		if (unlikely(hdr->hdr.gso_type))
> > +		data = mergeable_xdp_prepare(vi, rq, xdp_prog, ctx, &frame_sz, &num_buf, &page,
> > +					     offset, &len, hdr);
> > +		if (!data)
>
> unlikely().


Thanks.

>
> >  			goto err_xdp;
> >
> > -		/* Now XDP core assumes frag size is PAGE_SIZE, but buffers
> > -		 * with headroom may add hole in truesize, which
> > -		 * make their length exceed PAGE_SIZE. So we disabled the
> > -		 * hole mechanism for xdp. See add_recvbuf_mergeable().
> > -		 */
> > -		frame_sz = truesize;
> > -
> > -		/* This happens when headroom is not enough because
> > -		 * of the buffer was prefilled before XDP is set.
> > -		 * This should only happen for the first several packets.
> > -		 * In fact, vq reset can be used here to help us clean up
> > -		 * the prefilled buffers, but many existing devices do not
> > -		 * support it, and we don't want to bother users who are
> > -		 * using xdp normally.
> > -		 */
> > -		if (!xdp_prog->aux->xdp_has_frags &&
> > -		    (num_buf > 1 || headroom < virtnet_get_headroom(vi))) {
> > -			/* linearize data for XDP */
> > -			xdp_page = xdp_linearize_page(rq, &num_buf,
> > -						      page, offset,
> > -						      VIRTIO_XDP_HEADROOM,
> > -						      &len);
> > -			frame_sz = PAGE_SIZE;
> > -
> > -			if (!xdp_page)
> > -				goto err_xdp;
> > -			offset = VIRTIO_XDP_HEADROOM;
> > -
> > -			put_page(page);
> > -			page = xdp_page;
> > -		} else if (unlikely(headroom < virtnet_get_headroom(vi))) {
> > -			xdp_room = SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
> > -						  sizeof(struct skb_shared_info));
> > -			if (len + xdp_room > PAGE_SIZE)
> > -				goto err_xdp;
> > -
> > -			xdp_page = alloc_page(GFP_ATOMIC);
> > -			if (!xdp_page)
> > -				goto err_xdp;
> > -
> > -			memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM,
> > -			       page_address(page) + offset, len);
> > -			frame_sz = PAGE_SIZE;
> > -			offset = VIRTIO_XDP_HEADROOM;
> > -
> > -			put_page(page);
> > -			page = xdp_page;
> > -		} else {
> > -			xdp_page = page;
> > -		}
> > -
> > -		data = page_address(xdp_page) + offset;
> >  		err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
> >  						 &num_buf, &xdp_frags_truesz, stats);
> >  		if (unlikely(err))
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
