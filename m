Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B945C4338F
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 16:58:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37ABE610FF
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 16:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37ABE610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00B126071A;
	Mon,  2 Aug 2021 16:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YNOstYg2iniv; Mon,  2 Aug 2021 16:58:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4236A606A8;
	Mon,  2 Aug 2021 16:58:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21559C001B;
	Mon,  2 Aug 2021 16:58:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF3DEC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 16:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB1BD83A7C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 16:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7-0ubXbgkhx7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 16:58:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E337983A6C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627923505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLtJMTV3XxU3KgnKFo51GqvkBw6b2sHrRuc+JcFDw+A=;
 b=AdikwnAGI9E8i4fTc3z+35X5ArA3h1AjqoB3T4ZumUWARd+Yv4Uktud7Agf9VnnwjlE6p8
 eSYiZ96Ybd7fEDYhl5cjf0PpIMrojc2yqCJAAkgg50kzMmxBAEA5chtY3cKVkhJpgwtvVC
 9bjGT77k+P47gl3PZcHmfFaRI8EefgU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-d5zRqL7mN8eR4YP8QtQgZg-1; Mon, 02 Aug 2021 12:58:24 -0400
X-MC-Unique: d5zRqL7mN8eR4YP8QtQgZg-1
Received: by mail-ed1-f69.google.com with SMTP id
 ay20-20020a0564022034b02903bc515b673dso9110691edb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 09:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fLtJMTV3XxU3KgnKFo51GqvkBw6b2sHrRuc+JcFDw+A=;
 b=TgVA/BvG5v8YtZtCdSA1C4Fbn8bcW5H+7Kd43XwZ7XgenPMMHLxG8bT2MO/LTtBlNL
 +iaIm/bZzxAwoSoymZQpB5V9CAGj5ceOxli86HxhJmOvOi4BV9l6YnRe+mCRbD35FIiS
 H1fduHzXxEvARHkCZjZs4xi/N2w5aX4asOjjFoaNovOtXJlAc4fpz32WBW7usL3D9E9R
 w5on5Z9Z7h70HQmqyiR+xvDs4iWJGGG2sAYHDfb4oNl6ZdP/3RzHETaBi85C4px8Ca/w
 BYFwQYnMbm5NbFWozVvKUrxJeeGsYD8yJfaJ2Ulbz5cB1bFi6ab7/zdOdMZfnZGqFPkE
 Cy/w==
X-Gm-Message-State: AOAM531GVQ3WjeBaFbUWzDdJQGSk5Ip0jKj7o3uNhe2des6zyGrOa+P8
 TxyAIwElu6Kpx15wu8tQOPo/vVerHO1ZHU9FkcJ7IjzuNIYk6jochfitVELQEwGSTJQE1esNk5x
 nym/xHW3pmKJmlBMRoCWX1VvvxmPqTEZesSuEZBgEqQ==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr20337192edt.321.1627923503312; 
 Mon, 02 Aug 2021 09:58:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxATj21O1r3+lrhG39GL1DBPCTGKHsKjQ1WZRoae9Z7pfD25Idb0cd+cW5p1gKcyX1raoYWMw==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr20337179edt.321.1627923503167; 
 Mon, 02 Aug 2021 09:58:23 -0700 (PDT)
Received: from redhat.com ([2.55.140.205])
 by smtp.gmail.com with ESMTPSA id j8sm6402996edr.23.2021.08.02.09.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 09:58:21 -0700 (PDT)
Date: Mon, 2 Aug 2021 12:58:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v2 0/2] virtio-net: fix for build_skb()
Message-ID: <20210802125720-mutt-send-email-mst@kernel.org>
References: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
 <20210601070610-mutt-send-email-mst@kernel.org>
 <20210730051643.54198a9e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <20210730051643.54198a9e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jul 30, 2021 at 05:16:43AM -0700, Jakub Kicinski wrote:
> On Tue, 1 Jun 2021 07:06:43 -0400 Michael S. Tsirkin wrote:
> > On Tue, Jun 01, 2021 at 02:39:58PM +0800, Xuan Zhuo wrote:
> > > #1 Fixed a serious error.
> > > #2 Fixed a logical error, but this error did not cause any serious consequences.
> > > 
> > > The logic of this piece is really messy. Fortunately, my refactored patch can be
> > > completed with a small amount of testing.  
> > 
> > Looks good, thanks!
> > Also needed for stable I think.
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Just a heads up folks, looks like we ended up merging both this and the
> net-next version of the patch set:
> 
> 8fb7da9e9907 virtio_net: get build_skb() buf by data ptr
> 5c37711d9f27 virtio-net: fix for unable to handle page fault for address
> 
> and
> 
> 7bf64460e3b2 virtio-net: get build_skb() buf by data ptr
> 6c66c147b9a4 virtio-net: fix for unable to handle page fault for address
> 
> Are you okay with the code as is or should we commit something like:

Yes:
Acked-by: Michael S. Tsirkin <mst@redhat.com>

Will you post this one then?


> ---
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 56c3f8519093..74482a52f076 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -380,7 +380,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  				   struct page *page, unsigned int offset,
>  				   unsigned int len, unsigned int truesize,
>  				   bool hdr_valid, unsigned int metasize,
> -				   bool whole_page)
> +				   unsigned int headroom)
>  {
>  	struct sk_buff *skb;
>  	struct virtio_net_hdr_mrg_rxbuf *hdr;
> @@ -398,28 +398,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	else
>  		hdr_padded_len = sizeof(struct padded_vnet_hdr);
>  
> -	/* If whole_page, there is an offset between the beginning of the
> +	/* If headroom is not 0, there is an offset between the beginning of the
>  	 * data and the allocated space, otherwise the data and the allocated
>  	 * space are aligned.
>  	 *
>  	 * Buffers with headroom use PAGE_SIZE as alloc size, see
>  	 * add_recvbuf_mergeable() + get_mergeable_buf_len()
>  	 */
> -	if (whole_page) {
> -		/* Buffers with whole_page use PAGE_SIZE as alloc size,
> -		 * see add_recvbuf_mergeable() + get_mergeable_buf_len()
> -		 */
> -		truesize = PAGE_SIZE;
> -
> -		/* page maybe head page, so we should get the buf by p, not the
> -		 * page
> -		 */
> -		tailroom = truesize - len - offset_in_page(p);
> -		buf = (char *)((unsigned long)p & PAGE_MASK);
> -	} else {
> -		tailroom = truesize - len;
> -		buf = p;
> -	}
> +	truesize = headroom ? PAGE_SIZE : truesize;
> +	tailroom = truesize - len - headroom;
> +	buf = p - headroom;
>  
>  	len -= hdr_len;
>  	offset += hdr_padded_len;
> @@ -978,7 +966,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  				put_page(page);
>  				head_skb = page_to_skb(vi, rq, xdp_page, offset,
>  						       len, PAGE_SIZE, false,
> -						       metasize, true);
> +						       metasize,
> +						       VIRTIO_XDP_HEADROOM);
>  				return head_skb;
>  			}
>  			break;
> @@ -1029,7 +1018,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	rcu_read_unlock();
>  
>  	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, !xdp_prog,
> -			       metasize, !!headroom);
> +			       metasize, headroom);
>  	curr_skb = head_skb;
>  
>  	if (unlikely(!curr_skb))

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
