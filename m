Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB9288CA3
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139966; cv=none; b=NIo7dU6/absU5kgYiGQjSA0lqQibcynYcTX4s7Kfl+afYa11HgG85NaQwYBcx3fZjACTWie9KwkN27fm02gHXxzdBU4bii9z1ynx+gpmqwKOVzC92HBnHZwchbxq+7KLgq/L8HrdZUZY8uzDquyeS2aB4Z59+ibNmhx81kJJMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139966; c=relaxed/simple;
	bh=O4peJ7v1qA1iXniojrciQwOiCfHw08tfNgD3OKaS+7I=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=LTjlwfwmkq7iMA+k9qViUzg8i3Egmelup9sNXKOzK28Gcyg+si/CQZbKKUax592omcwSlbFWY0HLGyyKiXVsXs43yiX+9s7vgWVcy56U1zmU4yR6KdOt6q+yVP4cNATc9VBAkNVGZseQcPMjrxn5DKP1416/nCnvE+KeasGXsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iclGEJ48; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iclGEJ48"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762139953; h=Message-ID:Subject:Date:From:To;
	bh=Mr3yhH9lezCoWfm8WZApfVvgmIhFeCSwBlK5FIIIQhw=;
	b=iclGEJ48/yXViFusyhBTXHdh/USy0dyhnbyGBW053MpTRihaiujZLrhyPSlmAcS06Ey86Ar6IDD5mYzhYx4tSaGF5s4EgtVQWNYp24m2tVyUd7g66G3ko/UQwtzP4mmANSPcx+YjXLv9h1n5R9yJJ3AkjPrlr7lP4DGOhWmY9vA=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrW6iqs_1762139951 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 11:19:12 +0800
Message-ID: <1762139946.358394-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Mon, 3 Nov 2025 11:19:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <virtualization@lists.linux.dev>,
 <parav@nvidia.com>,
 <shshitrit@nvidia.com>,
 <yohadt@nvidia.com>,
 <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>,
 <shameerali.kolothum.thodi@huawei.com>,
 <jgg@ziepe.ca>,
 <kevin.tian@intel.com>,
 <kuba@kernel.org>,
 <andrew+netdev@lunn.ch>,
 <edumazet@google.com>,
 Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>,
 <mst@redhat.com>,
 <jasowang@redhat.com>,
 <alex.williamson@redhat.com>,
 <pabeni@redhat.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
 <20251027173957.2334-12-danielj@nvidia.com>
In-Reply-To: <20251027173957.2334-12-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 27 Oct 2025 12:39:56 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
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
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> v4: (*num_hdrs)++ to ++(*num_hdrs)
> ---
>  drivers/net/virtio_net.c | 207 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 198 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 587c4e955ebb..2a24fb601cc1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6940,6 +6940,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
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
> @@ -6957,11 +7003,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> @@ -7003,12 +7083,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
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
> @@ -7147,6 +7241,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
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
> @@ -7191,6 +7289,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  		size += sizeof(struct iphdr);
>  	else if (has_ipv6(fs->flow_type))
>  		size += sizeof(struct ipv6hdr);
> +
> +	if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
> +		++(*num_hdrs);
> +		size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
> +						 sizeof(struct udphdr);
> +	}
>  done:
>  	*key_size = size;
>  	/*
> @@ -7225,7 +7329,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>
>  static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  			     u8 *key,
> -			     const struct ethtool_rx_flow_spec *fs)
> +			     const struct ethtool_rx_flow_spec *fs,
> +			     int num_hdrs)
>  {
>  	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> @@ -7236,21 +7341,93 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
>  		selector->length = sizeof(struct ipv6hdr);
>
> -		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> -		    fs->h_u.usr_ip6_spec.tclass)
> +		if (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +				      fs->h_u.usr_ip6_spec.tclass))
>  			return -EOPNOTSUPP;
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
> -		    fs->h_u.usr_ip4_spec.tos ||
> -		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> +		if (num_hdrs == 2 &&
> +		    (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +		     fs->h_u.usr_ip4_spec.tos ||
> +		     fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4))
>  			return -EOPNOTSUPP;
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
> @@ -7290,6 +7467,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	struct virtio_net_ff_selector *selector;
>  	struct virtnet_classifier *c;
>  	size_t classifier_size;
> +	size_t key_offset;
>  	size_t key_size;
>  	int num_hdrs;
>  	u8 *key;
> @@ -7323,9 +7501,20 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	if (num_hdrs == 1)
>  		goto validate;
>
> +	key_offset = selector->length;
> +	selector = next_selector(selector);
> +
> +	err = setup_ip_key_mask(selector, key + key_offset, fs, num_hdrs);
> +	if (err)
> +		goto err_classifier;
> +
> +	if (num_hdrs == 2)
> +		goto validate;
> +
> +	key_offset += selector->length;
>  	selector = next_selector(selector);
>
> -	err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
> +	err = setup_transport_key_mask(selector, key + key_offset, fs);
>  	if (err)
>  		goto err_classifier;
>
> --
> 2.50.1
>
