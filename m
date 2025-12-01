Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258A32BF55
	for <virtualization@lists.linux.dev>; Mon,  1 Dec 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602775; cv=none; b=S9tj3OoayvJmdtWAFFkiI43ddImkvnY5O78O1BlNp0Uprpy1yDLUtGHV0XfTFT7n68ugLUFW6APX8CTqi+t01lFJGxkjz0Ry78dwFKsxEs4b96i9lwBQ3xe7PuU078a1rqPRUB+uJSi+ob8ZqmIINmN1dMVSdFGjpt/vmWF4860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602775; c=relaxed/simple;
	bh=o8FwZFVQ2xFRn5zK/Fo7fYLnpOCexob3KmOkeJg/AUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T1CG0NgtzY/o7nrUTzsor34ejPDx82DcAUXmzIoPjNQdjoCTaM/ggdiYs5q5snoGGVNhIC6yeGFbMSqis3neiSt086rjbRS6JHuaWxa9xyymJOOBaNwMarfvbXf5eZDSWC47wzewQIrvYiutqGfCedwHdxb8D5Fw0UwclxlkvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHVUuRJi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHVUuRJi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764602771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eTikolJriVieHtqa7nqQrvJ8OFM9g4/uewLustTZkbs=;
	b=FHVUuRJiCInf0VyhLylyv9zTRkwZvqZcwga5x6gIyZg374DMEYEptpNYx/DVcLeWp6jvku
	oooUER56phxGkZqqlvluDBqrsBtsWWpmLpVmqMCKnRHmF+wLemiQMg75+IIviAGBxUI7H2
	Bi+RAmPjzY7iCy9Z3m0oIuuMTyBdaIc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-_mWJxeeKP-C8htyeicBWBA-1; Mon, 01 Dec 2025 10:26:10 -0500
X-MC-Unique: _mWJxeeKP-C8htyeicBWBA-1
X-Mimecast-MFC-AGG-ID: _mWJxeeKP-C8htyeicBWBA_1764602769
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b7369635423so101673166b.2
        for <virtualization@lists.linux.dev>; Mon, 01 Dec 2025 07:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764602769; x=1765207569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTikolJriVieHtqa7nqQrvJ8OFM9g4/uewLustTZkbs=;
        b=GM+2J3A+1L3LyCy9qSmsZ25bq+Liq7ku1kqCvtwhx8bnK6UdPYnhQ0O3LJPtRPQMo5
         EHwG3vv2bizxpCu4g2g2kQjjUWyDpwYLmAe5QhNgetaoPCTYft0S0W+jYrrnPdU0NJaA
         LdxGu1cjNyVNqHQy/xT+7xSsuQb/lEymd27PR1IiNIKTO19N0hIzjusftu5cX/sUNe4k
         xsXBlFYhAfJvuV+1oS3g0mZYwLPE5m0QTrkgVxXBBzJI0InJq0JQpBJaIULSFflVZpD9
         GbcIHGf8C3eDet7ioSrEqnim58lYva8haNsqjNmgv2j684SbVk6YutQhUwa6wWjI4K9e
         Jd1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdqjLJMJCr6PXv2Jv5TBNnROAHpoxWa1PjcXa+UWmr2c9LvqQ5k51wUSKoiPmYLCVV+mT5b9U2cx2gIpxkZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+SlXCHKszj2CBVuop8tyN8Lvg8A4DKJA0fYRC4CKqkFuvx5NM
	RJ4cDLUR19DdbT2tIPGTZXrSUyA0fKLL60/mthCTGjFPn1UfsnV1xeyBmjP5PTn5Kr06yeRCKIU
	KQUADVooAbjJoxWnjgpamVohGU/aD8RgR11GRR9YFrI0XwGOEIx5KhfWOvY5lsYdfDpjN
