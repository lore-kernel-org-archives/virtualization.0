Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684187;
	b=DxwSSc76QxbyRPlVOLbOURAywGA+iAghgbOHazCtX/lfmhzp7Z87JFpWMJTCx24GUE4s
	 DK0dxi5jLAm2O5cpM02lBZ8cm0nLu9lOGTlhSt5MsAY7xndMoMH7qB0FiOXoDKu/fr9Do
	 gVSRJ7tuXByHafyA5ROt4q+r/37Slm5s9inUj5OpajYKLG73oYyttGfKJBY8PNFtFwv0C
	 O34xcqWec9Ao3o1VOyk1ywPAzUfgNHuhHMAouulpnEJ5gocMzZKLOCWh4OBY5LdwuAPIk
	 polBaPh6rXeLkzsQVGdqgdbWdz3LJzB6Xb3jgFk6yl/NSGKu296bPr61ksKMuFO0w+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684187;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=edpkLOOxI3UZhx0qBLk3k0QVSahabnGytonM03aDkHo=;
	b=unPUr4tsbO+6geppA0aIZCXPeXsFSX34ImQMaEV5Ax05jZFQKmqBs5AuJFTaRriDjhna
	 DLa9bcRhRvfOJ7mfTfUd4u6Z9XlIK2KNW/OGjGl5zcjN0uzFtwfGN4qDB+lNO6dXkutob
	 AYLZ81wo2L1p+xWu40OBf96fUq358jfv3Czo1yeoHYORbg3yFGHzlXDBTS6hGDRvZTny0
	 ameSrKW6II4rW1fJf3jt8mYJpo3srBLJWHW3uX2XefllO5cWmYbWLg6x+4TuUXLgCSRmw
	 aNYYAeKBIY8URWO6HImBOuAQpudnczKGySaeZ+rWKjTuXtd+P8pg/DE5G6F9YLRcUpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZUhfOjD8;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF1606A31A
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 15:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2EF1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZUhfOjD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792684185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=edpkLOOxI3UZhx0qBLk3k0QVSahabnGytonM03aDkHo=;
	b=ZUhfOjD85biDVgIJOXqeem06Nag9JfNO4EIfyzv08SyLM++yzVNtoNybE+0ftncxqFWkBs
	gVppOJIN6+VNXuk+aVnrpD7puskLerX8ZtD64PtXaH3RswYRRLkyD7fJ3rth1KZMOXe3uP
	kxS+O8HT+9P9vpRJ+JkYYbmAiZxnr9k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-IbnM6R9uOMiyg7xf7dGtBg-1; Thu, 22 Oct 2026 11:49:44 -0400
X-MC-Unique: IbnM6R9uOMiyg7xf7dGtBg-1
X-Mimecast-MFC-AGG-ID: IbnM6R9uOMiyg7xf7dGtBg_1792684183
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1d7c3b38eso17223235e9.2
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 08:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684183; x=1793288983;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=edpkLOOxI3UZhx0qBLk3k0QVSahabnGytonM03aDkHo=;
        b=mPr/i1PGE0vXYgLzdCUV+bMEui501maNMH6K7bv19Kpis8xbamE/Op3JLg44/a/pqd
         /BWqW5xFfcaEX+YWcbd/U0lbtruRhQdGTakPOYNEVQj8d8aN3kjKoZ1p+FUlgait9f68
         3wAvh15Jcag9NAsU5hEg1a4ivzceOND9glUT4APc9C4hKYFZlhk1V0WRJ+ytKfric6HO
         3HdYznZH8EU8dAo5sWN9LPdOLMN0Ojj1pzR9tzKLDdhaxJZMujVT1HS0u1uffdPx6qLC
         sEoZBiieRDK+LaIFCjBd5xHMG06QZ8KfqWRDNpviAruozXYnc1LIrOydQIELlbqNc2zw
         bV7g==
