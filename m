Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF113E5592
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 05:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790054067; cv=none; b=FmbnZfHZoJ0Z5duWAp0ZsbDTP+jCcalglwoXRsi8JrtO9Kxc1KuHSPu3bcCrH3Am5jIPu5LC/8lXbR/iySWONkE+Ju9sBWtt8jPX5pWmrdZ0Y9cAv/UWznAy1e9Ek0LDRQeUNEf/ngD5KebjcCUs0AnYpzilrU0gW0CcI12ZioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790054067; c=relaxed/simple;
	bh=IBYRew1Gn48H8EoC95eYc4QBC6GNCUPpYyi1xN1JZ9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UhNsgHAlV2P24aodcRW5yst2ZC/m15a7Xvxc/v12cFC++c64RGVyqVz4olHGKClE0fgFCbuTVZEiAZczWZuiixDFSi+FWjt5LbHweEGY5kTxBMOuinPZHHHhw2mQWtPU2zxWSSkqeS9mweI4exHRktFTyKAUu5vsWTt9baCSg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8gtN8Re; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8gtN8Re"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790054064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDZXXeuKgG9CJWcBMoYi7yy1cHyV/TKd01LFuIMC9Mg=;
	b=A8gtN8Rek6V3sq5Wyo4/uOMuMY7g0wSwoiEVgkpqa9oh9xjrB5YkwIRZkJ1ENLCmE+LG1O
	y9JHgeLMtz2PYLqMHz1wtRShsFMf9MrmBVN6DIL+nLtKR15Hz6FgBEn9ZnYxh3rNita9/0
	zqs5n+bvBQZ6lMTU3y/njBZUSTSAC5E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-lFY_UwiFOXaCf6b3Bu2sVA-1; Tue, 22 Sep 2026 01:14:22 -0400
X-MC-Unique: lFY_UwiFOXaCf6b3Bu2sVA-1
X-Mimecast-MFC-AGG-ID: lFY_UwiFOXaCf6b3Bu2sVA_1790054061
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso27319585e9.2
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 22:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790054061; x=1790658861;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDZXXeuKgG9CJWcBMoYi7yy1cHyV/TKd01LFuIMC9Mg=;
        b=H+64Rsh05Kq69nYVhWeAa1IscPZ1VHXIvXgz1H1CJ3RkoFOJKQ7h27uYDyNhgbRzF5
         +vLnWv3RL6oAbOANyVfQ3s/MfiWAdUI+LKieNPz0pSN7DXODScI3CwFrNxz7srs/x7sL
         +I9h881hydUY7XIpYcWnoxx7jYZlRQTPfi4N8N7Ck9XnFCht0Jk7RT6UyYcrgWhAz3vA
         1sLktqRrsOlDUffb3/2eb82dcXhYwBN0waeI4BYFlpOQHgXPReEJupXIieCYuO4MMp6z
         gqTatmbnHOKvTSg9jYWUo2f+v5gu/h7ZwTeNFb6JM2igNk/xioL0/8OH4IotZacOiuEe
         sd8A==
X-Forwarded-Encrypted: i=1; AKwUvBz2W3ZJnu5P1lB1FUna/WSjjhIGfL4dTbxe/wdCqHCckN3WnSiRexDaqm0ANRkbSFd9XmjK5V2e5sIG3s/B0g==@lists.linux.dev
X-Gm-Message-State: AFuF++m5fiWnOFwM5YBE8EytCMgF0jxGT3KFQFd2DZoO10/Dthz5MsQa
	X6gtkLY08g+ANrXCtkBGv3yXlryknDmaWymcE4hnPIJngRw0E0whhTN3YKnNBSE4OIkHJn/oOKH
	dg2flCZ0yfZyXbsN+w4UGqvAPblcZlv/V9JkvvAjyfplSPFy5Uf2y0T7bg3SPvgBSGUnM
