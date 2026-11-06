Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961549;
	b=mu8LJeemiHX9pFmclIvbazeclb9tc4wToj4t7GS+bzqDuO0AfDPKLtoqWHcwLvXkZ5Um
	 mgAno8AV3MGygtLZ0xH1iU1rOc5jdpkMyqouBDR6wCkEh1B6acHuUaiuUdmvqTfxr2V4u
	 kQTuY3JZUkbiOeD1mL1HNGkIZHPsStV6/o8TOQkSJDGMd9o0MTZcAhKrInYca1fH648U4
	 FneEJStxf7O6/x1rgGFIPCYu1FF51w5uDhWnM6GzC2l2yPema7OaTBfLtHSIYZ3MYaJBF
	 x7JSyNbMGSEY16eMvev9xEQmpbyilQ4QkJ3xsykz8OMI0Ra7F0gxp4xt/mX4npTYU0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961549;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=9xz2U+0Ol33gwn3MzV6oM8nP+N+ErAKgSBrkFeTy0pc=;
	b=k2kxZTIBBtlU9tWVXBUoP96qzGd9a4BVc3FtTzR2VPjC/sTl8z2bV3qypk3kmwB2sWuu
	 7edyAu1Zzcx+bsBPU09JqFpeM+TaVK1f2l+vbzsg5V5nl5Br3fontUGetUKi8lGIsrbF3
	 jaxysh6UvjQhSkpXS1QYtudIRuchM4xwIawsPvYv6xwIsusRJiLkAYzlqlth5VOkBPryU
	 daVj6fVgHIYvOoXvCCtPa0XEtANIyx68dCjNYvW7lLB/MiOA9IcJMaummWVCSDA++4Isq
	 BYbW9PX97s6xw1ZwEQvUbpjC1RQ5NmKdDpiw5gROzBZ+AFj18Q49HS/GzyYj6rI0oaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cfvhnqyl;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B850606A32F
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 10:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B850606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cfvhnqyl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793961547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9xz2U+0Ol33gwn3MzV6oM8nP+N+ErAKgSBrkFeTy0pc=;
	b=CfvhnqyllLD9Ytb2UTJhCKfVBlVuTB3Z4xrdDRCw4KNnzqn8PKVg9POCRQtTggGfiFIUrc
	lG1XLwTu7hlt06cZVudLn0ciJ7Z/kcw4HzRiJTBMI6MhLwtYJR95CeC3viyBtPwl5OJWC2
	WOQ3Gk4ZUIZojRGpeMLq0JWonVz9TaM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-lq5luibHPoKQpYXpaaE-bQ-1; Fri, 06 Nov 2026 05:39:05 -0500
X-MC-Unique: lq5luibHPoKQpYXpaaE-bQ-1
X-Mimecast-MFC-AGG-ID: lq5luibHPoKQpYXpaaE-bQ_1793961544
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-490c69dc02bso459588f8f.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 02:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961544; x=1794566344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xz2U+0Ol33gwn3MzV6oM8nP+N+ErAKgSBrkFeTy0pc=;
        b=DHXukgSHQ+v1MSfTF6XsmKHwa6C83awrgzfotL5hvKbXXNJyMm9c540/loTeBSLtbP
         BeXNwuibGonF4J8NpYE6qMxMSaseTa3wgF/zRybPGHkAqr2Zr5U/Tm8plLB2K8NwOkcL
         EjxppG3VZivpWu8hlxXboJ/brt4Z0RPBW+NXgWJ/IkWk4TCvTvFk49EZfMxvNCUEPdWU
         VcA9lVzvLH5pOuEOTUStfsYl4CrAJMhM27iF5ySJK5Jhaq7TeThiv9/T78hU51wDIZw8
         qpqVgUqludA5t9gFxhwWmmZJK8jY7uHbNgbMRICp6sla26ZOteQ7Y2q4HdaCIpOAOOfi
         /vEA==
X-Forwarded-Encrypted: i=1; AL+hErG5A/VU90I6NyVRMYxR0c+Qg+0N0b98VGmy80E15tDCzsp+2T+jSYbGKVZO70NDUt1zrTrdASgOiaPZL0lZEg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8DWlJh0dHrfUrKIf5YivEMTH4F+ECH1tTePIheqBQ1dMzREd5X
	M1h7qpLNmLwH28KafodPiwgbP/LEx4l5uzYNx1nqc080CeWYOlZwpM5RMNeKVDy1434blV8Kkbb
	zA7xvOwKXdoQA9rZTq3YtKZVMckzZTEejEPRlvzOqc2oEMLYm6nG+zICmUVGxSfdi3iN9
