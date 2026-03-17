Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7DD288530
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746964; cv=none; b=rNzLg4a31Gv+ORW/aAmTHdAZtHYPCSHetmk1jcYrudG9CXjFg1ZakAK3jGLM/qxNB9mOBVUUcoZIhAsguTFa+GZHFztioy/5lcnbqvXK7rUcR1vmVK74VHJC0JP9gSLpc81NiYL6b9Dt6NLnaP6l6/o0KclDPHqqCqAJTgPoYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746964; c=relaxed/simple;
	bh=4CSx9ZjbeRXfiJMtz5ON1cC5JPSin5oI4O9rPe/Ec7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvgWjkfQZCHiPXGBSZ9h42GCd1pC86xNTIEbFH5Q0nZONr8uPsIytquysgXN4Zl5/8K6iS5yfX+r6yJn0zp9Gryub+nMwHIS+VhEQ9Q2Ad5KGZIueAdCVzz+PDN1J7gVNsVLT7aW/M66sH1o/bwupJxT1RAzNYk7iU73YgLb3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiD4dPhS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiD4dPhS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773746962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFs80zw2O4/2NJrV7I0/zYaOrXH4RPoeh7BrpBnFPW0=;
	b=PiD4dPhSmic8eSbnKmpg6kHiBFhUA0GuO6qOkVD9BBzZfEUA+/azLwKZoNN2/2SneBFj3U
	ze8FfldDeWAGTkS5b1vKJH3c7I+qSQ4HPuSzNNn5DjW0cnMZtNsBjA/PNhCJs75ag1SVcp
	miMJIDMfPtAR4hlbJo1ftDLRuPPkYf8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-ip4ql7ebOBy9SsReIKzDtw-1; Tue, 17 Mar 2026 07:29:21 -0400
X-MC-Unique: ip4ql7ebOBy9SsReIKzDtw-1
X-Mimecast-MFC-AGG-ID: ip4ql7ebOBy9SsReIKzDtw_1773746960
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so5651245e9.0
        for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 04:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746960; x=1774351760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFs80zw2O4/2NJrV7I0/zYaOrXH4RPoeh7BrpBnFPW0=;
        b=JjG/4i4GWw1gDXl74kag5xGPQG3wZRaVZeiER4VXN6caeZxxVtxNekiNDWP6UR+xKO
         0Xlw3E4QRL7/MVta4vkHgJz0MOV5a+hB1BxrqNiYVaBgzK8A57GG71NSuQdyTxtuPt/2
         7zgY27R2q2dnPf/oMjeLz7BMsf8oM8vWUpCP7hngefbfAc8Fp7pXtDroXv8GpzZHCbIE
         Z0lNBQIO7GWAfVUEQEoocKbb4dYHTnz9Cw7J1ZwJQGqzNFJZW5AwD1kTYUn9tIc6XlB2
         8GUq8P8beHqoQaLklxUdODkj97gJzPZzWtOAevZhte/VBxTcwF4VmAR2kDe2PBwkIcPP
         FwTg==
X-Forwarded-Encrypted: i=1; AJvYcCV1jLJfldz2gSDR8QBAZ9guUTiucspN4GjJ4brzByQ9llSO7JBd1eRzTKnF5Ap3xUu80yZLlSvQCcDD4uS40w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOpClxXTUYSDGf6/MumBIa935bD6j0Izk/oTywKmMz/4aOUFb3
	AYiE6z9IwPgukoJKKoFOLOI5LzTb0q2BSUCCYp/ybnHib/OCLkU2E2AIVtMGfDcPw6ukTZ2OfxO
	z7iNMe9lLCg+1TMft1tj67OJycixgPmguep/ArEnoPOJ2svnY5wqlLgJEm3VwbbNJABwy
X-Gm-Gg: ATEYQzypHOCYgopDA0oKmRMoPA4revcs6CqVHiwNAwbCFqb7J8N0b/phl5w6YtTP39s
	T+t6lnWPpDjG6gzmMdVz0Uk9eGLeahgfStSFDII6EfN3zz2WoFYkvso7m+piyZhqqiSrv42kUo0
	PqkviMV7bVPfE8s5kIMFc8/yJ1hswzGHyJuEeQRkHRjOhlSzBAUbOwuOINwZrMMQgWSCekj/lE7
	/GbUHGgWjgQLpLG/yvyYekRHRQyLT67lSpfJJSDHvsb6j37ETdamDGrAaw6XrGtHoACgCBvSwG+
	Slw8MAHXFTCJHj1SB3kwFnr/ukVNgOUxCf3uTb7ndW+IU6eurCgXE0AM8nidVLDQT7t+ckTlzwP
	FVIPSd+ZqGiAZ+mCmwakoN+INXeiixtiHHgaHafVSnlqxmutCUW8g7/M=
X-Received: by 2002:a05:600c:5249:b0:485:38f1:5cec with SMTP id 5b1f17b1804b1-4856eac2b35mr51298755e9.7.1773746959762;
        Tue, 17 Mar 2026 04:29:19 -0700 (PDT)
X-Received: by 2002:a05:600c:5249:b0:485:38f1:5cec with SMTP id 5b1f17b1804b1-4856eac2b35mr51298285e9.7.1773746959237;
        Tue, 17 Mar 2026 04:29:19 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4857f224d5asm16069915e9.24.2026.03.17.04.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 04:29:18 -0700 (PDT)
Message-ID: <bc3a66a1-8c0d-4038-9b92-0fe3d10b1555@redhat.com>
Date: Tue, 17 Mar 2026 12:29:17 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux.dev
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
 <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nXnJXa1FsVYjkrTqTdtLPShUWI98Xh_zcazUHSAEGGo_1773746960
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 8:59 AM, Xuan Zhuo wrote:
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
>  drivers/net/virtio_net.c   |  6 +++++-
>  include/linux/virtio_net.h | 33 +++++++++++++++++++++++++++++----
>  3 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index a5f93b6c4482..fa5cab9d3e55 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>  					tun_vnet_is_little_endian(flags),
> -					vlan_hlen, true)) {
> +					vlan_hlen, true, false)) {
>  		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..7106333ef904 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  	struct virtio_net_hdr_v1_hash_tunnel *hdr;
>  	int num_sg;
>  	unsigned hdr_len = vi->hdr_len;
> +	bool feature_hdrlen;
>  	bool can_push;
>  
> +	feature_hdrlen = virtio_has_feature(vi->vdev,
> +					    VIRTIO_NET_F_GUEST_HDRLEN);
> +
>  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>  
>  	/* Make sure it's safe to cast between formats */
> @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
>  					virtio_is_little_endian(vi->vdev), 0,
> -					false))
> +					false, feature_hdrlen))
>  		return -EPROTO;
>  
>  	if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 75dabb763c65..48de4a16a96a 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
>  }
>  
> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> +					 struct virtio_net_hdr *hdr,
> +					 bool little_endian)
> +{
> +	u16 hdr_len;
> +
> +	hdr_len = skb_transport_offset(skb);
> +
> +	if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +		hdr_len += sizeof(struct udphdr);
> +	else
> +		hdr_len += tcp_hdrlen(skb);
> +
> +	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
> +}

The series LGTM, let's wait for Jason and or Michael.

If another revision is needed, please consider factoring out a
__virtio_net_set_hdrlen() helper taking an additional explicit
transport_offset argument, to deduplicate a bit the code between patch
1/2 and 2.2. Not a blocked anyway for me.

/P

