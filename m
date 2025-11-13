Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38D281532
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044783; cv=none; b=lHYzKB0Ga3KKNM5kNMW1ajbubexir7cKAjkHgl9fONCW5vbi6ziaYzcvNbn+eYA2BXxwh3RTKOelTyVxlwKdBlcQ70yrxhLlLXalFvMJGfTAF8PTVcttkVqiunx0ocN++KZBFMXN8H8Y3UUpsoAWNp2yH70ZcXrY/balf39m+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044783; c=relaxed/simple;
	bh=WZlXUh05gtlAY7ujomAKuF63JeA7BJis07HZSFeJXuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OW6/Fl8vfuwOhjKhPW8nbYMvocXwrDX6OR1KdHNgUqBoWUGaLLz4qICiUR+CsPLQH2zgYgLcnqX/Rqm87AEcqPEh4ef/c0TTymgaR//NGvzOgGRSfHtDIJGz+qRvEw6Dt0WJLJDVlo9NwSReuSEBYhlCyaHkMlyX1Hnn+poF9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRzAFso0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRzAFso0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763044780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6ZlE/8wFoMWAmPveb7rTnuh4QFvGSZOBJ0lkY75WHA=;
	b=SRzAFso0iznnitrCamVClU22g2/R8Z+KUoJ5VWefviUDPXb26pn51mYc3oYpC1UagfEy8w
	50vHkjmtfhCHzJzbrcvVXXfb/wgBQ4pPXyaMkg0G6SEuFgjWfBu5Z9zDSmZf7yHuD2QeBP
	zGqlr92FlR1q8bfhz6U8gAuqq0GW2EY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Cbz50nWQNfC267sIXMWkrQ-1; Thu, 13 Nov 2025 09:39:39 -0500
X-MC-Unique: Cbz50nWQNfC267sIXMWkrQ-1
X-Mimecast-MFC-AGG-ID: Cbz50nWQNfC267sIXMWkrQ_1763044778
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429c5da68e5so492145f8f.1
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 06:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044778; x=1763649578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6ZlE/8wFoMWAmPveb7rTnuh4QFvGSZOBJ0lkY75WHA=;
        b=Xa+JNvo2Uh1oOW5+L6uxjHDp2XLqmATRi7IKsXf63Jzqj3vcRBFKmz4QyIFuJv0et0
         hjYWgti0cFRzX9KjXPeE8/v1drnMxJq31jlIJ+6KnxBCseNZq8zDr7pgPFzjmqwuTztF
         MnCQNrvy+ri8m6oJQC7sU8KEZWG+gHJJDxcFBKpYuRZZvunlDTKSXdsRi4Z9XqwH+tna
         K+ud7AVCjsVrW1vs19JnjSK2RC/zIcgD4FPx2SVcWsZW/GxXB0+38dQq6GjSr7fTc1uj
         7+BpmWTZhndQz1WgbF1LgzvgQ8dC69jFJz6Xt/RSwxYLPBTSbO5SlnGK/Suw+JVAEC81
         Syug==
X-Forwarded-Encrypted: i=1; AJvYcCXX89NfUp9o/nM94yutR03vkDcTKsJ9dynZo8ma4Mw8mgikgT0sEpWn8Wtsbk2VKflj/0pwD8aNrjh56ty0qw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpk7FnK33MadwhvMh0cffbSnlKtlvf3W3FsWRnFH8wrpdAq4Lz
	MOoPHD3PyzQgRd6yLG8501u/lUtu4lLAV1UHzu1ao8G2ZSpkJkmEzXvqvW8xgq7dgbu3C3+ZZ2q
	O4M89O32Q5y9VAEc2pgfq4ai6a+Q/X2SOsFp+rqtx1ESXbUltfd5zX07z0QWdiF/Cqc5w
X-Gm-Gg: ASbGncvkjmDj6FrNUQy+islHk7xMJtFNSJjzrtTzjhAv93F6Hd0/G1u/F+U9wI53oWu
	OW2CPu8b5jLSSRDyGNGfiMBLlpwoOnL8WCCDa7jyZ6bAAOT00t7FCJn9E5+Da7GvXvb0c7o/rEk
	BEMB8eK6uYtKSfsWOP7H2xECQdDkSmY3Rek9kqYhkv7Z/D/gVwNv7QVEKt+s+kAwY0ed1XUd2E7
	TfMUAYFAFYxg5rSIqkTncfhZtm27tV1tKPQLZA5KMSPpT1Qn4hWC2ggPdraL/wBGhyghG/J7JF1
	ti709corv+x7RRtJVPeBBiQYOKgvITDMZlb1tJgv1gsjA/nvMP8Yrmkt1edGhjntWBF7tFbSNvW
	fHhHzOaSuBcC9
X-Received: by 2002:a05:6000:2911:b0:429:cc35:7032 with SMTP id ffacd0b85a97d-42b52821778mr3447021f8f.23.1763044778206;
        Thu, 13 Nov 2025 06:39:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGec5SZJzkrdZIMQyF+gi07hDcBuVbPd+9nb9X5ZfZ31kZtvs0xZMBq40lgAX06ufK4If5sPw==
X-Received: by 2002:a05:6000:2911:b0:429:cc35:7032 with SMTP id ffacd0b85a97d-42b52821778mr3446995f8f.23.1763044777793;
        Thu, 13 Nov 2025 06:39:37 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f29c5fsm4196462f8f.46.2025.11.13.06.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:39:37 -0800 (PST)
Message-ID: <25b05194-63cd-4265-8d2c-e174d801fc3a@redhat.com>
Date: Thu, 13 Nov 2025 15:39:35 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>, linux-um@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
 <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T5XaoSnQb9Zz4ZLe8GvWIVpsbxLp5-aZrP1w6JpijIA_1763044778
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 12:12 PM, Xuan Zhuo wrote:
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

IMHO this looks like more a new feature - namely,
VIRTIO_NET_F_GUEST_HDRLEN support - than a fix.

[...]
> @@ -2361,7 +2362,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (vnet_hdr_sz &&
>  	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
>  				    sizeof(struct virtio_net_hdr),
> -				    vio_le(), true, 0)) {
> +				    vio_le(), true, false, 0)) {
>  		if (po->tp_version == TPACKET_V3)
>  			prb_clear_blk_fill_status(&po->rx_ring);
>  		goto drop_n_account;
To reduce the diffstat, what about creating a __virtio_net_hdr_from_skb()
variant (please find a better name) allowing the extra `hdrlen_negotiated`
argument, define virtio_net_hdr_from_skb() as a wrapper of such helper
withthe extra arg == false, and use the helper in the few places that
really could use hdrlen?

