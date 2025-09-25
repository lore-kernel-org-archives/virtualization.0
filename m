Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944DD321286
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833616; cv=none; b=kn4l5XcN7cGIC22EEqem4c8zfr24JMTwRD397edMXxLszxsaVzavlaPA/n+x2EozDpdzsaULNJmKfHcBevzNV9x6Xg0hBg5/lQQvi1b4a8FdgHZnibh9IKGulQJuO6zz39eJNKe4ABvZI50OMq5Jgm3sMRFqhshoO4s3yX9gbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833616; c=relaxed/simple;
	bh=+OP/gBUm9FmhTMS53uZe1B4xHPtCyqIjuR+deKPFAfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=H7OCddy15QCVUICO2mlo1mqMCOtj1ko6Qsp6nb+Y7Y/c4rXRQde2pNdejdVRAmMErAplDCKVFpyRtFyQRzsWE+DHdfhXnW5OrlnQoVGEcNu7q4azWhofVTAtcEwhG/N/K2/kWF0IrNkSkr0j5VFkwZI+5bCrfG87g8HhSFtKRpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHR5nSMp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHR5nSMp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758833613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MipXnPr5GEwnUlZAIURDsCzQViB4tslWhi1ag8MYmJo=;
	b=bHR5nSMprwviRYqnKI4fVgoeHNcQDtBZ6b4yaSomB2bI0V3O0TZdstOupxzREh1iIZd0mY
	44WqsKzJOz8AKm0PR6PxnHBnsfy0ePTbzoWXOA7JRtBI9A1mUwEnXkZGGfq33S6vcdpzfY
	QUHXh2Li6O11mTfMK79lmUCR0q+9zis=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-xaMgyjyLOnaaT8rvowpFNg-1; Thu, 25 Sep 2025 16:53:28 -0400
X-MC-Unique: xaMgyjyLOnaaT8rvowpFNg-1
X-Mimecast-MFC-AGG-ID: xaMgyjyLOnaaT8rvowpFNg_1758833607
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e330a1946so7329265e9.1
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 13:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833607; x=1759438407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MipXnPr5GEwnUlZAIURDsCzQViB4tslWhi1ag8MYmJo=;
        b=dnrSIVEJPNZJndwKv9V3OqXh4ooFVYPeylux0l6S0flH1DUMVG6cosLAvo1Xj5e5wK
         Hkfd9yuUB1Ja9wFdgh9LcHZN5aatvrqqMp3VdNM6Wf+6VW4g68UGg7c46f9eCQWYxYgR
         XQz1lflNCKdHGTVxmqc4+eM3n4s2Wj26SbOeZzfab3U7hzjYs+IedWMWKxzFP9E0cBwQ
         jb0Nq4CkZxHH0WneeLwDOkE80tcslQ8kZbs1uQIGDJdretejSBWlObmA80rCHRO4ZD6M
         EJ1IEFixKN0egPXIClk2JgWWqK41KmSnFi0q2bEQUhB5GAlGIwKyTwXe4rXjobXb/Qs/
         Asxg==
X-Forwarded-Encrypted: i=1; AJvYcCXl/GZ9JN8uMMgvmly64rPHSj1fc/qNdKIrRaF7+m4veOBvugnD81YwRsrCkJBnOgVGP9Epb3pPhdl6tTdovw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsYCffLalXhxTE4C1tj7WIW8rXAcRC2q7BNnfq5MT1w+M4z2WZ
	nESlParhDSyjKqqvux8kBmXVtII+KNhASI2KmStvAfLw1ErAmjyUmaZQl7FhPVLR9xMRCGnh1wl
	ECTTPAQrt1juTwLaINwlpKTVlaw5Q+aSMFu1yjosFt2IriUNjr8tvC/dpz1NP4yrkuAbY
X-Gm-Gg: ASbGncu0KLh+RIszbruQJsq48FwvwTNAkTJx9n6nbumXblNckr1StPQGin33FTflS8g
	P5eYm5Pz77gtEkMHwhbClPhFMfAeRsLqqwOSyXGCva2uXTqo+ofaABkt+Wb4MfqVvTUN1+H6P6b
	mVK+ATOuUGtmiWuBdBvHy/Hi8RVV+uu/lxpRVZTLsclaaMTDlGSMpaVsKvPkWi2sQnOgi9IrIRV
	HmuG3x/XnZYfuUhzOb+Jkg/JM/MWGuVZvEXGLIs+CJ/EVJc2MJcu51G5/l5+XEIWAOU8r8HqLa/
	K4lWT4QtUx8bUVCs26h1SmNHcWDAflFTjw==
X-Received: by 2002:a05:600c:1c0b:b0:45f:28ed:6e22 with SMTP id 5b1f17b1804b1-46e329d4992mr55556025e9.3.1758833607048;
        Thu, 25 Sep 2025 13:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/nAk3zS8i0QurY2J8qG2/NB0XEn+zAdaJVlfQNrdrE9bVadTDwtK1Iw/ehky14Hd+Wq4PUQ==