X-Gm-Gg: AYBFou07GgbSv4nC8+fxCykoGrsmXxLCIn2LezGZM4jp8+o2cyb7tebluUKNWAJ+edx
	Ojirg0ur4ZNnFS1GSQ38P98TttJ36Zi7HbO7cw9NMTcbHVdqnecpgcmzU1pswJxKIgnflyB7QMC
	KTa1+zXKVWqxD6TI97u6+k9n0UmnZSQlk7MtsOgTNbn2NTiiQFHJSYJb9AFSnKifsqEVOvs9VD7
	zvWQ6gGMwWXFAkHgvVrbrMOxR4905hu088IjnOqHEDpGo96FJNKHjYlX0lxT9+tbFE8BeNKgmet
	OFFrh6cCXDcyUDhrkyLmlidAQ87cmr3+JqdnOBugUkS6e8/ol88uAFK/MPsr/c2J6P3Tn2pHhT1
	vgvhCRnBRcyTAJmPqAc8Tfy4=
X-Received: by 2002:a05:600c:548a:b0:49f:ce73:7ab with SMTP id 5b1f17b1804b1-49fce730859mr121568585e9.34.1790054061368;
        Mon, 21 Sep 2026 22:14:21 -0700 (PDT)
X-Received: by 2002:a05:600c:548a:b0:49f:ce73:7ab with SMTP id 5b1f17b1804b1-49fce730859mr121568235e9.34.1790054060859;
        Mon, 21 Sep 2026 22:14:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8cd5214sm49916415e9.9.2026.09.21.22.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:14:20 -0700 (PDT)
Date: Tue, 22 Sep 2026 01:14:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paulos Yibelo <habte.yibelo@gmail.com>
Cc: netdev@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
	pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, razor@blackwall.org,
	idosch@nvidia.com, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-um@lists.infradead.org,
	virtualization@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
Message-ID: <20260922005353-mutt-send-email-mst@kernel.org>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260922030310.8684-2-habte.yibelo@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GNFbV0mYkxIvwf8npuSasMRmG9pulRODXuPL_p7ABlY_1790054061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2026 at 11:03:09PM -0400, Paulos Yibelo wrote:
> __virtio_net_hdr_to_skb() checks a minimum network-header length for
> CHECKSUM_PARTIAL packets. Its checksum start is relative to skb->data,
> but some callers have not established skb->network_header when they
> convert the virtio header.
> 
> Pass the data-relative L3 origin explicitly. Ethernet receive paths
> parse the frame and nested VLAN headers without changing skb state.
> AF_PACKET uses the frame's actual L3 origin even when the socket
> protocol is ETH_P_IP and the raw frame carries VLAN tags. Non-Ethernet
> AF_PACKET devices retain their established skb network offset.
> 
> Also pass the actual L3 protocol so IPv6 packets use the 40-byte base
> header minimum even without TCPv6 GSO. IFF_TUN obtains that protocol
> from the packet before skb->protocol is set. Name the Ethernet parser
> accordingly, use the same origin for tunnel validation, and propagate
> conversion failures in UML.
> 
> The bound remains a minimum; fragmentation paths separately validate
> the parsed IPv4 or IPv6 header length before completing a checksum.
> 
> Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_net_hdr_to_skb()")
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Link: https://lore.kernel.org/netdev/20260920004733.6473-2-habte.yibelo@gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>


Wow i just asked some questions, and it's getting more and more complex.
I am not sure people have time to review at this pace.


