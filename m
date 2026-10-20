Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524508;
	b=RJZ0+x+JTfSgEbFmRguyl+YzRexNpO8iHEV72qgKLoVElrq4I1KwCWbyDjMw53XPpfnh
	 X7UoUKN0hvUesomJMZGCRNq2bRpa+Z+Ou3zRJfiN0rtiOV76xqS7MPFBUJTUC8h0TbjWL
	 NihclWJmdD/BQNK9yg36b1xrLSMbIKr1DZaIAYJZkC6e4w5taZmjL5BsGv3Yqzcl08gnb
	 IGkAcmLtsW8TodOaeivvO/xZweI1lp71jnBLx48daXCgfk6fJUNFu0QgTioo42OpWQ6qb
	 1PeB1zn40j13PCBp2jLerH1/JFVUygKPmTkO7m5sUxkEz9Dve6NMhFBktzQo7zWXykA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uM5DkyTcQcIY9+zos5+5Y8SpLbQKEPMCEH5xBlRrlEY=;
	b=ObUj8Lebk7JDpY+pKx8QD8WTRoOQoSgaPANG0xVy3+MMU3FLEOzjpJcPyU4qTpgklgN7
	 ImxBFKs9WHiVeQhe2jnzpwCW9LL9CmnjINAhYtzfwQ39aFEQK147VNCBnxZwR+nqvUR8V
	 heGNosN3Knj1bZYoYwfeV/VSAmwt8T3nsRADBAgyVskpSQf3ITRFe0Ftq51IJaCQX+csx
	 Gsu17OzWntndLite5t2+cyeUpY4wdz4Z3zlkze45Rm7eJN3gGqxO+ZnIpcs8K6DK/8npa
	 C2tQnOSQv+DtASyOx5oXYDn+TEBNBVKPL2xGc0CEO3qN/VRudXPklKbhglpoQT7L9Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KtnTlrbf;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1275606A31A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 19:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1275606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KtnTlrbf
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7c03a445cb8so24710137.0
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792524506; x=1793129306; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uM5DkyTcQcIY9+zos5+5Y8SpLbQKEPMCEH5xBlRrlEY=;
        b=KtnTlrbf8Msd190S+y5QrYQlFxtuhGczTWqdd/XrQ8NAZC0H9ERCzWzVlPHlWbmpr8
         zM/3bo1zCe9Rtf7EwYe7hKgJoYvqYK8CgQi0+d43KIsa2mkzEK/CWe8Y8E43Cx+Fpjf7
         yWlJ2ugfH7xcrxmAgVgyAJ+w/Fme+msVPL9thB+JqLkWU2FcPv7oBNfTGsvUR+bJ7RIh
         DKUQATit91i+zsMf37DaOCbWBG+NSDXazUJPJUqScfAnvmIzFXQx6JjwDmm1l9xIvIfY
         s8hu0GdPMfkiD8rz0PxEGjE0qrdj2ktbpVS4dpwZ8tAwW2B7NkFXTgxrWGHe8/c4esZT
         K6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792524506; x=1793129306;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uM5DkyTcQcIY9+zos5+5Y8SpLbQKEPMCEH5xBlRrlEY=;
        b=azJRwr0UD+KuhovFHwPH0q3SH2izWTzIflk8nBRNIYgbELNmY7Ns6T2hPw/d2l7VaV
         5E7EQsZVJAc+0W8rtVcMgl/aQ/BITV4EqOX03zTEQvhYiSLZJWe4xwBEanZ7WSQbS+6L
         NHdDK6j4ELCn2yf9sPCcdyO4d+76VNufxODmxzUB8DwRctPNk7OZbI4w56CcHUvAKLbQ
         lpLsONegPuA0WEsOrAlNPcreXe9aAnGHXm5GBB/UhF8Itc5w8KCOKbeGsMZs/CIgXxqd
         kD67Rq5IEtN2UTprjLAwnvCVvGUMqQxL8X/+3Kp8aIBqAnFjXlPutYYfi1Qzh7f7SRUj
         LWcw==
