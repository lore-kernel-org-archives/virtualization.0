Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E753B60A
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087456; cv=none; b=YyFr/9Zz7PmS1CR9/PCcIH4aNBZ11+AXd/J7aAjwrVFG/kSgeKACNpK8AcGY3rX5Q3UyJ3FIss3HAOT0bitXipSETvLlfwfuv+51HPhnttoIa2TYMtNC9lxNMFzvDvrRe27oFYc79zo6yJWVsTB9U/p4M01yChRIPz2KQXVCW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087456; c=relaxed/simple;
	bh=RBnf8b8QRw1/pS3XpaIdJOrSUHXXX4v/3KfV3aU8d/U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CsApTc6OT4Z7Nsqo9XLfQwPnOcBtb6c/lZ8JpMo4XBwgmWvqGgFLE/sAnpeUBmpJwH3wWmPQjz54ZV8whGITKazNYvEpBwW/4yBZrzmh1pzJbOitjAbBE2b5PvIuGhMm6CsEvQDDmNmI2VOV/pgCx+XCG+oIjfePyIqjDLSPt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agFCfo1j; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agFCfo1j"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5e948e56af3so1762234e0c.2
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792087449; x=1792692249; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xKibE8p71HG4LdZ63GfDMEy7h78ItNosZth3y1tUgIw=;
        b=agFCfo1jl1RcAPrN2PUXpnFXUynxPP/cGRPfZHZVEtwihLV2cwGhMUB1dFW6ysxajT
         kcCjWxgKBkfuzi5AW+lYXSpxEaQMg+JNzKleTJ38i/j51wUgjgeeB1q8DW8LNx6zqi3d
         H7dqajcMIzJBWQ4EkwliXQS0p2LFgAiMzTDBSlotAhrtEM34iJEslU9NzMxrsncj1TN5
         rMlAp32sromuTucUjpCfwbPnU+W2tQvJEI8xhfA0ZiYVPBmP0djMM56ae5KFRLB1y356
         f5HJhYIBpyADTA5pP744sreROgjByoUs5SJ+n2JvLF6QLCKeR7rLOy83SQI7d0kbmTIY
         Z+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792087449; x=1792692249;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKibE8p71HG4LdZ63GfDMEy7h78ItNosZth3y1tUgIw=;
        b=KtbMyCto702TY24w1nFQviiVJq0syy839NOgvUwkG8Ox6C936nAgrPNDghWdHnuxfK
         yXeE+AiNRTrbn54eJN/MgMCRnW/7NFsVp7pCs0SRFnwmKDJ7+ZCXLTtouKsNE+tMzOjG
         WdEA+rdlBWQ7lTSq1f8FSgXfMFUtXvvBIci5mK6bOWOtdl278mRXS+AQVq+EmEbVvgLW
         xFxr0/j73Bs+9GPe/IwVwBDrBEEZd+QAMCspcx6+4mP+ahGJVa2fWpzLAlthoupIK+m4
         6E0zoXytnni9juQfg1IdQtebrlCoF2Ll+nLHJPIzt78dVqty+MeRVitN5sI52TjM6yv/
         MILA==
X-Forwarded-Encrypted: i=1; AKwUvBwlR4dPp8RU3Ev8WpVRFTn4G0h3nzLdv50t9q6iEBu/fMLhdOdSwM354CctpbMZcrxg3KQEXEWzJGwMvjq8/g==@lists.linux.dev
X-Gm-Message-State: AFq9FYKGrw7Pb+CQc6SFh2TGnC0qqu5U81JfvXihTULrtBMxqZUqP6+B
	qdOAM4GKNrGPCtXh00Iyabv5QEKHzbbLA7Dp0lla0M/FOU7M+TSg1UOv
