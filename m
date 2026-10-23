Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792799169;
	b=UPLd9ae/59fKDsiVrDRnr/KOpFolI3IZnMIvzmrPEEYuGuAtMIOFGhyEXfB72qpkTN28
	 LJ3GVPc+7INoF+2gHMvzJWXmWsnm6NjbmY6ZiWTeGykCMwReu5z0rdLpWvbayml3zQbW5
	 xv8Tlonr6uHeHZvc5bVwVhgg4mh6H5K2HetiVUbgxAZZg1nCBiRUvEx85mCJ2QhxS7zlF
	 9mSaKiXuDCMB1/xWp+/JHpUJ9GOoQIOYFLfsnH3hMy8p980MjTRUzcgPzXNA0/iB9QFGh
	 g0aFyI1YzZiMGP/U5TPspnb2Cyv+dCh7Lj2O3gqN1y8jpQmwjbRe/BDVn1jmdfzUhKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792799169;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=O5btSrqleegX0p5ha9cygCby9IqJb3FwGDRdWPZ2zaI=;
	b=fnM7EwUhMdRY21tJBSfKG8zPCDk/YLDLOPmvtnLSblQ/v5WmgyztQAeliGIgcJXs1NmN
	 1DHfSdtgiTVY8mTroCYjAGzAKlSe4b68eK3EbjcBbdInvFqzvNLQBwr00D0pgGExLnTIJ
	 iCfnWemBEyk23JKneIXFeJtORrr1EITU5vCGKLE+Avqod8vPpyKG7aX9fZfiAK9gH5ZCb
	 CSBBKYAx0yAqGd9NGeVZJjNXGHMEcLWHYMtNkqbropvf7jw0p7UIn76fS3majBAHyTxgO
	 DJLLgs5MymebvG0tECsc4M6iKfTDirUQd1dn4AOJ0XIu2Qz/wIheRpX1aV6wDPAvgvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VHlN++zG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42659606A31A
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 23:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42659606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VHlN++zG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792799167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O5btSrqleegX0p5ha9cygCby9IqJb3FwGDRdWPZ2zaI=;
	b=VHlN++zGfy1mwsOiBdYnmBLsB4sojylTejSLE/kuc5Akk33ecfs1En1h5WXbi8nCY4d38n
	TogfJ3YbeOxEO5AJnfub0jpplafpDzYvl4M5wPGfeLt169bPG6xhrAf8sZxB2DTW93Uxai
	J9J8F/eiSRkwLSXOEMsaisAI9ERO6xY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-wUqPt0ciN4K4cjeg6Z5Esw-1; Fri, 23 Oct 2026 19:46:06 -0400
X-MC-Unique: wUqPt0ciN4K4cjeg6Z5Esw-1
X-Mimecast-MFC-AGG-ID: wUqPt0ciN4K4cjeg6Z5Esw_1792799165
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so731268f8f.1
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 16:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792799165; x=1793403965;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O5btSrqleegX0p5ha9cygCby9IqJb3FwGDRdWPZ2zaI=;
        b=tUapcY3XHVzk2hzIUN+1Z0o6TriUcYvP+eHdk8PluGQkB8zH4f1wQXFNEnw8OXXXNK
         qd0b+2c2/gaFGOiiWwOtnVKgM9xNABqt/Rs5kl3oZIbY7QRhcCECQIeKS4RU4Q/tsWBe
         euEafxue3A0YtFnopR0xPCQNIIznZopEUL9eDGybmpPC0c276j3BkcC04bAX4lnysUC5
         VXmpNkvUz9esBQN9vTQuWu5iQV0T94RDPcr6jQLgXB4EHr7wPQclKPtG+XFrP1za2Ksr
         FxqL98aPXJQG4BP/9D5QDuzWwbp+3q8kwkEjJXdc8q93vHr7mNn6Mcg6KMat+5RlCURC
         wF4w==
X-Forwarded-Encrypted: i=1; AKwUvBx3N7d5Kp77ymf0JaK8AYAOq7sNrP+Z1E9lr7OnuE5whlKqacFTMFHvYNd6bSzYKwDOQ+hcbIUCZ6l+L/YoBw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKzYs6naFlCoJ2uEWbQFwpl11YA1czw2slJFZg4HBtJ/2djYbkY
	P33ngooxVrGTbYZowx971JlW+BHoyWbzIDmspiYYTIvRQ0WYVAZIuhlk4uuhbsKLMb2P+jiEuIc
	IQmgW0d3Zm43h5vZqJd+8GROMoWwV8nLP2tdt3SCPH1+S98P+78AMrxRfQ0gJ9cagzrRa