X-Gm-Gg: AYBFou1TbXlQV5+vt65mgwCBbec+qOkXMmzvfuJlQA1nBFQu75FWqbSx8qM3sTLoUGg
	WtfiihYN7P6eodkwqvt4+L+0jgVoq+yjVsZes6rgqRdPe138dIVw1a5LaeCAiW/JBiw/nbTsXc0
	bWMdmv75kqvuydDgHT8uqWlCyeZ9c41u2PYKieR44NnJZRFRLB1jjijevBPnHk5GfNh9R4D7FBL
	IggPiQyS6nzvpItBSaMrvzRbfSoc5VysMYtY2JFRhqWrWmujkgKgE2qnTfJFNbtN7Fer3I+2D9L
	ntt0bU3LiqET/gogJHexIkD73hnPFeSwq6bl/uZ5TIdnH3/8VHKZ31AtEJXsfwkQb93Tbet/qUL
	9/duTYeV0clnN7ykbynjkdtTglZ/jqkAnG49WshMHng==
X-Received: by 2002:a5d:5e86:0:b0:48f:ead0:631a with SMTP id ffacd0b85a97d-49277e91eb9mr4142085f8f.47.1793961543668;
        Fri, 06 Nov 2026 02:39:03 -0800 (PST)
X-Received: by 2002:a5d:5e86:0:b0:48f:ead0:631a with SMTP id ffacd0b85a97d-49277e91eb9mr4142020f8f.47.1793961542990;
        Fri, 06 Nov 2026 02:39:02 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1401:db00:7367:7b9e:e66f:2b7d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d3c6c056sm3158065f8f.4.2026.11.06.02.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 02:39:02 -0800 (PST)
