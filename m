Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806592;
	b=XbnOunndcF62vlrWCoYWYJvG0Fq70IY0RYMlJN+RBEqsA7MUbjKzF5ImmkOwQXn9XC4o
	 JwA1Nqa296s7zKOpSWKMQcdJ/T+t3oHdQJrqdCGhe/qMIiZqOCAJKHXGiHUT1dtp7UnOL
	 0o3z8s9aog8Uxr1FZmbuzGo5njtSakM60JtfDcP6k32vNK/WB0dP8Mp6K+dUMfg+Y53KE
	 218DXljQaqlrTIojkepflULGk0BicaPDQi9PU92mAVYunGidw/O1Ebzs2ot8MBrNxejyU
	 KSM+lvKmgGzXwg/y1RuJC3MY6TkYyIQTcGDCfAzef0hfsNEYFRFJp05wSPbgJg6gRvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806592;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=xAtQKWzjOXKb3958QswYlotWoI/LcxYVqBPkJ2eRTAs=;
	b=Ht4q6rVVMTSJkMmWigGGOhe7VLfU3n/ZRbVEF8bKqaVZj6zmDWmJUhLpQNmW+6hs24BG
	 pMCjAJMWNUFU/Hy3zC0NEz5qjKPHmhoJ25EjmpZk3u5wIrRFXmQ5d9t44I/35pF+/QDKP
	 ZigXEmQoyN6aJpMnt1GA1Yelni0JaO3zGryfjJDaQ1OlvWrIzTopKQssNnUnpLL5WB+aG
	 2VbXfEtiEfn5wWfPVOBVK6S/Hlg/Fv9hTyfOviMccZRFJLbR897FzjnZyxtEKDw277PjI
	 D3Fz0R8ynbfQYATL463fo808O6aHD9mVSnhw+kBQoHFDGDHCzxjXhymlV4uoaewiT7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=foWPc5jH;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF4606A326
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 15:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DBF4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=foWPc5jH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793806591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xAtQKWzjOXKb3958QswYlotWoI/LcxYVqBPkJ2eRTAs=;
	b=foWPc5jHooaBPfoYegsjAnCNRABDcdxk88PXlcICWq8v4RB4SvdWDn//ZGqwpY+chdheko
	rGqyKgSe5IfCWRLGn2ufmHz2w52KkWLGpaqi4hD/kjaGI0VnVRwdx23iny0ZDW58QOvCIc
	CKO7j3MVpTLnMH5Ah2L+B9HCRJYJzv8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-0kgCCtXuPDC1_1iCCHErkw-1; Wed, 04 Nov 2026 10:36:29 -0500
X-MC-Unique: 0kgCCtXuPDC1_1iCCHErkw-1
X-Mimecast-MFC-AGG-ID: 0kgCCtXuPDC1_1iCCHErkw_1793806589
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4afef353dd2so13969515e9.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 07:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806588; x=1794411388;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAtQKWzjOXKb3958QswYlotWoI/LcxYVqBPkJ2eRTAs=;
        b=abrd/32aGmuX1gXE8hh3li2QEhRdhUcgwytMdgTGBzgva3mUizWXpqdoJ71NuUHGDO
         RLpohhnPnRNfgiUkwLkE70qWX5NhBiUf0viryHJYYTyEV8U5OEaclJQXAtJAXR34tME3
         ZGqhEOsy+bb+x6DeRwfbo2Dlk4eGYWwaYQCZ0KIzmnW5wdc+jixYaj+UsnF6c1bAbj4P
         xKxaPVCR35DYrkehg3sONe8TZWo2D+UxxSRSaoocte0CbeLrPKTIRxu987MknQGEyJlk
         4eBmPPewybOfZb1nUOVbJFHc1EzWVvGp89QJa+4BkyQ39wUxIsGAdQ02OPBzEMOm5728
         D0EQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxHtgRjqWzNSkMwzzGiwgGOyt1w9ZrTWJuaUKCaFYcx0BhErNZitP1uX14R8xHg2cDKjkpYXMJDjX6+PxfMw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9f9tNBE5xOxxP+/gUlQf2GBKdojvft8WSZhsb3iCJgB2Nj+DZX
	zdHv8r2n79WimVT3GGYqUcwvm+WhOCGIygVgaNPtxgmhQ1mCLxN+QSFMic4IZYO50HgyJ5Jp6KA
	UWrfEEpsDOo+BgYnrusNEaAnW/BjOk5Fk6QkXiavkBoiYthImhSOcYi8vm0wvaARE369i