X-Received: by 2002:a05:600c:1c0b:b0:45f:28ed:6e22 with SMTP id 5b1f17b1804b1-46e329d4992mr55555735e9.3.1758833606604;
        Thu, 25 Sep 2025 13:53:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab838b6sm88733595e9.24.2025.09.25.13.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:53:26 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:53:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 08/11] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20250925164807-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-9-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250923141920.283862-9-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z943UXDX7UToLTcNDOgfYML8D4rg7ZhVt6caZ4gyIHg_1758833607
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 09:19:17AM -0500, Daniel Jurgens wrote:
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
> ---
>  drivers/net/virtio_net/virtio_net_ff.c | 127 +++++++++++++++++++++++--
>  1 file changed, 119 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
> index 30c5ded57ab5..0374676d1342 100644
> --- a/drivers/net/virtio_net/virtio_net_ff.c
> +++ b/drivers/net/virtio_net/virtio_net_ff.c
> @@ -90,6 +90,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
>  	return true;
>  }
>  
> +static bool validate_ip4_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)

I'd prefer that all functions have virtnet prefix,
avoid polluting the global namespace.


> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct iphdr *cap, *mask;
> +
> +	cap = (struct iphdr *)&sel_cap->mask;
> +	mask = (struct iphdr *)&sel->mask;
> +
> +	if (mask->saddr &&
> +	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
> +	    sizeof(__be32), partial_mask))


pls align continuation to the right of (.

> +		return false;
> +
> +	if (mask->daddr &&
> +	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
> +	    sizeof(__be32), partial_mask))


and here

> +		return false;
> +
> +	if (mask->protocol &&
> +	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
> +	    sizeof(u8), partial_mask))


and here


> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -101,11 +129,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> +	mask->saddr = l3_mask->ip4src;
> +	mask->daddr = l3_mask->ip4dst;
> +	key->saddr = l3_val->ip4src;
> +	key->daddr = l3_val->ip4dst;
> +
> +	if (mask->protocol) {
> +		mask->protocol = l3_mask->proto;

Is this right? You just checked mask->protocol and are
now overriding it?


> +		key->protocol = l3_val->proto;
> +	}
> +}
> +
> +static bool has_ipv4(u32 flow_type)
> +{
> +	return flow_type == IP_USER_FLOW;
> +}
> +
>  static int setup_classifier(struct virtnet_ff *ff,
>  			    struct virtnet_classifier **c)
>  {
> @@ -237,6 +290,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  {
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
> +	case IP_USER_FLOW:
>  		return true;
>  	}
>  
> @@ -260,16 +314,27 @@ static int validate_flow_input(struct virtnet_ff *ff,
>  
>  	if (!supported_flow_type(fs))
>  		return -EOPNOTSUPP;
> -
>  	return 0;
>  }
>  
>  static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
> -				 size_t *key_size, size_t *classifier_size,
> -				 int *num_hdrs)
> +				size_t *key_size, size_t *classifier_size,
> +				int *num_hdrs)
>  {
> +	size_t size = sizeof(struct ethhdr);
> +
>  	*num_hdrs = 1;
>  	*key_size = sizeof(struct ethhdr);
> +
> +	if (fs->flow_type == ETHER_FLOW)
> +		goto done;
> +
> +	(*num_hdrs)++;

I prefer ++(*num_hdrs) in such cases generally. why return old value if
we discard it anyway?

> +	if (has_ipv4(fs->flow_type))
> +		size += sizeof(struct iphdr);
> +
> +done:
> +	*key_size = size;
>  	/*
>  	 * The classifier size is the size of the classifier header, a selector
>  	 * header for each type of header in the match criteria, and each header
> @@ -281,8 +346,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  }
>  
>  static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
> -				   u8 *key,
> -				   const struct ethtool_rx_flow_spec *fs)
> +				  u8 *key,
> +				  const struct ethtool_rx_flow_spec *fs,
> +				  int num_hdrs)
>  {
>  	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
>  	struct ethhdr *eth_k = (struct ethhdr *)key;
> @@ -290,8 +356,33 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>  	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
>  	selector->length = sizeof(struct ethhdr);
>  
> -	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
> -	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> +	if (num_hdrs > 1) {
> +		eth_m->h_proto = cpu_to_be16(0xffff);
> +		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
> +	} else {
> +		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
> +		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> +	}
> +}
> +
> +static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
> +			     u8 *key,
> +			     const struct ethtool_rx_flow_spec *fs)
> +{
> +	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> +	struct iphdr *v4_k = (struct iphdr *)key;
> +
> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +	selector->length = sizeof(struct iphdr);
> +
> +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +	    fs->h_u.usr_ip4_spec.tos ||
> +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> +		return -EOPNOTSUPP;
> +
> +	parse_ip4(v4_m, v4_k, fs);
> +
> +	return 0;
>  }
>  
>  static int
> @@ -312,6 +403,17 @@ validate_classifier_selectors(struct virtnet_ff *ff,
>  	return 0;
>  }
>  
> +static
> +struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
> +{
> +	void *nextsel;
> +
> +	nextsel = (u8 *)sel + sizeof(struct virtio_net_ff_selector) +
> +		  sel->length;

you do not need this variable. and cast to void* looks cleaner imho.

> +
> +	return nextsel;
> +}
> +
>  static int build_and_insert(struct virtnet_ff *ff,
>  			    struct virtnet_ethtool_rule *eth_rule)
>  {
> @@ -349,8 +451,17 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	classifier->count = num_hdrs;
>  	selector = &classifier->selectors[0];
>  
> -	setup_eth_hdr_key_mask(selector, key, fs);
> +	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
> +	if (num_hdrs == 1)
> +		goto validate;
> +
> +	selector = next_selector(selector);
> +
> +	err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
> +	if (err)
> +		goto err_classifier;
>  
> +validate:
>  	err = validate_classifier_selectors(ff, classifier, num_hdrs);
>  	if (err)
>  		goto err_key;
> -- 
> 2.45.0

