Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0D25C6FF
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763501486; cv=none; b=UKYKPTxOoWNIvXy9ZgMPicF6BEJmjFjL40IBzeqePgQv4NWKgALEM+ZiKSW/dz9/MSV5cKTR4/r79327BzWOuJaoZaBCrv2Mm6FVcdflc67wchJzeIza2gTrP5YJVsaYJBbj87StvM8jUHjkarotZsz94AXFUp3faPne7rijQWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763501486; c=relaxed/simple;
	bh=Rpu6WiuC87Ce+ui/bfvmt+q6RF6yHHIfC9lqi0kEvcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pIT/x4DuHIW7jW0fqpcdzKAXY8xHhfes2eMfbiunY17K/o9ruj5Cpik3snB66fqSI6h5oDkDsrSqNVK7IQxVmlXOlJZRK5IxCmaFL8u+pMnI+px9il92U7gQmVYFp85QefxsgDFa0uWK9rCSQdY2M/BXoL6kFkZzVvy3IZvHOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTcYFz1v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTcYFz1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763501483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXuVUW9cULZrgMlSP3F/R09NU+THIw38zacHvgl+tdo=;
	b=JTcYFz1vhEW3RKqRhOZ9tweWpG6D+up1QzjzMhniPwF7XV9wRUW/AGMmaEhJ6fucMA/8xK
	ecnGYfTqWLjssAwaeBWAEYAAF2+RXUDj1aYbK2HDqcQR7Z6hxBazy+x7NZp6raUg4QRoE6
	wNx6cdTpMyn4d6K/hwzVB/B3AYcx0Us=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-y0_-j8kiPvWBDCnV5dlFHg-1; Tue, 18 Nov 2025 16:31:16 -0500
X-MC-Unique: y0_-j8kiPvWBDCnV5dlFHg-1
X-Mimecast-MFC-AGG-ID: y0_-j8kiPvWBDCnV5dlFHg_1763501476
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2ffbba05so3347130f8f.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 13:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763501475; x=1764106275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXuVUW9cULZrgMlSP3F/R09NU+THIw38zacHvgl+tdo=;
        b=YAe76kkLWmroEovzEJa8uy0TEP4IzEhDT/NiCZ06/7rdpF30E0WERBff7cJMgB+Q2A
         /2AAMqCetNqUKlEkAForvnZ6JprqXhkSEtBM0ns92BD7fXZ6OuHULZZoivtg5KMT6rfO
         ZOnNGPwENiwDoNDATfh0Kq+wLyO3uiWgjG5OXBuHq33pN1/1nUt0kk5D+XJksegGknKG
         9BLzf/EXQEZ2jgjbuHyz6g/dVTlKAigPnMxlZh7NGfHv1+jy40xp0wInWDVsgKuc34Kc
         iAv3c0ZgCXkqC1i+zDMBGQIjoBM0nyMQP679YMly9AtiV1WlkEeCFVH32H13LgmnUwl7
         IcZA==
X-Forwarded-Encrypted: i=1; AJvYcCXpSfmlWuMkqPLWOnObp9yUXA7t64FaUeOLVPNmE+n8fooXVPP9sovnOzIa292zTIKfT5Yui6YhCIpPWAKY0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpEej46b29GcSiOtysJamOErnK3yOckhgB1DQwJ3mHn8TCMjGW
	NsPB44YdkReBYcNmdLrikv4HZoa8cnNiKOJ9fB81aW+Etdloy5h5yfUGJjMCXxwD+s1TvzuiY71
	R7s7RtGWzDYF86r8aJJaC5u7S6H+I0Gf+sDz+rNgN2lVg4Z3KIkAxP8WykPgQkiEnXrSP
