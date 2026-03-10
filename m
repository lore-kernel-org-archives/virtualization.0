Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B41F0991
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137142; cv=none; b=HH/4lIHjh3rE0zfYA5EE/jtRjqoKrCHayuK3CXuHlVDjKCerA6Je4e746bjHqHGon0ib0yz+YykfWzxPNCPhXYi3bAN5SkrtL9rbJFmTbBStzFQcnc3YlC3l6pwdkXf3XECwrhkjnhLUhQdDyNGCxwWhOLng/kW/ef6WzRjknOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137142; c=relaxed/simple;
	bh=ZVDPlz5F6+j8JfdfnlCeg2sGkIXu+w9bb1JGF7xr/bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atNci7515TsPmW4x8aH9NHHKwG9ZlkZI2EkS6S1g4C88DsT0tPqtuhQohMzNbK/A65snyioH50LHpJuI+WZwZYX8Xo/TljULg0wZQl8rpsEkYRj4LV8BWB+FAaJB/9doHR9yGDR/9oWlfjDKIMrtC1lQmq7CBsKuMKMSWKus1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/DGNPKV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/DGNPKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773137139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caLp6CkyccqcspSiLN9NhR+0Z+lORpoggQJiA3V+ZYU=;
	b=e/DGNPKVDdwh00Z2iknprHzBBxd47Om7h1+vHRaG3+4XvIgVzvfd0h1GNfyUZrZV6GMxVG
	FX6ZU70O7j+bcp+hUYhDvjmYHfGX/YQgdcQCHzEi2w9tPkdDPGl5UFtVAeujGDNkXAGNPE
	Xl5KWK5gp5gVUb7ABFQl83BZYxGTjdk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-PBFezSHXOeKS1v0kzTxXng-1; Tue, 10 Mar 2026 06:05:38 -0400
X-MC-Unique: PBFezSHXOeKS1v0kzTxXng-1
X-Mimecast-MFC-AGG-ID: PBFezSHXOeKS1v0kzTxXng_1773137137
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48544725bdeso6462475e9.2
        for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 03:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773137136; x=1773741936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caLp6CkyccqcspSiLN9NhR+0Z+lORpoggQJiA3V+ZYU=;
        b=b0Z0c+F3UVOwZnxjLshxFDBr+9x3Vr0M/e+8kB7QLJPPPfdY0SBERxxpJC3kSziLHo
         4vzAWv1CcIwOBko+FwoM7cAsQCDEKJeD9L66uuyctTinxcus+uLOY7x+0RdE4UlaHL4K
         XvH1ZStp2SH5tk09dHrzluDPiTagVywYP51/1uC6b81NqVxF2mKBQFxTpC6vWCMlBwyY
         z0CV6dhN05LV4Dd4nN7AbjpeSuqAGZTJqaezicARCSWw0Ru+GVMvR7uHy7ife8c0aBJg
         1PR/F8Y/FafVl6bPhi4iBqQnCSqXbzWdrXOsyis8gXczHwaerdUqX/YQ9a5FoW5NvLHg
         EzXg==
X-Forwarded-Encrypted: i=1; AJvYcCXls7aM6oEVGSuiVCFdVaNWlDQhv3sBxEGj9TSrxu4lAI+ReIdjkX4EhG6TkSAhUsp/mEZrtlnQFk8nCxNmsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNETsI/VslPVVnfda0zW9yWo+aZszlTJf64uvCwig8Lg/4Yn+A
	zvNgKuKWBe8D0rQ9ILLpzeIrETKb2CcF0TfckIW34rIE7TYI7IB/JoIURqOB+X83f5OBmol2fql
	dPeJGMzJL0BnTDgNJ8OIDhp/7aWa3zJK8a+50hWdCYMG4ksZ6SUTlA8cJTyIyBXrgQPhU
