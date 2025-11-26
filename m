Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54220A5F3
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138547; cv=none; b=B/9EqvUYJ0FxKwkINNTe3Je6XPDJJfL+pU5Zn64N1uNk6UDNdD1SXleNkv7m30E+1AHa8Nt7EzDN2sYLQ+bih5I6KFwzDvJqfatVPrkvz17mY1dAJgEXvdOzs/Z/sCR5cBjORiGO0uLbfRPbla+jsddf2nxXyK3rUyHuZ1UYqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138547; c=relaxed/simple;
	bh=3/pwaE5kNWc6xvRP4byT6Z1o7udkRNYHajixp1MyjGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=W2WI7njudN/Vstk75JwILqf2HlbfN6RiJubzeC64K2v1Kmd+8ZLIOvlFEmtMDyHPHIAP/Gkn1CW5j6lxVf+hj8Qt9PcvFIKsNHrhsdZFSbj014KPJ1+eUROOgNdEJE+wS4T5tnidSruUrwfn9Ef2mnMN1ZtyRqeXH+d/4gxcbNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9HqEjl6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9HqEjl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764138544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRoHaibIPNdZFAseTrDimat8Kh1F+X2mpCLBomjQqzI=;
	b=B9HqEjl66k1ARK7iKcHLE6KK1qBgHS5WQo0XM055ho+mEX2NZ8hMJj/R2lslN9vatfeeHw
	hDDMBo68EQzXknqYC2JQhi4/uc/fDBXqidNEcb/FZQnHFyyigYjA+gGBmT4Rhm2bPA7gYs
	mZ0+zJoTs94Zy6aDlY/bvYCCFD4tfMo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-yS_1JlR_O0uaeBELw3CmjA-1; Wed, 26 Nov 2025 01:29:02 -0500
X-MC-Unique: yS_1JlR_O0uaeBELw3CmjA-1
X-Mimecast-MFC-AGG-ID: yS_1JlR_O0uaeBELw3CmjA_1764138542
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so49288835e9.0
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 22:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138542; x=1764743342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRoHaibIPNdZFAseTrDimat8Kh1F+X2mpCLBomjQqzI=;
        b=t0FH2W/4iKVnvjpAb9Ojg7sSFB04ypqgdQpA3al6FJ1CQGozGxeJwvp7d53o5YYwxG
         BLiHV4X3C3lcUglQmwEFD7fBn7PagVE0laA6GJG3R/DWjunR7vREdUqBtShq8ru5Li7/
         7xpTtwckjHP2Wae756w/faSkWbiQV81g6ISuz8uEOvtR5mBPBp9qXdnEOGoYGp1R5V3h
         mpxgKqX7LQcZj9WHQr4gA1KQoorWZpNPY83W+OfltbTSz1PSSoljCJ8nWsAgV5Ms5sKo
         OgqG1Qp79Iu7kwl2Q9CIhYIqky4pwDln57NP0pvmXUH6FPIcBndGQ4ZiZEdEEL/2nqdC
         rdtA==
X-Forwarded-Encrypted: i=1; AJvYcCXHCtz5S4SUpnIjviQm0F/kQzhc9Nu9/palBryoS6kCy53HKFHCFxQ4XvxXhRqytwXxHrO6WL8xr9kFmUqdVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGqDMHc3ojGbJstqwxoz+xO+pFqppJNKlJByJRhrUFajbwrmFO
	AIr3xVtclzNgsziJoVA01t2K4q8neNYtf6AfG+OBjqM8zDnQnx0u1h32mInZFW0556TKpcK8kHw
	bnjpL1Qxl2i4gPd9/s97ehccyn55iaCC2CbEcuWTsHzlxkYhY138Fm4uCrg+9Bh6/sat/
