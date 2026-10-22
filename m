Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712341;
	b=LNZDhoW6Ga6vguBNSZfiK7i98cvjD4VDddRltMadurJoRaMiu1ouDxY1KfXA+j+B/89G
	 G/nW6cOCUM32UYOSWS3GxQX5IDdCK9lVv1NJXxisw84g8z9/xSr3LZkMowRXT01BMVE8o
	 DHj1DYOuokZcglLXtOstfzm9ZfcNhr+jxRr+eIW43dPBhsH0nnIdIOwlRwopJf1gLbWKS
	 HM+L5uZ6xP0kJVPmt7BRIHAUeE/Uud4PvLrilfacjgHZtuNPc4r4IMjwvhNxDfjS8m8f6
	 XvBWxOOSw7yYoVzkBaii8RERbAy4bf/DXi7dFSa6ngqjZOFzpuqr+pG7FTK9Gc28iVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712341;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Nqaq+KGmgq+7t4ixqZSLUjFN4QjJmmGs/RCocqmgwTQ=;
	b=UWskzOM+moDZu9u2sF12QakuVgX9I8tM+slXB+koZDwuyuPeRXZ/ReBDknXZg6bcTI9K
	 6qiWQjFJmVV9nj5hhJJnY3JKshrfYF50V6yYjmHMlbSZXMj5x2NskPPwYLRQeeJXTPqVR
	 ca3/DE18MJf93TbOA6p/yq9JfscziWDvkaOidvgAqPNX0DatdcgJNyMCkUhH1W1KqGN8Q
	 g/+4k3p5cEX1CKmruCvCoYezWvQ79wao2aFsq+HS5z8LSYwsYXUl85+XM5XCFeDB05hwB
	 +XSBNUKw5CO+LD/kAi7rthLcISJ4j6xfy+fYYyniB3rlyP+GnjjoMn8GD6EWh53RiGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fnqsRThz;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9BE606A31A
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 23:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE9BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fnqsRThz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792712340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nqaq+KGmgq+7t4ixqZSLUjFN4QjJmmGs/RCocqmgwTQ=;
	b=fnqsRThz9vxDV5ZsV6Ix4ml+uRyXI9Igbef+PSp/B8dHyIa0I0SzOjnhZIQ1D3JT+1SXu7
	zDnQlS+xSB6SvuMLMPDFlNEzQRfVWfKvblQQJ41r9dfhni+X4JknD0GsHZezpGfwMBssIQ
	3OZEOjd+l5mTr2AZfykPB9RG48V2YZo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-ZTDP9sbWOiKFSVVdYTnvWw-1; Thu, 22 Oct 2026 19:38:58 -0400
X-MC-Unique: ZTDP9sbWOiKFSVVdYTnvWw-1
X-Mimecast-MFC-AGG-ID: ZTDP9sbWOiKFSVVdYTnvWw_1792712337
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e1291432aso163906f8f.2
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 16:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792712337; x=1793317137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nqaq+KGmgq+7t4ixqZSLUjFN4QjJmmGs/RCocqmgwTQ=;
        b=Dgj5VWyN9tT9LEQPhoeNR7ZTKx+sNwZAMx7DVY2zGd/bGViALzAMIUVUuHg3WaeOli
         ohHjfKvK5b8GXyBk1BWr3GkQvINHhJKWgl06agZDVxhU/MkJeo+mRMc4nfSgknrds95H
         yryhBvcwGNBt8KuyJ5D8TV0C7rtSirPzmm/olk3GWfWN2jOmto/t+ZA1gvIaQQDNL/wm
         I7IVirO6hHnayIuqYz3lyvKL5RiBvDMz0oX81ZTNyWrt9ixR21T9eZPYEKjIphBFJMya
         bOnN2Su1khkwKyWQFZafzOHBvlm86zjeT50cvAbyuF0A2Rsk6OM+V2gRmG+RSf1NIJ+P
         hUzw==
X-Forwarded-Encrypted: i=1; AKwUvBxl9E9yfBjnQTj6UvtD/fTEsq2qh9sip7WmHqAhFRIntNmyWILV8D4LGemg+9mekYlYqNepemVnz5Mx1kJfcQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLk0Y0oz5QL35cBYb2fDbQzxEb/kA4lWeD20Q9y+nGnSELRLJEu
	I8ywrv07GApxnzajg+p2r4F20ffRcyJxWdSSmyRRBy0Uiz0NdUoykxrMZ7HR9iXEAkEcipgbr6V
	uDl8qiCtwiEaAMwGwGKuYeLA8YL7Sq9PqM5bO5jJFIgBZiVWYmcYdSBH86Xj/QsMl25DQ