X-Gm-Gg: ATEYQzwD6aMUyYJozkNrlH0xAT3HNPcGG8Mo8IuD734cvn9Ow5Yww5JIqBZHeqwW990
	ypVZne+1S8xoocYEvISFZf/l0rhyfhjzoNDJcfhhjlhYgdHv3YgVf2pZP7Y92CAImWTQqcsrjsT
	ecqVVnggjjiWVHAy1rYXC4GuwW4juvFdEKkKaS9/z7Jhqya501FJGss2VErVBwdecHZYyX6kFgR
	9nI1BGGFzFN+becedz1oT2lJgnlPM9iOIssq1E0ZItJdKt1grgcnekCwEN5yvzoHy4Bxh49bSk4
	OFxB41WVWXLjth0noF0fWlTM8YMXbqZOJwDfSBErNvF2KdniqhzSsxMlbdTdAunUuRih+oxxJ4V
	pSvrAU5Hq0jUVHyv7BeUuN3m1eJvly5ZXvHHV2uBvIsA7t+EajrMbaisS
X-Received: by 2002:a05:600c:8707:b0:485:3ff1:d5c3 with SMTP id 5b1f17b1804b1-4853ff1d6a6mr93411625e9.5.1773137136136;
        Tue, 10 Mar 2026 03:05:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8707:b0:485:3ff1:d5c3 with SMTP id 5b1f17b1804b1-4853ff1d6a6mr93410985e9.5.1773137135513;
        Tue, 10 Mar 2026 03:05:35 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853149caffsm96041305e9.1.2026.03.10.03.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:05:35 -0700 (PDT)
Message-ID: <cf62a942-e1e8-4b37-837a-b0bd76297656@redhat.com>
Date: Tue, 10 Mar 2026 11:05:33 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 2/2] virtio-net: correct hdr_len handling for
 tunnel gso
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux.dev
References: <20260305031938.24518-1-xuanzhuo@linux.alibaba.com>
 <20260305031938.24518-3-xuanzhuo@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260305031938.24518-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mKaeEaO5fAbT-3LdcBrTGWFjxjfWoadVka1jMtLzMZ4_1773137137
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/26 4:19 AM, Xuan Zhuo wrote:
> The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") introduces support for the UDP GSO tunnel feature in
> virtio-net.
> 
> The virtio spec says:
> 
>     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
>     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
>     all the headers up to and including the inner transport.
> 
> The commit did not update the hdr_len to include the inner transport.
> 
> I observed that the "hdr_len" is 116 for this packet:
> 
>     17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
>         192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
>     fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
>         192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796
> 
> 116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)
> 
> Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_net.h | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 23f42bb8ece0..906157779955 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -209,18 +209,29 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  
>  static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
>  					 struct virtio_net_hdr *hdr,
> +					 struct skb_shared_info *sinfo,
>  					 bool little_endian,
>  					 bool feature_hdrlen)
>  {
>  	u16 hdr_len;
>  
>  	if (feature_hdrlen) {
> -		hdr_len = skb_transport_offset(skb);
> -
> -		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> -			hdr_len += sizeof(struct udphdr);
> -		else
> -			hdr_len += tcp_hdrlen(skb);
> +		if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +				       SKB_GSO_UDP_TUNNEL_CSUM)) {
> +			hdr_len = skb_inner_transport_offset(skb);
> +
> +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +				hdr_len += sizeof(struct udphdr);
> +			else
> +				hdr_len += inner_tcp_hdrlen(skb);
> +		} else {
> +			hdr_len = skb_transport_offset(skb);
> +
> +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +				hdr_len += sizeof(struct udphdr);
> +			else
> +				hdr_len += tcp_hdrlen(skb);
> +		}

I already mentioned the following a couple of times, with no replies...
perhaps the 3rd attempt will be more successful.

I think it's a bad adding tunnel specific check here. It sounds like
layering violation. Instead you could have tunnel-specific variant, say
virtio_net_set_tnl_hdrlen(), and use it in virtio_net_hdr_tnl_from_skb().

Or you could try what i suggested in:

https://lore.kernel.org/netdev/CAF6piCLkv6kFqoq7OQfJ=Su9AVHSQ9J7DzaumOSf5xuf9w-kyA@mail.gmail.com/#t

Thanks,

Paolo