X-Gm-Gg: AYBFou2XJnbHP0ILImfTXIOjG25okvJfSzxY5tFQ1olAz+NMv131SK20DgAMQsCWfcW
	X7kaRWQKggrhfJQmMFRdsRW3eJR7Jm+ZHQlvVy95/YLb9WuiwdSvIZYvlvZyJH8bpqglcmUdwwr
	XFSa/+3KS4hKZ04sw3TqU7OVcXo3Ns5c5FI5NBr2Hl0BHIXbEUfblaBcPjIKQLeWYWuzurD8+MI
	hmh+iojYhI3sGXTvMM+p+UCDZ3K2y2nC8qlG4lKfY+MxTWicBWPIp0Hhv2cORmuZZtL7Wgdp8gm
	B7nySMXlSWx8UpEeApYMpRaIOLV5vuwgMH3kiKdov1NbtQtL7opV1pvuiJAc93V9VVFn7q4=
X-Received: by 2002:a05:600c:4f4f:b0:4a3:5a42:b29c with SMTP id 5b1f17b1804b1-4a35acbc00bmr6034975e9.26.1792799164695;
        Fri, 23 Oct 2026 16:46:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4f4f:b0:4a3:5a42:b29c with SMTP id 5b1f17b1804b1-4a35acbc00bmr6034755e9.26.1792799164158;
        Fri, 23 Oct 2026 16:46:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fc1207sm12576005e9.1.2026.10.23.16.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 16:46:03 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:46:00 -0400
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
Subject: Re: [PATCH net v6 4/5] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261023192005-mutt-send-email-mst@kernel.org>
References: <cover.1792768096.git.mst@redhat.com>
 <bd468c7ea5468d6e3827a3c678eee15243615580.1792768096.git.mst@redhat.com>
 <willemdebruijn.kernel.3ae6f662e1ed8@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.3ae6f662e1ed8@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B3fUGt6Wun8VYJu2qGfUQ9WdW-V-Z1WOzNoyTlDX-wk_1792799165
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 23, 2026 at 03:37:48PM -0400, Willem de Bruijn wrote:
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
> 
> A few comments inline. All but one cosmetic. Feel free to ignore
> those. Please do review the comment from an LLM about the tunnel.
> Aside from that LGTM.
> 

...

> > @@ -368,7 +637,20 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
> > +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > +						 inner_proto))
> > +		return 0;
> > +
> > +	return __virtio_net_resolve_csum_partial_mismatch(skb);
> 
>     Allowing `!skb_is_gso(skb)` packets through `virtio_net_hdr_tnl_to_skb()`
>     has a few issues:
> 
>     1. When `!skb_is_gso(skb)` and `virtio_net_csum_partial_ok_at_offset()`
>        returns false, `__virtio_net_resolve_csum_partial_mismatch()` completes
>        the checksum in software and lets the packet pass, but `skb->encapsulation`,
>        `skb->inner_protocol`, `skb->inner_transport_header`,
>        `skb->inner_network_header`, and `skb->inner_mac_header` have already
>        been populated with the unvalidated `inner_th` (`csum_start`) and
>        `inner_nh` offsets (unlike `virtio_net_hdr_to_skb()`, which restores
>        `skb->transport_header`).

Oh right. Hmm. I can just run the check first.


>     2. If `!skb_is_gso(skb)` and `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM` is set,
>        clearing `SKB_GSO_UDP_TUNNEL_CSUM` drops the outer UDP checksum request,
>        since a non-GSO skb can only carry a single `CHECKSUM_PARTIAL` offset
>        (at `inner_th`).

Right. But it works! Because the checksum is 0 then. I'll ponder what is
best.


>     3. On RX, a non-GSO UDP packet with `CHECKSUM_PARTIAL` at `inner_th` causes
>        `skb_csum_unnecessary()` (`skb_checksum_start_offset(skb) >= 0`) to treat
>        the outer UDP checksum as already validated.
> 
>     Unlike plain GSO (commit 7c6d2ecbda83), UDP tunnel offload is modern-only and
>     explicitly requires GSO (`/* The UDP tunnel must carry a GSO packet, but no UFO. */`).
>     Why not reject `!skb_is_gso(skb)` right after `__virtio_net_hdr_to_skb()`, and
>     return `-EINVAL` directly if `!virtio_net_csum_partial_ok_at_offset()`?

This will break apps, I think. See 7c6d2ecbda83

-- 
MST

