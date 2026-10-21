Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541132;
	b=gattBdIshE0/Q8uB+NSRleH/7DjIJAgcupJkNbVWIn5EZ1KzlM8UegTSKt5kX+HcvPMu
	 Y+afc6Nq6glB1AKgdsnP47Im1lJBdl9+EIEfwE03hU+QmYb/BvfvRSxB5vQJGjHJLxFKd
	 BcH2zATud5quSD9IYM9YJcJJVhXGNPrkz1nWCuVHORLnteXxL3xa9steUu5BqtICE63o2
	 KrWl7XwUrgO4J8HFhdP+hIF62dAt2QG6/tamI6+1dtoKOViAa6aIKqIMeDsR+qnYMrGe7
	 Me8eScFbuhZ1bBKmVb5JDSVZsZwVHx3ujDAC+6Ynl9BFhWGs1VskPoIvWp08G4PcfHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9KmVjMJTY8zcLg9QfQKrHKxwneViwt4HwZ1IqLmXRp8=;
	b=MJC3c4ZyJB3vH1eEITSrYItCTH8AiZ6RHcgxqAzZbHXA4A5OcG/jbMjG8xvhC4miYbPf
	 mex9t+xpm27u/u2Uw4y521sftOGfVMQUcf6DfS9FT612vgC1t0WNgnDGIhFJFiYiMXuki
	 B2Kkxx0CeDTqVAeSSjO7Q0hMfzOgym84+hvb83vQJPWoCtO/k8csVtkg/O6UUEDX86fDc
	 m+5YAICXfcA0wNzDnaNBQ+vk5ZX9HwfanJ8iPCWEKXnf5NplkG1Vp372ZLfkZX9wya3RD
	 5r3QSoUVyVqLWiI5Wy8wayYGudvS+PrznYRaTpmL1kDMF62DoDq3K6rLwnYr0vw1Tfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bvRuDGzR;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC729606A321
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 00:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC729606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bvRuDGzR
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5e94a057300so44652e0c.1
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792541131; x=1793145931; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9KmVjMJTY8zcLg9QfQKrHKxwneViwt4HwZ1IqLmXRp8=;
        b=bvRuDGzRLLDz/EMIR5wwHu9KT5xaPxWXVOZKyEAFrnFEAuTcSg34KlAJp9XbSGc1AW
         2k9ex3lf0uY8/ZU50F+wSjInaOPbNWL9AFYMIaPkmPM6LaYkySFnqXdgCrd2GHUEZwnI
         Y+5GetBpUaWRJ9grnPSgftva5euRws3GTa0VDpbUDPTpIUQXHn4zSeCcrp5GKxvBBFwX
         nH7F+A8VI/lKPPQWxvCvWRFiWgFpOqT5pAPTQ1cxcKw0XgyTnCS7otQGHkDGJczVjJE0
         ruXVzLfa26EJTqO9n3gRk4PpEkSezp9dQcBCs2q0+2yG80SAf0EXkR6b1pktpC4MJBlE
         PwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541131; x=1793145931;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KmVjMJTY8zcLg9QfQKrHKxwneViwt4HwZ1IqLmXRp8=;
        b=MtoauuUnRrGu0K8Wrjuexcf4p0mf5gVnp2ppsyQfCpuIYsbxrRWYXmQDsJ+qw8msKM
         VWpSWxXPOgGfIK0Nxn5J/bhT0gh52XL1D8QsoEuFXI7pqW6zhhXN+woR5x310uCNsDtp
         fRMMyqFkNVjvN1GFUtluMyHzt654F3MJ/zyQLbkSuSzBJJa0oc9bikrKeMf1rxCxKaPb
         Td6Kpjq1NXbw++Epl8V80t7O+wfMHZ54s/QACYEJ88VLpGDvcwxba81Dye6XvCBzljeY
         QNQNSbe9QD/ZzGYORke8FM1dLBsQpUHK5whHvKs9B2Mnl3upzM1UR1uYdvFlVTdbYDnW
         rUtg==
