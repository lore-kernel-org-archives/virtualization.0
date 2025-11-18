Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E162E7623
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502520; cv=none; b=e8E0QwdqTHn4oCQ5k/06FOHwbL1O8TmYdQ06c+u5EUltLnl7Yr93ELyIYIfh5Oh8KrZvKVqbdIvUVZWkqU78m+n4lu6SmO3PZEFt7y1dn4lRrc/naK/GzyhWVO493EqDUJVj4b33OYPJpjJZd3Q9e+UAtafb9lU4E3Dzy6LCPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502520; c=relaxed/simple;
	bh=TPTgzrbVMNecIPQUYlT9kC0lc8aPV7SNalegsNW6Hz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NFrMh9V/6AJwwuQadxczGMEv1ocd5H75Y6LwN31Ix+XM7wgPlYiHZprTHUpH7jm5lmdDgFfId4O+UqQfzavcxTA2gUYBixfkZaGqwMCj3OeN7hF8GrufLey+ZDjJiAwV3TqXovRmurVDGejZ5eq4LbRKXlP/IZcdMuY0KNNoJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FtBwWLWN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtBwWLWN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763502518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sStvlBcr8OSiAiHYVCz0UTg8SNcwHDImj6MEoWSIFfM=;
	b=FtBwWLWNqoz5r1XS3GmDCoJM0PrCMlJ3gJNiIdYdxl+D+/u/G88EU1Zq29FzZSrQDeH0so
	lqlBLmPeVyNFH2i7xp8Z6+OBg36HkgO3TMq1/JOZUEuVDznsKkTT+YQdSUI5JQIzk1bork
	SAGWIkO+l8jqi1Ypr8+/4RwDK2P7eHA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-FX7qsjV9PPWiMgCvSkySkg-1; Tue, 18 Nov 2025 16:48:26 -0500
X-MC-Unique: FX7qsjV9PPWiMgCvSkySkg-1
X-Mimecast-MFC-AGG-ID: FX7qsjV9PPWiMgCvSkySkg_1763502506
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47777158a85so52264855e9.3
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 13:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763502505; x=1764107305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sStvlBcr8OSiAiHYVCz0UTg8SNcwHDImj6MEoWSIFfM=;
        b=V6dID1TgUWM7wur2/CzMvvzULVXhpg7+3uJJz/EKJVQ2S8shUeY+63thqNNAYnIxnM
         pKnH4TqWEeXYdYJHZ94Z0SQUyZe2CHfhAtowIzw7gxl4pusQwUZpoRQ7wtkGEA792yyQ
         Lc8soyEHtq7gj6S0TQFBtHZmF9pqD1wOQLLJ7XsbeNWPus/yD8SWeeOsdi4hF6KX1F91
         7i9tLkvmsN8oaEKax7eoKFvVtVM64dM3tHgtBHgBkR3GeG9EQpwDqQKVah01R7vqJ5o7
         ZNnv91/s1csSb6odwE9TXVdngTHTl4zeYg7wDfgRJYauXvEDD8EnlEnYL5psjhZWPUah
         cqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0KGRP7aFUR3UYsVuiBnZljug3k5nj4Ai9W8LtbzX3Q1PProrP1Kv1rtsPoqM3q0GgJ0D7DoHDmEvZfpqnJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYIcRI2nSWgDMrqEWrPxHjn3kc7I06G7js9plbGbwFomjNZrxQ
	6JAvtSH0Fi45DEawtnop3u8vr80wq0V0TD2uUyCmdk+elebBeMZyevCQDcsi517Q1tK5pY4Ggfg
	PcfA8C1FNHJC82og/xDJd9Uc81cGBofzCKTi4aU8wuuOapSJ6zA6tSNS46EGCyngTUEYG
X-Gm-Gg: ASbGnctWjAHZqWxz5BIYjb+WBZ6NEnDJrlX1nLjmRMymupkiWoSbJN3ILPXHaNjRX8t
	q3BQcBsx5hZeWykjydzIZsIaFzYTLhbuVU2jqW7MFjEti1fs21Q8LDMOSbIQUh31jnlDb8MKRKJ
	RL7NO1r0Ftfwhub05u8TQhlHKrRTYIAOoIFLKeqNxT1MsLVBDTd3x4NHuhzyqtmD+C0/ntfn3lS
	fLxADzC+b8tmrdLWzFkB5ClFT3QlixnjiiFSymWqU/v/rt85V4H1y+QW7wR2G3NoX54XWfydUjB
	L4K/9l7VuOHISWuVFt7191fxmENLGDXI+tuoksDZphWyekEtF1KE/UMQC793APFSamvTrflSG/F
	XBMhU8Rh1xnoydvrSZfOQ5Lxr2DnX7A==
