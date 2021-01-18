Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A9C433E0
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 11:57:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B6A2231F
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 11:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B6A2231F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E0D38667B;
	Mon, 18 Jan 2021 11:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZNWovmQtikqR; Mon, 18 Jan 2021 11:57:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3ECC386554;
	Mon, 18 Jan 2021 11:57:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22467C08A1;
	Mon, 18 Jan 2021 11:57:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10DA5C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 11:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F1F9787017
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 11:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SczERtMluSX8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 11:57:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9950887011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610971071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LoqPxpfeYycDuUL/2cYOBhH9WdXmeOhkFIXWsmpTNSw=;
 b=HRQJkuwOCCSH+tzkRcm2sfYj2VbxX4OYvnWJXbw5V/UMhf9q5lVRBt3mkNh1yXYv08tcbW
 J2WvekoHYe6MvyXiM7q+ZcTI6y0jvJtZfCNCSAkKOoPl+yh7P8KaelW5/eAO0jy4oit+Oz
 GmeKipK9Tg3Rqq51DF9DQaK3GeKj85w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-jP0gUwl_Obue1QrR0WzJvg-1; Mon, 18 Jan 2021 06:57:49 -0500
X-MC-Unique: jP0gUwl_Obue1QrR0WzJvg-1
Received: by mail-wm1-f71.google.com with SMTP id s24so1920759wmj.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 03:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LoqPxpfeYycDuUL/2cYOBhH9WdXmeOhkFIXWsmpTNSw=;
 b=TvYUnFMsvpYE18xKTSg5vM/yS4O94OEnSsoH+w9XTZK4dIVnwXG6my9K+nQ/lF8oqJ
 fa2SuGOLBcWwI04IuGwo/hZqNRVCAsoL+3DcbSQj10Qbpw3+LaS9CrB3syKgs1IoM4cU
 VqFtsGmeD2TOvvLqym1YJpiKVzEIGEbaBSaMg8+4cTdauOBqzrWC2tHoAU/0n/8OhSi5
 cTTvNJZnPfgss0Y/ceunknMqNwyzrUGTFqXSbesadCbWVFyr5lSFvbUeAJ4SC0jrGL3b
 cK2IzD7r3GnyKKbZEWIpUHwuc+hP38YcWm3ib2DJ48VTxSv/O03CvG/yU1FoRN1jJgit
 MVOA==
X-Gm-Message-State: AOAM533/KR3Z657q6GAXxmani+lk8Z8s4xMRyKGCb2hRvE+mNqfUy/Ob
 IuuIL9BpFg+z9OSHyJQw4u+0MSxgHHR/JUrzp9m6ZOYN7XsRkQqjH4YQyYI618B590FzjpM+6Y8
 vXv8Su9eyA9y/SemSHI0JT+rWCquCL4Nb5SowoTp4GQ==
X-Received: by 2002:adf:e705:: with SMTP id c5mr24925184wrm.303.1610971066989; 
 Mon, 18 Jan 2021 03:57:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTh4vSeufaPJSnJVf3R7wVFsQj/rkTLW1VQyr3aMQQQsUAC4pwJ8IXd1eSkAL4NCaIVrJ8Iw==
X-Received: by 2002:adf:e705:: with SMTP id c5mr24925168wrm.303.1610971066777; 
 Mon, 18 Jan 2021 03:57:46 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id d2sm29288739wre.39.2021.01.18.03.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 03:57:46 -0800 (PST)
Date: Mon, 18 Jan 2021 06:57:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH bpf-next] xsk: build skb by page
Message-ID: <20210118065333-mutt-send-email-mst@kernel.org>
References: <579fa463bba42ac71591540a1811dca41d725350.1610764948.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <579fa463bba42ac71591540a1811dca41d725350.1610764948.git.xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Miaohe Lin <linmiaohe@huawei.com>, Michal Kubecek <mkubecek@suse.cz>,
 Song Liu <songliubraving@fb.com>, Andrew Lunn <andrew@lunn.ch>,
 Alexander Lobakin <alobakin@pm.me>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Meir Lichtinger <meirl@mellanox.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yhs@fb.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 Antoine Tenart <atenart@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>
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