X-Forwarded-Encrypted: i=1; AKwUvBwYgWZeD0stTzDmoROUjoBjEkDU6WSwWZUnNN3jvheQ55nIAJFDJnZ1uiQEPkcdcCur70PR1MwJZnkovbgPqw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLgdfO/q2hPRyL01dXbgMcBcYyQ8grT+lK+hOQr+pVgIhKjl9wu
	si0Pk8cdRoHZYzTE+SpX8C4VYTVP/MkYPkHQQJlJdYHDsz1VljQoA5Mq
X-Gm-Gg: AYBFou23BgR+47MU7c9/IcEmXVzF8ixIPzhw689Etqbg9QcwEmJ23oVs2IS2FXvuh3k
	AqaUouU7FtIhCw3DjAXWT+JMNWR+GuEU8ipObEtV72WibGBzxzJOXYtup/SSUM2ArrMWGAXTRSz
	R9vLbK+XE2/59PQ18YMeV/yGcC7OhD23vAxnpLL1z1+5xIvAWlCM03iqAKyrP+kmbvJqqbpa9y1
	rAUE5cXnB3aZCn36zZ7KPH4/8eIF3aNfXI+cQjV9G5Ct2DRBlzE/ftgNZ2DIAGuYMy4ofVKH8e8
	vfGuSLELhb4DyXRn9PSQsZK3ODQmSNIbV745d4Q4MKlxDHcyi2IZ+LqtHGRhDMD9LQ4k2JMh2Yn
	FzX+Gyj5UuyOzCphEoAZpxAeOSr4ie3rddgjrQ1WdyRY42b8bQqg5DRIt13TgeswYaze3etSFON
	8dLnt67HhaZE5iTMoprQymeR+1mVUzGGwTgoiLG6RFwPQtafnGDZRm4q8ShyooTVWekAe/O0ECW
	xnm4AbMBN/GfUuC/RQvFoF/U9kYh/+i8aq8mUEVsJmaxJhzulPfjDlSOzRZsSKtBxOkEioCDQdh
	9/L30NTQz3E7EpX0bBmFjQs4+n8eDnZQSxOODw==
X-Received: by 2002:a05:6122:1d9f:b0:5e6:82ca:c551 with SMTP id 71dfb90a1353d-5eaebef16acmr141977e0c.22.1792541130631;
        Tue, 20 Oct 2026 17:05:30 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae981d239sm1228104e0c.14.2026.10.20.17.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:05:29 -0700 (PDT)
Date: Tue, 20 Oct 2026 20:05:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
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
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Paulos Yibelo <habte.yibelo@gmail.com>
Message-ID: <willemdebruijn.kernel.1da723f98c23a@gmail.com>
In-Reply-To: <20261020170908-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <9c08d12b3a7819ae03ded6a154e4f908276e93d4.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.2eb449439b094@gmail.com>
 <20261020170908-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v3 5/8] net: resolve uncommon partial checksums at
 ingress
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Tue, Oct 20, 2026 at 03:44:35PM -0400, Willem de Bruijn wrote:
> > > +/* Walk the L3 header at @nhoff: where does its transport header
> > > + * start, and which protocol is it?  Returns false if the header
> > > + * is truncated, malformed or fragmented.
> > > + */
> > > +static inline bool
> > > +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> > > +		    unsigned int *thoff, int *ip_proto)
> > > +{
> > > +	if (proto == htons(ETH_P_IP)) {
> > > +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> > > +
> > > +		if (!iph || ip_is_fragment(iph))
> > > +			return false;
> > > +		*ip_proto = iph->protocol;
> > > +		return true;
> > > +	}
> > > +
> > > +	if (proto == htons(ETH_P_IPV6)) {
> > > +		const struct ipv6hdr *iph;
> > > +		int flags = 0;
> > > +
> > > +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > > +			return false;
> > > +		iph = (const void *)(skb->data + nhoff);
> > > +		if (iph->version != 6)
> > > +			return false;
> > > +		*thoff = nhoff + sizeof(*iph);
> > > +		*ip_proto = iph->nexthdr;
> > > +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> > > +			*thoff = nhoff;
> > > +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> > > +						  &flags);
> > > +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > > +				return false;
> > > +		}
> > > +		return true;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > 
> > for all this parsing: could we use flow dissection, like the
> > !VIRTIO_NET_HDR_F_NEEDS_CSUM case?
> 
> Hmm I don't see how.  That one trusts the caller's protocol and network
> header. We could parse L2 ourselves and use the dissector for L3+. But
> it stops at whatever it does not know, and every miss would turn into a
> drop or a software checksum for a packet the stack delivers fine.  Our
> parser deliberately covers everything the stack can deliver.

