Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE60C433B4
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 18:10:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655756128A
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 18:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655756128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A74984C66;
	Wed,  7 Apr 2021 18:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0tEQUmqNlIJ3; Wed,  7 Apr 2021 18:10:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96D3384C4E;
	Wed,  7 Apr 2021 18:10:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78FF3C000C;
	Wed,  7 Apr 2021 18:10:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B818C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 18:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1284C400BB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 18:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O6wzh9bMELyu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 18:10:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 813E54002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 18:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617819003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sIJdtqncyoAj6XEcbUfmwwq7YASSmOYsJ3oO6UTSf9Q=;
 b=h94phMiiYSNVKH825FyOFPp4vT4LGCKmRkfCckvthgqp8DmmoqsrYNDgAdr+7GN9TpJ/oN
 rp7kMJqgF3Bbu2kK83WtYriEgSGFuY++g2yit63rdY2MrIXpBg2GOOMgY/Aotl3J337zht
 KEr63TRVWP9HRX5wfk99syHWrsmwaLA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-BKeyjLhbPjOj-cClpNu_Zg-1; Wed, 07 Apr 2021 14:10:01 -0400
X-MC-Unique: BKeyjLhbPjOj-cClpNu_Zg-1
Received: by mail-wr1-f70.google.com with SMTP id l3so7276517wrp.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Apr 2021 11:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sIJdtqncyoAj6XEcbUfmwwq7YASSmOYsJ3oO6UTSf9Q=;
 b=INfwqAqbj1jCl95sOxV+ECZEZnH6OiPyKxWB5lroi2Z1bqM6y/ZZdKVltYNLEFpAu7
 UkFoIQt/wg9N4VtIvhsWrK3pJM1cpOp5GE7mLuNsR4++4Ic+BkW+N+1g3waHMdRMZD0L
 D5laCd/rMuvVS0Y3byfLFXwJC8wAJAdKhi4+g6dEnqXOK/Wu5o6CCxYggwU3WV8B24AS
 IofSMPzKX9A0O7OARkpxbYEZrWycjf8LfspNK2HFi6GDomLpD8UQgFf/csZRcr4gk3de
 xyXIAPkSzof0DfuY+yVgdrRZtD7VQlaedXh9/w16/mea2xL1qkZLCgtoixdImYc1/hAo
 FTgw==
X-Gm-Message-State: AOAM532BjJZisMxVtMT2ff1reGFEysviSYW0PMMv1QU/uTR0ZYRDjX7e
 fx5MP54YieSOTj6GgSbfhSLWr0ZDtXDD4MwnI9WlKgpXesd5Nun5DwEqk/gMgzFOunPe6j0obkH
 DIJCkQdVZC40OVkvnyubVulg3slIsXHUALkCTTYc8wg==
X-Received: by 2002:a05:6000:cd:: with SMTP id
 q13mr5880702wrx.346.1617818999735; 
 Wed, 07 Apr 2021 11:09:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmGWcbswH2Snjx8UwjwZags/B+Rm4ezDOG1zQdILuxIjW6cC2J/oKr2mnShnnrqIUdzuYpWw==
X-Received: by 2002:a05:6000:cd:: with SMTP id
 q13mr5880682wrx.346.1617818999543; 
 Wed, 07 Apr 2021 11:09:59 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id c16sm6422763wrx.46.2021.04.07.11.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 11:09:59 -0700 (PDT)
Date: Wed, 7 Apr 2021 14:09:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH net] virtio_net: Do not pull payload in skb->head
Message-ID: <20210407140333-mutt-send-email-mst@kernel.org>
References: <20210402132602.3659282-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20210402132602.3659282-1-eric.dumazet@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>
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

On Fri, Apr 02, 2021 at 06:26:02AM -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Xuan Zhuo reported that commit 3226b158e67c ("net: avoid 32 x truesize
> under-estimation for tiny skbs") brought  a ~10% performance drop.
> 
> The reason for the performance drop was that GRO was forced
> to chain sk_buff (using skb_shinfo(skb)->frag_list), which
> uses more memory but also cause packet consumers to go over
> a lot of overhead handling all the tiny skbs.
> 
> It turns out that virtio_net page_to_skb() has a wrong strategy :
> It allocates skbs with GOOD_COPY_LEN (128) bytes in skb->head, then
> copies 128 bytes from the page, before feeding the packet to GRO stack.
> 
> This was suboptimal before commit 3226b158e67c ("net: avoid 32 x truesize
> under-estimation for tiny skbs") because GRO was using 2 frags per MSS,
> meaning we were not packing MSS with 100% efficiency.
> 
> Fix is to pull only the ethernet header in page_to_skb()
> 
> Then, we change virtio_net_hdr_to_skb() to pull the missing
> headers, instead of assuming they were already pulled by callers.
> 
> This fixes the performance regression, but could also allow virtio_net
> to accept packets with more than 128bytes of headers.
> 
> Many thanks to Xuan Zhuo for his report, and his tests/help.
> 
> Fixes: 3226b158e67c ("net: avoid 32 x truesize under-estimation for tiny skbs")
> Reported-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Link: https://www.spinics.net/lists/netdev/msg731397.html
> Co-Developed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks a lot for looking into this, Eric and Xuan Zhuo !

> ---
>  drivers/net/virtio_net.c   | 10 +++++++---
>  include/linux/virtio_net.h | 14 +++++++++-----
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 82e520d2cb1229a0c7b9fd0def3e4a7135536478..0824e6999e49957f7aaf7c990f6259792d42f32b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -406,9 +406,13 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	offset += hdr_padded_len;
>  	p += hdr_padded_len;
>  
> -	copy = len;
> -	if (copy > skb_tailroom(skb))
> -		copy = skb_tailroom(skb);
> +	/* Copy all frame if it fits skb->head, otherwise
> +	 * we let virtio_net_hdr_to_skb() and GRO pull headers as needed.
> +	 */
> +	if (len <= skb_tailroom(skb))
> +		copy = len;
> +	else
> +		copy = ETH_HLEN + metasize;
>  	skb_put_data(skb, p, copy);
>  
>  	if (metasize) {
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 98775d7fa69632e2c2da30b581a666f7fbb94b64..b465f8f3e554f27ced45c35f54f113cf6dce1f07 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -65,14 +65,18 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  	skb_reset_mac_header(skb);
>  
>  	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> -		u16 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
> -		u16 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
> +		u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
> +		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
> +		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
> +
> +		if (!pskb_may_pull(skb, needed))
> +			return -EINVAL;
>  
>  		if (!skb_partial_csum_set(skb, start, off))
>  			return -EINVAL;
>  
>  		p_off = skb_transport_offset(skb) + thlen;
> -		if (p_off > skb_headlen(skb))
> +		if (!pskb_may_pull(skb, p_off))
>  			return -EINVAL;
>  	} else {
>  		/* gso packets without NEEDS_CSUM do not set transport_offset.
> @@ -102,14 +106,14 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  			}
>  
>  			p_off = keys.control.thoff + thlen;
> -			if (p_off > skb_headlen(skb) ||
> +			if (!pskb_may_pull(skb, p_off) ||
>  			    keys.basic.ip_proto != ip_proto)
>  				return -EINVAL;
>  
>  			skb_set_transport_header(skb, keys.control.thoff);
>  		} else if (gso_type) {
>  			p_off = thlen;
> -			if (p_off > skb_headlen(skb))
> +			if (!pskb_may_pull(skb, p_off))
>  				return -EINVAL;
>  		}
>  	}
> -- 
> 2.31.0.208.g409f899ff0-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