> ---
>  arch/um/drivers/vector_transports.c | 13 ++++-
>  drivers/net/tun_vnet.h              | 52 ++++++++++++++++-
>  drivers/net/virtio_net.c            | 10 +++-
>  include/linux/virtio_net.h          | 87 ++++++++++++++++++++++++-----
>  net/packet/af_packet.c              | 24 +++++++-
>  5 files changed, 163 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index ddd127ee9..5a9d8f49a 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -197,6 +197,8 @@ static int raw_verify_header(
>  	uint8_t *header, struct sk_buff *skb, struct vector_private *vp)
>  {
>  	struct virtio_net_hdr *vheader = (struct virtio_net_hdr *) header;
> +	__be16 network_protocol;
> +	int network_offset;
>  
>  	if ((vheader->gso_type != VIRTIO_NET_HDR_GSO_NONE) &&
>  		(vp->req_size != 65536)) {
> @@ -209,8 +211,14 @@ static int raw_verify_header(
>  	if ((vheader->flags & VIRTIO_NET_HDR_F_DATA_VALID) > 0)
>  		return 1;
>  
> -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> -	return 0;
> +	network_offset = virtio_net_hdr_eth_get_l3_offset(skb, vheader,
> +							  &network_protocol);
> +	if (network_offset < 0)
> +		return network_offset;
> +
> +	return virtio_net_hdr_to_skb(skb, vheader,
> +				     virtio_legacy_is_little_endian(),
> +				     network_offset, network_protocol);
>  }
>  
>  static bool get_uint_param(
> @@ -491,4 +499,3 @@ int build_transport_data(struct vector_private *vp)
>  		return build_bess_transport_data(vp);
>  	return 0;
>  }
> -
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index f4c652b1f..e004213fa 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -177,10 +177,49 @@ static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>  	return __tun_vnet_hdr_put(sz, 0, iter, hdr);
>  }
>  
> +static inline int
> +tun_vnet_hdr_get_l3_offset(unsigned int flags, const struct sk_buff *skb,
> +			   const struct virtio_net_hdr *hdr,
> +			   __be16 *network_protocol)
> +{
> +	if ((flags & TUN_TYPE_MASK) != IFF_TAP) {
> +		u8 version, first_byte;
> +		const u8 *first;
> +
> +		*network_protocol = 0;
> +		if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> +			return 0;
> +
> +		first = skb_header_pointer(skb, 0, sizeof(first_byte),
> +					   &first_byte);
> +		if (!first)
> +			return -EINVAL;
> +
> +		version = *first >> 4;
> +		if (version == 4)
> +			*network_protocol = htons(ETH_P_IP);
> +		else if (version == 6)
> +			*network_protocol = htons(ETH_P_IPV6);
> +		return 0;
> +	}
> +
> +	return virtio_net_hdr_eth_get_l3_offset(skb, hdr,
> +					      network_protocol);
> +}
> +
>  static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
>  				      const struct virtio_net_hdr *hdr)
>  {
> -	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
> +	__be16 network_protocol;
> +	int network_offset = tun_vnet_hdr_get_l3_offset(flags, skb, hdr,
> +						       &network_protocol);
> +
> +	if (network_offset < 0)
> +		return network_offset;
> +
> +	return virtio_net_hdr_to_skb(skb, hdr,
> +				     tun_vnet_is_little_endian(flags),
> +				     network_offset, network_protocol);
>  }
>  
>  /*
> @@ -199,10 +238,19 @@ tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
>  			struct sk_buff *skb,
>  			const struct virtio_net_hdr_v1_hash_tunnel *hdr)
>  {
> +	const struct virtio_net_hdr *vnet_hdr = (const struct virtio_net_hdr *)hdr;
> +	__be16 network_protocol;
> +	int network_offset = tun_vnet_hdr_get_l3_offset(flags, skb, vnet_hdr,
> +						       &network_protocol);
> +
> +	if (network_offset < 0)
> +		return network_offset;
> +
>  	return virtio_net_hdr_tnl_to_skb(skb, hdr,
>  				features & NETIF_F_GSO_UDP_TUNNEL,
>  				features & NETIF_F_GSO_UDP_TUNNEL_CSUM,
> -				tun_vnet_is_little_endian(flags));
> +				tun_vnet_is_little_endian(flags),
> +				network_offset, network_protocol);
>  }
>  
>  static inline int tun_vnet_hdr_from_skb(unsigned int flags,
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d05..8e93dad28 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2502,6 +2502,8 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
>  {
>  	struct virtio_net_common_hdr *hdr;
>  	struct net_device *dev = vi->dev;
> +	__be16 network_protocol;
> +	int network_offset;
>  
>  	hdr = skb_vnet_common_hdr(skb);
>  	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> @@ -2515,9 +2517,13 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
>  		goto frame_err;
>  	}
>  
> -	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> +	network_offset = virtio_net_hdr_eth_get_l3_offset(skb, &hdr->hdr,
> +							  &network_protocol);
> +	if (network_offset < 0 ||
> +	    virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
>  				      vi->rx_tnl_csum,
> -				      virtio_is_little_endian(vi->vdev))) {
> +				      virtio_is_little_endian(vi->vdev),
> +				      network_offset, network_protocol)) {
>  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
>  				     dev->name, hdr->hdr.gso_type,
>  				     hdr->hdr.gso_size, hdr->hdr.flags,
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index c381b916c..b89d821a0 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -48,16 +48,61 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +/*
> + * Return the L3 offset and protocol of an Ethernet frame starting at skb->data.
> + * The offset is unused without NEEDS_CSUM, so avoid parsing and return zero.
> + */

