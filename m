Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DCB372B5C
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102504; cv=none; b=kiyq1/Vgc/iJ3L/gyKgcH7WU7ZfcRCCJ3tzjovIjLLBUCwL+jTbW7eFmP56kQ9F3KCpuvO6zTCWHT8Y9c70Zr+E2pjnZ5qLwDgZCV7soQcjlu+BvGMdmW3JahWZfLZq+xSohsiH6rFWuXLAXMBS9FCmwjp8l67XCzsXkzxqLY7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102504; c=relaxed/simple;
	bh=YKqy4dOSjpxRjuWOZfiiaS8IFhLQkNGhBeaum7DfH9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sayRuB7wRTpQ0NLlkQ1jUrIa0w3wAlJk/uFxaAZNLofOhloEjAf7d5wiri3alcVcVi8VxbXdCTJm2DMw6DnaXlYKJo9nAw/X2tM2NBUlZVQM4H88ThRMegXxzUKhuNqtHy0amMLpfzpqh4uOQz0R0s3mu+M61F02a/69zG6vOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAQ/tSH9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAQ/tSH9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769102487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LW3W2gA/isNxioIH5fWqQEKCicVcLJNySRCeMcQHGvQ=;
	b=XAQ/tSH9n9mrSxAT5ahlVj9vtCR1x2ly3KWkEqKQ/xtSGbVoJyz3pGcX/TwA0SwsdmzwNZ
	XCdjBrsbjRSoSw/zwq1N0Ed+RGEf3xVIeH5hQ9bbh0SSJi8ED9friKNv+wLBEzfFeJluuz
	mWFk4C7PxLRp6II7rfRh26qrdGl1rLU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-Pc4tvOCpOYKUGgL3EO-uNA-1; Thu, 22 Jan 2026 12:21:26 -0500
X-MC-Unique: Pc4tvOCpOYKUGgL3EO-uNA-1
X-Mimecast-MFC-AGG-ID: Pc4tvOCpOYKUGgL3EO-uNA_1769102486
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47edc79ff28so8407025e9.2
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 09:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102485; x=1769707285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW3W2gA/isNxioIH5fWqQEKCicVcLJNySRCeMcQHGvQ=;
        b=kWJNDLgA+Vis6WRtC9RBl0MfakeCP5d3RdZnltU39DUdEbMJWY0KERYBGXrGZGyx+x
         qOq19iTgDwXsWMNx47a/hfKadn3I8IyIvwi7XK9LubC8KE9i6HpBAXLmd9rchY7AKdOz
         dvLDpDn63zC4MO35gUkkYKUvqQs5d5dktAD/s7aLknqeNBoISKMBizpTITi4RVGJzIVi
         hBBleyG1VgS1pVI4PfcQkWlhUlYe1bJKeu+XOa6X1Y7iXcMOmRelIPrM+EW5pBR2AFdz
         nyHXLvnJ0CGnrUQGzQy93w5ayoSSY3KhhqYzkl2OuZA7MTSCZEoSO//7TvOp6SolFG1r
         7UEg==
X-Forwarded-Encrypted: i=1; AJvYcCVFOKvqGrouebFgkpjFIxLnWVTVCke1jYqXktYaug39HyNWhxhXOWlQ28pFXByQKslpz39ZKdTg7t0wJixFmg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+OqPo73+Mdmu9qfPDTOxrUDvrdlBbW3jIPfqcBmOJBbw+aSI0
	CXD6FuM8rCx2k5zt5/mLRuwnxSzgjFEbJTgkKkSVcETiFKdv9OjgElJs3mg36nzve22hzfwc1/D
	PUkricibC45Hv1YkEKf2W9X7QRosraW6KAlB0sSgKBQAU+vbMZGiPrpauTVqaTG7Ups3xpJn+fN
	sv
X-Gm-Gg: AZuq6aKwGfFQZ/oqF/cuMNNKRsCRRbSjERM26Mjzf8X2hQJ/fXrZ6u6MfesyR+chFlB
	kSZtpWV+NR6JDlT0hf+BQ3+vGJYswDK/anV5RBOpT3+JVEDY3KDM3mzGlQUJp8Rc8iv3zMck+68
	GBw2lcHTZ1DPnMrYwNf1e/JMEgUbu2nEbl5F3j9oWY0dghuLa0c02B6vDb6WPhi2QqJFzheW4+Z
	2IGMOqvOPAeOWoDF0jIY2T1Y27Kxs4pdq4Rlc0zcw10dRq0KuU+qLZBhAwIl0TBRPdrZe7+mK0u
	zTWQJWU6VNKWvZxCGeQmjElSwM8Hp8drcLnQPEYyXZYb7hQerL1Kvz5y5/QaMyyEpKZLwt3EjbL
	qFp1SetTSW6FFUEk/lAJ0SsVU3Aw1O2MMjg==
X-Received: by 2002:a05:600c:3b24:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-4804c94f82amr5685265e9.7.1769102484668;
        Thu, 22 Jan 2026 09:21:24 -0800 (PST)
