Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82432F757
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021131; cv=none; b=iQi5hD6tL0uv5fo1wbrYoqWblL/NLX90zj6mn7bf10hofBYOMMHIqB63+hkgYeGSMz28pBkGhz3WIiV1KKZ37gqgmxhvkO8ffNKnkrjzR8O9ewKstXEQZ6FFisXZ6VK+paFnK9fzjuPPlk7NK+MmNPXe8wEiEAyGgG1a4jI/Xc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021131; c=relaxed/simple;
	bh=69dAMBVYbztyVdrlAwio7Tlwu8BnjSF7DoB7OI2TWQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=byI61+7iREsfFgQQI+eVN2fRteUj81mtiWTIPHYZYgPSfFpe/+os6pBMif6Hb2i0wmUawtxVVNf8gM5F5mcidx4wt+NFgICBKUSXmHSXRvRO5qEHfkeWmv3FW9NukLr68jjVlHitPn/x5Vo4uj/LIBlhLS4BFxRHRrNAL6XlnjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRVz+X2Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRVz+X2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764021128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e72N/nLYBkd3gASLyDGIbv2w/OuUmcz0uSrgBqx4nMM=;
	b=MRVz+X2ZxeuuwgvEBfH3iKcy0aU6GLqUMXkJ083ggpusnM0wkKajEwMIclQwD6iPJyujPm
	rwFrwDfhkwANHsiEck8BTcyJZaM7P5WIBAZUXC4t1/fbHRL6tFlEtKjnGai+IPXpjvNzeE
	rlM2NnRojExg+R2q27UOBhUNzcYhmZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-FPiK9B27O-Gci773wj5g9Q-1; Mon, 24 Nov 2025 16:52:04 -0500
X-MC-Unique: FPiK9B27O-Gci773wj5g9Q-1
X-Mimecast-MFC-AGG-ID: FPiK9B27O-Gci773wj5g9Q_1764021123
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a11d9f89so22799115e9.3
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 13:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764021123; x=1764625923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e72N/nLYBkd3gASLyDGIbv2w/OuUmcz0uSrgBqx4nMM=;
        b=RBIGWhRniECZq4O4+u64mpTYalICl91CbNOT79uoFuiV5TGrWDnX3w4GVDGLyLPHqG
         REpOCUpcXEkQ5eD5LYckKHG1dFIlxWmqBI+WZjnfprUO7SiM07WnfqshAFupFB2U8GFS
         k6Zx/H3VVIJiMwOIh9dVx0nr/xUMfNP/qukXisMNcv1Ox2T3IUcj7qxh3ulfj/zPMpYC
         CN6WUQfBUxkVVgZWI9jILKsBTdNNfS/hRIawEpOj+HJVc+izkrTAUNHpUG3gTXti1q7U
         e+Olpr+sSf5BJKLXLwPEd/vBqkWzcPSH4h0hh2pCESl28HLgccjCMcc6LxmEtYuQy73b
         yUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ491ZHHg1dGAu3YFfCREjXiZPQkV0VEmaUOyfn68LnysiVLt1oF8gEmNm3tGgEhrBTEXiz0B4WFkNY+P53Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsD2RlDTK+UiL0EiC1yUbY3vLyrKwztVUlE05zO9RTJyO0t3eE
	Lqn2tVyX+eNIlwsDtAnJUnN6p7Wmb8HD6hdeAt/BF0smTG/4JOd6cEPjjJacdLjsPt06oUnJrK3
	D7FPuoQKN5TA7y67EhaQfeUTnbVw3zdM6LV1Y2mj/hEIMt6B5hKAMsg25YlbeSlCwjUTG
