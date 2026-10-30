Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400596;
	b=t/lpymvlHzWmS8lnITPXffbFalErUZermknFep8khMLWZKHMZ51EwPzcuBd8bQuiBzQr
	 7q2T6Cc9xlPWhPPe9y9CiQMkDblJWplnX/90vYpg9nczF8P/zS3fEIreOsg2IHZ8kCrWt
	 MPshUN+sWGl2Eap/Blw6G7teZMRbMbhkgtmC8wHeaMbJu6xA8ucnlNXIDG8hIn8UDcZiQ
	 VnK7h3P0Swoep9HqvC+wwkwNat8WNDrbSjgrjk3nWZIYeHBoNNFIyvrwJW5OPgAHvfWhe
	 FwKiwi1cT0ZE7v5ipAjrIk6f5U+gokBnIfP1W0S3ucxLhdlvc3vBQu8ozST9MgLEAcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400596;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=+T9BCD4WHAeHhgAEVu7K97ymFe/bRNG12NnyP6fiFZk=;
	b=isHCotB4dzkTnamNGmv0PktTjwYdJigCcPrXZa8nQYzpnh2nVK2PqxpP3J2Bl0Ig/zep
	 62+uu6TQndoKqX1JcE0HzVptzXQDLwAQXG1FLhK3tam66S3q/iU0O5Uca8n/AGAln/7Cf
	 L0yz+zOXwgDOzBe0NBMG1o25RE/ZmQ35Jp/nKNhw4qMU3uljSYQjXy9OdKU8C3uP7nQgY
	 krVlzVWz70ybUT2PukYm0wJwXpQDuPckIvaEhZWRYZGWtmqqkHWcvCB3bosrqV66b9Abv
	 17Ia4G/cC8MTD31nM3zziABS8sj/D7U0gUZbUKlxD0VIGFGRc0m9f8a5CUVioLl/fxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gVUqsrrZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09F606A31F
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 22:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A09F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gVUqsrrZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793400594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+T9BCD4WHAeHhgAEVu7K97ymFe/bRNG12NnyP6fiFZk=;
	b=gVUqsrrZkg6LpTfju9XTWs6XqPcv4Yk4oUEBoMjYA90Yxo2LDgqoFpdrTPwwLBOwFDrwli
	Wm9RMYIuOaJMl4e61QLyldCkkjM5XDRSOnok8n2F1DEnT0QXF5c4xY4KDLDuKwflhOnTAz
	6OVrkLqxQvuI9/OpyuJgzP52FuVjqWw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-neLbIjx9PC6kq63w92TnMw-1; Fri, 30 Oct 2026 18:49:52 -0400
X-MC-Unique: neLbIjx9PC6kq63w92TnMw-1
X-Mimecast-MFC-AGG-ID: neLbIjx9PC6kq63w92TnMw_1793400591
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso10405365e9.0
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 15:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793400591; x=1794005391;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+T9BCD4WHAeHhgAEVu7K97ymFe/bRNG12NnyP6fiFZk=;
        b=ii9+GWtFOX5tQYzty75UJFBChkCaCnfQ+lHXx1XebJjR7XHzh0uLA1gZ0ih7gd+aAx
         xZcuRfmCwabqkIN+WNPZKtUy3J45JNKnDDTmJeLJA++rBqBgzA9Bx8uf0hvQgsb9m6J3
         2pJ0cp1MTl9m8jVM2Tn/PxNC174hIdm0kWvWCr6t6Zr2WTcHCG13Xwz7NDVXJPdPO/qj
         a6nH+yAmlia5cSRJL1QCOY2zMcDHMvObJHMFeNGsh4ceB1aZbfsX1ary6SiTBMc1QWO1
         acM+7mWWePzt2+m88YSGIgUWep4zAs46Rp2oscjKhH7REQAGowAUClzA3RQb+ONkZUmu
         mJ0A==
X-Forwarded-Encrypted: i=1; AKwUvByJV3plagjhhHEqH/2HVfNcQfLMWvgqgPZvy8jqO3PT+4wEfIXYhcWnwwp5kMAYzOKcdcMfGF9SYHD44IeHWg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLBlC3gPEbMKILRT/pxxEGaTBj6qtThS64CSSnBPEvOuCX5yZu+
	NGpOj/OeOY++GgyYUuReqNl/RVzu7BREVTrMm/krHxwamAWP05N44n/6r/TtTAkw7mHo/I2hPDO
	ZlmeYTMn0VpCqu9v/OEoM2QJvibf6rVzUi0jddVffEdyAeoacRPoy98ldUm/wvRqAyudH
X-Gm-Gg: AYBFou2AaOfrkc9YcNvmXghKTsyyP1V3YqsKyWcNpzEYZH+rDkP0pDYMXpDjwL/5V1B
	Ma5sUAt8cIjM/XSCa7JkPKvjM5qI2YTx3WSNFef7FuQHPMkkTl2IpzsJDJNhVnFeI60XYyNJoGM
	a7ZP0d2s/l20b9RXOs4yAucmfuKBhWY1zLkbZmRqBwE2O3tiY8mwQVQVDxyogPAQi1qTCP43F6i
	TFClqzg1/Rp/9Ax1eSSVCJJ+8s6UwHeiBdZYekp0ALcJLzJU2DHf1GGr+FxF2KprmaaohAQCG57
	jg2aP5wHT/797dfJnslQbrIKDiKpJ9evAXje4aWat8xGzmsrnwbrsKyFkAWnjRXRcqBGGC/L72m
	Ys62BK0t/3x/8e459R52u1YBJAwtjmY46V6wqnUWFgjDk
