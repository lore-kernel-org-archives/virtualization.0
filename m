Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792719488;
	b=VDA7v9hnoVc/9ppqnxRRkGp1wD78C/BDo6LcVh9QHLCHpVH2N3oyIBlMnfG9zg0Z6wGT
	 r9zlD3SUuGU+EOdaLRpWTmT2d+EyNc40PdNEcMJ/Ze383JlgwYi+YIatCw/wkR9ADod3r
	 oB6PpX3qVcYEsSerxe3TkE1lat1EFp9eGWq4aFCQXGI27lAQm8eAIqedm03BdcRGuT9Ce
	 BWCqLZzVC7+BC0M9tkbOWDyvARGnO5szyGBgRBzgPiTvQbMvQSnXwajtD1A8E/PtQrhaF
	 pmLdSJXDuuOw/Q+Usg6jO+oMLmEEgpu8Exf9oTfz7i08oA6rNRypQbO/5DUNO/BmiJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792719488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VyS6G3Kx6WPq1nBIZXm3hw0RmZ6T3d+8BhWqtGP+Tt4=;
	b=fmig6H3v21I01FGbWajjIVA9UEGxByOSksCHG3LFxRwbx5pxvSqDjq2xLfQjPYVeG1sc
	 DeobmBslk0Jt8GkgwDDjbi/CCCMYhTzxbtsC4x+IGYwzZwe3na5R6PLw0LNEt6MM5SFHL
	 wTUAy+V/VyR1z1p436cxionOFioLDg48/Tzh4rsW/Ll6jwvH34rYtHf9mlj/pTq9Mum4z
	 IV2oEy7kBJL5X6k21CeDLzGOKllrAXHQEthEXA48eomkwKI/Up4dlJ9M9yT6jpcP4/ZWS
	 Yc3NI2ZiS+paj/Z1fx517KqyLSVc14LFtLG+rcGRI776Vw5sDXl6VuZvjRfaQQri6gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=P0xLBtpP;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11D606A31A
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 01:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E11D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=P0xLBtpP
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-825b40f8a26so180592a34.1
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 18:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792719487; x=1793324287; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VyS6G3Kx6WPq1nBIZXm3hw0RmZ6T3d+8BhWqtGP+Tt4=;
        b=P0xLBtpPR1qX6V+gUkYfdIEwMro9TjMfiamfI8sKs/p7Zl2FvaQqz89ej4w96MOZQU
         ZVpra5lybbN48MPwcAnxGnQ3bGSqIEzacdt7er1LwjmtA1Q0jOM+D+6pl5vgOe3od7G8
         bTwIR4KwL2xSE9emEUtL8epBSd7GhjSgfirCukJzf4AmYy65XclJJlkjTJcLKGw7U107
         jSn0ozcfppYuiI7CZ1pYUOm/VWxJJKGYq416uTWOKlHvaKzYWlSPeNLy2U2Xbyv4pu7u
         do0y7cG6ld4pMwM2D4Enof2Pd+MC6r60QLiyHa6w64599aOtE8h1QTJ1Wr2gPT6LQdB6
         AfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792719487; x=1793324287;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VyS6G3Kx6WPq1nBIZXm3hw0RmZ6T3d+8BhWqtGP+Tt4=;
        b=xG7L5wfc+5Ce5orHTH5pcMAfGDM4NW1K5nRM2tpp5qvEo3fWWWe93CpgALdIuhml9o
         HmdnMGDn6k3qXrmQ5IbWLAq/hvEdgp6R9cORYoNXZ6wLXClMHA/hPHfffWzjAcWcbnAN
         hMuUolXMGycV65wq0jxKQ7lKdQ5fioTOaJvNSVOpa58EFN81nfdugwy+eSUTVE/CgbTJ
         wECtwdguQAkK1RT/Dr5YLnEtX4vaQ+MSpHzA5dtKXnMO17MrR3t4SYP3TdizBkAuMHg5
         Kp548RVed1fHA52z4VlH5zSiWO7bFhNk5ErEKrAOy102tn6QC9FTi303Z8zK+3ef32CD
         yWcw==
X-Forwarded-Encrypted: i=1; AKwUvBzrG+8rjExvy5camvdJ5ak/6EFFwEWeRaYscMxXe1gxxHUvjedYi6Oy97ZuE1T6yC7ribMgxJvrBt60msBcHA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKtPgZaf2S+hApQiedpHpwtZwVpEg6R/iZ+mZOPG68RQoByUfi1
	3rDMdc9qJ3WpeDK6Si1rqcAvNSRT86uo3yRklgFlnlUHY00tyNtOV75chAGsFrdbW2w=