X-Forwarded-Encrypted: i=1; AKwUvBzTdYTIEQsnz3r1cSuulzS9tzIi4DxPLLr6+rSinAFMPjmDESjErwEdkYmGEuOYmavTr0VreqiL+hK24K0GnQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLU5B8FcPDAtn6ITpgEPFs/CyywbwYJ67Ac/VVCTWVfI5BDz5cg
	/d6NdRUy/v8n/H/qzNbD3synIFBxYKI72Q+FttoHiX2Re+6fhRf6x7pmMV/H2YBnK6BJAresBPQ
	WV0apIiHRKEyawBrYC+HU3q88IXGIdhbxDt4ZC6y/0lPSYLA47RoaY8PCc3meL/r98rXRklVqoi
	VX
X-Gm-Gg: AYBFou28LYErvGQR2vQ1yCQ0rJ40vTHLLas45C0QUmsBR93NZhoO8M0xxa5UauyGiXn
	6kAV+9P4E+2Xb/fqyKMXyjoNaZQKqUnTJb4OIVaQ8MRWZcCskxAKUDTiN9bjnjvI4RjvY1km7In
	ffSr5zTx62SmUQkPvHYMQvnQp8OWbrqp40gjx1Dvo0VW92EOAyHblxgvBM+ZI1E8zhjXYrxI4jj
	XN5pbZEzN4o98/aLnYxErlrC4cRkRYSjkpOs7kiaxGrEG/8cNlsQx6TYIEjrXYmXlldGWm8IJlM
	4O8FVMUsvjN+xO1xgoF07e01lDuTLflAm/c57I+2539e+8dq5fnrOkugGgrFs4jVK1Y=
X-Received: by 2002:a05:600c:3b17:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a1fdd31aebmr120615715e9.16.1792684182746;
        Thu, 22 Oct 2026 08:49:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3b17:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a1fdd31aebmr120615365e9.16.1792684182123;
        Thu, 22 Oct 2026 08:49:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210473567sm4256075e9.12.2026.10.22.08.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:49:41 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:49:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net v5 4/7] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261022114552-mutt-send-email-mst@kernel.org>
