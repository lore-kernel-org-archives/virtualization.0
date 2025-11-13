Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8727FB32
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045423; cv=none; b=F2E9DsoWF5AEVApBHQ+37sIQ6HE20/vcXGGHVYclO5UuTJXzOwMI20pTYuNQAZ4sSVTBAPr6c5kfvKXMvTP+pRLMS5jw5w8NG86awv/krz7IHPY3iAdEK5WTniqS0WaEq+KKXks9v8urbN+bWF9i4wIoGWlAVH+uAbDWO4S1xKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045423; c=relaxed/simple;
	bh=8sn+1gVfv+/0ejEVwbJvhBy3kmgLgBs0jIjZ3GlTFwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqcvSfYBJMbGc4ZAJ+HnJBPJR3cdXP4nhkC7YqV4N0kUdvyaEIvEoM2OS0XFOBQzhm2a/Kr0/dZfpeFAI5Rgeo8vvJ4UY0nAKTvAlegXwO/d9i8MdHWrVla2Cc18M+MIqKK4goySVvOE8vYXawwOVnbOl8GlSH/G9/OuXLORAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyGJ+RVz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyGJ+RVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763045420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccPBcVEYfv3CKsEVYsFhFk4zVwAZCORA96fhkulkBm4=;
	b=AyGJ+RVzubab4ACwUSsCC1wCyW8h2JNJnYrbAGrujceegOyH/9xnq3EZyJ4CQPpfqMWRqv
	eSh6P5nivZtyT4GODU7jCjkeh9D+HvoiWgCICOpbu6tchLZn4s+T8h5QdLscQlDysxrDBc
	aQgVtBpo/QXchDVyy3UBcSl8iG877fk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-MGW4BTrbOTWWakBvoCxVUQ-1; Thu, 13 Nov 2025 09:50:19 -0500
X-MC-Unique: MGW4BTrbOTWWakBvoCxVUQ-1
X-Mimecast-MFC-AGG-ID: MGW4BTrbOTWWakBvoCxVUQ_1763045418
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7343d2a0fbso142979066b.3
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 06:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763045416; x=1763650216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccPBcVEYfv3CKsEVYsFhFk4zVwAZCORA96fhkulkBm4=;
        b=EyOrAbtvt6lK+XhoPivX0/Vb7S8abFDwbL2d4ULy9FraUeJkTPO57IvKU9/KQzGvEs
         VbGC+cHUC+P0Fv+e0bn4RWOnr0QjWzE0e/u55PRhMxuPa2jWIRNp+t1+XdLwuIYp+zRd
         xr6dOrCqRcAyVRVZ7+Df1115Jd7eC5N2rNMhE1eNiyoDpsH5WJUYkTnsuSafV9pDT9r8
         aWRj17rZ5bMfEdP/78h5ox/XbLkKpALqGKRKVhvYq4Kq/qIosldvItyyyH5UlgI2SDCX
         otBKHdLXpeg3E4DOjS7uNaLXUDIu+GAPLFrBcZuin3b4VRL2vxFdc8ufnYLoYa+LPINJ
         3uKw==
X-Forwarded-Encrypted: i=1; AJvYcCXXB72mo1Y4ELJXEv6Pi0UCj42BEP8gZMzIVcDmmuKOq2BTBUUbaB5wUN/dUQHcdL4uKQq6OH3spsTUwUwApg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUXOEqlV/478hmQfhPjcmLe/Ks940zzLSWmet4KH7B+AWSXwyk
	qIwcrMBQ+QinFBCvGwH238wQ02eSM4d2bQNYaFgVFcJ982WtFmvzk0lUVvDtTQpBukPYEwn8Sl+
	nc26Jp3oH1FcoQ745FaCwa6JE3FgbxRc9C8nNShLB7s95/fTVfDrOh7grXw4j3qUrzCGf
X-Gm-Gg: ASbGncttmMf6jTibmCe4kFqsA37rFkwjbVE8gjf0wj5OCPE3b09Qkv1atPPp+zSfVIX
	yy3MMW95QilVfbis9E2a7q/9gNgaa1prLEUQaLs5hYaIEFKKtkFgMdmR1sx/pQS9H/cec7T8zia
	1M0eyva2mZ2gPUyNjFAr4Fdn4lxQTQ3kOJePf9FZBTzBxHm1ZMjnKVFBsQbkDmfuyiaFitIMVZN
	Nh5C9Y8qD1nEGAnrlTRFVkzE2/acfkOl+A2Z9YkCl7AQcSw5x7YfR17Ax6pQ54/VmVYrbEDmSTo
	nLa3AKO1rQIpDYyCMQbAgJ9ussSQ1QVUzEgx9J3MapMRp6/VVQq6xjTRrgkBRRL9VqjyC5uNhti
	5rEWsnwBvdH83
X-Received: by 2002:a17:907:6092:b0:b6d:62e4:a63a with SMTP id a640c23a62f3a-b7331aa9775mr765258366b.40.1763045416544;
        Thu, 13 Nov 2025 06:50:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd5TszTx9Ftbc+1tpBg2R5bDY4Ip4/CQe2Mmx4GrIHNGWKqsCGbjONvF+Dgw0TZ/pVKl41bg==
X-Received: by 2002:a17:907:6092:b0:b6d:62e4:a63a with SMTP id a640c23a62f3a-b7331aa9775mr765254466b.40.1763045416035;
        Thu, 13 Nov 2025 06:50:16 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734ff36ac6sm175932366b.74.2025.11.13.06.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:50:15 -0800 (PST)
Message-ID: <f79bf201-c4fe-41a9-9ccb-b93271d83183@redhat.com>
Date: Thu, 13 Nov 2025 15:50:13 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] virtio-net: correct hdr_len handling for
 tunnel gso
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
 <20251111111212.102083-3-xuanzhuo@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251111111212.102083-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BIb42c_hNziyXqyNQLEAP1oMFyJYqjCNz0Bsqz8XA5Q_1763045418
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 12:12 PM, Xuan Zhuo wrote:
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
>  include/linux/virtio_net.h | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 3cd8b2ebc197..432b17979d17 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -232,12 +232,23 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  			return -EINVAL;
>  
>  		if (hdrlen_negotiated) {
> -			hdr_len = skb_transport_offset(skb);
> +			if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					       SKB_GSO_UDP_TUNNEL_CSUM)) {

I'm personally not a huge fan of adding UDP tunnel specific check to the
generic code, did you tried something along the lines suggested here:

https://lore.kernel.org/netdev/CAF6piCLkv6kFqoq7OQfJ=Su9AVHSQ9J7DzaumOSf5xuf9w-kyA@mail.gmail.com/

?

Thanks,

Paolo