X-Received: by 2002:a05:600c:46d1:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4ac17b2c8a7mr81098265e9.25.1793400591332;
        Fri, 30 Oct 2026 15:49:51 -0700 (PDT)
X-Received: by 2002:a05:600c:46d1:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4ac17b2c8a7mr81097795e9.25.1793400590841;
        Fri, 30 Oct 2026 15:49:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf0b36853sm80313395e9.0.2026.10.30.15.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:49:49 -0700 (PDT)
Date: Fri, 30 Oct 2026 18:49:46 -0400
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
Subject: Re: [PATCH RFC v7 4/5] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261030184752-mutt-send-email-mst@kernel.org>
References: <cover.1793276116.git.mst@redhat.com>
 <93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com>
 <willemdebruijn.kernel.10a41a35b45f6@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.10a41a35b45f6@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BSESpJb3HfZcW5cL2SJrfQDudGs9fDnjdUXDy-EfjWM_1793400591
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 30, 2026 at 03:21:57PM -0400, Willem de Bruijn wrote:
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
> > Note a fundamental limitation of this approach: an nf/BPF program
> > that tweaks the payload of a packet in flight may rely on the
> > checksum being fixed up later, assuming the packet carries
> > CHECKSUM_PARTIAL.
> > 
> > For metadata that fails validation the checksum
> > is now completed at input, so such edits leave a stale checksum
> > and the packet is dropped at the receiver.  Protocols whose
> > transport header we cannot parse (anything but TCP and UDP) are
> > affected even when the metadata is self-consistent.
> > 
> > The sysctl added in the next patch is the escape hatch for these setups,
> > but it is a very blunt tool.
> > 
> > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Reported-by: Chris Arges <carges@cloudflare.com>
> > Tested-by: Chris Arges <carges@cloudflare.com>
> > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
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
> 
> Minor, not cause for respinning on its own.
> 
>     `flags` should include `IP6_FH_F_AUTH` so `ipv6_find_hdr()` stops at
>     `NEXTHDR_AUTH` instead of skipping it:
> 
>     - `CHECKSUM_PARTIAL` and GSO behind IPsec AH are invalid: AH authenticates
>       the inner L4 header including its checksum field
> 
> > +		}
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> 
> > @@ -368,6 +660,21 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
> >  	skb->transport_header = outer_th + skb_headroom(skb);
> >  	skb->encapsulation = 1;
> > +
> > +	if (!skb_is_gso(skb)) {
> > +		/* Too small to segment: complete the checksum in place
> > +		 * instead of dropping - senders do tag small packets
> > +		 * with GSO headers, e.g. packetdrill sets gso_type and
> > +		 * gso_size with --mss, whatever the packet size.
> > +		 * The outer UDP checksum is not calculated, but a zero
> > +		 * one is fine: UDP over IPv4 allows a disabled
> > +		 * checksum, and so do tunnels over IPv6 where the
> > +		 * receiver opts in (RFC 6935, RFC 6936).
> > +		 */
> > +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> > +					       SKB_GSO_UDP_TUNNEL);
> 
> Maybe this carve-out for non-gso packet is best moved to its own
> patch, as that is where the remaining issues (to merging the rest)
> seem to be.
> 
>     1. Moving `!tnl_csum_negotiated` below `virtio_net_csum_partial_ok_at_offset()`
>        accepts packets with an unnegotiated `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM`
>        flag whenever inner validation falls back to
>        `__virtio_net_resolve_csum_partial_mismatch()`.
>     2. `__virtio_net_resolve_csum_partial_mismatch()` calls `skb_checksum_help()`,
>        which completes only the inner checksum at `hdr->csum_start` and sets
>        `skb->ip_summed = CHECKSUM_NONE`, leaving the outer UDP `uh->check` with
>        an uncompleted pseudo-header checksum seed.
> 
>     Despite the comment, this block neither completes any checksum in place nor
>     is the outer UDP checksum zero when `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM` is set:
>   
>     - With `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM`, the outer `uh->check` carries the
>       non-zero pseudo-header checksum seed (as expected by
>       `__skb_udp_tunnel_segment()`), not `0`.

Oh yea i kept tweaking this and forgot to update the ocmment.

>     - Clearing `SKB_GSO_UDP_TUNNEL_CSUM` on a `!skb_is_gso(skb)` packet leaves
>       `skb->ip_summed == CHECKSUM_PARTIAL` at `inner_th` with nothing completing
>       the outer `uh->check` on transmit/forwarding (`validate_xmit_skb()` only
>       completes/offloads the single inner checksum, emitting a corrupt outer UDP
>       checksum). Even zeroing `uh->check` would be invalid over IPv6 unless the
>       receiver explicitly opted into RFC 6936 (`UDP_NO_CHECK6_RX`).

Indeed.

> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > MST
> > 
> 

