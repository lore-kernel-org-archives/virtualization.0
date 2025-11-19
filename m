Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E75366DA0
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566078; cv=none; b=YO8Nv1uJEiaCRphrafpxokiF7/qwFWvW/7oddQlUPhMkxCfsqty4iL49iQmB66ZGupsX6tdDmUttlYSEtTLaWLN5YV7bFevCeVbk4ngALIaXcG0CudZ7UapoS2GwFOeTq6cZ69jBPGcnzbVHLHbHOTm9iGG1kCjwsvMW64iNajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566078; c=relaxed/simple;
	bh=2AHtk/lQXbNZZpPx6nfAIJ2au2S7m30j106Z1+vqVM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=obTaSzGm1cs3/pRq/YQHHZro6Ofa6v6NHHDNr5O+GOVxQEoiemmXiJ0qqAYs6gu/mtFLJiy/G7DHk09as/wiwlPnCM6Fj+DcbZupd+krzv+5KAb48FjZX24QYvsYbYemyLbB7pPtfmJ0JQJ7+Y8AXn89764yYDLKfTkBfoNjnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8P9DelU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8P9DelU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763566075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eHlhvFLfyKP0IuFGERbeyuWea/xjnUWPpjGJ0qsZJv4=;
	b=O8P9DelUEUVe/ZPwFA15GwCudvZFaDp/QdfgXlUnHgdISFx20DRpG4iEyLU5bIeyaosLVT
	J9hFsMnyGPPV+hrs9n3VXSOD0+aPkHBj/yB5NHUrpKBDAlpgvv3M0pCiPKOtWSrGhaQ0Q5
	Fyt2imVQpDUTepLYky1I0f8V3UdvYM8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-UEIJCBvLNWuC4fpThhnD7w-1; Wed, 19 Nov 2025 10:27:52 -0500
X-MC-Unique: UEIJCBvLNWuC4fpThhnD7w-1
X-Mimecast-MFC-AGG-ID: UEIJCBvLNWuC4fpThhnD7w_1763566071
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47775585257so52495045e9.1
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763566071; x=1764170871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHlhvFLfyKP0IuFGERbeyuWea/xjnUWPpjGJ0qsZJv4=;
        b=jFU2/UUWN9M2wrPQP2NuaivaqOySwEhZDQOWgNzbV1t8QndRMyyvaz071aQ0qiYpJ3
         m7v0jSE3fg7VXjyOgfGcjukbO1V9poRBlWcefJiGnEDucWnyIIw5CxTkFEpoA/uQJ412
         44UgCrIvvsdudNpugCDYscXcvYAWx5UThsU24tyAENDh/CJvIom1lPvNHpH7FTZyFHed
         LHtByp9gtMMC2Ex/9+havbmnDxgUy5PY2ibFiZPWQ6o1NQAC6HWAe14rFKKeypJriPwK
         j75UW+HgJWlGhLuqb5A/tIfrkKJXWia2sL5aVn/h4XPV0BQzsQMrN4q244B1Kf3l+2Z5
         fymQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMIkV346JbhB0OGUxp3X+CA3BvU2jgm/x0871kCAy+oKv6RLrh1F7Q0ubrylQ35XzGcRGa6MElqCNdv2FiHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpPszL2hb/k6z0oBIBRXV+HWefdTX+K/aobO2KOmL9D9/qVY3e
	Xm5BoU5CAouVU+fr55uhpVAYDbnX5YaoY8I93ohHgZIKVuNDvGNXGwunPeTJqp/qePkEFthRMoQ
	Ioo9x8LAUaiJkiUy9xbT8KvXeVnGHflvRiSPPVBk5CDBiD8fRfpPcDwVKNHfS2RO0PIBa
X-Gm-Gg: ASbGnctWoYCY14CapN4WQryltkpeyUAnHx07Jn+1fKZ+NfeB5JkZElrooTv8njh6jND
	hbFobOGC70Tn7+l7msyANHTLhNENY79Oj4kmMAjhHOpg1+k/1TEoS2qXq24/leqSN3gwG4aJmO3
	oomZn9tMAC7s8FgKF+S0vgyblAWiUdEeHP1ITRk/9f0Y2d/oaOP0/wlwBnSefeUof/qR6JO91cw
	/6XkaIl5dFu5MriSa2q/ssAHCQlscpahm2SILQhdBJmcjFb9pRzNNn7H8BO4Lo0vNaY49OiBKMG
	8r7JVTuhK4bb6Rf0oe3MfgNOQkTyA9l3+QSjDR8zJRu7SYXtFFEhRMKApEFliUSPMXowz/Cqkeb
	bUH/sHwf9FGc99HkXjrcpYzypsbqaUA==
X-Received: by 2002:a05:600c:4995:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-47796713b41mr111156685e9.35.1763566070984;
        Wed, 19 Nov 2025 07:27:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCuJHBRec3mpLMUz50uZ6t1pbpsWtDxU16tpLG7QVSudm09TacV9uCNP3CKm0YHndmXcfHlg==