X-Forwarded-Encrypted: i=1; AKwUvBzE2n5YQeVBKQMOHIIDOX0q3QwV3UE6BjLmsdCEakalB/LkKnuO6kGy92dOgPrYMvVVm1B7wH2Il9f54nw8KA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLS9d2T/I53oL7x7skGnIJegNm6IzIUuMZDKDYOC3hL/UI2Wq4w
	1BFBW7KKq5UnaC0nJpAXcSlWR/r4Kz4dix5f1Gyz2ocSibgXjduBVKfW
X-Gm-Gg: AYBFou0JVTnIIY4bOYrDc+lydoo4rkWATFDRwhvsEssKkYiSvwuFnbhLIE0j+UhpKiG
	vbjo+XHXgqpk4xb7C6hd/3Yw5XPkp0ZzIB+nSID7AkRpX337FFNYnoMsGAcMfeAXmNYDELxb3lD
	FVj+WfQhbdMlFfvMWryaQJv92j81sd+YOYP5p49Hk13afojJoyl3Y0yqPcm5LI1+QylEn4E+0id
	IGo0JWcnUJGKx+wfW7GKS6RnMp98AvCrf9mM9t7gEddfDgiwkVqzuUeS53Fkyjh/x6QSw1DFcTu
	quWN1T2FJ8rppV27H22XX9R06wfvJuvLaOqlF/bGB3qjuji28xGxWa4gH7TbvX17OxexdQqmmhx
	iwKRlKjDLSSkpkf14nM8oRJV4vN9LBLGEgZRuxN54y12MPNw5WMiALbrOAagI5f2b06fjz1WRdU
	+PEHB+t3FVIML3JRnS/6glRRak5V4P7EToKNHdHRUMheEv2xyJzjlWvSDilnKQU4tfzlaIZSE4r
	5M7UOb9yy1qxrD8SmDYj9a8MGJEGvKuPgfcEiKPllSEGD8C3VKm3TEFJiWgjDhjToLw+F+AHtlx
	/rAyQ1N02rglapW2Pnl7oxTu/Vi5jTZQi6+GeA==
X-Received: by 2002:a05:6102:5348:b0:7be:3766:9062 with SMTP id ada2fe7eead31-7cc9271c22bmr70477137.27.1792524506671;
        Tue, 20 Oct 2026 12:28:26 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc924348c4sm207823137.11.2026.10.20.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:28:26 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:28:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.317e66c2e17bb@gmail.com>
In-Reply-To: <554a7cf11f82676fcadde914c7044dcad9bbd0b5.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <554a7cf11f82676fcadde914c7044dcad9bbd0b5.1792411304.git.mst@redhat.com>
Subject: Re: [PATCH net v3 2/8] um: vector: honor virtio net hdr conversion
 failures
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

Michael S. Tsirkin wrote:
> virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> it cannot make sense of, but the vector raw transport ignored
> its return value: rejected packets went on into the stack with
> their metadata unvalidated.
> 
> Propagate the failure.
> 
> Note that a follow-up patch will modify virtio_net_hdr_to_skb()
> to return a negative value on error and a non-negative value on
> success.  This is why we don't just propagate its return value
> directly.
> 
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/um/drivers/vector_transports.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index e1fb2a76fdff..8b7548458663 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -210,7 +210,9 @@ static int raw_verify_header(
>  		return 1;
>  
>  	skb_set_network_header(skb, ETH_HLEN);
> -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> +	if (virtio_net_hdr_to_skb(skb, vheader,
> +			virtio_legacy_is_little_endian()) < 0)
> +		return -1;

fold into the previous patch? It already mentions that it covers all
cases.


>  	return 0;
>  }
>  
> -- 
> MST
> 