X-Gm-Gg: AYBFou0XbCQ+mO9dIkx0mMhCm0x7NyZTL3N9FaX4g7Oz/LbaQBQkOxD6GzhJVaV9vZD
	itGSprhkVFdkaCFIBQ853tTEN0p1u9O69szMu60SRAOQUke1A0qGS02UjVaQ0JtM8RVkugbLcjl
	toI8pQ8Jv6VswwXWz4HgF5WbPy2oQxpJGzQSaAd7p/1BiofOU05L4hpEKrDB+t3Lk6GsfSBO6S1
	Nle7ACm8ie8/N6hVDS1/p+YZS0l07xT4xwcM5SwjTeROl6uIkY9j0tjn+LbVdUlzVYWiROkZmLY
	4AMpD2r12xPqOvId4OtgfjAS/ZWFmCa4e7GzYS45mykF9VWwKpXb420N2I+Ex6nIkiyFlG4=
X-Received: by 2002:a05:600c:350e:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4a211c7fb6bmr9087205e9.4.1792712337433;
        Thu, 22 Oct 2026 16:38:57 -0700 (PDT)
X-Received: by 2002:a05:600c:350e:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4a211c7fb6bmr9087035e9.4.1792712337018;
        Thu, 22 Oct 2026 16:38:57 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210473567sm30620015e9.12.2026.10.22.16.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 16:38:56 -0700 (PDT)
Date: Thu, 22 Oct 2026 19:38:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chris Arges <carges@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
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
Message-ID: <20261022193052-mutt-send-email-mst@kernel.org>
References: <cover.v5.git.mst@redhat.com>
 <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
 <willemdebruijn.kernel.2987fc5710162@gmail.com>
 <atpIiwcUlH5ttBb6@20HS2G4>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <atpIiwcUlH5ttBb6@20HS2G4>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zJ_dekabB5TEF_jHJprkCww93qiYoLrAuOHqzY0YYNI_1792712337
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 22, 2026 at 12:52:36PM -0500, Chris Arges wrote:
> > > @@ -335,9 +592,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >  	/* Let the basic parsing deal with plain GSO features. */
> > >  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
> > >  				      hdr->gso_type & ~gso_tunnel_type);
> > > -	if (ret)
> > > +	if (ret < 0)
> > >  		return ret;
> > >  
> 
> One other case I found in testing is that a producer can set gso_size
> larger than the remaining packet data. __virtio_net_hdr_to_skb() then
> succeeds, but intentionally does not install GSO state because the packet
> is too small to segment. NEEDS_CSUM has still left the skb with
> CHECKSUM_PARTIAL.

So why is this a problem? If checksum offset is correct we leave
packet as CHECKSUM_PARTIAL. That's intentional.
What does your test do that makes this a problem?

> The following check fixes my test case:
> 
> 	if (!virtio_net_hdr_validate_disabled(skb) &&
> 	    !skb_is_gso(skb))
> 		return -EINVAL;
> 
> A concern I have is this may reject valid packets, so maybe there's a better
> place for this.


Indeed, it's not uncommon to have small packets with !gso.

See also:
commit 7c6d2ecbda83150b2036a2b36b21381ad4667762
    net: be more gentle about silly gso requests coming from user
    


> 
> > > +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> > > +		return -EINVAL;
> > > +
> > >  	/* In case of USO, the inner protocol is still unknown and
> > >  	 * `inner_isv6` is just a guess, additional parsing is needed.
> > >  	 * The previous validation ensures that accessing an ipv4 inner
> > > @@ -353,7 +613,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >  	}
> > >  
> > >  	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> > > -						 htons(ETH_P_IP));
> > > +			    htons(ETH_P_IP));
> > >  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> > >  		if (!tnl_csum_negotiated)
> > >  			return -EINVAL;
> > > @@ -368,7 +628,22 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
> > >  	skb->transport_header = outer_th + skb_headroom(skb);
> > >  	skb->encapsulation = 1;
> > > -	return 0;
> > > +
> > > +	if (!skb_is_gso(skb))
> > > +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> > > +					       SKB_GSO_UDP_TUNNEL);
> > > +
> > > +	/*
> > > +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> > > +	 * set CHECKSUM_PARTIAL.
> > > +	 */
> > > +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> > 
> > on second thought, if having to respin, might as well fold the trivial
> > fix in patch 7 in here from the start.
> > 
> > > +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > +						 inner_proto))
> > > +		return 0;
> > > +
> > > +	/* A tunnel header implies GSO, so drop. */
> > 
> > no longer true for the above !skb_is_gso(skb) case
> >
> 
> virtio_net_csum_partial_ok_at_offset()

Sorry I don't get what you are saying.

>  
> > > +	return __virtio_net_resolve_csum_partial_mismatch(skb);
> > >  }
> > >  
> > >  /* Checksum-related fields validation for the driver */
> > > -- 
> > > MST
> > > 
> > 
> > 