On Sat, Jan 16, 2021 at 10:44:53AM +0800, Xuan Zhuo wrote:
> This patch is used to construct skb based on page to save memory copy
> overhead.
> 
> This has one problem:
> 
> We construct the skb by fill the data page as a frag into the skb. In
> this way, the linear space is empty, and the header information is also
> in the frag, not in the linear space, which is not allowed for some
> network cards. For example, Mellanox Technologies MT27710 Family
> [ConnectX-4 Lx] will get the following error message:
> 
>     mlx5_core 0000:3b:00.1 eth1: Error cqe on cqn 0x817, ci 0x8, qn 0x1dbb, opcode 0xd, syndrome 0x1, vendor syndrome 0x68
>     00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000030: 00 00 00 00 60 10 68 01 0a 00 1d bb 00 0f 9f d2
>     WQE DUMP: WQ size 1024 WQ cur size 0, WQE index 0xf, len: 64
>     00000000: 00 00 0f 0a 00 1d bb 03 00 00 00 08 00 00 00 00
>     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000020: 00 00 00 2b 00 08 00 00 00 00 00 05 9e e3 08 00
>     00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     mlx5_core 0000:3b:00.1 eth1: ERR CQE on SQ: 0x1dbb
> 
> I also tried to use build_skb to construct skb, but because of the
> existence of skb_shinfo, it must be behind the linear space, so this
> method is not working. We can't put skb_shinfo on desc->addr, it will be
> exposed to users, this is not safe.
> 
> Finally, I added a feature NETIF_F_SKB_NO_LINEAR to identify whether the
> network card supports the header information of the packet in the frag
> and not in the linear space.
> 
> ---------------- Performance Testing ------------
> 
> The test environment is Aliyun ECS server.
> Test cmd:
> ```
> xdpsock -i eth0 -t  -S -s <msg size>
> ```
> 
> Test result data:
> 
> size    64      512     1024    1500
> copy    1916747 1775988 1600203 1440054
> page    1974058 1953655 1945463 1904478
> percent 3.0%    10.0%   21.58%  32.3%

Nice, but it looks like the patch presented wouldn't compile.
It's worth retesting after you actually make it compile.

> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c        |   2 +-
>  include/linux/netdev_features.h |   5 +-
>  net/ethtool/common.c            |   1 +
>  net/xdp/xsk.c                   | 108 +++++++++++++++++++++++++++++++++-------
>  4 files changed, 97 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4ecccb8..841a331 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2985,7 +2985,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	/* Set up network device as normal. */
>  	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
>  	dev->netdev_ops = &virtnet_netdev;
> -	dev->features = NETIF_F_HIGHDMA;
> +	dev->features = NETIF_F_HIGHDMA | NETIF_F_SKB_NO_LINEAR;
>  
>  	dev->ethtool_ops = &virtnet_ethtool_ops;
>  	SET_NETDEV_DEV(dev, &vdev->dev);
> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
> index 934de56..8dd28e2 100644
> --- a/include/linux/netdev_features.h
> +++ b/include/linux/netdev_features.h
> @@ -85,9 +85,11 @@ enum {
>  
>  	NETIF_F_HW_MACSEC_BIT,		/* Offload MACsec operations */
>  
> +	NETIF_F_SKB_NO_LINEAR_BIT,	/* Allow skb linear is empty */
> +
>  	/*
>  	 * Add your fresh new feature above and remember to update
> -	 * netdev_features_strings[] in net/core/ethtool.c and maybe
> +	 * netdev_features_strings[] in net/ethtool/common.c and maybe
>  	 * some feature mask #defines below. Please also describe it
>  	 * in Documentation/networking/netdev-features.rst.
>  	 */
> @@ -157,6 +159,7 @@ enum {
>  #define NETIF_F_GRO_FRAGLIST	__NETIF_F(GRO_FRAGLIST)
>  #define NETIF_F_GSO_FRAGLIST	__NETIF_F(GSO_FRAGLIST)
>  #define NETIF_F_HW_MACSEC	__NETIF_F(HW_MACSEC)
> +#define NETIF_F_SKB_NO_LINEAR	__NETIF_F(SKB_NO_LINEAR)
>  
>  /* Finds the next feature with the highest number of the range of start till 0.
>   */
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 24036e3..2f3d309 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -68,6 +68,7 @@
>  	[NETIF_F_HW_TLS_RX_BIT] =	 "tls-hw-rx-offload",
>  	[NETIF_F_GRO_FRAGLIST_BIT] =	 "rx-gro-list",
>  	[NETIF_F_HW_MACSEC_BIT] =	 "macsec-hw-offload",
> +	[NETIF_F_SKB_NO_LINEAR_BIT] =	 "skb-no-linear",
>  };
>  
>  const char
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 8037b04..94d17dc 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -430,6 +430,95 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>  	sock_wfree(skb);
>  }
>  
> +static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> +					      struct xdp_desc *desc)
> +{
> +	u32 len, offset, copy, copied;
> +	struct sk_buff *skb;
> +	struct page *page;
> +	char *buffer;
> +	int err, i;
> +	u64 addr;
> +
> +	skb = sock_alloc_send_skb(&xs->sk, 0, 1, &err);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	addr = desc->addr;
> +	len = desc->len;
> +
> +	buffer = xsk_buff_raw_get_data(xs->pool, addr);
> +	offset = offset_in_page(buffer);
> +	addr = buffer - (char *)xs->pool->addrs;
> +
> +	for (copied = 0, i = 0; copied < len; ++i) {
> +		page = xs->pool->umem->pgs[addr >> PAGE_SHIFT];
> +
> +		get_page(page);
> +
> +		copy = min((u32)(PAGE_SIZE - offset), len - copied);
> +
> +		skb_fill_page_desc(skb, i, page, offset, copy);
> +
> +		copied += copy;
> +		addr += copy;
> +		offset = 0;
> +	}
> +
> +	skb->len += len;
> +	skb->data_len += len;
> +	skb->truesize += len;
> +
> +	refcount_add(len, &xs->sk.sk_wmem_alloc);
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> +				     struct xdp_desc *desc, int *err)

