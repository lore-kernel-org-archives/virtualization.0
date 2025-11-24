Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB8334C1C
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021788; cv=none; b=ssXHSPkOSQnJcXnlVkJvIFhtkYUz7iYygCCC4HMTkwY1Ty0gguxaR0VcBOLIEzsNzP2uMddF9wHhAtaVclzvtUskSQag/A9zFcyKA5aD1m9WLLUQjeNKuAMHyu6HPBw8EuSwYFMMX7PlmexIHChYPh5aOrZS/IKrg3EkLXzqeIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021788; c=relaxed/simple;
	bh=UzmZ4JZ4FIRYr0P3sojXXIpUWGlp2SOuZbJ+WJiq8C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eYcIfhG6Nj4Cc1OnTDaxXQqt+QMM4nqb4B7OU/LgEgtcOfUFV9u+FOKjPkmSKmlJL+dJcUT7XLbeBBp9ZAmJpd59NxTOFUQPdz4cN897KPfIC5YGi3X92yXVTiMpHl+Bn9HO1YZ+UY7csAQz32sraigfftmUqW8KL0rKfJrKgwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayBGVQtz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayBGVQtz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764021785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0JhuHVIms7jkxQWWfNx7f+RKOZNrOLy8i2f1ZMv9aa0=;
	b=ayBGVQtz/UGCTkz9S2SM26C8COKtDojzA5X7k8iADhrvG9fQ49FL9ZeuP93OHaF5UCbpK6
	ugYCjz239bC+rV73Y4+34JSvInYinO6SinJxHe9dkUdsCUrLv8p1v4/sWRrSOw3wAiqKbs
	xLuEsNmYhdjUJ7/G0boIWZIu5phDnzo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-W25bTIUOP3mZwyymR4YJUQ-1; Mon, 24 Nov 2025 17:03:01 -0500
X-MC-Unique: W25bTIUOP3mZwyymR4YJUQ-1
X-Mimecast-MFC-AGG-ID: W25bTIUOP3mZwyymR4YJUQ_1764021780
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2ad29140so2785287f8f.0
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 14:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764021780; x=1764626580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JhuHVIms7jkxQWWfNx7f+RKOZNrOLy8i2f1ZMv9aa0=;
        b=TXVXsvhu9dKZcJejJgrxPtEH3/o23QR7jG64c0dSc8R/89YdnLuVu/o9KL7t9rNBUX
         +El6mp8q4cy4yXp9ZyD3unr5cXkrQ//HxlsvRunfKEiDrkRUaZMLycGppUcPx73urPED
         h87QRxraMlIH/aqj2SpOIDtYp5ksOasEDXBJGI7nZIBbKxobITqzVsaozFtFKbDR0xUi
         rAW4p4kAFJSiJV6295s2oFC2zTTekemYazTA4r7oYpIAusFrnjCE/mh/cHDniEnTIV8S
         +Vwbji0HpyKsNGEABLH8yx5lRXMZpb9aAiPCLgHprt4WzTnB9lB1Te6xBz1ma8mT4cG/
         /f4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWgroBNEA8YMgohv80lBRcN04LM9P24mNOT88Z7dqfyyKZgS5oQUNVZ92av5CxCO+ggLo/0NYM1/EeLCJ/sg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo4Vx5MJ0Qh7d3TdYDCHeNoRlXxiRVYAdbjgoHdzi0MUD/f0QD
	V4sw80kUjaa9uJv2Tymosm5jN7e8GNjOtfTgTzp6Yf2Cm7x15nSlkSkIHYJJYmfol5QK7yqkcMt
	tqzcnvvqDz8AxCCO9QZiSk3AdBjw6Isz8aiKI/rPmodjeJgpUM2tlo72GBF7WYiBJVxQq
X-Gm-Gg: ASbGncv11LyRK50KEIt4+8OXn2jZ+JFjQQIXQii0mI2EYMAtEneIJzUUW0lREpBD4p7
	Bw3NfgsgCnGf7mzfRYiJH4eB7OrAW4C6b3JhJ+CJ+QecADsmdrTeZmOaZbsOjdvU/XElu0A92uh
	Qw4Nuv4zaf9Zl0DyOHKCO235rZMCTUDSwdATWXrdKxvyQ3i82otAXjaFcOo6TURC4FOndEesWi0
	4YE7BFJJTcjcAGt9SG9kfGCIPLQCgEtOK9WRMTF894wkhjpHsCwaxo1hFe9m4qz2TGVNI07nIo4
	cCawfFVYXwZgs26G8yIHOSQ2Cn9CYhUAqwgDT7m+aHKJIb2oDPO6AE/x77XURmbflWoOKg3fN/j
	VEvBI9khBr4HqzYvANfG6IN65i+njew==