X-Gm-Gg: AYBFou1JnfYyRTp48XmwL4xDOyf3QNMn6SvW0T1EMt8esaN+D53K37MieR+rVVOrDC8
	0zwHRVduq78QedYDCoTVD3Ace538358XbQh1NJpp6le+08y4r4PVWbY71hb+C5VY+uDK5js7HDY
	Bo9iP6YRTypKoAXzDH2rRqz2j3f5lIOX3VbPM3I37yjkcpWeDBRCnQZGEzDnKEA8EZewBNRQNXd
	UVJNXE+YagUmNIYXnM8/7pV6cqjee1BwtrvWwuwrO5ao56AGTzhD96OVQrTQvHJdje6RWepJESt
	Z/rpzpY2pPu1Qr77d0vB2h14oY2Uvgrv0h4mQY8kbTi30cHqYKDHuVq9+nfPP7Wx1y/qausKKjC
	JiERgPow2BpvFZ7jklyZySntfMO6FVbH+HkWSu1TB43vhIGtBfpOFYYXXG0+nWrlZsqT9LuQANv
	pL/jujwRifS44GdY+HCdevW+F56lcdlyeThjfLtd4d4NKXU64WZDDzn/peybsHpzjSbGdV+DjcZ
	pdikaYU3PzIhlL290xIOfFjoEwe/hP1cGE=
X-Received: by 2002:a05:6830:4412:b0:7eb:9464:ac2e with SMTP id 46e09a7af769-84fb0d542femr668994a34.11.1792719487276;
        Thu, 22 Oct 2026 18:38:07 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:96::f:3b8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84fbdf59d82sm770666a34.15.2026.10.22.18.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:38:05 -0700 (PDT)
Date: Thu, 22 Oct 2026 20:38:03 -0500
From: Chris Arges <carges@cloudflare.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Max Krasnyansky <maxk@qualcomm.com>, Rusty Russell <rusty@rustcorp.com.au>, 
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net v5 4/7] net: resolve uncommon partial checksums at
 ingress
Message-ID: <atq3hiJcsVi_1v0u@20HS2G4>
References: <cover.v5.git.mst@redhat.com>
 <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
 <willemdebruijn.kernel.2987fc5710162@gmail.com>
 <atpIiwcUlH5ttBb6@20HS2G4>
 <20261022193052-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022193052-mutt-send-email-mst@kernel.org>

On 2026-10-22 19:38:53, Michael S. Tsirkin wrote:
> On Thu, Oct 22, 2026 at 12:52:36PM -0500, Chris Arges wrote:
> > > > @@ -335,9 +592,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > > >  	/* Let the basic parsing deal with plain GSO features. */
> > > >  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
> > > >  				      hdr->gso_type & ~gso_tunnel_type);
> > > > -	if (ret)
> > > > +	if (ret < 0)
> > > >  		return ret;
> > > >  
> > 
> > One other case I found in testing is that a producer can set gso_size
> > larger than the remaining packet data. __virtio_net_hdr_to_skb() then
> > succeeds, but intentionally does not install GSO state because the packet
> > is too small to segment. NEEDS_CSUM has still left the skb with
> > CHECKSUM_PARTIAL.
> 
> So why is this a problem? If checksum offset is correct we leave
> packet as CHECKSUM_PARTIAL. That's intentional.
> What does your test do that makes this a problem?

The problem I saw used this case and setting inner_nh_offset incorrectly.
I'll dig more into this, and follow-up separately if this indeed is a
real problem.

> 
> > The following check fixes my test case:
> > 
> > 	if (!virtio_net_hdr_validate_disabled(skb) &&
> > 	    !skb_is_gso(skb))
> > 		return -EINVAL;
> > 
> > A concern I have is this may reject valid packets, so maybe there's a better
> > place for this.
> 
> 
> Indeed, it's not uncommon to have small packets with !gso.
> 
> See also:
> commit 7c6d2ecbda83150b2036a2b36b21381ad4667762
>     net: be more gentle about silly gso requests coming from user
>     

Ok this is helpful, I can see why that doesn't work.
Thanks

> 
> 
> > 
> > > > +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> > > > +		return -EINVAL;
> > > > +
> > > >  	/* In case of USO, the inner protocol is still unknown and
> > > >  	 * `inner_isv6` is just a guess, additional parsing is needed.
> > > >  	 * The previous validation ensures that accessing an ipv4 inner
> > > > @@ -353,7 +613,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > > >  	}
> > > >  
> > > >  	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> > > > -						 htons(ETH_P_IP));
> > > > +			    htons(ETH_P_IP));
> > > >  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> > > >  		if (!tnl_csum_negotiated)
> > > >  			return -EINVAL;
> > > > @@ -368,7 +628,22 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > > >  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
> > > >  	skb->transport_header = outer_th + skb_headroom(skb);
> > > >  	skb->encapsulation = 1;
> > > > -	return 0;
> > > > +
> > > > +	if (!skb_is_gso(skb))
> > > > +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> > > > +					       SKB_GSO_UDP_TUNNEL);
> > > > +
> > > > +	/*
> > > > +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> > > > +	 * set CHECKSUM_PARTIAL.
> > > > +	 */
> > > > +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> > > 
> > > on second thought, if having to respin, might as well fold the trivial
> > > fix in patch 7 in here from the start.
> > > 
> > > > +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > > +						 inner_proto))
> > > > +		return 0;
> > > > +
> > > > +	/* A tunnel header implies GSO, so drop. */
> > > 
> > > no longer true for the above !skb_is_gso(skb) case
> > >
> > 
> > virtio_net_csum_partial_ok_at_offset()
> 
> Sorry I don't get what you are saying.
> 
> >  
> > > > +	return __virtio_net_resolve_csum_partial_mismatch(skb);
> > > >  }
> > > >  
> > > >  /* Checksum-related fields validation for the driver */
> > > > -- 
> > > > MST
> > > > 
> > > 
> > > 
> 