Rather than passing int *err, you can return PTR_ERR.
Seems cleaner ...

> +{
> +	struct sk_buff *skb;
> +
> +	if (xs->dev->features & NETIF_F_SKB_NO_LINEAR) {
> +		skb = xsk_build_skb_zerocopy(xs, desc);
> +		if (unlikely(!skb)) {
> +			*err = -ENOMEM;
> +			return NULL;
> +		}
> +	} else {
> +		char *buffer;
> +		u64 addr;
> +		u32 len;
> +		int err;

So err is int here

> +
> +		len = desc->len;
> +		skb = sock_alloc_send_skb(&xs->sk, len, 1, &err);
> +		if (unlikely(!skb)) {
> +			*err = -ENOMEM;

.. and you dereference it here

> +			return NULL;
> +		}
> +
> +		skb_put(skb, len);
> +		addr = desc->addr;
> +		buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
> +		err = skb_store_bits(skb, 0, buffer, len);
> +
> +		if (unlikely(err)) {
> +			kfree_skb(skb);
> +			*err = -EINVAL;

Same thing here ... how does it compile?

> +			return NULL;
> +		}
> +	}
> +
> +	skb->dev = xs->dev;
> +	skb->priority = xs->sk.sk_priority;
> +	skb->mark = xs->sk.sk_mark;
> +	skb_shinfo(skb)->destructor_arg = (void *)(long)desc->addr;
> +	skb->destructor = xsk_destruct_skb;
> +
> +	return skb;
> +}
> +
>  static int xsk_generic_xmit(struct sock *sk)
>  {
>  	struct xdp_sock *xs = xdp_sk(sk);
> @@ -446,43 +535,28 @@ static int xsk_generic_xmit(struct sock *sk)
>  		goto out;
>  
>  	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> -		char *buffer;
> -		u64 addr;
> -		u32 len;
> -
>  		if (max_batch-- == 0) {
>  			err = -EAGAIN;
>  			goto out;
>  		}
>  
> -		len = desc.len;
> -		skb = sock_alloc_send_skb(sk, len, 1, &err);
> +		skb = xsk_build_skb(xs, &desc, &err);
>  		if (unlikely(!skb))
>  			goto out;
>  
> -		skb_put(skb, len);
> -		addr = desc.addr;
> -		buffer = xsk_buff_raw_get_data(xs->pool, addr);
> -		err = skb_store_bits(skb, 0, buffer, len);
>  		/* This is the backpressure mechanism for the Tx path.
>  		 * Reserve space in the completion queue and only proceed
>  		 * if there is space in it. This avoids having to implement
>  		 * any buffering in the Tx path.
>  		 */
>  		spin_lock_irqsave(&xs->pool->cq_lock, flags);
> -		if (unlikely(err) || xskq_prod_reserve(xs->pool->cq)) {
> +		if (xskq_prod_reserve(xs->pool->cq)) {
>  			spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
>  			kfree_skb(skb);
>  			goto out;
>  		}
>  		spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
>  
> -		skb->dev = xs->dev;
> -		skb->priority = sk->sk_priority;
> -		skb->mark = sk->sk_mark;
> -		skb_shinfo(skb)->destructor_arg = (void *)(long)desc.addr;
> -		skb->destructor = xsk_destruct_skb;
> -
>  		err = __dev_direct_xmit(skb, xs->queue_id);
>  		if  (err == NETDEV_TX_BUSY) {
>  			/* Tell user-space to retry the send */
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
