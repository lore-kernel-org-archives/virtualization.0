Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75812E1726
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502323; cv=none; b=iVE2qAmBnI/oS7Q3Bk/ie4idn4WfPPmZXKH8NaZhI+W1A0+iI7+c81/2oX0BS4DwcgPWU1ebgniEn5k623J9Un3RryDx35IydNFDzjrTlPvrGlStRTMKyKsjBkkAvNKw9hcTfscEKlpmcxrHb8niXtHuld9ad8mRFqdJBg9MoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502323; c=relaxed/simple;
	bh=EWVoiStL8xxc8fjRAlKEGJa+L4prc8/ogGMYl/n3jNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=csg+H8m2HQDOfn9REPzXNPmiosbqHjiHgk+adUfmmkcmi+PZT1/zwuVdtT7WVzHI0m9CpzL3aAw/gv8Fd2PZS6hOZodu5ORnYz63rN52hhz52UkS1duXMrFs+H2vvoV7Tpzn8FxPDFcg9QmFj9zZ8lJCKG1J2qNoitzFC/sxf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPLLI7Pq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPLLI7Pq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763502320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xmcD+jsjC8wZ84+RswPoQFo8c1DNHek5aHXjd3P3kGk=;
	b=VPLLI7PqiIYQFz5QHWqSbf7icqbqHk5WqT374FKsfmzOgUghj8NM+vMazwAeBYP/0b3f8P
	3yuw5h/4fET0OzjSuYroe/YoYFW4mmBusDmpuie3WufWBdqaWGphvNyuOSx5UFL6P141Qu
	iZDRPclT/fsQscoXBii515oKglbUeQ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-JONaTPuBMh6WybCbJR9_Qw-1; Tue, 18 Nov 2025 16:45:19 -0500
X-MC-Unique: JONaTPuBMh6WybCbJR9_Qw-1
X-Mimecast-MFC-AGG-ID: JONaTPuBMh6WybCbJR9_Qw_1763502318
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2ffbba05so3351504f8f.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 13:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763502318; x=1764107118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmcD+jsjC8wZ84+RswPoQFo8c1DNHek5aHXjd3P3kGk=;
        b=J3bSyyX0Xi80Q+zx6oFnGiuOH++jl7+KIFexnIBDUVT1uJc9b+A8EbGtSUEEFwWObv
         DsoBvEgu+RN/K6cmMQmRl9W2HlYgjw9iGE29EkvTFGJaihmKm5/bp5LBX+rvpKrEH2Rl
         mkn5N9+0+c79Sv7nMjoFY5NSxqyurqA46N+UBXEZeOCvR1vzpemG0x4vK2tgfg2g5WKA
         UOeTfyuFfgSSAQRbcDbLBcljhjhSokU5S5j8iHnFnUqCy/8nzuvsb7dw5C+tiLOHldek
         C1cjsu1r+geMBK5LQHXNacg0Un8hq71mJv0HpKxW3nByY1967IXwqD92ERY/uwK5albi
         HSPA==
X-Forwarded-Encrypted: i=1; AJvYcCXOpHak2EdjxwKSicL72oPs2mxyn3x57pouktjz20wDDdWca01+z5e3WisLMIua6W1IumDcUpiyQk8tAhBlyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywew05RGZeO2ZGHfulpSNlLYaweDGUUEZ5Kcd4p4ZgBVfI6vd8e
	N4qjOGhSAZbrjO68R3dwKU/no7DAo2kTzh1l0Xk3lm0uFKcfXJVtMy/SFc+4jJVajtJD6IiNj+v
	iBoXrMg3XVvlzbKKFOxkKX4itPUw2cJs9W4rHnbMUqNsgAJzOQjo+wKQZOBnkrtX/+D8B
X-Gm-Gg: ASbGncui1QYm8JtXgjuHMB3u7mjHj+1MuecvrFjBoCpUyNRuGIdk70t6uyTaoOB8Btd
	Af/dmI5dPzSzjwwl1smsFWFskV44kCimRQHNi5OVAGllRbBT75UhjDNEkLDyfkHOLOsKxQdD/Ie
	BWGw7k0KsWTp0fFlOG0kRYjsO0CkuyK/svXSZFLhw/y7n/OWbPCsHX/8RMIjN7+o98qkcIOxOa6
	+jAYBfBO0llvf7YWWWHWLqFl+0BVXMxixd94sF9EjYH4KNNCjHBGofxESAj6TzZp6ipXzQFsROP
	DjxjXiWUzOJKxuxxrNlvF/UcK+VL9Ju7n5xGUJQxL3sgwUSCiCse3R0456DKSRoxNBW7wMOehHf
	30RVoc+5ninHP88RiJPXOlYTZXZs/tg==
X-Received: by 2002:a05:6000:615:b0:425:75c6:7125 with SMTP id ffacd0b85a97d-42b5934f2famr15507763f8f.16.1763502318143;
        Tue, 18 Nov 2025 13:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6pbEaOuD4MXi0DZA4VBiHWLk/LNDtUUFYZniNj6WmjWygzYmgIegGsNOm3BN26F6K9mlM8g==
X-Received: by 2002:a05:6000:615:b0:425:75c6:7125 with SMTP id ffacd0b85a97d-42b5934f2famr15507746f8f.16.1763502317590;
        Tue, 18 Nov 2025 13:45:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f174afsm33416600f8f.33.2025.11.18.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:45:17 -0800 (PST)
Date: Tue, 18 Nov 2025 16:45:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20251118164400-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: CsO4j-ISAW0ClT5bbD59mpveV4ylIfUwoCGgEY-rmDc_1763502318
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


I find it weird that this does not modify setup_eth_hdr_key_mask

So it still hardcodes ETH_P_IP for all IP flows?
For IPv6, should it not use ETH_P_IPV6 instead?

how does it work?

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