X-Received: by 2002:a05:600c:4995:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-47796713b41mr111156385e9.35.1763566070324;
        Wed, 19 Nov 2025 07:27:50 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477afb54774sm26915625e9.3.2025.11.19.07.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:27:49 -0800 (PST)
Date: Wed, 19 Nov 2025 10:27:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v6 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251119102708-mutt-send-email-mst@kernel.org>
References: <20251119055522.617-1-xuanzhuo@linux.alibaba.com>
 <20251119055522.617-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119055522.617-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y7iz8K-KK0GODR3pjXBMhflLAfM2Lort7sA3IrxDS98_1763566071
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:55:21PM +0800, Xuan Zhuo wrote:
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
> 
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
> 
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.
> 
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/tun_vnet.h     |  2 +-
>  drivers/net/virtio_net.c   |  8 ++++--
>  include/linux/virtio_net.h | 58 ++++++++++++++++++++++++++++++--------
>  3 files changed, 54 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 81662328b2c7..b06aa6f2aade 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>  					tun_vnet_is_little_endian(flags),
> -					vlan_hlen)) {
> +					false, vlan_hlen)) {
>  		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0369dda5ed60..a62acfaf631b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3317,9 +3317,12 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	struct virtio_net_hdr_v1_hash_tunnel *hdr;
> -	int num_sg;
>  	unsigned hdr_len = vi->hdr_len;
> +	bool guest_hdrlen;
>  	bool can_push;
> +	int num_sg;
> +
> +	guest_hdrlen = virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_HDRLEN);
>  
>  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>  
> @@ -3339,7 +3342,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> -					virtio_is_little_endian(vi->vdev), 0))
> +					virtio_is_little_endian(vi->vdev),
> +					guest_hdrlen, 0))
>  		return -EPROTO;
>  
>  	if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b673c31569f3..ee960ec9a35e 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -207,20 +207,40 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
>  }
>  
> -static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> -					  struct virtio_net_hdr *hdr,
> -					  bool little_endian,
> -					  bool has_data_valid,
> -					  int vlan_hlen)
> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> +					 struct virtio_net_hdr *hdr,
> +					 bool little_endian,
> +					 bool guest_hdrlen)
> +{
> +	u16 hdr_len;
> +
> +	if (guest_hdrlen) {
> +		hdr_len = skb_transport_offset(skb);
> +
> +		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +			hdr_len += sizeof(struct udphdr);
> +		else
> +			hdr_len += tcp_hdrlen(skb);
> +	} else {
> +		/* This is a hint as to how much should be linear. */
> +		hdr_len = skb_headlen(skb);
> +	}
> +
> +	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
> +}


So this adds code that is broken for tunnels, then the follow up patch
fixes it up. I don't feel it's worth it, just squash the two patches
together please.


> +
> +static inline int __virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +					    struct virtio_net_hdr *hdr,
> +					    bool little_endian,
> +					    bool has_data_valid,
> +					    bool guest_hdrlen,
> +					    int vlan_hlen)
>  {
>  	memset(hdr, 0, sizeof(*hdr));   /* no info leak */
>  
>  	if (skb_is_gso(skb)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> -		/* This is a hint as to how much should be linear. */
> -		hdr->hdr_len = __cpu_to_virtio16(little_endian,
> -						 skb_headlen(skb));
>  		hdr->gso_size = __cpu_to_virtio16(little_endian,
>  						  sinfo->gso_size);
>  		if (sinfo->gso_type & SKB_GSO_TCPV4)
> @@ -231,6 +251,10 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
>  		else
>  			return -EINVAL;
> +
> +		virtio_net_set_hdrlen(skb, hdr, little_endian,
> +				      guest_hdrlen);
> +
>  		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>  			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
>  	} else
> @@ -250,6 +274,16 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +					  struct virtio_net_hdr *hdr,
> +					  bool little_endian,
> +					  bool has_data_valid,
> +					  int vlan_hlen)
> +{
> +	return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +					 has_data_valid, false, vlan_hlen);
> +}
> +
>  static inline unsigned int virtio_l3min(bool is_ipv6)
>  {
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> @@ -384,6 +418,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
>  			    bool tnl_hdr_negotiated,
>  			    bool little_endian,
> +			    bool guest_hdrlen,
>  			    int vlan_hlen)
>  {
>  	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
> @@ -394,8 +429,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
>  						    SKB_GSO_UDP_TUNNEL_CSUM);
>  	if (!tnl_gso_type)
> -		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> -					       vlan_hlen);
> +		return __virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> +						 guest_hdrlen, vlan_hlen);
>  
>  	/* Tunnel support not negotiated but skb ask for it. */
>  	if (!tnl_hdr_negotiated)
> @@ -408,7 +443,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  
>  	/* Let the basic parsing deal with plain GSO features. */
>  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
> -	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
> +	ret = __virtio_net_hdr_from_skb(skb, hdr, true, false,
> +					guest_hdrlen, vlan_hlen);
>  	skb_shinfo(skb)->gso_type |= tnl_gso_type;
>  	if (ret)
>  		return ret;
> -- 
> 2.32.0.3.g01195cf9f

