Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A170BC433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 08:12:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9B423131
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 08:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9B423131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9DA7D86D42;
	Wed, 20 Jan 2021 08:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3t4cG9AUm71H; Wed, 20 Jan 2021 08:12:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C364B86631;
	Wed, 20 Jan 2021 08:12:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB56FC08A1;
	Wed, 20 Jan 2021 08:12:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81AFFC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7DE7D80CEC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:12:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GULVpr-TzmuE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:12:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0F123806F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611130320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SgoON6JCbiRoEe3MsxmL7+i8CTj6HRhH96NwSvSwXcc=;
 b=W5VvnZPPTNXyseReGbsJiWrDLKquynG3QR4UJPJ4UCVoUaxmXSdj+m0gYBCuvVUp1N82fb
 khotffMened5jjWTsy/D+1NjoK786QFF2BBvdJKiJ1SEekOqVMcEImmYp81dVmiYzXFCJ8
 hnobXFIZvHGwQpSJRx75OBC9vDVH9c8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-6D2LtGO6MSCsMbrRVOC_OA-1; Wed, 20 Jan 2021 03:11:58 -0500
X-MC-Unique: 6D2LtGO6MSCsMbrRVOC_OA-1
Received: by mail-wm1-f69.google.com with SMTP id r1so971705wmn.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SgoON6JCbiRoEe3MsxmL7+i8CTj6HRhH96NwSvSwXcc=;
 b=klLLNNEW7b0IPwX0Tgoog3np+QQ3Euj4h0Wax4RfK5szFSuUvQG1Qd/4qnuNDArEEt
 FPMBgZNrsdiicjSlHygw1Di87Nw9EIt8lXJZc/v5gtCm/6a/aZdkyd/f4P9rgewhv8R+
 FUszDED3JnrPrgC1JcqoKQFtzSDp+xwWR/qEmjFBYVVQk5m8C7gjneWC63ZzlU88NlmZ
 5qdBnrC2x+tv+YgZb8WQaF2Ip4xxJa12LVnkt7LcmpZJU4sztRQYMMvriBxXmS4eVrn3
 AzWS6beCpSzL7v1Dg560tALa+Nq9Qo8uHvKbaNFy4p2hpZEuv/VSyDx3NdDE5m2mk5iC
 KwZA==
X-Gm-Message-State: AOAM5333TGjNeL4LeK8oLZRiQsyZUBwIUoecp2sCqkobzKSTz006Z4Vp
 maOUQ00oJd4GPgS/IvxX7frp4P1DjqJ+gyCN2L6VjDYGidra/9xbSW2M1BfML3GMdeOpph/9b/e
 +wLw+E7jd48QJwl+MsHLCeEd8JA3bsm3Aqpnj9ZJsYA==
X-Received: by 2002:a05:6000:11c1:: with SMTP id
 i1mr8130847wrx.16.1611130317171; 
 Wed, 20 Jan 2021 00:11:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+qxq/9yALfuQf8DHvIqACZWEbB+C15hwmEqydGIBZ5tMlhik23jRChzHH2VZSQ71fjPH6aw==
X-Received: by 2002:a05:6000:11c1:: with SMTP id
 i1mr8130807wrx.16.1611130316948; 
 Wed, 20 Jan 2021 00:11:56 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id h9sm2367974wre.24.2021.01.20.00.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 00:11:56 -0800 (PST)
Date: Wed, 20 Jan 2021 03:11:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 3/3] xsk: build skb by page
Message-ID: <20210120031130-mutt-send-email-mst@kernel.org>
References: <cover.1611128806.git.xuanzhuo@linux.alibaba.com>
 <6787e9a100eba47efbff81939e21e97fef492d07.1611128806.git.xuanzhuo@linux.alibaba.com>
 <20210120030418-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210120030418-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexander Lobakin <alobakin@pm.me>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, bjorn.topel@intel.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jan 20, 2021 at 03:11:04AM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 20, 2021 at 03:50:01PM +0800, Xuan Zhuo wrote:
> > This patch is used to construct skb based on page to save memory copy
> > overhead.
> > 
> > This function is implemented based on IFF_TX_SKB_NO_LINEAR. Only the
> > network card priv_flags supports IFF_TX_SKB_NO_LINEAR will use page to
> > directly construct skb. If this feature is not supported, it is still
> > necessary to copy data to construct skb.
> > 
> > ---------------- Performance Testing ------------
> > 
> > The test environment is Aliyun ECS server.
> > Test cmd:
> > ```
> > xdpsock -i eth0 -t  -S -s <msg size>
> > ```
> > 
> > Test result data:
> > 
> > size    64      512     1024    1500
> > copy    1916747 1775988 1600203 1440054
> > page    1974058 1953655 1945463 1904478
> > percent 3.0%    10.0%   21.58%  32.3%
> > 
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> 
> I can't see the cover letter or 1/3 in this series - was probably
> threaded incorrectly?


Hmm looked again and now I do see them. My mistake pls ignore.

