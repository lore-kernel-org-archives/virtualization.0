Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938911;
	b=EqLVDGdhBJ5Iy/TvTPbVMC5OIsx37tocC0lep2xkjjQKQoOjW3n/0QvvU9zMjF1i6tsB
	 0142VpJkd10dWNhErdWpCm1yaD63Epe6NnimFsHjeNWrspXRVvYuULiOV4YtfreE/2+dx
	 th5k0+cN4YqlQlrxPg+AMjNgU9+o+pAmVXMk9y4oL7An3VssEqPVce7qcaIwVeI3Hhwo9
	 X6I6R30PDnUT3aHkn6nx46PCY9rFzLiE4FT3+FW2qVsyjENAJE/+EfgpwTl2CH2RpCzyo
	 WSBpIVazhMMeY7C4MbDTtJDvoYlZW+xYoy3D5y/V9D5t4NQK5FfCA7nvLMEJdpDfxQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3iWGu++LVn2H+H7qSXINsSF2Yix8YUXmGD2jfuzlbW4=;
	b=HfI90zSqFKh1jXMKqyxVpuk3jjYVj++WsWj4vLawy2399nT9h37JIBtpsVqNsUGBaO/Z
	 13re3KKNyZbT5XfDLqo9edVuxLJZL6UdFxSKeqn2VaK/zR3G7hv49eSXK/CnNq5jHMVFu
	 kX8zLEcvvYqz7gaMkKu/CioDgiTME+kOkxy7Z4YYJZhGrYSr9GG+wdILQhmgrDJtmacBK
	 AJIO/off7Ed2Cezzz0r/Pvq9+s1+pzEkUkGHQO64oduZ5Pkugh6dI50mG9AIHRhVepAT/
	 /IalxzwybCUSlkCl/EYXeAYhM7mPm4kpifNmbLOStHLYnh/rhSfAZAUQ0Krp9hJ6Puw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QOBx94jG;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DF606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 04:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 671DF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QOBx94jG
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7ce77f98658so79060137.3
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 20:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938910; x=1794543710; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3iWGu++LVn2H+H7qSXINsSF2Yix8YUXmGD2jfuzlbW4=;
        b=QOBx94jGXFQUgXrieFqY4ta4nfZy2iUxd56221YG/7yo5sAA4C9wj+pmfgcx3C+FKV
         pS5ISMectTJyLfxzZBwwkEHQnqDSHo9BUCJihXHQzxYoJTno10V6QasnpeHN4Cxfu1NO
         Un8TKl0hq7okhcnBZxaWuGzEQxWpuuX5fTpU8hx+aHU6yup9P2QQVFnFGsZ8648etXu2
         jB8XO9VQgHWdjoGiTLbwo0BDEmQkelVuKTS3clO+yedJI1/Lt+/Wu1gexzrq1g7fBYm/
         ox6jz4JAOWt2UKCO4WlqQQdjUWs/tNM7ZJwd4XWIoSL70zOhrrqXcPWCGlmZOJR37oRD
         KYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938910; x=1794543710;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3iWGu++LVn2H+H7qSXINsSF2Yix8YUXmGD2jfuzlbW4=;
        b=WYh+zaFrDW+jzsT8G1ySINROP31xQt4wGTWBrh9OFLnbclHVvWOOCtRcQeJs84RoOX
         am4InYzwQ62WRYxOPaaoeGaEWM8z8W4ICS+SOovC8nGa7eLWI5qBBNaVi1JW6H3ahopF
         iwlBIAeA4+AJvqDER8EP8p4CwEKepKVgD6b5m/P9E4/myT8PUxRqo6RQdoksquzy2mhr
         JaEt67dBq1XI/4JZqG2dBWX/jXOyT7b7A5ogKf3y6MLCMUh4Ct01v3qw/kOlgUbm8CEa
         fRD+Z18NuF2Vv8uPmglVeYm3FxXWLni/KG44z87Gxdv0Lk6n48BAsaqVyJH1Dd/gcY3h
         SwQA==
X-Forwarded-Encrypted: i=1; AKwUvByONQIDXd6MnRw3Uh4lYu6aj50nVfwHNdByITiFoBffhViU5W9cnmByd11dhtiSIXH8Gy6xPDRiZntISt6R5A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/YZA1Ui+CF4b9wtIm1OBBczqE98UC/jpv63CjDgQm/rVG1QXF4
	IY+Uvy4q6n1Co49m78DgbP3abF7vvQGjUNhsvNBz8GCt/4fN+1PWPLWL