X-Gm-Gg: ASbGncuqgRDKVlHAD1gmrsgZjJOwF1PQPLrJHGyJJexBraPO+BNEGEGwFYC7LUJ2XKE
	ThSrmBkzNqSzMEN5oSI//1yOBF/NxlmJJiMsoZCIyj7BZE+0eV24C5ovhYe88EY0+NQdPrntHea
	44OukZXD11jhSTHH3NcHv3Tnq6+7FJr2/CD42cHvpuhAED34tG5uRCgCucSqLJ6Bi+mv/WLiFjS
	eyO4VYgY8aaHsCQrL6rMNaH46oduUZ/+DjNQo/Jc2ZmXwW9o5ZOYKhss1+a24Uec+PZWpnN9/sF
	9mykzvwDz8FtqBQvD61cCusHddu4WNmRSGBZAhHWsI/1xWvlJLmyIczUTfUjAFxKRxRNse8pWOt
	gRLgrDf1QYLwZupnEHKGhiAmR+r9wPA==
X-Received: by 2002:a05:6000:1445:b0:42b:3ed2:c08a with SMTP id ffacd0b85a97d-42cc1cbd06dmr19876150f8f.13.1764138541594;
        Tue, 25 Nov 2025 22:29:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz3A2mfZSj7obvLm5ShaXHAmTMrtQXHYWQePIsCFH4Le2VTsSdvCCTNjdEfLEsFspW6+5HWQ==
X-Received: by 2002:a05:6000:1445:b0:42b:3ed2:c08a with SMTP id ffacd0b85a97d-42cc1cbd06dmr19876120f8f.13.1764138541147;
        Tue, 25 Nov 2025 22:29:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e574sm38233964f8f.3.2025.11.25.22.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 22:29:00 -0800 (PST)
Date: Wed, 26 Nov 2025 01:28:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v3] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Message-ID: <20251126012848-mutt-send-email-mst@kernel.org>
References: <20251125222754.1737443-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251125222754.1737443-1-jon@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5IGaDBYW9yziKRS5dMDk3ik_EJuUXxZEGoB9gxRWf5Q_1764138542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2025 at 03:27:53PM -0700, Jon Kohler wrote:
> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") inadvertently altered checksum offload behavior
> for guests not using UDP GSO tunneling.
> 
> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
> has_data_valid = true to virtio_net_hdr_from_skb.
> 
> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
> which passes has_data_valid = false into both call sites.
> 
> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
> for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
> guests are forced to recalculate checksums unnecessarily.
> 
> Restore the previous behavior by ensuring has_data_valid = true is
> passed in the !tnl_gso_type case, but only from tun side, as
> virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
> which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.
> 
> Cc: Paolo Abeni <pabeni@redhat.com>
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2-v3: Add net tag (whoops, sorry!)
> v1-v2: Add arg to avoid conflict from driver (Paolo) and send to net
>        instead of net-next.
>  drivers/net/tun_vnet.h     | 2 +-
>  drivers/net/virtio_net.c   | 3 ++-
>  include/linux/virtio_net.h | 7 ++++---
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 81662328b2c7..a5f93b6c4482 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>  					tun_vnet_is_little_endian(flags),
> -					vlan_hlen)) {
> +					vlan_hlen, true)) {
>  		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cfa006b88688..96f2d2a59003 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3339,7 +3339,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> -					virtio_is_little_endian(vi->vdev), 0))
> +					virtio_is_little_endian(vi->vdev), 0,
> +					false))
>  		return -EPROTO;
>  
>  	if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b673c31569f3..75dabb763c65 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -384,7 +384,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
>  			    bool tnl_hdr_negotiated,
>  			    bool little_endian,
> -			    int vlan_hlen)
> +			    int vlan_hlen,
> +			    bool has_data_valid)
>  {
>  	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
>  	unsigned int inner_nh, outer_th;
> @@ -394,8 +395,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
>  						    SKB_GSO_UDP_TUNNEL_CSUM);
>  	if (!tnl_gso_type)
> -		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> -					       vlan_hlen);
> +		return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +					       has_data_valid, vlan_hlen);
>  
>  	/* Tunnel support not negotiated but skb ask for it. */
>  	if (!tnl_hdr_negotiated)
> -- 
> 2.43.0