X-Gm-Gg: AYBFou1fmoM+myiZacY7oz+TOq8RwNrVeiawa+EtY7rWFWmsW+Nc+UsTRGKl9sSAKoq
	W+KNWeblluDmUjL1vFHe4twUgyGnyi2zTukww7tPF2h7x0OSAKgqRRaz08Cip13MTZPxuR/w9uf
	KAbeYuGTiTH1gzNH6YA767QogP4DeLbVznHz8FnTTjQyw6o3KNQRuMwdq1OwOVYe40Q9LgXLTlO
	x7neAt7TwLKSnShl33r2c5BmuKhnOHDyW0LMaKKCurft9W02scgIz6G0vLB+At/ytrcAHYnBI4/
	9ctkB10I6TFOEDz5KMHLxOEplDYTAhN8kF8xuWwGGGDXv1cSAU0J1VAwjGFluezv2RWRdKveWGS
	CI6hMNpW94cIWwJBCAIk/d1mHYveOYZq0KR3C/MWMew==
X-Received: by 2002:a05:600c:4e11:b0:4a0:eae0:769a with SMTP id 5b1f17b1804b1-4ac185bc7d0mr365205585e9.28.1793806588312;
        Wed, 04 Nov 2026 07:36:28 -0800 (PST)
X-Received: by 2002:a05:600c:4e11:b0:4a0:eae0:769a with SMTP id 5b1f17b1804b1-4ac185bc7d0mr365204975e9.28.1793806587601;
        Wed, 04 Nov 2026 07:36:27 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa481a45sm135508985e9.7.2026.11.04.07.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:36:26 -0800 (PST)