X-Gm-Gg: AYBFou2qQZ1yJx5JiX3skCcjj0au2kMxAklDoin1/Ls+CvjpJgrDaSOGNxhsEfq2veI
	Znu+9Y2WTgmDPLz5asT/C4ef3uNVGqF0N4HKMZ5EThu0Kc4RJFgebb18bbl8rHRu6p1drrq4BZh
	iIq0BgiQd7d0NGQQYX/1ISC/QaOzsr2SGaKsxcSAvHPan5mmFvWmpH9Bq3iqpGumj07gFRgkCV5
	Jkz9c4udnLLRXSBZXfDY+bznwKt0gfPkoO2P+jxa8QFoQY8iUq4d7xj7PdcHYJRBVYqHlxQrZ+T
	95KOe2UfnizPSWxStiCFJ0RAbmZNOsIzAL2R3OENJGzmnfr8otD9zRv6ASFG01AMbV28RuJj7A5
	mnHIJbppSNPfWqp4/bV293RiPGmetn66BAk6vQ8ukSzQYv1abFHOHqIRViS/EdmgKfRQySaJvts
	XxGp7GUgd1lZaI9SbdmpSyt45RgtBewMf727Nlh2DErllFuEFm7dM9vVWEq2cO9KT2FLPr+84t9
	OetC9F9yB5ngwyw5rfXEOXKPU0l03aIbbgdI/IUS0718HsF6gGC4puNw7KEhU2j69SAeywpoxlZ
	Z0aN9E5fHRoJxdY0CxPdtjJKTQNH8Q1UlRlIKPL2iC5J6OQDl45k3odupiXomeSqzB+KKR9B8Nd
	9V3UDJjNgZNV40lGDSWgvT2Vu1ouo0/u9GtDrxpGapwGhlogGspauj0QB3Txlm7fHCVBUuRI=
X-Received: by 2002:a05:6102:a18f:10b0:7ce:6474:7216 with SMTP id ada2fe7eead31-7d2a2f0ac8cmr439924137.36.1793938910317;
        Thu, 05 Nov 2026 20:21:50 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2a85beb50sm492944137.1.2026.11.05.20.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:21:49 -0800 (PST)
Date: Thu, 05 Nov 2026 23:21:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.1afc96da83d57@gmail.com>
In-Reply-To: <20261105115715.1466924-4-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-4-edumazet@kernel.org>
Subject: Re: [PATCH net v3 3/8] tun: clear stale skb->protocol of NAPI frags
 skbs
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> With IFF_NAPI_FRAGS, tun_napi_alloc_frags() gets its skb from
> napi_get_frags(). If GRO merged the previous frame with
> GRO_MERGED_FREE, that skb was recycled by napi_reuse_skb(), which does
> not reset skb->protocol set by napi_frags_skb() for the previous frame.
> 
> On the IFF_TAP path, tun_get_user() calls tun_vnet_hdr_tnl_to_skb()
> before eth_type_trans(), so the virtio header checks see the protocol
> of the previous frame: the outer protocol check of UDP tunnel GSO
> packets rejects a valid frame when the two ethertypes differ, and
> GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are dissected with
> the wrong protocol.
> 
> This needs GRO to hold packets across writes, for example with
> napi_defer_hard_irqs and gro_flush_timeout set on the device.
> 
> Clear skb->protocol for IFF_TAP frames, as for skbs allocated by
> tun_alloc_skb(). eth_type_trans() sets it right after.
> 
> Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179386753589.488856.11455181721004759454@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  drivers/net/tun.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 3920b3dff1e8..6b648f21018c 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1941,6 +1941,11 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			goto drop;
>  		}
>  		skb_set_network_header(skb, ETH_HLEN);
> +		/* A NAPI frags skb recycled by napi_reuse_skb() keeps the
> +		 * protocol of a previous frame. eth_type_trans() sets it
> +		 * below, the virtio header checks must not see a stale one.
> +		 */
> +		skb->protocol = 0;

This resets it for all IFF_TAP.

Would it make sense to do this in tun_napi_alloc_frags if it is only
needed for IFF_NAPI_FRAGS?

>  		break;
>  	}
>  
> -- 
> 2.53.0
> 


