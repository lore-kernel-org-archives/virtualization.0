Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9E1114
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833279; cv=none; b=RUdGWmaPNw0b5ZSOxdPcw+yxjhG9FYjJOb94wr0IqcXBRj3uAWqSvz4dSxfKJZY+gFPs7KqUZTIT3+ljgxIH715Fgxq1ca/KvhjMWwiA6V7cEMo0cKDeNNGicV0ubT89lTAfrpyZOFyWusLcs5kXwRLYlnf2OpA/3P0OgMLRaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833279; c=relaxed/simple;
	bh=vv1qT8fOOxz4P2aDEkoamPsKw/+5vRplAQYBiNFpwgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oq3z+iIc+OQaNSEdh2Ft6++hO8lK5GOKkpE0cNmgRxt60OMWncKf5/+CsslAHhz9yZiN4zAlsyCxYCX1/xAIDHQE7yMpEsOmhz3apXLwJTQQ4tdopI1yfAOyJAIbEiL80CIiLqgdlPZYAgXhb52huqo8Up1/K/bqb9mBT6GVn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJKzv4Dj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJKzv4Dj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758833277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sG0c/Qg9PuQWEUfT6xJTnuG9wSgs8VT4bht8XQ+1qgg=;
	b=SJKzv4DjxfxWlOCM4OzaHSt6+3rdGUd6I+/jNgLbgiPiIRtITlaCS/QGGdvgYMBRw0ugdW
	+AbGZ5j7HCF+agiwEWsFSBiL2sCshsGGy7bIK+HBreqy3hJRDXsn4Y1aRxY/jK8GVbM/0q
	tViPnk0ejhp+jiBbml+JeX35HLT9Rjg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-tI5gmTpuMWmVYFZ2UIH9HQ-1; Thu, 25 Sep 2025 16:47:55 -0400
X-MC-Unique: tI5gmTpuMWmVYFZ2UIH9HQ-1
X-Mimecast-MFC-AGG-ID: tI5gmTpuMWmVYFZ2UIH9HQ_1758833275
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f42b54d159so1030318f8f.2
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 13:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833275; x=1759438075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG0c/Qg9PuQWEUfT6xJTnuG9wSgs8VT4bht8XQ+1qgg=;
        b=DJdIfJ9Ojk8/3hBdXEK/MG1kgdJYbhyUM4n8JbSZMAVwo74rUisX1WQ0BotFb8TIPM
         sz28vziduVSw3xZ2zqWMhEOpTuB5pB8kJk/vsFTQQFWuF3qejSryYsy1Uf14V0BulWyi
         GUcH/81bkibLmY25pu5MkdbWhrbae5v9t2U2Ub1+7nPh1TZI0gDW8QCHeWg8mpiEIaoc
         mA/s91rX4SUEI8meERoVWn+EKJ2Q23GFtJz1zQZ/MFVBI8Jai6jsT4d+cz5h5B9jaH1W
         95YzTocDsGiPwOo2iTLPTm7XbCAKxIAnwNmKsn40Q9rwlW14oUlnWD6E4OdQnQCUu8Hu
         ixKA==
X-Forwarded-Encrypted: i=1; AJvYcCXNjO/RcxCkQJDFRtQv/Fl/4jP+vJ9XcNwGN8czHbGxS6MQyw0ev1Jir4H9vAGXrKawzbJVcam66Xhv0n8t0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBXeFfM7aQ6cC7he+o2z+evufl6UM27hHdWlHJhamwXfDYBg9y
	kiluQqnPTTo0AgRp74vTHxP7h53kdt7aqa/3qVZSalEA8LhLsqvD1Ud26tWR1Vw8C5ERyBZEaW8
	OaydiCpWn+jmv82ePukdb1rNDluVu93IMTRuD9kyVF2slZpNdkJy5ExOxe+4tCEZxCI8O
X-Gm-Gg: ASbGnctxfXIhHXEkAlLSIerEC7H8pYFqZS4eModKH8Q1IX4PS+fOhDF6n1GxhXDlaKC
	7S+5f/IWgGigDNrGJpNeUpJoAMPXiZNDttHR6O5WLWvU5sWYoD3SPGunSXI5hnjORzRTbfSXa1i
	A/AJJcxnn4VzI5pxUQrVgJzjH6jag8/aMfV6Fo6Syt1uqzYYYVMcCj0y6Nigq7jYDwgQ6bWQpMl
	cNEMpYyohccdGJUyRyquWDSpcZoELV+hosj545JqFOsAuUmcP6/CgtfymePakzrVP1b086LdxOR
	TJit3X6xaffVX8L/FFLWfj31jS5fEgJ88A==
X-Received: by 2002:a05:600c:3b8e:b0:45f:2cf9:c236 with SMTP id 5b1f17b1804b1-46e329d4744mr61060905e9.4.1758833274637;
        Thu, 25 Sep 2025 13:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDfEyEaPjw+sH25J0AnTpfCAxI5nak9eeL4uYfANblZHdjS1y/uomSUQxYhcmeiuL/n546Ag==
X-Received: by 2002:a05:600c:3b8e:b0:45f:2cf9:c236 with SMTP id 5b1f17b1804b1-46e329d4744mr61060695e9.4.1758833274178;
        Thu, 25 Sep 2025 13:47:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac55esm100238695e9.6.2025.09.25.13.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:47:53 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:47:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 09/11] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20250925164519-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-10-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250923141920.283862-10-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: At-8-czob0GhvnDNdogi4-BduHYOo4L8BqEiJpZlMqo_1758833275
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 09:19:18AM -0500, Daniel Jurgens wrote:
> Implement support for IPV6_USER_FLOW type rules.
> 
> Example:
> $ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
> Added rule with ID 0
> 
> The example rule will forward packets with the specified soure and


source


> destination IP addresses to RX ring 3.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net/virtio_net_ff.c | 89 +++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
> index 0374676d1342..ce59fb36dae9 100644
> --- a/drivers/net/virtio_net/virtio_net_ff.c
> +++ b/drivers/net/virtio_net/virtio_net_ff.c
> @@ -118,6 +118,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -132,6 +160,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  
>  	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
>  		return validate_ip4_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +		return validate_ip6_mask(ff, sel, sel_cap);
>  	}
>  
>  	return false;
> @@ -154,11 +185,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
> @@ -291,6 +349,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
>  	case IP_USER_FLOW:
> +	case IPV6_USER_FLOW:
>  		return true;
>  	}
>  
> @@ -332,7 +391,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  	(*num_hdrs)++;
>  	if (has_ipv4(fs->flow_type))
>  		size += sizeof(struct iphdr);
> -
> +	else if (has_ipv6(fs->flow_type))
> +		size += sizeof(struct ipv6hdr);
>  done:
>  	*key_size = size;
>  	/*
> @@ -369,18 +429,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
> 2.45.0

