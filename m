Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD3331A46
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021565; cv=none; b=j/BlwCeiZTvfdu8cwMeIRSJegEyL0Py2VY3paeJVBjcfdo0jTW1oTc0YRfathCq2ovHExLgyxKDZV7y+1rvLVdd8O7XYOyN2hGAr2p01ZyqyQhmnovaGC9yS/dBvb0lfVo4WFUdGmKoI8jnBgChfAaB4iyyEaWl+sqF3qZdosHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021565; c=relaxed/simple;
	bh=Js9zql4OgnnEBD7cr5m1CxyZi+lfX0iqvKkLedjQ8QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E4ufIYhXYHlrU46NyxGylXXFs2dMYRuh58XypBA3NgiOVsoC4d4uxUx28IrfcJXo1+uR3tN4bHorfJT5+0ER7eVTDD1eEY1NOb/rk46I4WpWKbCSvj882n5gDAh2DAntX640ss3Wf5LBlBOnYSxF4VIYMt91LWyLYuWLpySCkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYjwwmWJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYjwwmWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764021561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+YMo5H3YOL7jAqTWtFFIZqMJZpECBZ8f74TJyFBR38=;
	b=QYjwwmWJfz/DiEHYGHcSmu9tHiZ+CAAUxZjDs1pWgTafYYcIRpGOJf4t/99K3jg7G/2ETZ
	O7azMIpQ37TtIRGaFxc2AbAprayrMxE+SK2BxVLe1gvC/5V1T5UJU9JqJ1HHeYFtJeP+Qx
	q0rGr7dW52OhY8cm1Ia4PmvlM3bnh4I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-tl5Np5iEOCqSwuZDeUel1g-1; Mon, 24 Nov 2025 16:59:20 -0500
X-MC-Unique: tl5Np5iEOCqSwuZDeUel1g-1
X-Mimecast-MFC-AGG-ID: tl5Np5iEOCqSwuZDeUel1g_1764021559
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cce847c4so3389418f8f.2
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 13:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764021559; x=1764626359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+YMo5H3YOL7jAqTWtFFIZqMJZpECBZ8f74TJyFBR38=;
        b=AXOYiK5YjrNIeKTmIT33oG0vAPJIVA/DVYKAlwhfEkMn0KqaNmsjgROP3gFuZHctBl
         /OcS7HSEjgorQrmysdKBH2XKlVNc/d1GhtK3/9d/xC9WvrLKZ81zuIKLl8oFyh4b1PSl
         +9WMpawl6o1I5UQZWObOl0cAis7tP/iRFt4rdexepYuYcmtZGjFhBBkXmvELU+2gLs/s
         3Q6tkGNayXlS7/3JWBVuA7Yi86M8dyJwDTgKVJe9PX8BQacfS7AotcPqKNM3k+t6dBej
         t/YGtrMO7ai8jJqqvoK9ac76qt/4nNdlrzKUVmHx3nGOY9+3xYZmhMe/7V7xYCKAhp/3
         cQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCUKVsJz8HkMwFYiNLavvS5zuyY8eYuR90op0xaIqCzSrzJu7Y9jF4votSxh8SGTrg5aSH3CBWgwarwWX/vl8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPPbAD8f9Z47HPY4k8sbrnxsreLqsRy3d7zVh0Rp3VYpfU/NiN
	sKLnd3uLdGTcxloip6sFsABkld4yGmkmZao7BjxoyFgNyuuZ+VghXNu6OBxjFHFZg2qV4kPBqWS
	nRUfMFmKBPl38mVxTw1KfJK//51TTEwFN6zZQo2YpU6U86qf+C1R/pVvamqJY9FlG/+6W
X-Gm-Gg: ASbGncvpmkUeN03pgGiwObANoTD379hEW84fmWg/ntXxw/WvODviRk2oBjgOF29J9Xr
	pEKMII3YEGOlqsgMLtpx1GAH5ah4S2evlIfp7Mwnf6zMzUtouRs277WkQ7iYadeO5Tn52wUooy/
	f6l6OHULYhMX9L2VUG/Ns2GzYhLLrPXgzWfdcHmpl7/sBAC05ig8uJrXFpVYChWbyN3B6QUGfHM
	+6MKKFrtuy2TFE7ik9ueL+m+PfG749TXxuJNSGdm2oviLwXPZhoZJH2eZ2fZCMvsh1SUqSpdFz9
	NwnkwP44Yv/ys/6I97xdRHBPA6C2YT2ztN8N6SK4pQTnCpjpXQwYPlj8fvLgN/34wJGHHy1sdxQ
	XEdMOMUy4iFqYX9z4fW2ma7sVqh353A==