X-Gm-Gg: AYBFou115LK7Pxe0ZQHofK54WBYVjP8jua+ldf16LbN8gv6hgmF57PgE8NMwlng5leH
	3fGL66EBPGx389F8AhjZwRKAEu7Ueu1ymKAFJ8Dkof5dpgRlLmCOQMM3CZZ6cOljBhIQPpIsSBU
	gXpZHoD2DAi28B9eAGqyIQcZtEqDJgqJMGfbjmZloEsrnUJL7A7FMz9/5ct9kdYnHqdUu3GVWHR
	a83a6RAD2ub4xWeVzXou8gsQKrzDMcIIMy+sScbeJGmz4LDEfYsxz91lh4qZ1LhZgAiIbreC+W+
	V40IHmodXBQDOSax9xZW/o0ZKeCZ0RCYQ49DIS6qSjctyHC8WNvfQqv2VccBsrrvXohD27eaOyn
	ImSeZZBLgdZYUzMEWup1JcMdMmXnloMa67qamjn4LI2szz9AiALt5ehxsxI9+hA7OOOSm497/zQ
	v+yjGMapLn6SuVg4zfCcClrM+0HuQ2lrXnuaYeXJYzZwcbzyi+EuF9cj0/HR7vPgStNC2VJ0cdJ
	NRQ+GyWlhA11/1J0lfONWGIlQnw2y5udY3/fyHWL6yTDaeFUR26YdfOEi3C9nzxQUM/xF/mmZ6h
	oXsWUsUqlYA9xFP7L2iugTEQzdHK4fLhHIsDWw==
X-Received: by 2002:a05:6122:2388:b0:5ea:98fb:e9de with SMTP id 71dfb90a1353d-5ea98fbeb25mr215788e0c.3.1792087448837;
        Thu, 15 Oct 2026 11:04:08 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9943cdabsm280979e0c.6.2026.10.15.11.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 11:04:07 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:04:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Paulos Yibelo <habte.yibelo@gmail.com>, 
 Chris Arges <carges@cloudflare.com>
Message-ID: <willemdebruijn.kernel.1a9a8b3792ae6@gmail.com>
In-Reply-To: <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
Subject: Re: [PATCH net-next v2 4/7] net: resolve uncommon partial checksums
 at ingress
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
> others, credited below, found more ways the bug can affect users) a
> virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
> If that state is retained, later checksum completion can modify the
> packet after protocol processing has made decisions from it.
> 
> Let's fix that: let's validate csum_start and csum_offset and only keep
> CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> headers.  Complete other non-GSO checksums immediately, before any
> protocol processing runs.
> 
> We can't easily "complete the checksum" for GSO we don't recognize - GSO
> assumes knowledge of the protocol. We could segment ignoring the
> checksum then do whatever csum_start and csum_offset say, but that
> seems like an overkill for something that shouldn't happen.
> 
> There's some risk here:
> - non-gso packets which can't be parsed get checksum calculated in
>   software, adding performance overhead
> - gso packets which can't be parsed get dropped
> 
> To mitigate the risks, the following patch will add a sysctl knob to
> bypass the resolution. This is reasonable if the setup is such that
> there is no protocol processing at all.
> 
> UDP tunnel headers get the same handling on the inner header.
> 
> Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
> 
> Assisted-by: LLM
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
> Tested-by: Chris Arges <carges@cloudflare.com>
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio_net.h | 251 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 241 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd0..357115ff0ec2 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -5,7 +5,11 @@
>  #include <linux/if_vlan.h>
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
> +#include <linux/netdevice.h>
>  #include <linux/udp.h>
> +#include <net/gso.h>
> +#include <net/ip.h>
> +#include <net/ipv6.h>
>  #include <net/tcp.h>
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>

>  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					  const struct virtio_net_hdr *hdr,
>  					  bool little_endian, u8 hdr_gso_type)
> @@ -158,8 +327,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		case SKB_GSO_UDP_L4:
>  			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
>  				return -EINVAL;
> -			if (skb->csum_offset != offsetof(struct udphdr, check))
> -				return -EINVAL;
>  			if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
>  				return -EINVAL;
>  			if (gso_type != SKB_GSO_UDP_L4)
> @@ -167,10 +334,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  			break;
>  		case SKB_GSO_TCPV4:
>  		case SKB_GSO_TCPV6:
> -			if (skb->ip_summed == CHECKSUM_PARTIAL &&
> -			    skb->csum_offset != offsetof(struct tcphdr, check))
> -				return -EINVAL;
> -

Maybe keep this and the above check, to keep things exactly as is when the
sysctl is disabled.

Removing these checks weakens validation vs the present state.