X-Received: by 2002:a05:6000:186b:b0:42b:3dbe:3a53 with SMTP id ffacd0b85a97d-42cc1d0c716mr15152372f8f.40.1764021780244;
        Mon, 24 Nov 2025 14:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh9ZIHDZbys51wQMG/TUIVh5V+sCNtsy4yhJ+PKJR3RAQlsBA/V34iuOCd3W/fC9BI7f84tw==
X-Received: by 2002:a05:6000:186b:b0:42b:3dbe:3a53 with SMTP id ffacd0b85a97d-42cc1d0c716mr15152332f8f.40.1764021779636;
        Mon, 24 Nov 2025 14:02:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7ec454csm29446534f8f.0.2025.11.24.14.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:02:58 -0800 (PST)
Date: Mon, 24 Nov 2025 17:02:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <20251124165953-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-12-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119191524.4572-12-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2NtSm_fJ0Nej6mV-NL3zdsSRnrsWjkEdsUA_gsfGQp4_1764021780
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:15:22PM -0600, Daniel Jurgens wrote:
> Implement TCP and UDP V4/V6 ethtool flow types.
> 
> Examples:
> $ ethtool -U ens9 flow-type udp4 dst-ip 192.168.5.2 dst-port\
> 4321 action 20
> Added rule with ID 4
> 
> This example directs IPv4 UDP traffic with the specified address and
> port to queue 20.
> 
> $ ethtool -U ens9 flow-type tcp6 src-ip 2001:db8::1 src-port 1234 dst-ip\
> 2001:db8::2 dst-port 4321 action 12
> Added rule with ID 5
> 
> This example directs IPv6 TCP traffic with the specified address and
> port to queue 12.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4: (*num_hdrs)++ to ++(*num_hdrs)
> 
> v12:
>   - Refactor calculate_flow_sizes. MST
>   - Refactor build_and_insert to remove goto validate. MST
>   - Move parse_ip4/6 l3_mask check here. MST
> ---
> ---
>  drivers/net/virtio_net.c | 223 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 212 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index bb8ec4265da5..e6c7e8cd4ab4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5950,6 +5950,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
>  	return true;
>  }
>  
> +static bool validate_tcp_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct tcphdr *cap, *mask;
> +
> +	cap = (struct tcphdr *)&sel_cap->mask;
> +	mask = (struct tcphdr *)&sel->mask;
> +
> +	if (mask->source &&
> +	    !check_mask_vs_cap(&mask->source, &cap->source,
> +	    sizeof(cap->source), partial_mask))
> +		return false;
> +
> +	if (mask->dest &&
> +	    !check_mask_vs_cap(&mask->dest, &cap->dest,
> +	    sizeof(cap->dest), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool validate_udp_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct udphdr *cap, *mask;
> +
> +	cap = (struct udphdr *)&sel_cap->mask;
> +	mask = (struct udphdr *)&sel->mask;
> +
> +	if (mask->source &&
> +	    !check_mask_vs_cap(&mask->source, &cap->source,
> +	    sizeof(cap->source), partial_mask))
> +		return false;
> +
> +	if (mask->dest &&
> +	    !check_mask_vs_cap(&mask->dest, &cap->dest,
> +	    sizeof(cap->dest), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -5967,11 +6013,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  
>  	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
>  		return validate_ip6_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_TCP:
> +		return validate_tcp_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_UDP:
> +		return validate_udp_mask(ff, sel, sel_cap);
>  	}
>  
>  	return false;
>  }
>  
> +static void set_tcp(struct tcphdr *mask, struct tcphdr *key,
> +		    __be16 psrc_m, __be16 psrc_k,
> +		    __be16 pdst_m, __be16 pdst_k)
> +{
> +	if (psrc_m) {
> +		mask->source = psrc_m;
> +		key->source = psrc_k;
> +	}
> +	if (pdst_m) {
> +		mask->dest = pdst_m;
> +		key->dest = pdst_k;
> +	}
> +}
> +
> +static void set_udp(struct udphdr *mask, struct udphdr *key,
> +		    __be16 psrc_m, __be16 psrc_k,
> +		    __be16 pdst_m, __be16 pdst_k)
> +{
> +	if (psrc_m) {
> +		mask->source = psrc_m;
> +		key->source = psrc_k;
> +	}
> +	if (pdst_m) {
> +		mask->dest = pdst_m;
> +		key->dest = pdst_k;
> +	}
> +}
> +
>  static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  		      const struct ethtool_rx_flow_spec *fs)
>  {
> @@ -5987,6 +6067,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  		mask->daddr = l3_mask->ip4dst;
>  		key->daddr = l3_val->ip4dst;
>  	}
> +
> +	if (l3_mask->proto) {
> +		mask->protocol = l3_mask->proto;
> +		key->protocol = l3_val->proto;
> +	}
>  }
>  
>  static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> @@ -6004,16 +6089,35 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
>  		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
>  		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
>  	}
> +
> +	if (l3_mask->l4_proto) {
> +		mask->nexthdr = l3_mask->l4_proto;
> +		key->nexthdr = l3_val->l4_proto;
> +	}
>  }
>  
>  static bool has_ipv4(u32 flow_type)
>  {
> -	return flow_type == IP_USER_FLOW;
> +	return flow_type == TCP_V4_FLOW ||
> +	       flow_type == UDP_V4_FLOW ||
> +	       flow_type == IP_USER_FLOW;
>  }
>  
>  static bool has_ipv6(u32 flow_type)
>  {
> -	return flow_type == IPV6_USER_FLOW;
> +	return flow_type == TCP_V6_FLOW ||
> +	       flow_type == UDP_V6_FLOW ||
> +	       flow_type == IPV6_USER_FLOW;
> +}
> +
> +static bool has_tcp(u32 flow_type)
> +{
> +	return flow_type == TCP_V4_FLOW || flow_type == TCP_V6_FLOW;
> +}
> +
> +static bool has_udp(u32 flow_type)
> +{
> +	return flow_type == UDP_V4_FLOW || flow_type == UDP_V6_FLOW;
>  }
>  
>  static int setup_classifier(struct virtnet_ff *ff,
> @@ -6153,6 +6257,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  	case ETHER_FLOW:
>  	case IP_USER_FLOW:
>  	case IPV6_USER_FLOW:
> +	case TCP_V4_FLOW:
> +	case TCP_V6_FLOW:
> +	case UDP_V4_FLOW:
> +	case UDP_V6_FLOW:
>  		return true;
>  	}
>  
> @@ -6194,6 +6302,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  			size += sizeof(struct iphdr);
>  		else if (has_ipv6(fs->flow_type))
>  			size += sizeof(struct ipv6hdr);
> +
> +		if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
> +			++(*num_hdrs);
> +			size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
> +							 sizeof(struct udphdr);
> +		}
>  	}
>  
>  	BUG_ON(size > 0xff);
> @@ -6233,7 +6347,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>  
>  static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  			     u8 *key,
> -			     const struct ethtool_rx_flow_spec *fs)
> +			     const struct ethtool_rx_flow_spec *fs,
> +			     int num_hdrs)
>  {
>  	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> @@ -6244,23 +6359,95 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
>  		selector->length = sizeof(struct ipv6hdr);
>  
> -		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> -		    fs->m_u.usr_ip6_spec.l4_4_bytes)
> +		if (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +				      fs->m_u.usr_ip6_spec.l4_4_bytes))
>  			return -EINVAL;
>  
>  		parse_ip6(v6_m, v6_k, fs);
> +
> +		if (num_hdrs > 2) {
> +			v6_m->nexthdr = 0xff;
> +			if (has_tcp(fs->flow_type))
> +				v6_k->nexthdr = IPPROTO_TCP;
> +			else
> +				v6_k->nexthdr = IPPROTO_UDP;
> +		}
>  	} else {
>  		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
>  		selector->length = sizeof(struct iphdr);
>  
> -		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> -		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> -		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> -		    fs->m_u.usr_ip4_spec.ip_ver ||
> -		    fs->m_u.usr_ip4_spec.proto)
> +		if (num_hdrs == 2 &&
> +		    (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +		     fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> +		     fs->m_u.usr_ip4_spec.l4_4_bytes ||
> +		     fs->m_u.usr_ip4_spec.ip_ver ||
> +		     fs->m_u.usr_ip4_spec.proto))
>  			return -EINVAL;
>  
>  		parse_ip4(v4_m, v4_k, fs);
> +
> +		if (num_hdrs > 2) {
> +			v4_m->protocol = 0xff;
> +			if (has_tcp(fs->flow_type))
> +				v4_k->protocol = IPPROTO_TCP;
> +			else
> +				v4_k->protocol = IPPROTO_UDP;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int setup_transport_key_mask(struct virtio_net_ff_selector *selector,
> +				    u8 *key,
> +				    struct ethtool_rx_flow_spec *fs)
> +{
> +	struct tcphdr *tcp_m = (struct tcphdr *)&selector->mask;
> +	struct udphdr *udp_m = (struct udphdr *)&selector->mask;
> +	const struct ethtool_tcpip6_spec *v6_l4_mask;
> +	const struct ethtool_tcpip4_spec *v4_l4_mask;
> +	const struct ethtool_tcpip6_spec *v6_l4_key;
> +	const struct ethtool_tcpip4_spec *v4_l4_key;
> +	struct tcphdr *tcp_k = (struct tcphdr *)key;
> +	struct udphdr *udp_k = (struct udphdr *)key;
> +
> +	if (has_tcp(fs->flow_type)) {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_TCP;
> +		selector->length = sizeof(struct tcphdr);
> +
> +		if (has_ipv6(fs->flow_type)) {
> +			v6_l4_mask = &fs->m_u.tcp_ip6_spec;
> +			v6_l4_key = &fs->h_u.tcp_ip6_spec;
> +
> +			set_tcp(tcp_m, tcp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
> +				v6_l4_mask->pdst, v6_l4_key->pdst);
> +		} else {
> +			v4_l4_mask = &fs->m_u.tcp_ip4_spec;
> +			v4_l4_key = &fs->h_u.tcp_ip4_spec;
> +
> +			set_tcp(tcp_m, tcp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
> +				v4_l4_mask->pdst, v4_l4_key->pdst);
> +		}
> +
> +	} else if (has_udp(fs->flow_type)) {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_UDP;
> +		selector->length = sizeof(struct udphdr);
> +
> +		if (has_ipv6(fs->flow_type)) {
> +			v6_l4_mask = &fs->m_u.udp_ip6_spec;
> +			v6_l4_key = &fs->h_u.udp_ip6_spec;
> +
> +			set_udp(udp_m, udp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
> +				v6_l4_mask->pdst, v6_l4_key->pdst);
> +		} else {
> +			v4_l4_mask = &fs->m_u.udp_ip4_spec;
> +			v4_l4_key = &fs->h_u.udp_ip4_spec;
> +
> +			set_udp(udp_m, udp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
> +				v4_l4_mask->pdst, v4_l4_key->pdst);
> +		}
> +	} else {
> +		return -EOPNOTSUPP;
>  	}
>  
>  	return 0;
> @@ -6300,6 +6487,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	struct virtio_net_ff_selector *selector;
>  	struct virtnet_classifier *c;
>  	size_t classifier_size;
> +	size_t key_offset;
>  	int num_hdrs;
>  	u8 key_size;
>  	u8 *key;
> @@ -6332,11 +6520,24 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
>  
>  	if (num_hdrs != 1) {
> +		key_offset = selector->length;
>  		selector = next_selector(selector);
>  
> -		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
> +		err = setup_ip_key_mask(selector, key + key_offset,
> +					fs, num_hdrs);
>  		if (err)
>  			goto err_classifier;
> +
> +		if (num_hdrs >= 2) {


So elsewhere it is num_hdrs > 2 here it's >= 2 ...

all this is confusing.



Can you please add some constants so reader can understand why
is each condition checked.



For example, is this not invoked on ip only filters? num_hdrs will be 2,
right?

> +			key_offset += selector->length;
> +			selector = next_selector(selector);
> +
> +			err = setup_transport_key_mask(selector,
> +						       key + key_offset,
> +						       fs);
> +			if (err)
> +				goto err_classifier;
> +		}
>  	}
>  
>  	err = validate_classifier_selectors(ff, classifier, num_hdrs);
> -- 
> 2.50.1

