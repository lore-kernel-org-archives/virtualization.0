Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D6560AC3
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086250; cv=none; b=lXfBB+KzSMXTUA3kJoW8o4io+t3OLA9SO6LCMUF480l2JeZ60ZR7fsfLljTV2rGoWUwv8uX8xxZio1b5rSS2GNPyAwmjt5rWalYTSWN5Yy28foaD12hggptSkc1HBxUbty5vyBRS3PelM0l31mtQ6PcaQTmpnW4NPqrkOvGPuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086250; c=relaxed/simple;
	bh=sytodgxjAh9gySpG8zzgLLjbT7aoWMjZhihhU7wYyrM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BDc75xT1mfyzhhM8aRsX0PtspJGo+BW7apMyS89QCom5SqIkpgUAWfhDVXHXrk2bLGqsC5MatnplU/aOpEBILOulLM9RAXadqZX6LggznRbN9v57oTYNhtTiuvbagptphlR/T0vII2i0ydFvDRttGnV6BJ3TPfcKZIs5yjdD5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWcGs5dh; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWcGs5dh"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5dc2dc6d3fdso2074128e0c.0
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792086237; x=1792691037; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zXqTw5mwMKBm9G0IR9t3lLlhBekv/xFtuJz7QLQvz30=;
        b=LWcGs5dh2iQTCi3XEbM7OonkyWD5hWwWUa7ExqXqSLovPy++AbLp+VJZCHfs3Kmuni
         iB1ZmVrAvaFoEsbeqYOvJNzpSYEZxdhgkJwJrqH8zqu8rgaI1wTlSa9O1sACWlC/n2NJ
         wPv/VsEwGJLEvgfnTmlE15jeba72/Av+3LfwD2xbbYHw0ZM+lAraJjd0SZZ0s3yjMQ7A
         Y+j7I0OrwfCryTUwPQ3vhz6w2VoQS8k5TSG/88/jbN8C9sNTIpiVDem72a537raqi/+W
         aa55UX7hXVkEQBWYlqRhSriwNdZR9pgeI/ifBSU79+xMfj4ouZUc0Or7sHuoyhBl+0Uo
         czOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792086237; x=1792691037;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zXqTw5mwMKBm9G0IR9t3lLlhBekv/xFtuJz7QLQvz30=;
        b=Z7lEi9IId2pxu1k8pk2lNcAdVeCQut+3MEuQ7Q+PEgO1YuHr37WUhjt805KebnNYLQ
         GIB0Ls746n4qoPCt0OVTkaMnOr7h6dIk99hoDVy+pM/WkU0+GskZV08aHED5EoryVU0y
         TId1Cyqtm5AuDpBsTRZ6hBXxod4SQ3wdRlRN5deArhO3ALyqHpTegOjHOx3TZOYRo/xG
         aPqxRgX9/sNUW3BOJvVcvU68dYz6Q/zIKI1lt+8FAZJ4lNY4smOEXUxPIjypc17Q9SpU
         k54QbmmRme6GrBTnRYi6XMrBfVvLkRMjw8qwyd9/AwKwr00v8enjjq19KADKqAofO/Wn
         feLw==
X-Forwarded-Encrypted: i=1; AKwUvBxjGCE/fAP1Cv83Exoi0MH0QolFax3HREGdHLOzS/d9zuuFrKAhZQuuIuWFFVdBxKjY8FvnyXY9bzuuYMfcwg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJjEsFsqS/Ke+3gupg/VZ4EK9616oYdL7Rj8DL5kBykWYG6sxhs
	4ijvG9B9yf1YArGGc6ZuwyyLm+OC3NKClE9Zl+a+APrluFuLQUwwpWCj
X-Gm-Gg: AYBFou1L7uCTpQdy0auHY0d2Y8jq1k8Dgv0aZnV8Unm4aE3lwxp4GoarJtkRZzLU1ea
	AbtwfgdsF9CZppzwTInpejBqICzh6DQ51c+dgwluep/y1fIdcApCVhLLgyKcSPkutqQhuKmynMG
	d5tkaLDk+W5ZVH6qHYZxU+ChW9Pz7oUA/g+aW/secEvwHdH2KPqVHlnyuJvZnw4Yk4wn5Mjlmdk
	DgAkewO/VZWxoh7jJlu5hZWS3/AaKD8I5DEEy+ItjrETMSejHn09apJsL7N7HWcWqLnA5yzpQoX
	Q8KlAJPZ66pZmoajMKFJbheGiuDMHU9bUkBVgYgd1Z6RmAARgKORlm0ybBNJCKxEnkE9HTLC7nC
	5zNn4sKbyH/xRsKSGApxu8sl2McjOUTTQUAI+aVNPFfpIVCfg2nJqk4DJ3i1c18j88NA8637rfH
	a/BL85hFr6BLqDKv7JYjfZrN+YnA/Z0opo9M1kWEIi5MW0sU2+N8snrq0lxit+I4A/rgV2mrMqy
	Pxe9r1Mrxp9ywR59hXdhkQNqTb08Vu4yLNMkF9XcMm3GLWy7D1oDVLTw4VXdiSeQ2joK4gCLuEj
	u6N8nhFDHuDyc8pK3xWt0CD/jFW4c1nQMVE3UA==