Date: Fri, 6 Nov 2026 05:38:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 1/2] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
Message-ID: <20261106053849-mutt-send-email-mst@kernel.org>
References: <20261106095340.2113683-1-edumazet@kernel.org>
 <20261106095340.2113683-2-edumazet@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261106095340.2113683-2-edumazet@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MJ3pTTyks1SSsnTOMbXIgLy1smdRo5xh5996brOMDYk_1793961544
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2026 at 10:53:39AM +0100, Eric Dumazet wrote:
> virtio_net_hdr_tnl_to_skb() trusts the virtio header to describe a
> UDP tunnel over IPv4 or IPv6, but never checks that the frame actually
> carries such outer headers. Because VIRTIO_NET_HDR_F_NEEDS_CSUM is
> mandatory for tunnel GSO, __virtio_net_hdr_to_skb() skips the flow
> dissector, so virtio_net_hdr_match_proto() is never applied either.
> 
> A guest (or a tap writer) can then inject a frame with an arbitrary
> outer ethertype, for example ETH_P_NSH, with SKB_GSO_UDP_TUNNEL set.
> The GSO stack then runs nsh_gso_segment() on top of the UDP tunnel
> segmentation, which assumes a different header layout. The result is
> segments with skb->data before skb->head, and a host crash in
> skb_under_panic() as soon as a later layer pushes a header:
> 
>   skbuff: skb_under_panic: ... put:4 ... dev:gretap1
>   kernel BUG at net/core/skbuff.c:215!
>    skb_push
>    __gre_xmit
>    gre_tap_xmit
>    ...
>    tun_get_user
> 
> Validate the outer headers with the parsing helpers from Michael's
> series "net: resolve uncommon partial checksums at ingress":
> 
> - locate the L3 header: Ethernet with optional VLAN tags, or the
>   network header set by the caller. skb->protocol is not trusted when
>   it disagrees with the frame.
> - require the outer L3 protocol to match the declared tunnel type.
> - require the outer UDP header exactly at outer_th_offset, after IPv4
>   options or IPv6 extension headers, and reject fragments.
> 
> Unlike the original helpers:
> 
> - the callers tell whether the frame starts with an Ethernet header,
>   with a new has_eth argument of virtio_net_hdr_tnl_to_skb(), instead
>   of using the device type. tun frames packets from its IFF_TAP and
>   IFF_TUN flags, and TUNSETLINK can set the device type to any value.
>   virtio_net and tun_xdp_one() always pass true, tun_get_user() passes
>   whether the device is IFF_TAP.
> - ipv6_find_hdr() stops at an AH header, as Willem suggested in the
>   review of that series.
> 
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Reported-by: Hassan Sultan <hassansultan@google.com>
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Co-developed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tun.c          |   9 +-
>  drivers/net/tun_vnet.h     |   5 +-
>  drivers/net/virtio_net.c   |   2 +-
>  include/linux/virtio_net.h | 169 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 180 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e601..3920b3dff1e8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1944,7 +1944,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		break;
>  	}
>  
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> +	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
> +				    (tun->flags & TUN_TYPE_MASK) == IFF_TAP)) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		err = -EINVAL;
>  		goto free_skb;
> @@ -2621,7 +2622,11 @@ static int tun_xdp_one(struct tun_struct *tun,
>  	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
>  	skb->dev = tun->dev;
>  	skb_set_network_header(skb, ETH_HLEN);
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
> +	/* Frames always start with an Ethernet header here, as the
> +	 * eth_type_trans() call below expects.
> +	 */
> +	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr,
> +				    true)) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		kfree_skb(skb);
>  		ret = -EINVAL;
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index f4c652b1fa44..3364e08dd6e0 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -197,9 +197,10 @@ static inline netdev_features_t tun_vnet_hdr_guest_features(int vnet_hdr_sz)
>  static inline int
>  tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
>  			struct sk_buff *skb,
> -			const struct virtio_net_hdr_v1_hash_tunnel *hdr)
> +			const struct virtio_net_hdr_v1_hash_tunnel *hdr,
> +			bool has_eth)
>  {
> -	return virtio_net_hdr_tnl_to_skb(skb, hdr,
> +	return virtio_net_hdr_tnl_to_skb(skb, hdr, has_eth,
>  				features & NETIF_F_GSO_UDP_TUNNEL,
>  				features & NETIF_F_GSO_UDP_TUNNEL_CSUM,
>  				tun_vnet_is_little_endian(flags));
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd2c41ef6fbe..ed20e76fbc4c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2533,7 +2533,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
>  
>  	skb->dev = dev;
>  	skb_set_network_header(skb, ETH_HLEN);
> -	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> +	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, true, vi->rx_tnl,
>  				      vi->rx_tnl_csum,
>  				      virtio_is_little_endian(vi->vdev))) {
>  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd0..b7b6b542f476 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -5,7 +5,10 @@
>  #include <linux/if_vlan.h>
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
> +#include <linux/netdevice.h>
>  #include <linux/udp.h>
> +#include <net/ip.h>
> +#include <net/ipv6.h>
>  #include <net/tcp.h>
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>
> @@ -48,6 +51,145 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +/* TODO: nothing virtio specific here, move to ip.h */
> +
> +/*
> + * Pull and minimally validate the IPv4 header at @nhoff.
> + * Returns the header and stores the transport header offset in
> + * @thoff, or NULL if truncated or malformed.  The whole header,
> + * options included, is guaranteed linear on return.
> + */
> +static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> +						  unsigned int nhoff,
> +						  unsigned int *thoff)
> +{
> +	unsigned int ihl;
> +	struct iphdr *iph;
> +
> +	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
> +		return NULL;
> +
> +	iph = (struct iphdr *)(skb->data + nhoff);
> +	if (iph->version != 4 ||
> +	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
> +		return NULL;
> +
> +	ihl = iph->ihl * sizeof(u32);
> +	*thoff = nhoff + ihl;
> +	/* Pull the options as well: the transport header offset
> +	 * returned above must be within the linear data.  iph goes
> +	 * stale across the pull.
> +	 */
> +	if (!pskb_may_pull(skb, nhoff + ihl))
> +		return NULL;
> +
> +	return (struct iphdr *)(skb->data + nhoff);
> +}
> +
> +/* Where does the L3 header start, and what protocol is it?
> + * With @has_eth, the frame starts with an Ethernet header, possibly
> + * followed by VLAN tags. Otherwise the L3 header starts at the network
> + * header offset the caller set up.
> + *
> + * The caller knows how the frame will be parsed later: the device
> + * type does not tell, as tun can change it with TUNSETLINK.
> + */
> +static inline bool
> +virtio_net_l3_start(struct sk_buff *skb, bool has_eth, int *nhoff,
> +		    __be16 *proto)
> +{
> +	if (has_eth) {
> +		__be16 h_proto;
> +
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		h_proto = eth_hdr(skb)->h_proto;
> +		/* skb->protocol is a sender claim, and parts of the
> +		 * stack parse the packet per it: when it disagrees with
> +		 * the frame we do not know which view the packet will
> +		 * be parsed as, so do not validate.
> +		 */
> +		if (skb->protocol && skb->protocol != h_proto)
> +			return false;
> +		*nhoff = ETH_HLEN;
> +		*proto = h_proto;
> +		if (eth_type_vlan(*proto)) {
> +			*proto = __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}
> +	} else {
> +		const struct iphdr *iph;
> +
> +		*nhoff = skb_network_offset(skb);
> +		/* An unset network header shows up as an offset
> +		 * outside of the packet.
> +		 */
> +		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
> +			return false;
> +		/* No L2 header to cross-check with: take the protocol
> +		 * from the IP version at the network header.
> +		 */
> +		if (!pskb_may_pull(skb, *nhoff + 1))
> +			return false;
> +		iph = (const struct iphdr *)(skb->data + *nhoff);
> +		if (iph->version == 4)
> +			*proto = htons(ETH_P_IP);
> +		else if (iph->version == 6)
> +			*proto = htons(ETH_P_IPV6);
> +		else
> +			return false;
> +		if (skb->protocol && skb->protocol != *proto)
> +			return false;
> +	}
> +	return true;
> +}
> +
> +/* Walk the L3 header at @nhoff: where does its transport header
> + * start, and which protocol is it?  Returns false if the header
> + * is truncated, malformed or fragmented.
> + */
> +static inline bool
> +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> +		    unsigned int *thoff, int *ip_proto)
> +{
> +	if (proto == htons(ETH_P_IP)) {
> +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> +
> +		if (!iph || ip_is_fragment(iph))
> +			return false;
> +		*ip_proto = iph->protocol;
> +		return true;
> +	}
> +
> +	if (proto == htons(ETH_P_IPV6)) {
> +		const struct ipv6hdr *iph;
> +		int flags = IP6_FH_F_AUTH;
> +
> +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> +			return false;
> +		iph = (const void *)(skb->data + nhoff);
> +		if (iph->version != 6)
> +			return false;
> +		*thoff = nhoff + sizeof(*iph);
> +		*ip_proto = iph->nexthdr;
> +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> +			*thoff = nhoff;
> +			/* Find the transport header behind any
> +			 * extension headers. IP6_FH_F_AUTH stops
> +			 * the walk at AH, so frames with AH are rejected.
> +			 */
> +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> +						  &flags);
> +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> +				return false;
> +		}
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					  const struct virtio_net_hdr *hdr,
>  					  bool little_endian, u8 hdr_gso_type)
> @@ -282,9 +424,33 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
>  
> +/* Do the tunnel offsets match the outer headers in the frame?
> + * The L3 header the tunnel claims must be the one the frame
> + * carries, with UDP following it at @outer_th.
> + */
> +static inline bool
> +virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool has_eth, bool outer_isv6,
> +			  unsigned int outer_th)
> +{
> +	int nhoff;
> +	__be16 proto;
> +	unsigned int thoff;
> +	int ip_proto;
> +
> +	if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto))
> +		return false;
> +	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> +		return false;
> +	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> +		return false;
> +
> +	return ip_proto == IPPROTO_UDP && outer_th == thoff;
> +}
> +
>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> +			  bool has_eth,
>  			  bool tnl_hdr_negotiated,
>  			  bool tnl_csum_negotiated,
>  			  bool little_endian)
> @@ -338,6 +504,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	if (ret)
>  		return ret;
>  
> +	if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th))
> +		return -EINVAL;
> +
>  	/* In case of USO, the inner protocol is still unknown and
>  	 * `inner_isv6` is just a guess, additional parsing is needed.
>  	 * The previous validation ensures that accessing an ipv4 inner
> -- 
> 2.53.0