X-Received: by 2002:a05:600c:45d4:b0:477:7c45:87b2 with SMTP id 5b1f17b1804b1-4778fe5dde3mr222607775e9.16.1763502505361;
        Tue, 18 Nov 2025 13:48:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDmYO+o8e4AVZRDDZCetiy0Wy+fznwXJqQNCxPGDtsL+2uC5fri5NSn3L4Zgrurw3FDKvkYA==
X-Received: by 2002:a05:600c:45d4:b0:477:7c45:87b2 with SMTP id 5b1f17b1804b1-4778fe5dde3mr222607595e9.16.1763502504967;
        Tue, 18 Nov 2025 13:48:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1022a32sm15144355e9.8.2025.11.18.13.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:48:24 -0800 (PST)
Date: Tue, 18 Nov 2025 16:48:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20251118164552-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-11-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-11-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V29HzKG_QD9gADnNvD4mSzDmjn6dJA9hMqDzQ6jMHr4_1763502506
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:39:00AM -0600, Daniel Jurgens wrote:
> Implement support for IPV6_USER_FLOW type rules.
> 
> Example:
> $ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
> Added rule with ID 0
> 
> The example rule will forward packets with the specified source and
> destination IP addresses to RX ring 3.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4: commit message typo
> ---
>  drivers/net/virtio_net.c | 89 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 81 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c1adba60b6a8..78fc8f01b6c4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6932,6 +6932,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
>  	return true;
>  }
>  
> +static bool validate_ip6_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct ipv6hdr *cap, *mask;
> +
> +	cap = (struct ipv6hdr *)&sel_cap->mask;
> +	mask = (struct ipv6hdr *)&sel->mask;
> +
> +	if (!ipv6_addr_any(&mask->saddr) &&
> +	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
> +			       sizeof(cap->saddr), partial_mask))
> +		return false;
> +
> +	if (!ipv6_addr_any(&mask->daddr) &&
> +	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
> +			       sizeof(cap->daddr), partial_mask))
> +		return false;
> +
> +	if (mask->nexthdr &&
> +	    !check_mask_vs_cap(&mask->nexthdr, &cap->nexthdr,
> +	    sizeof(cap->nexthdr), partial_mask))

indent sizeof here please - align on ( not on !.

> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -6946,6 +6974,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  
>  	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
>  		return validate_ip4_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +		return validate_ip6_mask(ff, sel, sel_cap);
>  	}
>  
>  	return false;
> @@ -6968,11 +6999,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  	}
>  }
>  
> +static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> +		      const struct ethtool_rx_flow_spec *fs)
> +{
> +	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
> +	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
> +
> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
> +		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
> +		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
> +	}

so this checks mask then copies but parse_ip4 copies unconditionally?
why?

> +
> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
> +		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
> +		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
> +	}
> +
> +	if (l3_mask->l4_proto) {
> +		mask->nexthdr = l3_mask->l4_proto;
> +		key->nexthdr = l3_val->l4_proto;
> +	}
> +}
> +
>  static bool has_ipv4(u32 flow_type)
>  {
>  	return flow_type == IP_USER_FLOW;
>  }
>  
> +static bool has_ipv6(u32 flow_type)
> +{
> +	return flow_type == IPV6_USER_FLOW;
> +}
> +
>  static int setup_classifier(struct virtnet_ff *ff,
>  			    struct virtnet_classifier **c)
>  {
> @@ -7108,6 +7166,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
>  	case IP_USER_FLOW:
> +	case IPV6_USER_FLOW:
>  		return true;
>  	}
>  
> @@ -7150,7 +7209,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  	++(*num_hdrs);
>  	if (has_ipv4(fs->flow_type))
>  		size += sizeof(struct iphdr);
> -
> +	else if (has_ipv6(fs->flow_type))
> +		size += sizeof(struct ipv6hdr);
>  done:
>  	*key_size = size;
>  	/*
> @@ -7187,18 +7247,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  			     u8 *key,
>  			     const struct ethtool_rx_flow_spec *fs)
>  {
> +	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> +	struct ipv6hdr *v6_k = (struct ipv6hdr *)key;
>  	struct iphdr *v4_k = (struct iphdr *)key;
>  
> -	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> -	selector->length = sizeof(struct iphdr);
> +	if (has_ipv6(fs->flow_type)) {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
> +		selector->length = sizeof(struct ipv6hdr);
>  
> -	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> -	    fs->h_u.usr_ip4_spec.tos ||
> -	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> -		return -EOPNOTSUPP;
> +		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +		    fs->h_u.usr_ip6_spec.tclass)
> +			return -EOPNOTSUPP;
>  
> -	parse_ip4(v4_m, v4_k, fs);
> +		parse_ip6(v6_m, v6_k, fs);
> +	} else {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +		selector->length = sizeof(struct iphdr);
> +
> +		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +		    fs->h_u.usr_ip4_spec.tos ||
> +		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> +			return -EOPNOTSUPP;
> +
> +		parse_ip4(v4_m, v4_k, fs);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.50.1