You're right, the protocol and network offset need to be parsed
manually. After that it could be passed to the flow dissector.

Totally untested:

    static inline bool virtio_net_setup_l3_input(struct sk_buff *skb, int *nhoff, __be16 *proto)
    {
        const struct net_device *dev = skb->dev;

        /* Devices with Ethernet framing: ARPHRD_ETHER, loopback, macvlan, etc. */
        if (dev->header_ops == &eth_header_ops || dev->type == ARPHRD_ETHER) {
            if (!pskb_may_pull(skb, ETH_HLEN))
                return false;
            *nhoff = ETH_HLEN;
            *proto = eth_hdr(skb)->h_proto;
        } else if (dev->type == ARPHRD_NONE) {
            /* Raw L3 devices (e.g. tun in IFF_TUN mode) */
            *nhoff = 0;
            *proto = skb->protocol;
            if (!*proto) {
                if (!pskb_may_pull(skb, 1))
                    return false;
                if ((skb->data[0] >> 4) == 4)
                    *proto = htons(ETH_P_IP);
                else if ((skb->data[0] >> 4) == 6)
                    *proto = htons(ETH_P_IPV6);
                else
                    return false;
            }
        } else {
            /* Fallback for other netdevs using caller's network header */
            *nhoff = skb_network_offset(skb);
            if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
                return false;
            *proto = skb->protocol;
        }

        return true;
    }

    static inline bool virtio_net_csum_partial_ok(struct sk_buff *skb, u8 hdr_gso_type)
    {
        struct flow_keys_basic keys;
        __be16 orig_proto = skb->protocol;
        u16 orig_net_hdr = skb->network_header;
        __be16 proto;
        int nhoff;
        u16 csum_offset;
        size_t min_thlen;
  
        if (!virtio_net_setup_l3_input(skb, &nhoff, &proto))
            return false;
  
        skb_set_network_header(skb, nhoff);
        skb->protocol = proto;
  
        if (!skb_flow_dissect_flow_keys_basic(dev_net(skb->dev), skb, &keys,
                              NULL, 0, 0, 0, 0))
            goto restore_fail;
  
        /* Disallow fragments: partial checksums cannot be retained across frags */
        if (keys.control.flags & FLOW_DIS_IS_FRAGMENT)
            goto restore_fail;
  
        /* Validate protocol matching */
        switch (keys.basic.ip_proto) {
        case IPPROTO_TCP:
            if (!virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type))
                goto restore_fail;
            min_thlen = sizeof(struct tcphdr);
            csum_offset = offsetof(struct tcphdr, check);
            break;
        case IPPROTO_UDP:
            if (!virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type))
                goto restore_fail;
            min_thlen = sizeof(struct udphdr);
            csum_offset = offsetof(struct udphdr, check);
            break;
        default:
            goto restore_fail;
        }

        /* csum_start must match the dissected transport header offset */
        if (skb_transport_offset(skb) != keys.control.thoff)
            goto restore_fail;

        /* csum_offset must point to the transport checksum field */
        if (skb->csum_offset != csum_offset)
            goto restore_fail;

        /* Ensure the transport header is linear */
        if (!pskb_may_pull(skb, keys.control.thoff + min_thlen))
            goto restore_fail;

        return true;

    restore_fail:
        skb->protocol = orig_proto;
        skb->network_header = orig_net_hdr;
        return false;
    }