Date: Wed, 4 Nov 2026 10:36:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v2 1/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
Message-ID: <20261104103616-mutt-send-email-mst@kernel.org>
References: <20261104050131.629967-1-edumazet@kernel.org>
 <20261104050131.629967-2-edumazet@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261104050131.629967-2-edumazet@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GMpjMOoZNfh937xMVR87CTKfleW7RUMi40Fp73kQtyI_1793806589
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2026 at 06:01:29AM +0100, Eric Dumazet wrote:
> virtio_net_hdr_tnl_to_skb() trusts the virtio header to describe a
> UDP tunnel over IPv4 or IPv6, but never checks that the frame actually
> carries such outer headers. Because VIRTIO_NET_HDR_F_NEEDS_CSUM is
> mandatory for tunnel GSO, __virtio_net_hdr_to_skb() skips the flow
> dissector, so virtio_net_hdr_match_proto() is never applied either.
> 
> A guest (or a tap writer) can then inject a frame with an arbitrary
> outer ethertype, for example ETH_P_NSH, with SKB_GSO_UDP_TUNNEL set.
> The GSO stack then runs nsh_gso_segment() on top of the UDP tunnel
> segmentation, which assumes a different header layout. The result is
> segments with skb->data before skb->head, and a host crash in
> skb_under_panic() as soon as a later layer pushes a header:
> 
>   skbuff: skb_under_panic: ... put:4 ... dev:gretap1
>   kernel BUG at net/core/skbuff.c:215!
>    skb_push
>    __gre_xmit
>    gre_tap_xmit
>    ...
>    tun_get_user
> 
> Validate the outer headers with the parsing helpers from Michael's
> series "net: resolve uncommon partial checksums at ingress":
> 
> - locate the L3 header from the device type: Ethernet with optional
>   VLAN tags, or the network header set by the caller. skb->protocol is
>   not trusted when it disagrees with the frame.
> - require the outer L3 protocol to match the declared tunnel type.
> - require the outer UDP header exactly at outer_th_offset, after IPv4
>   options or IPv6 extension headers, and reject fragments.
> 
> Unlike the original helpers, ipv6_find_hdr() stops at an AH header,
> as Willem suggested in the review of that series.
> 
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Reported-by: Hassan Sultan <hassansultan@google.com>
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Co-developed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio_net.h | 169 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd0..b9c8babb1fd7 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -5,7 +5,10 @@
>  #include <linux/if_vlan.h>
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
> +#include <linux/netdevice.h>
>  #include <linux/udp.h>
> +#include <net/ip.h>
> +#include <net/ipv6.h>
>  #include <net/tcp.h>
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>
> @@ -48,6 +51,146 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +/* TODO: nothing virtio specific here, move to ip.h */
> +
> +/*
> + * Pull and minimally validate the IPv4 header at @nhoff.
> + * Returns the header and stores the transport header offset in
> + * @thoff, or NULL if truncated or malformed.  The whole header,
> + * options included, is guaranteed linear on return.
> + */
> +static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> +						  unsigned int nhoff,
> +						  unsigned int *thoff)
> +{
> +	unsigned int ihl;
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
> +	ihl = iph->ihl * sizeof(u32);
> +	*thoff = nhoff + ihl;
> +	/* Pull the options as well: the transport header offset
> +	 * returned above must be within the linear data.  iph goes
> +	 * stale across the pull.
> +	 */
> +	if (!pskb_may_pull(skb, nhoff + ihl))
> +		return NULL;
> +
> +	return (struct iphdr *)(skb->data + nhoff);
> +}
> +
> +/* Where does the L3 header start, and what protocol is it?
> + * Handles Ethernet and VLAN headers; other devices use the
> + * network header offset the caller set up.
> + */
> +static inline bool
> +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> +{
> +	/* skb->dev should always be set here already,
> +	 * but let's not crash when it is not.
> +	 */
> +	if (WARN_ON_ONCE(!skb->dev))
> +		return false;
> +
> +	if (skb->dev->type == ARPHRD_ETHER ||
> +	    skb->dev->type == ARPHRD_LOOPBACK) {
> +		__be16 h_proto;
> +
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		h_proto = eth_hdr(skb)->h_proto;
> +		/* skb->protocol is a sender claim, and parts of the
> +		 * stack parse the packet per it: when it disagrees with
> +		 * the frame we do not know which view the packet will
> +		 * be parsed as, so do not validate.
> +		 */
> +		if (skb->protocol && skb->protocol != h_proto)
> +			return false;
> +		*nhoff = ETH_HLEN;
> +		*proto = h_proto;
> +		if (eth_type_vlan(*proto)) {
> +			*proto = __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}
> +	} else {
> +		const struct iphdr *iph;
> +
> +		*nhoff = skb_network_offset(skb);
> +		/* An unset network header shows up as an offset
> +		 * outside of the packet.
> +		 */
> +		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
> +			return false;
> +		/* No L2 header to cross-check with: take the protocol
> +		 * from the IP version at the network header.
> +		 */
> +		if (!pskb_may_pull(skb, *nhoff + 1))
> +			return false;
> +		iph = (const struct iphdr *)(skb->data + *nhoff);
> +		if (iph->version == 4)
> +			*proto = htons(ETH_P_IP);
> +		else if (iph->version == 6)
> +			*proto = htons(ETH_P_IPV6);
> +		else
> +			return false;
> +		if (skb->protocol && skb->protocol != *proto)
> +			return false;
> +	}
> +	return true;
> +}
> +
> +/* Walk the L3 header at @nhoff: where does its transport header
> + * start, and which protocol is it?  Returns false if the header
> + * is truncated, malformed or fragmented.
> + */
> +static inline bool
> +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> +		    unsigned int *thoff, int *ip_proto)
> +{
> +	if (proto == htons(ETH_P_IP)) {
> +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> +
> +		if (!iph || ip_is_fragment(iph))
> +			return false;
> +		*ip_proto = iph->protocol;
> +		return true;
> +	}
> +
> +	if (proto == htons(ETH_P_IPV6)) {
> +		const struct ipv6hdr *iph;
> +		int flags = IP6_FH_F_AUTH;
> +
> +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> +			return false;
> +		iph = (const void *)(skb->data + nhoff);
> +		if (iph->version != 6)
> +			return false;
> +		*thoff = nhoff + sizeof(*iph);
> +		*ip_proto = iph->nexthdr;
> +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> +			*thoff = nhoff;
> +			/* Find the transport header behind any
> +			 * extension headers, AH included.
> +			 */
> +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> +						  &flags);
> +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> +				return false;
> +		}
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					  const struct virtio_net_hdr *hdr,
>  					  bool little_endian, u8 hdr_gso_type)
> @@ -282,6 +425,29 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
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
>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> @@ -338,6 +504,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	if (ret)
>  		return ret;
>  
> +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +		return -EINVAL;
> +
>  	/* In case of USO, the inner protocol is still unknown and
>  	 * `inner_isv6` is just a guess, additional parsing is needed.
>  	 * The previous validation ensures that accessing an ipv4 inner
> -- 
> 2.53.0