X-Received: by 2002:a05:600c:3b24:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-4804c94f82amr5684275e9.7.1769102483618;
        Thu, 22 Jan 2026 09:21:23 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470cf1acsm81696635e9.14.2026.01.22.09.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:21:22 -0800 (PST)
Date: Thu, 22 Jan 2026 12:21:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v16 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20260122115857-mutt-send-email-mst@kernel.org>
References: <20260121220652.894364-1-danielj@nvidia.com>
 <20260121220652.894364-10-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260121220652.894364-10-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9yOL5GAhssR8VRrleUcUiiVoU2Ck7_YCwZJkabmjj_4_1769102486
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 21, 2026 at 04:06:49PM -0600, Daniel Jurgens wrote:
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
>     - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
>     - changed return of setup_ip_key_mask to -EINVAL.
>     - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST
> 
> v13:
>     - Set tos field if applicable in parse_ip4. MST
>     - Check tos in validate_ip4_mask. MST
>     - check l3_mask before setting addr and mask in parse_ip4. MST
>     - use has_ipv4 vs numhdrs for branching in build_and_insert. MST
> ---
> ---
>  drivers/net/virtio_net.c | 129 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 123 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ba231f10b803..7ce120baeb41 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5818,6 +5818,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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


this cast is only portable if sel and sel_cap are properly aligned.



Because if not then at least saddr/daddr accesses below are
not portable and need
Documentation/core-api/unaligned-memory-access.rst

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
> +	if (mask->tos &&
> +	    !check_mask_vs_cap(&mask->tos, &cap->tos,
> +			       sizeof(u8), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -5829,11 +5862,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
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

this cast is only portable if sel and sel_cap are properly aligned.



Because if not then at least saddr/daddr accesses below are
not portable and need
Documentation/core-api/unaligned-memory-access.rst

> +
> +	if (l3_mask->ip4src) {
> +		mask->saddr = l3_mask->ip4src;
> +		key->saddr = l3_val->ip4src;
> +	}
> +
> +	if (l3_mask->ip4dst) {
> +		mask->daddr = l3_mask->ip4dst;
> +		key->daddr = l3_val->ip4dst;
> +	}
> +
> +	if (l3_mask->tos) {
> +		mask->tos = l3_mask->tos;
> +		key->tos = l3_val->tos;
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
> @@ -5969,6 +6032,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  {
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
> +	case IP_USER_FLOW:
>  		return true;
>  	}
>  
> @@ -6000,8 +6064,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  				 u8 *key_size, size_t *classifier_size,
>  				 int *num_hdrs)
>  {
> +	size_t size = sizeof(struct ethhdr);
> +
>  	*num_hdrs = 1;
> -	*key_size = sizeof(struct ethhdr);
> +
> +	if (fs->flow_type != ETHER_FLOW) {
> +		++(*num_hdrs);
> +		if (has_ipv4(fs->flow_type))
> +			size += sizeof(struct iphdr);
> +	}
> +
> +	BUG_ON(size > 0xff);
> +	*key_size = size;
>  	/*
>  	 * The classifier size is the size of the classifier header, a selector
>  	 * header for each type of header in the match criteria, and each header
> @@ -6013,8 +6087,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
> @@ -6022,8 +6097,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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

Are mask and key guaranteed to be aligned here?


Because if not then at least saddr/daddr accesses in parse_ip4
call below are not portable and need
Documentation/core-api/unaligned-memory-access.rst




> +
> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +	selector->length = sizeof(struct iphdr);
> +
> +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> +	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> +	    fs->m_u.usr_ip4_spec.ip_ver ||
> +	    fs->m_u.usr_ip4_spec.proto)
> +		return -EINVAL;
> +
> +	parse_ip4(v4_m, v4_k, fs);
> +
> +	return 0;
>  }
>  
>  static int
> @@ -6045,6 +6147,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
>  	return 0;
>  }
>  
> +static
> +struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
> +{
> +	return (void *)sel + sizeof(struct virtio_net_ff_selector) +
> +		sel->length;
> +}
> +
>  static int build_and_insert(struct virtnet_ff *ff,
>  			    struct virtnet_ethtool_rule *eth_rule)
>  {
> @@ -6082,7 +6191,15 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	classifier->count = num_hdrs;
>  	selector = (void *)&classifier->selectors[0];
>  
> -	setup_eth_hdr_key_mask(selector, key, fs);
> +	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);

So this will set sel->length to 14.


> +
> +	if (has_ipv4(fs->flow_type)) {
> +		selector = next_selector(selector);


And this will point next one at an offset 8 + 14 then?

> +
> +		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);


and this will pass unaligned mask and key?

> +		if (err)
> +			goto err_classifier;
> +	}
>  
>  	err = validate_classifier_selectors(ff, classifier, num_hdrs);
>  	if (err)
> -- 
> 2.50.1