References: <cover.v5.git.mst@redhat.com>
 <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
 <willemdebruijn.kernel.2987fc5710162@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.2987fc5710162@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fa2JDGs4f2UZTfQvUVsg8ijES3itW4MKz95cNUUGuRQ_1792684183
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 22, 2026 at 10:52:25AM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
> > others, credited below, found more ways the bug can affect users) a
> > virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
> > If that state is retained, later checksum completion can modify the
> > packet after protocol processing has made decisions from it.
> > 
> > Let's fix that: let's validate csum_start and csum_offset and only keep
> > CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> > UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> > headers.  Complete other non-GSO checksums immediately, before any
> > protocol processing runs.
> > 
> > We can't easily "complete the checksum" for GSO we don't recognize - GSO
> > assumes knowledge of the protocol. We could segment ignoring the
> > checksum then do whatever csum_start and csum_offset say, but that
> > seems like an overkill for something that shouldn't happen.
> > 
> > There's some risk here:
> > - non-gso packets which can't be parsed get checksum calculated in
> >   software, adding performance overhead
> > - gso packets which can't be parsed get dropped
> > 
> > Note that for zero copy, userspace can change the data after the
> > checksum has been calculated.  This is fundamental to zero copy by
> > design, and the only outcome is a bad checksum and a packet drop.
> > 
> > To mitigate the risks, the following patch will add a sysctl knob to
> > bypass the resolution. This is reasonable if the setup is such that
> > there is no protocol processing at all.
> > 
> > UDP tunnel headers get the same handling on the inner header.
> > 
> > Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
> > 
> > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Reported-by: Chris Arges <carges@cloudflare.com>
> > Tested-by: Chris Arges <carges@cloudflare.com>
> > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Notes (changelog):
> >     v4->v5:
> >         caller changes moved to "account for ingress-resolved
> >         virtio net hdr state" (Willem de Bruijn)
> >         a packet too small to be GSO: ignore the tunnel GSO request,
> >         complete wild metadata in place (sashiko)
> >         document the zero copy interaction (sashiko)
> >         honor a preset skb->protocol on ethernet: the stack uses it,
> >         except on loopback which re-parses the frame (sashiko)
> > 
> >  include/linux/virtio_net.h | 283 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 279 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 013c6c7e2dea..52852a33a2db 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -5,7 +5,11 @@
> >  #include <linux/if_vlan.h>
> >  #include <linux/ip.h>
> >  #include <linux/ipv6.h>
> > +#include <linux/netdevice.h>
> >  #include <linux/udp.h>
> > +#include <net/gso.h>
> > +#include <net/ip.h>
> > +#include <net/ipv6.h>
> >  #include <net/tcp.h>
> >  #include <uapi/linux/tcp.h>
> >  #include <uapi/linux/virtio_net.h>
> > @@ -48,6 +52,205 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
> >  	return 0;
> >  }
> >  
> > +/* TODO: nothing virtio specific here, move to ip.h */
> > +
> > +/*
> > + * Pull and minimally validate the IPv4 header at @nhoff.
> > + * Returns the header and stores the transport header offset in
> > + * @thoff, or NULL if truncated or malformed.  Only the fixed header
> > + * is guaranteed linear; callers that need the options or the
> > + * transport header must pull further.
> > + */
> > +static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> > +						  unsigned int nhoff,
> > +						  unsigned int *thoff)
> > +{
> > +	struct iphdr *iph;
> > +
> > +	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
> > +		return NULL;
> > +
> > +	iph = (struct iphdr *)(skb->data + nhoff);
> > +	if (iph->version != 4 ||
> > +	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
> > +		return NULL;
> > +
> 
> Pulling again if ihl != 0 should probably have been here too.

oh right you told me. I forgot.

> Else we have to verify that all callers safely pull. Note that
> iph will become stale after another pull.

right.

> > +	*thoff = nhoff + iph->ihl * sizeof(u32);
> > +	return iph;
> > +}
> > +
> > +/* Where does the L3 header start, and what protocol is it?
> > + * Handles Ethernet and VLAN headers; other devices use the
> > + * network header offset the caller set up.
> > + */
> > +static inline bool
> > +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> > +{
> > +	/* skb->dev is only guaranteed to be set since 44378d02c5aa
> > +	 * ("net: always dissect GSO packets in
> > +	 * __virtio_net_hdr_to_skb()"), do not crash when it is not.
> > +	 */
> > +	if (WARN_ON_ONCE(!skb->dev))
> > +		return false;
> > +
> > +	/* A preset protocol is what the stack will use, except on
> > +	 * loopback which re-parses the frame: loopback_xmit() calls
> > +	 * eth_type_trans() on it.
> > +	 */
> > +	if (skb->dev->type == ARPHRD_ETHER ||
> > +	    skb->dev->type == ARPHRD_LOOPBACK) {
> > +		if (!pskb_may_pull(skb, ETH_HLEN))
> > +			return false;
> > +		*nhoff = ETH_HLEN;
> > +		*proto = skb->protocol;
> 
> Why this change now?


I keep going back and forth about which to use where... however ...


> skb->protocol cannot be trusted (to be consistent with actual packet
> content).
> 
> Express goal is to take the actual packet content instead of relying
> on this spoofable field.
> 
> On top of that there are issues around setting protocol to IP and
> inserting VLAN headers. That would skip the eth_type_vlan branch.
> 
> IMHO, we should only use skb->protocol if no other source to detect
> protocol exist, i.e., if no L2 header exists.
> 
> Also, instead of preferring one over the other, we could actually
> read both and
> 
>     if (skb->protocol &&
>         skb->protocol != eth_hdr(skb)->h_proto)
>             return false;


That's best. I like that.


> 
> > +		if (!*proto || skb->dev->type == ARPHRD_LOOPBACK)
> > +			*proto = eth_hdr(skb)->h_proto;
> > +		if (eth_type_vlan(*proto)) {
> > +			*proto = __vlan_get_protocol(skb, *proto, nhoff);
> > +			if (!*proto)
> > +				return false;
> > +		}
> > +	} else {
> > +		*nhoff = skb_network_offset(skb);
> > +		/* An unset network header shows up as an offset
> > +		 * outside of the packet.
> > +		 */
> > +		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
> > +			return false;
> > +		*proto = skb->protocol;
> 
> Same
> 
> > +		if (!*proto) {
> > +			const struct iphdr *iph;
> > +
> > +			/* A packet socket bound to ETH_P_ALL leaves the
> > +			 * protocol unset: infer it from the IP version
> > +			 * at the network header.
> > +			 */
> > +			if (!pskb_may_pull(skb, *nhoff + 1))
> > +				return false;
> > +			iph = (const struct iphdr *)(skb->data + *nhoff);
> > +			if (iph->version == 4)
> > +				*proto = htons(ETH_P_IP);
> > +			else if (iph->version == 6)
> > +				*proto = htons(ETH_P_IPV6);
> > +		}
> > +	}
> > +	return true;
> > +}
> > +
> > +/* Walk the L3 header at @nhoff: where does its transport header
> > + * start, and which protocol is it?  Returns false if the header
> > + * is truncated, malformed or fragmented.
> > + */
> > +static inline bool
> > +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> > +		    unsigned int *thoff, int *ip_proto)
> > +{
> > +	if (proto == htons(ETH_P_IP)) {
> > +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> > +
> > +		if (!iph || ip_is_fragment(iph))
> > +			return false;
> > +		*ip_proto = iph->protocol;
> > +		return true;
> > +	}
> > +
> > +	if (proto == htons(ETH_P_IPV6)) {
> > +		const struct ipv6hdr *iph;
> > +		int flags = 0;
> > +
> > +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > +			return false;
> > +		iph = (const void *)(skb->data + nhoff);
> > +		if (iph->version != 6)
> > +			return false;
> > +		*thoff = nhoff + sizeof(*iph);
> > +		*ip_proto = iph->nexthdr;
> > +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> > +			*thoff = nhoff;
> > +			/* Find the transport header behind any
> > +			 * extension headers, AH included.
> > +			 */
> > +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> > +						  &flags);
> > +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > +				return false;
> > +		}
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +/* Does checksum metadata match a known TCP or UDP header? */
> > +static inline bool
> > +virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
> > +				     unsigned int nhoff, __be16 proto)
> > +{
> > +	unsigned int thoff;
> > +	int ip_proto;
> > +
> > +	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> > +		return false;
> > +
> > +	if (skb_checksum_start_offset(skb) != thoff)
> > +		return false;
> > +
> > +	switch (ip_proto) {
> > +	case IPPROTO_TCP:
> > +		if (skb->csum_offset != offsetof(struct tcphdr, check) ||
> > +		    !pskb_may_pull(skb, thoff + sizeof(struct tcphdr)))
> > +			return false;
> > +		break;
> > +	case IPPROTO_UDP:
> > +		if (skb->csum_offset != offsetof(struct udphdr, check) ||
> > +		    !pskb_may_pull(skb, thoff + sizeof(struct udphdr)))
> > +			return false;
> > +		break;
> > +	default:
> > +		return false;
> > +	}
> > +
> > +	switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> > +	case VIRTIO_NET_HDR_GSO_NONE:
> > +		return true;
> > +	case VIRTIO_NET_HDR_GSO_TCPV4:
> > +		return proto == htons(ETH_P_IP) && ip_proto == IPPROTO_TCP;
> > +	case VIRTIO_NET_HDR_GSO_TCPV6:
> > +		return proto == htons(ETH_P_IPV6) && ip_proto == IPPROTO_TCP;
> > +	case VIRTIO_NET_HDR_GSO_UDP:
> > +	case VIRTIO_NET_HDR_GSO_UDP_L4:
> > +		return ip_proto == IPPROTO_UDP;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +static inline bool
> > +virtio_net_csum_partial_ok(struct sk_buff *skb, u8 hdr_gso_type)
> > +{
> > +	int nhoff;
> > +	__be16 proto;
> > +
> > +	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> > +		return false;
> > +
> > +	return virtio_net_csum_partial_ok_at_offset(skb, hdr_gso_type, nhoff,
> > +						   proto);
> > +}
> > +
> > +/*
> > + * Handle a packet whose checksum metadata does not match the packet:
> > + * GSO packets are dropped, as segmentation needs one checksum per
> > + * segment; others are completed in software.
> > + */
> > +static inline int __virtio_net_resolve_csum_partial_mismatch(struct sk_buff *skb)
> > +{
> > +	if (skb_is_gso(skb))
> > +		return -EINVAL;
> > +
> > +	return skb_checksum_help(skb) ?: 1;
> > +}
> > +
> >  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> >  					  const struct virtio_net_hdr *hdr,
> >  					  bool little_endian, u8 hdr_gso_type)
> > @@ -194,11 +397,35 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Return value:
> > + * 0 - success
> > + * >0 - checksum was completed in software (slow path)
> > + * <0 - failure
> > + */
> >  static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> >  					const struct virtio_net_hdr *hdr,
> >  					bool little_endian)
> >  {
> > -	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
> > +	typeof(skb->transport_header) old_transport = skb->transport_header;
> > +	int ret = __virtio_net_hdr_to_skb(skb, hdr, little_endian,
> > +					  hdr->gso_type);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (skb->ip_summed != CHECKSUM_PARTIAL ||
> > +	    virtio_net_csum_partial_ok(skb, hdr->gso_type))
> > +		return 0;
> > +
> > +	/*
> > +	 * Here we do not trust the checksum metadata.
> > +	 * __virtio_net_hdr_to_skb set the transport header to csum_start
> > +	 * from virtio hdr, restore it to a known good value.
> > +	 */
> > +	skb->transport_header = old_transport;
> > +
> > +	return __virtio_net_resolve_csum_partial_mismatch(skb);
> >  }
> >  
> >  /* This function must be called after virtio_net_hdr_from_skb(). */
> > @@ -282,6 +509,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
> >  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> >  }
> >  
> > +/* Do the tunnel offsets match the outer headers in the frame?
> > + * The L3 header the tunnel claims must be the one the frame
> > + * carries, with UDP following it at @outer_th.
> > + */
> > +static inline bool
> > +virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
> > +			  unsigned int outer_th)
> > +{
> > +	int nhoff;
> > +	__be16 proto;
> > +	unsigned int thoff;
> > +	int ip_proto;
> > +
> > +	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> > +		return false;
> > +	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> > +		return false;
> > +	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> > +		return false;
> > +
> > +	return ip_proto == IPPROTO_UDP && outer_th == thoff;
> > +}
> > +
> > +/*
> > + * Return value:
> > + * 0 - success
> > + * >0 - checksum was completed in software (slow path)
> > + * <0 - failure
> > + */
> >  static inline int
> >  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> > @@ -293,6 +549,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	unsigned int inner_nh, outer_th, inner_th;
> >  	unsigned int inner_l3min, outer_l3min;
> >  	u8 gso_inner_type, gso_tunnel_type;
> > +	__be16 inner_proto;
> >  	bool outer_isv6, inner_isv6;
> >  	int ret;
> >  
> > @@ -335,9 +592,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	/* Let the basic parsing deal with plain GSO features. */
> >  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
> >  				      hdr->gso_type & ~gso_tunnel_type);
> > -	if (ret)
> > +	if (ret < 0)
> >  		return ret;
> >  
> > +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> > +		return -EINVAL;
> > +
> >  	/* In case of USO, the inner protocol is still unknown and
> >  	 * `inner_isv6` is just a guess, additional parsing is needed.
> >  	 * The previous validation ensures that accessing an ipv4 inner
> > @@ -353,7 +613,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	}
> >  
> >  	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> > -						 htons(ETH_P_IP));
> > +			    htons(ETH_P_IP));
> >  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> >  		if (!tnl_csum_negotiated)
> >  			return -EINVAL;
> > @@ -368,7 +628,22 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
> >  	skb->transport_header = outer_th + skb_headroom(skb);
> >  	skb->encapsulation = 1;
> > -	return 0;
> > +
> > +	if (!skb_is_gso(skb))
> > +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> > +					       SKB_GSO_UDP_TUNNEL);
> > +
> > +	/*
> > +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> > +	 * set CHECKSUM_PARTIAL.
> > +	 */
> > +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> 
> on second thought, if having to respin, might as well fold the trivial
> fix in patch 7 in here from the start.

sure.

> > +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > +						 inner_proto))
> > +		return 0;
> > +
> > +	/* A tunnel header implies GSO, so drop. */
> 
> no longer true for the above !skb_is_gso(skb) case

indeed.

> > +	return __virtio_net_resolve_csum_partial_mismatch(skb);
> >  }
> >  
> >  /* Checksum-related fields validation for the driver */
> > -- 
> > MST
> > 
> 