X-Received: by 2002:a05:6122:3906:b0:5c9:c60a:e9b6 with SMTP id 71dfb90a1353d-5e91f568fe2mr5786944e0c.22.1792086237269;
        Thu, 15 Oct 2026 10:43:57 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9909f364sm286539e0c.0.2026.10.15.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:43:56 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:43:56 -0400
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
Message-ID: <willemdebruijn.kernel.11ecc15463d9@gmail.com>
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
> @@ -48,6 +52,171 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +/* TODO: nothing virtio specific here, move to ip.h */
> +
> +/*
> + * Pull and minimally validate the IPv4 header at @nhoff.
> + * Returns the header and stores the transport header offset in
> + * @thoff, or NULL if truncated or malformed.  Only the fixed header
> + * is guaranteed linear; callers that need the options or the
> + * transport header must pull further.
> + */

nit: comment basically describes the code (what), which is quite
self explanatory. I'd drop. Or else consider converting to kdoc fmt.

> +static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> +						  unsigned int nhoff,
> +						  unsigned int *thoff)
> +{
> +	struct iphdr *iph;
> +
> +	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
> +		return NULL;
> +
> +	iph = (struct iphdr *)(skb->data + nhoff);
> +	if (iph->version != 4 ||
> +	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
> +		return NULL;
> +
> +	*thoff = nhoff + iph->ihl * sizeof(u32);
> +	return iph;
> +}
> +
> +/* Where does the L3 header start, and what protocol is it?
> + * Handles Ethernet and VLAN headers; other devices use the
> + * network header offset the caller set up.
> + */
> +static inline bool
> +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> +{
> +	if (skb->dev->type == ARPHRD_ETHER) {

Only since recent commit 44378d02c5aa ("net: always dissect GSO
packets in __virtio_net_hdr_to_skb()") can skb->dev be relied on to be
non-zero.

We'll have to be careful that this does not get backported to stable
without that.

Perhaps an explicit precondition test and error return (and
DEBUG_NET_WARN_ON_ONCE) if a NULL skb->dev is encountered.

OTOH, it results in a hard crash so will be discoverd fast without
that too.


> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		*nhoff = ETH_HLEN;
> +		*proto = eth_hdr(skb)->h_proto;

When called from virtio_net_hdr_tnl_to_skb, according to my LLM mac
header may not be set yet. Have not verified yet.

skb_reset_mac_header(skb) is called inside __virtio_net_hdr_to_skb,
which is then not called yet.

> +		if (eth_type_vlan(*proto)) {
> +			*proto = __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}
> +	} else {
> +		*nhoff = skb_network_offset(skb);

The same is true for skb->network_header. Since an uninitialized/zero
value there causes more subtle issues, here an explicit check may be
more valuable (even) than for skb->dev.

> +		*proto = skb->protocol;
> +	}
> +	return true;
> +}
> +

>  
>  /* This function must be called after virtio_net_hdr_from_skb(). */
> @@ -282,6 +470,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
>  
> +/* Do the tunnel offsets match the outer headers in the frame?
> + * The L3 header the tunnel claims must be the one the frame
> + * carries, with UDP following it at @outer_th.
> + */
> +static inline bool
> +virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
> +			  unsigned int outer_th)
> +{
> +	int nhoff;
> +	__be16 proto;
> +	unsigned int thoff;
> +	int ip_proto;
> +
> +	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> +		return false;
> +	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> +		return false;
> +	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> +		return false;
> +
> +	return ip_proto == IPPROTO_UDP && outer_th == thoff;
> +}
> +
> +/*
> + * Return value:
> + * 0 - success
> + * >0 - checksum was completed in software (slow path)
> + * <0 - failure
> + */
>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> @@ -293,6 +510,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	unsigned int inner_nh, outer_th, inner_th;
>  	unsigned int inner_l3min, outer_l3min;
>  	u8 gso_inner_type, gso_tunnel_type;
> +	__be16 inner_proto;
>  	bool outer_isv6, inner_isv6;
>  	int ret;
>  
> @@ -332,10 +550,13 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	    inner_th < inner_nh + inner_l3min)
>  		return -EINVAL;
>  
> +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +		return -EINVAL;
> +
>  	/* Let the basic parsing deal with plain GSO features. */
>  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
>  				      hdr->gso_type & ~gso_tunnel_type);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	/* In case of USO, the inner protocol is still unknown and
> @@ -353,7 +574,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	}
>  
>  	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> -						 htons(ETH_P_IP));
> +			    htons(ETH_P_IP));
>  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
>  		if (!tnl_csum_negotiated)
>  			return -EINVAL;
> @@ -368,7 +589,17 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
>  	skb->transport_header = outer_th + skb_headroom(skb);
>  	skb->encapsulation = 1;
> -	return 0;
> +
> +	/*
> +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> +	 * set CHECKSUM_PARTIAL.
> +	 */
> +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> +						 inner_proto))
> +		return 0;
> +
> +	return virtio_net_resolve_csum_partial_mismatch(skb);
>  }
>  
>  /* Checksum-related fields validation for the driver */
> -- 
> MST
> 


