Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F46B2EBDF9
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343103; cv=none; b=daiZ9jsd5yrJop4PsOgO/p1xVEoQ0F15lkdIVnIo6ullzI2seH0uecZvg9an5DLuC0hhuJQC/UIyxxbhLDdZAPltEziguBO6awdV6peCBXlTY2eyVuk7KqDBt7n6P5lGy4XnN85dzcJue9/2YemB92MEUeH0SB2Vg1Dn0fORl4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343103; c=relaxed/simple;
	bh=9yCeUnVOh4PkNtq971jR4OvxcgQqKArslTOCky9HAQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOWF6KMGI1Mh1PgsU8hc0flrjPlzNDxha6ilbGc7rTuwQ5zlF8K5LqHxAQcJXskIf57M9lfD+w3lxjjxpzDdqAn1yVtx4AdhE3SUSlpIMBdqxDkXuRCtf5vL9mZplAIlQ8FIAhfXbifP97kBiLS/hvxad0ezrc+pJpnVoCAxHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrMDkz1g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrMDkz1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760343101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1tPp8YEljYMfDXm3ZuBVdpyd9eaR3nb2fIv3sUlkgA=;
	b=LrMDkz1g41hoUfjBS7RIXFSScTQiGibBNcRz/e+Sa5FB+AnKuWGG2ciN9UuasDwMyxrISZ
	F4EQBQMHpHyNQM0YilxPMadcKdGQtgime0bufBXQWs0XNLvs8a35HcNvUUbltTwszRNrRY
	f1dbRE2rJI4eKICGto18oNI18lZqA90=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-bWx31BkpMJqSajpspKKc8A-1; Mon, 13 Oct 2025 04:11:40 -0400
X-MC-Unique: bWx31BkpMJqSajpspKKc8A-1
X-Mimecast-MFC-AGG-ID: bWx31BkpMJqSajpspKKc8A_1760343099
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee1317b132so2386449f8f.0
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 01:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343099; x=1760947899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1tPp8YEljYMfDXm3ZuBVdpyd9eaR3nb2fIv3sUlkgA=;
        b=t435QQqkQqx6eE60i3J7nqG2IN0S8YGMfzXHnOh8gycINrLzFSfIdvhYnFAGJI9un5
         gKAyk0VF6caS7bB25kiZ8IrZiWXciYArMIY88LRddkgzVtMECzXTXThzOh+s/gFMLkAW
         /nhkZZGFq5f30l0W2dcA02lmMA2XpaBphyzXUUjo5kDSrUxgjOiGwNKagwP2mDo1E+TJ
         13OAUPQdnzwWazsbJBYq0hcetZsvB2QxzdApK06XG21pEvhsV8fn49oA7M2yGjUGjacK
         MgnItZSWBFCPisENNqsh2lveuqLb5HGG9BLi4eyJIb9dLoItlGu3IyFCDFwTlTu7/2fz
         EpDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3BVHdB9GdjV/9FqGQ/GDLtNJIo9r6Qzejg0NC491ZnZbfHrKWQDHN8Pt3qPyM/6SXe8gph4LsaCBRhZLqlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvNIg4o9p4QYq/J7gU/Rp+E5LufgWjbyAK5d0UZmbN9c1OGftw
	WWPx1AcekhigY30Hsgbea5OYaSt78xpiN2CKzH4NfZRL7QwWBDByQtRdyDOYEMMN/2Sv5Rl39B7
	phTUbCkpuejW3fO1OXLjKNLDzzIFhFEDMNZxGP+P1EhqFLjUae4cdxL65jlrr8H/ptViI
X-Gm-Gg: ASbGncu7Prj2PNzwZG6cvifX4Nx/vDSb/+hDkI+OHxDwZ3W/ERPeMuY5z6ZIOh2mt9z
	DGINz7asLqA3pJwORZIeOJy1tFx+S0mbBKboLcte3oCN7XPU39Q4ovQGPy2It5yI3re3MkQbj1+
	d1TYr26bRTDx/QlZW9U767OYQ0sI0RUN2itHpToxmZCkI8WRBVtMHLBqZXQVcFp7BmdCycD67MU
	km0aNPq5iOZ0SeuGierCXoDcnQJDqqNC0zZsuseCxjDHov9Y1MwYXreVt2vPVV5+szI4JlmL5vp
	sLZ44oqJOKNAC+eqKo5epc6mc1RJuXArYUItUT/bQ7uJ
X-Received: by 2002:a05:6000:603:b0:407:77f9:949e with SMTP id ffacd0b85a97d-42666ac7026mr12224003f8f.21.1760343098696;
        Mon, 13 Oct 2025 01:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7JlCWnkPct1cz9l8P3e2Ai1ZjwIQPTyoLeL4/jqXzDz+4utC6DGYywfrc0J3b6VB+SnU/BQ==
X-Received: by 2002:a05:6000:603:b0:407:77f9:949e with SMTP id ffacd0b85a97d-42666ac7026mr12223975f8f.21.1760343098309;
        Mon, 13 Oct 2025 01:11:38 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.153.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cc03sm17518704f8f.4.2025.10.13.01.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:11:37 -0700 (PDT)
Message-ID: <27931e85-451f-4711-9681-38db2563efc2@redhat.com>
Date: Mon, 13 Oct 2025 10:11:31 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] virtio-net: correct hdr_len handling for
 tunnel gso
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
 Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev
References: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
 <20251013020629.73902-4-xuanzhuo@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013020629.73902-4-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 66nKYVS5ZbK3acUjqeMHmYWnz0lOMy6SdkX6roQN57k_1760343099
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 4:06 AM, Xuan Zhuo wrote:
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
> Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Side note: qemu support for UDP GSO tunneling is available in qemu since
commit a5289563ad.

> ---
>  include/linux/virtio_net.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index e059e9c57937..765fd5f471a4 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -403,6 +403,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
>  	unsigned int inner_nh, outer_th;
>  	int tnl_gso_type;
> +	u16 hdr_len;
>  	int ret;
>  
>  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
> @@ -434,6 +435,23 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	outer_th = skb->transport_header - skb_headroom(skb);
>  	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
>  	vhdr->outer_th_offset = cpu_to_le16(outer_th);
> +
> +	switch (skb->inner_ipproto) {
> +	case IPPROTO_TCP:
> +		hdr_len = inner_tcp_hdrlen(skb);
> +		break;
> +
> +	case IPPROTO_UDP:
> +		hdr_len = sizeof(struct udphdr);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	hdr_len += skb_inner_transport_offset(skb);
> +	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);

I'm not sure this is the correct fix.

virtio_net_hdr_tnl_from_skb() just called virtio_net_hdr_from_skb() on
the inner header. The virtio spec also specifies:

"""
 If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
 \field{hdr_len} indicates the header length that needs to be replicated
 for each packet. It's the number of bytes from the beginning of the packet
 to the beginning of the transport payload.
"""

If `hdr_len` is currently wrong for UDP GSO packets, it's also wrong for
 plain GSO packets (without UDP tunnel) and the its value should be
possibly fixed in virtio_net_hdr_from_skb().

Thanks,

Paolo