X-Gm-Gg: ASbGncvMx0XBUntzFFG1B8K/8wgIdrSX4zsA45dInLvS2znIfmkMKEjeiMwYOKRl1Gq
	5GYXBAMWWQPu2JFZeAz6/oHapDZ9Mi5WvjjPNi/9a0bBe7bctcNR3xMtyngaXRQ8tsWeZyc0Q2e
	Oksc3ye8ew2dN6xQ0hL9rGdMdFiE+JGut0j0hsxzus+knkrtf4NKFSz7Ovzou5x8r+z3dixWgER
	XnsQw6779KpbM4Wr7ufzpOct3j06YMJmB/hA+gNNjFwnXHPWCxsVCGairYT+R2AKosJ+HLyFaL9
	jscof03EcQv4ATIJqA49nLr2yV0rlB899aT/YRy4XmaMa5AzLCF2pjaD+XEjHdebzI+IqUXlE8Q
	HrFuK
X-Received: by 2002:a17:907:984:b0:b76:bcf5:a388 with SMTP id a640c23a62f3a-b76c563c139mr2865409066b.50.1764602769216;
        Mon, 01 Dec 2025 07:26:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/R1Nj40/3I+dbcJE/UMwSYe/bAkEM9LSlgj2Lgf/+8Z9Zt4nu3arZ5g20uw9nPnbXsrts1Q==
X-Received: by 2002:a17:907:984:b0:b76:bcf5:a388 with SMTP id a640c23a62f3a-b76c563c139mr2865402266b.50.1764602768441;
        Mon, 01 Dec 2025 07:26:08 -0800 (PST)
Received: from redhat.com ([2a06:c701:73f0:bd00:7951:f7c0:f4c7:a98f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a7afb4sm1229484066b.70.2025.12.01.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 07:26:07 -0800 (PST)
Date: Mon, 1 Dec 2025 10:26:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <20251201102256-mutt-send-email-mst@kernel.org>
References: <20251126193539.7791-1-danielj@nvidia.com>
 <20251126193539.7791-12-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251126193539.7791-12-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bNs8WaDnJpbaxwG1N121ASSuFAh6kGt5TUSY7z_pF78_1764602769
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:
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
>  drivers/net/virtio_net.c | 229 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 215 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 28d53c8bdec6..908e903272db 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5963,6 +5963,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
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


given you are parsing tcphdr you should include uapi/linux/tcp.h 

for udp - uapi/linux/udp.h

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
> @@ -5980,11 +6026,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> @@ -6005,6 +6085,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  		mask->tos = l3_mask->tos;
>  		key->tos = l3_val->tos;
>  	}
> +
> +	if (l3_mask->proto) {
> +		mask->protocol = l3_mask->proto;
> +		key->protocol = l3_val->proto;
> +	}
>  }
>  
>  static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> @@ -6022,16 +6107,35 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
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
> @@ -6171,6 +6275,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
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
> @@ -6212,6 +6320,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
> @@ -6251,7 +6365,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>  
>  static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  			     u8 *key,
> -			     const struct ethtool_rx_flow_spec *fs)
> +			     const struct ethtool_rx_flow_spec *fs,
> +			     int num_hdrs)
>  {
>  	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> @@ -6263,27 +6378,99 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  		selector->length = sizeof(struct ipv6hdr);
>  
>  		/* exclude tclass, it's not exposed properly struct ip6hdr */
> -		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> -		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
> -		    fs->h_u.usr_ip6_spec.tclass ||
> +		if (fs->h_u.usr_ip6_spec.tclass ||
>  		    fs->m_u.usr_ip6_spec.tclass ||
> -		    fs->h_u.usr_ip6_spec.l4_proto ||
> -		    fs->m_u.usr_ip6_spec.l4_proto)
> +		    (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +				      fs->m_u.usr_ip6_spec.l4_4_bytes ||
> +				      fs->h_u.usr_ip6_spec.l4_proto ||
> +				      fs->m_u.usr_ip6_spec.l4_proto)))
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
> @@ -6323,6 +6510,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	struct virtio_net_ff_selector *selector;
>  	struct virtnet_classifier *c;
>  	size_t classifier_size;
> +	size_t key_offset;
>  	int num_hdrs;
>  	u8 key_size;
>  	u8 *key;
> @@ -6355,11 +6543,24 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
>  
>  	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
> +		key_offset = selector->length;
>  		selector = next_selector(selector);
>  
> -		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
> +		err = setup_ip_key_mask(selector, key + key_offset,
> +					fs, num_hdrs);
>  		if (err)
>  			goto err_classifier;
> +
> +		if (has_udp(fs->flow_type) || has_tcp(fs->flow_type)) {
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