for networking code multiline comments:

/* always
 * look like this
 */

/*
 * never
 * like this
 */


> +static inline int
> +virtio_net_hdr_eth_get_l3_offset(const struct sk_buff *skb,
> +				 const struct virtio_net_hdr *hdr,
> +				 __be16 *network_protocol)
> +{
> +	unsigned int parse_depth = VLAN_MAX_DEPTH;
> +	const struct ethhdr *eth;
> +	struct ethhdr ethbuf;
> +	__be16 protocol;
> +	int depth = ETH_HLEN;
> +
> +	*network_protocol = 0;
> +	if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> +		return 0;
> +
> +	eth = skb_header_pointer(skb, 0, sizeof(ethbuf), &ethbuf);
> +	if (!eth)
> +		return -EINVAL;
> +
> +	protocol = eth->h_proto;
> +	while (eth_type_vlan(protocol)) {
> +		const struct vlan_hdr *vh;
> +		struct vlan_hdr vhdr;
> +
> +		vh = skb_header_pointer(skb, depth, sizeof(vhdr), &vhdr);
> +		if (!vh || !--parse_depth)
> +			return -EINVAL;
> +
> +		protocol = vh->h_vlan_encapsulated_proto;
> +		depth += VLAN_HLEN;
> +	}
> +
> +	*network_protocol = protocol;
> +	return depth;
> +}
> +
>  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					  const struct virtio_net_hdr *hdr,
> -					  bool little_endian, u8 hdr_gso_type)
> +					  bool little_endian, u8 hdr_gso_type,
> +					  int network_offset,
> +					  __be16 network_protocol)
>  {
> -	unsigned int nh_min_len = sizeof(struct iphdr);
> +	int nh_min_len = sizeof(struct iphdr);
>  	unsigned int gso_type = 0;
>  	unsigned int thlen = 0;
>  	unsigned int p_off = 0;
>  	unsigned int ip_proto;
>  
> +	if (network_protocol == htons(ETH_P_IPV6))
> +		nh_min_len = sizeof(struct ipv6hdr);

I'd prefer this inside the initializer:
unsigned int nh_min_len = (network_protocol == htons(ETH_P_IPV6))?
	sizeof(struct ipv6hdr) : sizeof(struct iphdr);

> +
>  	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
>  		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
>  		case VIRTIO_NET_HDR_GSO_TCPV4:
> @@ -98,16 +143,20 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
>  		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
>  		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
> +		int transport_offset;
>  
>  		if (!pskb_may_pull(skb, needed))
>  			return -EINVAL;
>  
>  		if (!skb_partial_csum_set(skb, start, off))
>  			return -EINVAL;
> -		if (skb_transport_offset(skb) < nh_min_len)
> +
> +		transport_offset = skb_transport_offset(skb);
> +		if (transport_offset < nh_min_len || network_offset < 0 ||
> +		    network_offset > transport_offset - nh_min_len)
>  			return -EINVAL;
>  
> -		nh_min_len = skb_transport_offset(skb);
> +		nh_min_len = transport_offset;
>  		p_off = nh_min_len + thlen;
>  		if (!pskb_may_pull(skb, p_off))
>  			return -EINVAL;
> @@ -206,9 +255,12 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  
>  static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					const struct virtio_net_hdr *hdr,
> -					bool little_endian)
> +					bool little_endian,
> +					int network_offset,
> +					__be16 network_protocol)


From API POV, what is network_protocol here, exactly? I suspect it is
really af packet with IP protocol specific? So maybe it's really min_hdr
and then everyone except AF_PACKET can just pass 0? or do I
misunderstand?

