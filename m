Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775537F8C9
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774789; cv=none; b=KJ93mLi+6x6GAvoQ4JbS5idJa5xWyS+jZIP/OQSUrGvubqHrMjNHOxibzh5xzHMs6WNWw4TT3+B9OOzOayX+m+ZQnd+/VVBxdSDBAJ3/KvG7oTaMMfH9BmK3uzchHX8uwvPP8uEE2ZsSF4LysuX/hVWW38XRJIpMsPlzNQNSRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774789; c=relaxed/simple;
	bh=btkUi3OcexvT6IZ4ns2WxhjYI4N9WeIm6cNjGZT9Bho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JsgJU8TI9pQHSxMXe5fkhcQ0PhfEopUVudz/yfjH4p/v+GP3ovRaYC+usHI6QwbTF1qPu2FMePW6pS/VO9zEb40EpDesBJjwFxbxC2RNEaZymPwnpgqA/QK9jgvQlGi5cy+2KtkTgNbQ8K8lnteAoRYAVv8NErR1oITUx3mwHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtiKpUMc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtiKpUMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785774787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1DtRG8e3IaaHp2KIXy0j58mZLMIXAdUrZd9V06OZ9kQ=;
	b=KtiKpUMcCdD2ps+Di8wg9FSyNk9LWMau1+6l9fjnuadmKveIoVa/3KJb1WKkZn5ReaFYbc
	Jb6pQ0iAYQaUscip8ZiFzqfOX/K9+wPRcY3v0XDlEHFp5xkyHQWyd8HMsqeYWUv11VvD93
	Yd7fgPnUHmmFquAOnGZIWW4Kzd0xD3s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-cv65lcayM3G2qcRpgg0VSw-1; Mon, 03 Aug 2026 12:33:05 -0400
X-MC-Unique: cv65lcayM3G2qcRpgg0VSw-1
X-Mimecast-MFC-AGG-ID: cv65lcayM3G2qcRpgg0VSw_1785774784
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so2857545f8f.0
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 09:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774784; x=1786379584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1DtRG8e3IaaHp2KIXy0j58mZLMIXAdUrZd9V06OZ9kQ=;
        b=THCHgbjL3urUB0TlfddJsaAiwj/3Y7YjiVu+WKFBmnFGVBWe9b+OZSuZxEc8s+HIrn
         3uZko+/Xxy7bwa7JNmLBj3PLaxyIfYoS+d0CVNxlsf5QX3exYbVmAHwtIsQ+LtuGkO11
         Y83a0sWIxjNLBoLOq6j9YOT0KTnmWVfo/OTmZo1WhrYm+oZSSVfbgm7J8USt//Opanjx
         uCUgs0LpuBf949A/4dsTXxVTbb2QZFf25bV+MopI1k32x082fzxCXzeXCMsiBWk/DxWj
         w0/CDLWJSM7/tahhH6id+/QuE+Xax6VrlsZWY9dlCs83eRccLfLZWdzvO66vSRnDHmjg
         kinw==
X-Forwarded-Encrypted: i=1; AHgh+RpGbNxjVRr4HCPdrv71W8lVF5+yGK3POtmqpKi/KgMmnIW9a+bIkRR1rkPb8v0K3rqOol2dKIC9ZOyEzgGGlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgyyJ/9sfVaC4i7ALuXYohXQsH+PP9bFxH0DlcNCRXXytngUD7
	1bjeKqa4ODu7LqTLYZTuotigVBckZccEb6okmyBFMBtiv6qPIoQLW0SwIPzOw+OPm6Fi0j8fHeH
	0FynZykwWiHc5dX0LlOStVJ04DyozcUWMzqdUVVgKH3dlzv7m3uqN9hNf8GRVM7JBdodS
X-Gm-Gg: AR+sD13E0HjCBhVpIUbv5kuHseeYjZwG7ZKKrtEaeJ6D4DNDZ194ZcUu2oj4LOJQXpS
	kFWNEv4seOhRgKC57csjbaaQ21Xo01CY/YLHZudvgpEl+L8pxZiwBcBUVDVTEJdx9Nux17eb27V
	8SvHg/B6qM0t5x9jgAu9itAlSX4vtYSUZ//pOsZdbFrWWr5EyVevxHsTWObfGW/R9WMVmoFyxQe
	ma5cSpW7nmEDh14gN4nuWo7tei5prT0K5I7FRDfBAHF+ApEtfTzSqYuSQlhg2tC+RkseS3H92l9
	8uD9P2Nnc3XaleZSOHtMmhtf1J9YDbdDSICHqV9RtqFDDrZ9Un3TACdVNUk9woTee81GxssHs/p
	LAh1T6KQ1rr9ANGV/Zz3PhQ==