X-Gm-Gg: ASbGncul8OcQ4GQ0rRI9yWtluMhInQMU9z3JcRTjrSf3OUVyDepi+NTO4z4jT3KeSaR
	b4eJF+JdS16Rtb9bQCigwYjdDGpDADjozQN7JAeeXhhCAqQoUlP+H/KiDsqNXxR3l1fuciwcVKR
	bYf/rDKgszCwJ0cLvnhhsFAWWbaAeEwKRxIlKQnOFloy2XwHzKfPXWhE4awHuF22zkD6jE63Olz
	vFxW+OUJruitQ4joIiKEIXnv1VGPa/EIiaBZyYRuvwPDGlYqRp0VTX+Dyt3c8PGdNFmJBRU5cah
	5qz0vWS9HbZ/Zm6YunuUEiCZaLvvbBprAH622iJOLqnLfKL/nvl1BsoAXxV21Y9chrNnQsZfCS9
	sxjZGBwAyf5mpCsXZrFmL6mJiMF/wOQ==
X-Received: by 2002:a05:6000:4202:b0:429:f050:adbb with SMTP id ffacd0b85a97d-42b5935092dmr17736307f8f.26.1763501473475;
        Tue, 18 Nov 2025 13:31:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu38DvC86w3LRimVQliXUo6EbnnHvWPNcGjX4pRxB9qHJOJk/98ijr3Q/Yz/69RWLRzwM+Mw==
X-Received: by 2002:a05:6000:4202:b0:429:f050:adbb with SMTP id ffacd0b85a97d-42b5935092dmr17736172f8f.26.1763501469376;
        Tue, 18 Nov 2025 13:31:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42c97745f79sm20005459f8f.23.2025.11.18.13.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:31:08 -0800 (PST)
Date: Tue, 18 Nov 2025 16:31:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251118161734-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-10-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pL00O711B7TtNkKkmEeyDXr1RW2Wy06INdiqSPKv8IM_1763501476
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:59AM -0600, Daniel Jurgens wrote:
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
> ---
>  drivers/net/virtio_net.c | 122 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 115 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f392ea30f2c7..c1adba60b6a8 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6904,6 +6904,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
> @@ -6915,11 +6943,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> +	if (l3_mask->proto) {

you seem to check mask for proto here but the ethtool_usrip4_spec doc
seems to say the mask for proto must be 0. 


what gives?


> +		mask->protocol = l3_mask->proto;
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
> @@ -7054,6 +7107,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  {
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
> +	case IP_USER_FLOW:
>  		return true;
>  	}
>  
> @@ -7082,11 +7136,23 @@ static int validate_flow_input(struct virtnet_ff *ff,
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

So *key_size  is assigned here ...

> +
> +	if (fs->flow_type == ETHER_FLOW)
> +		goto done;
> +
> +	++(*num_hdrs);
> +	if (has_ipv4(fs->flow_type))
> +		size += sizeof(struct iphdr);
> +

... never used

> +done:
> +	*key_size = size;

and over-written here.


what is going on here, is that this is spaghetti code
misusing goto for if instructions which obscures the flow.

It should be if (fs->flow_type != ETHER_FLOW) {

	... rest of code ...
}

and then it will be clear doing *key_size = size once is enough.


>  	/*
>  	 * The classifier size is the size of the classifier header, a selector
>  	 * header for each type of header in the match criteria, and each header
> @@ -7098,8 +7164,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
> @@ -7107,8 +7174,33 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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

So include/uapi/linux/ethtool.h says:

 * struct ethtool_usrip4_spec - general flow specification for IPv4
 * @ip4src: Source host
 * @ip4dst: Destination host
 * @l4_4_bytes: First 4 bytes of transport (layer 4) header
 * @tos: Type-of-service
 * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
 * @proto: Transport protocol number; mask must be 0

I guess this ETH_RX_NFC_IP4 check validates that userspace follows this
documentation? But then shouldn't you check the mask
as well? and mask for proto?





> +
> +	parse_ip4(v4_m, v4_k, fs);
> +
> +	return 0;
>  }
>  
>  static int
> @@ -7130,6 +7222,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
> @@ -7167,8 +7266,17 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	classifier->count = num_hdrs;
>  	selector = (void *)&classifier->selectors[0];
>  
> -	setup_eth_hdr_key_mask(selector, key, fs);
> +	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
> +	if (num_hdrs == 1)
> +		goto validate;


Please stop abusing goto's for if.
this is not error handling, not breaking out of loops ...


please do not.


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
> 2.50.1