>  {
> -	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
> +	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type,
> +				       network_offset, network_protocol);
>  }
>  
>  /* This function must be called after virtio_net_hdr_from_skb(). */
> @@ -287,7 +339,7 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  	return 0;
>  }
>  
> -static inline unsigned int virtio_l3min(bool is_ipv6)
> +static inline int virtio_l3min(bool is_ipv6)
>  {
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
> @@ -297,18 +349,20 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
>  			  bool tnl_hdr_negotiated,
>  			  bool tnl_csum_negotiated,
> -			  bool little_endian)
> +			  bool little_endian, int network_offset,
> +			  __be16 network_protocol)
>  {
>  	const struct virtio_net_hdr *hdr = (const struct virtio_net_hdr *)vhdr;
> -	unsigned int inner_nh, outer_th, inner_th;
> -	unsigned int inner_l3min, outer_l3min;
>  	u8 gso_inner_type, gso_tunnel_type;
>  	bool outer_isv6, inner_isv6;
> +	int inner_nh, outer_th, inner_th;
> +	int inner_l3min, outer_l3min;
>  	int ret;
>  
>  	gso_tunnel_type = hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL;
>  	if (!gso_tunnel_type)
> -		return virtio_net_hdr_to_skb(skb, hdr, little_endian);
> +		return virtio_net_hdr_to_skb(skb, hdr, little_endian,
> +					     network_offset, network_protocol);
>  
>  	/* Tunnel not supported/negotiated, but the hdr asks for it. */
>  	if (!tnl_hdr_negotiated)
> @@ -332,19 +386,24 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	outer_isv6 = gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
>  	inner_isv6 = gso_inner_type == VIRTIO_NET_HDR_GSO_TCPV6;
>  	inner_l3min = virtio_l3min(inner_isv6);
> -	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
> +	outer_l3min = virtio_l3min(outer_isv6);
> +	if (network_protocol == htons(ETH_P_IPV6))
> +		outer_l3min = sizeof(struct ipv6hdr);

So I vaguely understand that "network_protocol" is something af_packet
specific? because we already have inner_isv6 and outer_isv6
so this is neither? or do I misunderstand?


>  	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
>  	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
>  	outer_th = le16_to_cpu(vhdr->outer_th_offset);
> -	if (outer_th < outer_l3min ||
> +	if (network_offset < 0 ||
> +	    outer_th < outer_l3min ||
> +	    network_offset > outer_th - outer_l3min ||
>  	    inner_nh < outer_th + sizeof(struct udphdr) ||
>  	    inner_th < inner_nh + inner_l3min)
>  		return -EINVAL;
>  
>  	/* Let the basic parsing deal with plain GSO features. */
>  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
> -				      hdr->gso_type & ~gso_tunnel_type);
> +				      hdr->gso_type & ~gso_tunnel_type,
> +				      network_offset, network_protocol);
>  	if (ret)
>  		return ret;
>  
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 50cae32ae..0b37d5474 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2550,6 +2550,26 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
>  	sock_wfree(skb);
>  }
>  
> +static int packet_vnet_hdr_to_skb(struct sk_buff *skb,
> +				  const struct virtio_net_hdr *vnet_hdr)
> +{
> +	__be16 network_protocol = 0;
> +	int network_offset;
> +
> +	if (skb->dev->type == ARPHRD_ETHER) {
> +		network_offset = virtio_net_hdr_eth_get_l3_offset(skb, vnet_hdr,
> +								  &network_protocol);
> +	} else {
> +		network_offset = skb_network_offset(skb);
> +		network_protocol = skb->protocol;
> +	}
> +	if (network_offset < 0)
> +		return network_offset;
> +
> +	return virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le(),
> +				     network_offset, network_protocol);
> +}
> +
>  static int __packet_snd_vnet_parse(struct virtio_net_hdr *vnet_hdr, size_t len)
>  {
>  	if ((vnet_hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> @@ -2901,7 +2921,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  		}
>  
>  		if (has_vnet_hdr) {
> -			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
> +			if (packet_vnet_hdr_to_skb(skb, &vnet_hdr)) {
>  				tp_len = -EINVAL;
>  				goto tpacket_error;
>  			}
> @@ -3103,7 +3123,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  	packet_parse_headers(skb, sock);
>  
>  	if (vnet_hdr_sz) {
> -		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
> +		err = packet_vnet_hdr_to_skb(skb, &vnet_hdr);
>  		if (err)
>  			goto out_free;
>  		len += vnet_hdr_sz;
> 
> base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
> -- 
> 2.46.0