X-Received: by 2002:a05:6000:420e:b0:426:d5a0:bac8 with SMTP id ffacd0b85a97d-42cc1d19624mr15321382f8f.56.1764021558704;
        Mon, 24 Nov 2025 13:59:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOmSX5mj9MaFFqRaX6/7n+Y65AhzF6tbw5qWchg4LDEwTyYYy89Tcq3gxbCKSQXJxm4RNtRQ==
X-Received: by 2002:a05:6000:420e:b0:426:d5a0:bac8 with SMTP id ffacd0b85a97d-42cc1d19624mr15321363f8f.56.1764021558157;
        Mon, 24 Nov 2025 13:59:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ffesm31331232f8f.10.2025.11.24.13.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 13:59:17 -0800 (PST)
Date: Mon, 24 Nov 2025 16:59:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20251124165246-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-11-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119191524.4572-11-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: on9VxYdVfZLUGqBzr3n50DQH0oZnrUzwd2Afcgaf_Bg_1764021559
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:15:21PM -0600, Daniel Jurgens wrote:
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
> 
> v12:
>   - refactor calculate_flow_sizes. MST
>   - Move parse_ip6 l3_mask check to TCP/UDP patch. MST
>   - Set eth proto to ipv6 as needed. MST
>   - Also check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
>   - Remove tclass check in setup_ip_key_mask. If it's not suppored it
>     will be caught in validate_classifier_selectors.  MST
>   - Changed error return in setup_ip_key_mask to -EINVAL
> ---
> ---
>  drivers/net/virtio_net.c | 92 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 82 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b0b9972fe624..bb8ec4265da5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5922,6 +5922,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
> +			       sizeof(cap->nexthdr), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -5936,6 +5964,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  
>  	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
>  		return validate_ip4_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +		return validate_ip6_mask(ff, sel, sel_cap);
>  	}
>  
>  	return false;
> @@ -5958,11 +5989,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  	}
>  }
>  
> +static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> +		      const struct ethtool_rx_flow_spec *fs)
> +{

I note logic wise it is different from ipv4, it is looking at the fs.

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

Is this enough?
For example, what if user tries to set up a filter by l4_proto ?


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
> @@ -6099,6 +6152,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
>  	case IP_USER_FLOW:
> +	case IPV6_USER_FLOW:
>  		return true;
>  	}
>  
> @@ -6138,6 +6192,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  		++(*num_hdrs);
>  		if (has_ipv4(fs->flow_type))
>  			size += sizeof(struct iphdr);
> +		else if (has_ipv6(fs->flow_type))
> +			size += sizeof(struct ipv6hdr);
>  	}
>  
>  	BUG_ON(size > 0xff);
> @@ -6165,7 +6221,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>  
>  	if (num_hdrs > 1) {
>  		eth_m->h_proto = cpu_to_be16(0xffff);
> -		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
> +		if (has_ipv4(fs->flow_type))
> +			eth_k->h_proto = cpu_to_be16(ETH_P_IP);
> +		else
> +			eth_k->h_proto = cpu_to_be16(ETH_P_IPV6);
>  	} else {
>  		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
>  		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> @@ -6176,20 +6235,33 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
> -	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> -	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> -	    fs->m_u.usr_ip4_spec.ip_ver ||
> -	    fs->m_u.usr_ip4_spec.proto)
> -		return -EINVAL;
> +		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +		    fs->m_u.usr_ip6_spec.l4_4_bytes)
> +			return -EINVAL;
>  
> -	parse_ip4(v4_m, v4_k, fs);
> +		parse_ip6(v6_m, v6_k, fs);


why does ipv6 not check unsupported fields unlike ipv4?

> +	} else {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +		selector->length = sizeof(struct iphdr);
> +
> +		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> +		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> +		    fs->m_u.usr_ip4_spec.ip_ver ||
> +		    fs->m_u.usr_ip4_spec.proto)
> +			return -EINVAL;
> +
> +		parse_ip4(v4_m, v4_k, fs);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.50.1

