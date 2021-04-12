Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E6C43461
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 09:12:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207F061220
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 09:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207F061220
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D11F1403DC;
	Mon, 12 Apr 2021 09:12:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JdIp4v8zpPiA; Mon, 12 Apr 2021 09:12:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00B0F403D8;
	Mon, 12 Apr 2021 09:12:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF6C4C000C;
	Mon, 12 Apr 2021 09:12:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A372C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08B174020A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hrrJx5Yzz3HJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:12:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06F7E40206
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618218750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9MX/q65ulilBbiEmH9SpX/hWPbm4em/YWE26ePKzMIY=;
 b=hxegpaqbRqTCbX4NxRDHe97SA+3DcrN8SBmPYACarJZcBfEHlBhDiO7glZ2x+z4pkJUGf3
 dUPOI3n6d0szOhYQrfyvI2k51eaDx4RGdoOFBfm2E/a8CgwrLw35us5blhGv4VOV5hZsoQ
 6Y3QWrTd6p35JVdYGAyW0M0cKHe+4N4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-OMQVdD03PJm7I-wjxm_JPQ-1; Mon, 12 Apr 2021 05:12:28 -0400
X-MC-Unique: OMQVdD03PJm7I-wjxm_JPQ-1
Received: by mail-wr1-f71.google.com with SMTP id a6so5749570wro.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 02:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9MX/q65ulilBbiEmH9SpX/hWPbm4em/YWE26ePKzMIY=;
 b=Q1Cs8hfv+fWbaHq5Z8DR/DLs6ycz6GcqXy94kpoKWJGCldM6R0MI7ocBOwfDQAvy5n
 TTaimYRHPNlNgESMOoMYweFoFL1LhC/YVM0LtVND6Jl5HSkLeHRS5wxuhPcZYIBKyya3
 8T36vj4t0zAzRCr+fEzyzpptw6rNFsg43t9n4zQEnfYQR/UvpE3GvoZv3QoZClvzcix2
 LME2dwMexhHUTQMtuObRIhGIWA75tBJzfOcNgVzx6l4lH4Qf3boK7z+aRWOPGp/nWUMG
 eiNPGsMQu6tSwet/s6+uRHmBHttVkqo9VUL5ccaLbaT0reeKUugsZsWNyBnYDtms6kuO
 0QDA==
X-Gm-Message-State: AOAM531xj5vQE8Lx7l9eox3D07772eOX67/84FJSsK5K0X5r82/belH2
 FOH0SdDgESIPfyONhhBA8TZpseTtC1YZH3IOSgIawb37l8nogVf1swH+q/zTScX+8u6UiDFMwFI
 Qxc9pb2kjDRux5U1qi0h4m+At686ymlqbmh/4HmNV2Q==
X-Received: by 2002:a1c:c355:: with SMTP id t82mr8739028wmf.160.1618218747305; 
 Mon, 12 Apr 2021 02:12:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytReoQtggqwIdF15Nw8+1JD7ZnJzHU1656q8IXOGUyc29YkyAmvn7gN5OjoJW6bjg/x6usvw==
X-Received: by 2002:a1c:c355:: with SMTP id t82mr8739013wmf.160.1618218747161; 
 Mon, 12 Apr 2021 02:12:27 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id 24sm13711646wmg.19.2021.04.12.02.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 02:12:26 -0700 (PDT)
Date: Mon, 12 Apr 2021 05:12:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4.19 28/66] virtio_net: Do not pull payload in skb->head
Message-ID: <20210412051204-mutt-send-email-mst@kernel.org>
References: <20210412083958.129944265@linuxfoundation.org>
 <20210412083959.037627043@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <20210412083959.037627043@linuxfoundation.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Sasha Levin <sashal@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
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

On Mon, Apr 12, 2021 at 10:40:34AM +0200, Greg Kroah-Hartman wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 0f6925b3e8da0dbbb52447ca8a8b42b371aac7db ]
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
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>




Note that an issue related to this patch was recently reported.
It's quite possible that the root cause is a bug elsewhere
in the kernel, but it probably makes sense to defer the backport
until we know more ...


> ---
>  drivers/net/virtio_net.c   | 10 +++++++---
>  include/linux/virtio_net.h | 14 +++++++++-----
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0b1c6a8906b9..06ddf009f833 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -413,9 +413,13 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
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
> index a1829139ff4a..8f48264f5dab 100644
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
> 2.30.2
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