X-Gm-Gg: ASbGncvfKjR0AS4LWC3wWpx2xqxaMjHti1Ix+zUvyPRu4wvkkot1qn+l7iRA0Vgyk9U
	JlH1zsOgb9IM96tDJe3Fa3PAXxsijPiretxss7BIh1suflInrvQfpP24KXBfHnI7QrbTxGfeTUw
	vNOKGSFKohLx3/dfMOaa5Jyl9zPuahF6MUk5T1Qem2x9CRCcIufV2qO3cplpIM0CxdZ8EE1qJ9t
	x7AjZVxtZTvJLsySJ/0ycWR8grDzPctrOY52A5Lq6bIP/iW3lrHV/LOZTknEZRGN6jAoRNSjlM+
	HmmXs9iguxPPe5ppjSbsZ5mMtkdHcbyr8zWGwbWULF+Eio9mLxNH5tKgo1tO1+QqmqU29uCviRx
	bNcwqqF7udkNupIVF+Rk3OyWWOgwafw==
X-Received: by 2002:a05:600c:3b05:b0:477:9a28:b09a with SMTP id 5b1f17b1804b1-477c00e7900mr151196345e9.0.1764021123267;
        Mon, 24 Nov 2025 13:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6hVPBmzcjYWA4CqHGLf4Muh92XaXgWBSJ5z9lrobTdgS5JPAenWyhhlTP0Vz5JFQJrG2rwg==
X-Received: by 2002:a05:600c:3b05:b0:477:9a28:b09a with SMTP id 5b1f17b1804b1-477c00e7900mr151196065e9.0.1764021122799;
        Mon, 24 Nov 2025 13:52:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790552c39dsm89035e9.1.2025.11.24.13.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 13:52:02 -0800 (PST)
Date: Mon, 24 Nov 2025 16:51:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251124164600-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-10-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119191524.4572-10-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -gYduL8tmx1Gh3KHItch6vmPd1PfNumZXvIn_Cfddes_1764021123
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:15:20PM -0600, Daniel Jurgens wrote:
> Add support for IP_USER type rules from ethtool.
> 
> Example:
> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
> Added rule with ID 1
> 
> The example rule will drop packets with the source IP specified.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4:
>     - Fixed bug in protocol check of parse_ip4
>     - (u8 *) to (void *) casting.
>     - Alignment issues.
> 
> v12
>     - refactor calculate_flow_sizes to remove goto. MST
>     - refactor build_and_insert to remove goto validate. MST
>     - Move parse_ip4 l3_mask check to TCP/UDP patch. MST
>     - Check saddr/daddr mask before copying in parse_ip4. MST
>     - Remove tos check in setup_ip_key_mask.

So if user attempts to set a filter by tos now, what blocks it?
because parse_ip4 seems to ignore it ...

>     - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
>     - changed return of setup_ip_key_mask to -EINVAL.
>     - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST
> ---
> ---
>  drivers/net/virtio_net.c | 119 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 113 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5e49cd78904f..b0b9972fe624 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5894,6 +5894,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
>  	return true;
>  }
>  
> +static bool validate_ip4_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct iphdr *cap, *mask;
> +
> +	cap = (struct iphdr *)&sel_cap->mask;
> +	mask = (struct iphdr *)&sel->mask;
> +
> +	if (mask->saddr &&
> +	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
> +			       sizeof(__be32), partial_mask))
> +		return false;
> +
> +	if (mask->daddr &&
> +	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
> +			       sizeof(__be32), partial_mask))
> +		return false;
> +
> +	if (mask->protocol &&
> +	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
> +			       sizeof(u8), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -5905,11 +5933,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  	switch (sel->type) {
>  	case VIRTIO_NET_FF_MASK_TYPE_ETH:
>  		return validate_eth_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +		return validate_ip4_mask(ff, sel, sel_cap);
>  	}
>  
>  	return false;
>  }
>  
> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> +		      const struct ethtool_rx_flow_spec *fs)
> +{
> +	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
> +	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
> +
> +	if (mask->saddr) {
> +		mask->saddr = l3_mask->ip4src;
> +		key->saddr = l3_val->ip4src;
> +	}

So if mast->saddr is already set you over-write it?

But what sets it? Don't you really mean l3_mask->ip4src maybe?



> +
> +	if (mask->daddr) {
> +		mask->daddr = l3_mask->ip4dst;
> +		key->daddr = l3_val->ip4dst;
> +	}
> +}


Same question.