> 
> > ---
> >  net/xdp/xsk.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 86 insertions(+), 18 deletions(-)
> > 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 8037b04..817a3a5 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -430,6 +430,87 @@ static void xsk_destruct_skb(struct sk_buff *skb)
> >  	sock_wfree(skb);
> >  }
> >  
> > +static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > +					      struct xdp_desc *desc)
> > +{
> > +	u32 len, offset, copy, copied;
> > +	struct sk_buff *skb;
> > +	struct page *page;
> > +	char *buffer;
> 
> Actually, make this void *, this way you will not need
> casts down the road. I know this is from xsk_generic_xmit -
> I don't know why it's char * there, either.
> 
> > +	int err, i;
> > +	u64 addr;
> > +
> > +	skb = sock_alloc_send_skb(&xs->sk, 0, 1, &err);
> > +	if (unlikely(!skb))
> > +		return ERR_PTR(err);
> > +
> > +	addr = desc->addr;
> > +	len = desc->len;
> > +
> > +	buffer = xsk_buff_raw_get_data(xs->pool, addr);
> > +	offset = offset_in_page(buffer);
> > +	addr = buffer - (char *)xs->pool->addrs;
> > +
> > +	for (copied = 0, i = 0; copied < len; i++) {
> > +		page = xs->pool->umem->pgs[addr >> PAGE_SHIFT];
> > +
> > +		get_page(page);
> > +
> > +		copy = min_t(u32, PAGE_SIZE - offset, len - copied);
> > +
> > +		skb_fill_page_desc(skb, i, page, offset, copy);
> > +
> > +		copied += copy;
> > +		addr += copy;
> > +		offset = 0;
> > +	}
> > +
> > +	skb->len += len;
> > +	skb->data_len += len;
> > +	skb->truesize += len;
> > +
> > +	refcount_add(len, &xs->sk.sk_wmem_alloc);
> > +
> > +	return skb;
> > +}
> > +
> > +static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > +				     struct xdp_desc *desc)
> > +{
> > +	struct sk_buff *skb = NULL;
> > +
> > +	if (xs->dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> > +		skb = xsk_build_skb_zerocopy(xs, desc);
> > +		if (IS_ERR(skb))
> > +			return skb;
> > +	} else {
> > +		char *buffer;
> > +		u32 len;
> > +		int err;
> > +
> > +		len = desc->len;
> > +		skb = sock_alloc_send_skb(&xs->sk, len, 1, &err);
> > +		if (unlikely(!skb))
> > +			return ERR_PTR(err);
> > +
> > +		skb_put(skb, len);
> > +		buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
> > +		err = skb_store_bits(skb, 0, buffer, len);
> > +		if (unlikely(err)) {
> > +			kfree_skb(skb);
> > +			return ERR_PTR(err);
> > +		}
> > +	}
> > +
> > +	skb->dev = xs->dev;
> > +	skb->priority = xs->sk.sk_priority;
> > +	skb->mark = xs->sk.sk_mark;
> > +	skb_shinfo(skb)->destructor_arg = (void *)(long)desc->addr;
> > +	skb->destructor = xsk_destruct_skb;
> > +
> > +	return skb;
> > +}
> > +
> >  static int xsk_generic_xmit(struct sock *sk)
> >  {
> >  	struct xdp_sock *xs = xdp_sk(sk);
> > @@ -446,43 +527,30 @@ static int xsk_generic_xmit(struct sock *sk)
> >  		goto out;
> >  
> >  	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> > -		char *buffer;
> > -		u64 addr;
> > -		u32 len;
> > -
> >  		if (max_batch-- == 0) {
> >  			err = -EAGAIN;
> >  			goto out;
> >  		}
> >  
> > -		len = desc.len;
> > -		skb = sock_alloc_send_skb(sk, len, 1, &err);
> > -		if (unlikely(!skb))
> > +		skb = xsk_build_skb(xs, &desc);
> > +		if (IS_ERR(skb)) {
> > +			err = PTR_ERR(skb);
> >  			goto out;
> > +		}
> >  
> > -		skb_put(skb, len);
> > -		addr = desc.addr;
> > -		buffer = xsk_buff_raw_get_data(xs->pool, addr);
> > -		err = skb_store_bits(skb, 0, buffer, len);
> >  		/* This is the backpressure mechanism for the Tx path.
> >  		 * Reserve space in the completion queue and only proceed
> >  		 * if there is space in it. This avoids having to implement
> >  		 * any buffering in the Tx path.
> >  		 */
> >  		spin_lock_irqsave(&xs->pool->cq_lock, flags);
> > -		if (unlikely(err) || xskq_prod_reserve(xs->pool->cq)) {
> > +		if (xskq_prod_reserve(xs->pool->cq)) {
> >  			spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
> >  			kfree_skb(skb);
> >  			goto out;
> >  		}
> >  		spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
> >  
> > -		skb->dev = xs->dev;
> > -		skb->priority = sk->sk_priority;
> > -		skb->mark = sk->sk_mark;
> > -		skb_shinfo(skb)->destructor_arg = (void *)(long)desc.addr;
> > -		skb->destructor = xsk_destruct_skb;
> > -
> >  		err = __dev_direct_xmit(skb, xs->queue_id);
> >  		if  (err == NETDEV_TX_BUSY) {
> >  			/* Tell user-space to retry the send */
> > -- 
> > 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