X-Received: by 2002:a05:6000:4305:b0:47f:77dc:60c6 with SMTP id ffacd0b85a97d-47fdd6ce493mr20563172f8f.1.1785774784349;
        Mon, 03 Aug 2026 09:33:04 -0700 (PDT)
X-Received: by 2002:a05:6000:4305:b0:47f:77dc:60c6 with SMTP id ffacd0b85a97d-47fdd6ce493mr20563094f8f.1.1785774783785;
        Mon, 03 Aug 2026 09:33:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41cf404sm33721390f8f.1.2026.08.03.09.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:33:03 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:33:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 12/13] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <20260803123200-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-13-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260803140721.1871678-13-shshitrit@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q31ydDEzlSVzmFK7tAjFueg3GW0eAun87Wh86KK97B4_1785774784
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2026 at 05:07:20PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
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
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 223 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 209 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7750447bbb34..236887c7976d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -32,6 +32,8 @@
>  #include <net/ip.h>
>  #include <uapi/linux/virtio_pci.h>
>  #include <uapi/linux/virtio_net_ff.h>
> +#include <linux/tcp.h>
> +#include <linux/udp.h>
>  #include <linux/xarray.h>
>  #include <linux/refcount.h>
>  #include <linux/unaligned.h>
> @@ -5864,6 +5866,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
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
> +	if (get_unaligned(&mask->source) &&
> +	    !check_mask_vs_cap(&mask->source, &cap->source,
> +			       sizeof(cap->source), partial_mask))
> +		return false;
> +
> +	if (get_unaligned(&mask->dest) &&
> +	    !check_mask_vs_cap(&mask->dest, &cap->dest,
> +			       sizeof(cap->dest), partial_mask))
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
> +	if (get_unaligned(&mask->source) &&
> +	    !check_mask_vs_cap(&mask->source, &cap->source,
> +			       sizeof(cap->source), partial_mask))
> +		return false;
> +
> +	if (get_unaligned(&mask->dest) &&
> +	    !check_mask_vs_cap(&mask->dest, &cap->dest,
> +			       sizeof(cap->dest), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -5881,11 +5929,47 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> +	/* mask/key may be unaligned; use memcpy */
> +	if (psrc_m) {
> +		memcpy(&mask->source, &psrc_m, sizeof(mask->source));
> +		memcpy(&key->source, &psrc_k, sizeof(key->source));
> +	}
> +	if (pdst_m) {
> +		memcpy(&mask->dest, &pdst_m, sizeof(mask->dest));
> +		memcpy(&key->dest, &pdst_k, sizeof(key->dest));
> +	}
> +}
> +
> +static void set_udp(struct udphdr *mask, struct udphdr *key,
> +		    __be16 psrc_m, __be16 psrc_k,
> +		    __be16 pdst_m, __be16 pdst_k)
> +{
> +	/* mask/key may be unaligned; use memcpy */
> +	if (psrc_m) {
> +		memcpy(&mask->source, &psrc_m, sizeof(mask->source));
> +		memcpy(&key->source, &psrc_k, sizeof(key->source));
> +	}
> +	if (pdst_m) {
> +		memcpy(&mask->dest, &pdst_m, sizeof(mask->dest));
> +		memcpy(&key->dest, &pdst_k, sizeof(key->dest));
> +	}
> +}
> +
>  static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  		      const struct ethtool_rx_flow_spec *fs)
>  {
> @@ -5927,12 +6011,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
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
> @@ -6067,6 +6165,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
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
> @@ -6119,6 +6221,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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

shouldn't we check this is within
ff_caps->selectors_per_classifier_limit ?


> @@ -6158,7 +6266,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>  
>  static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  			     u8 *key,
> -			     const struct ethtool_rx_flow_spec *fs)
> +			     const struct ethtool_rx_flow_spec *fs,
> +			     int num_hdrs)
>  {
>  	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> @@ -6170,27 +6279,99 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  		selector->length = sizeof(struct ipv6hdr);
>  
>  		/* exclude tclass, it's not exposed directly in struct ipv6hdr */
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
> @@ -6230,6 +6411,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	struct virtio_net_ff_selector *selector;
>  	struct virtnet_classifier *c;
>  	size_t classifier_size;
> +	size_t key_offset;
>  	int num_hdrs;
>  	u8 key_size;
>  	u8 *key;
> @@ -6262,11 +6444,24 @@ static int build_and_insert(struct virtnet_ff *ff,
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
> 2.49.0

