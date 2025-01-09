Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783521A432
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432019; cv=none; b=s8aVKmzzWTXNAbHyppCl1+uJXkOmwFvlXObF6hIg9cqdfn+NP7zxfBNoWCpwaFvN7yGWipc/QENsuR1LFE0QYHRA9UkbMdzOaYzB4POB9fH/UwkT6XdS6S/6oGiQr1GakXmYkadWSGPjwDxx1coaaW7pXYVp9aaZHgEAdF54DTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432019; c=relaxed/simple;
	bh=zyy3moZDkbBG+czu1d7X5YD5pi5vZzi9VgokJOCwylk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=C6bEDM4x78+CZ565hYf/s4kE5LL/6deQaIYRHJzFxMdRqqXxPGkZ2augjp3FyGHnVG+B7RH9v9Ol1vQwWvpJdYLbcFTawIh+SImVMpHg0KkN4w8b7Jro2Jg9rVwlwx41a31KGDshcpwaJsusvUjuuiYXU0UBPZyT3CUdHsH72cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMGPn0uY; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMGPn0uY"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2D92408AA
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kdow2jVnFzeh for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 14:13:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f2d; helo=mail-qv1-xf2d.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6FF9F408A5
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FF9F408A5
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QMGPn0uY
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6FF9F408A5
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:13:36 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6d92cd1e811so16470456d6.1
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 06:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736432015; x=1737036815; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBEhWD1K9TGnwPZW+7/5J69P4pRtuGWs9a6RJnwPAas=;
        b=QMGPn0uYETe+NOE8fZmTEatST67VEd629nk3zmsmuv4j9WvERgLUeXrK9jjvVRkmfQ
         j4QSBAsUzSCQ5mzDeZMimeJdaUbixpen486Mxf5R69i5vnlq3Of4Y5d/3q8SGdFjHUTy
         4MWgXTs260teVB1vVFUaUTdDaw4RVNgXJIuj5mtz9y7zwi3XmVIhcv3t7sl1XRbEu/v1
         PpcVQvJPPelPTQFH9TQ029v8aOPdpkZjFzSRU1Xfim4+wbGFxm4W1ZCDJ08/EYYuwNlI
         5tldnVfOz6yHGzlOQt1lhbPjrxyc/ohDBeebPBJr3CH0jEtKxmfoSq5zsD1BkGYtVKng
         8Bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736432015; x=1737036815;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBEhWD1K9TGnwPZW+7/5J69P4pRtuGWs9a6RJnwPAas=;
        b=O9mNGPKkxJFZQU1A5Fr1sF8Ct31li7pRzVBO/3BNVno1dXwI8yqE3I/RbEUTvuNyHv
         si0ObTpfBAGBzXu+XP6mhk/6yF47Th9VtcjiwMoGzrScPhjGmlbAjyX9e4ITFY/kJwBr
         fpseOWhELKetOyEwmCrOh5uMhH61sbcIJUyhgRTbovow4xPrB1X5uDZ0xZhuNVWvAu5u
         C6kcxuNuSg6rqfvzK3U7rjP8U8ottXIIz8LdC3s4VYGp8N1NRr9+Y8QOzukHBEYULMUT
         ihQ/LNm0fxFw7dfPXao4Y4uHr9woc1r7vNlnY1BaVYBmJ8q44oplxdatyenOOLgZirZn
         o+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9jYVjVoMVkSQ84fwVBGqoST8wMyfBEd6RkXLJupPv4yVhaUCf7VEXIL4qDJIVza3wHiIhiaIMDx7EyJbmpg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx0Wlo+QR0MRB1oW1SZDbAg7d2dw1b9zCy828swesgIYRAxu+Uo
	okFDO+3y+qJ7hFI+xbV2HxYovzkh0+cb5dgVCvUYI9UX+u8gWIGj
X-Gm-Gg: ASbGncstAzmsPibD8ZAp7C/T6zoJXufcpkIkKILSfc1va0V4iPOEbsGgoLC4jexTgNW
	biQtkfxdjDSaBoWQeEkm6uGXGUTXOznD2cutzsFqBlvJqVTjKmkmtFJORK7SOia3WXiK0J9XyvP
	8zHTZKe/6tW9IXY7OOvhKlLfK/9TPTdyEVevaKPZIKYYRbvgo4GSi5423wCg9lgzYdMkMu6MvUC
	gGENeVum44Slohhgr+YGwJrdmkJs2sbYhwnWMcGT+VjHpfEnQPl70320Q7+j/RNCg2dYnzBhkac
	rp48T+m7G95kKP16ba4Y2+KE/+sM
X-Google-Smtp-Source: AGHT+IHIdNIzp5p1G8XahHluwZvKPdRIT1LWx03OX6jYqP63ZJjh8hSiwgfOtm/xBp8p/l0BBmw0eA==
X-Received: by 2002:ad4:5964:0:b0:6d8:94f4:d2a8 with SMTP id 6a1803df08f44-6dfa3a77ca6mr51443876d6.9.1736432015072;
        Thu, 09 Jan 2025 06:13:35 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd32b2be9esm179389276d6.34.2025.01.09.06.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:13:34 -0800 (PST)
Date: Thu, 09 Jan 2025 09:13:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <677fd98d89df1_362bc12942f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250109-rss-v6-1-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
 <20250109-rss-v6-1-b1c90ad708f6@daynix.com>
Subject: Re: [PATCH v6 1/6] virtio_net: Add functions for hashing
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> They are useful to implement VIRTIO_NET_F_RSS and
> VIRTIO_NET_F_HASH_REPORT.

Toeplitz potentially has users beyond virtio. I wonder if we should
from the start implement this as net/core/rss.c.

 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 188 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 02a9f4dc594d..3b25ca75710b 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -9,6 +9,194 @@
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>
>  
> +struct virtio_net_hash {
> +	u32 value;
> +	u16 report;
> +};
> +
> +struct virtio_net_toeplitz_state {
> +	u32 hash;
> +	const u32 *key;
> +};
> +
> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
> +					 VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
> +					 VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
> +					 VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
> +					 VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
> +					 VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
> +
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
> +
> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t len)
> +{
> +	while (len >= sizeof(*input)) {
> +		*input = be32_to_cpu((__force __be32)*input);
> +		input++;
> +		len -= sizeof(*input);
> +	}
> +}
> +
> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
> +					    const __be32 *input, size_t len)
> +{
> +	while (len >= sizeof(*input)) {
> +		for (u32 map = be32_to_cpu(*input); map; map &= (map - 1)) {
> +			u32 i = ffs(map);
> +
> +			state->hash ^= state->key[0] << (32 - i) |
> +				       (u32)((u64)state->key[1] >> i);
> +		}
> +
> +		state->key++;
> +		input++;
> +		len -= sizeof(*input);
> +	}
> +}

Have you verified that this algorithm matches a known toeplitz
implementation. And computes the expected values for the test
inputs in

https://learn.microsoft.com/en-us/windows-hardware/drivers/network/verifying-the-rss-hash-calculation

We have a toeplitz implementation in
tools/testing/selftests/net/toeplitz.c that can also be used as
reference.

> +
> +static inline u8 virtio_net_hash_key_length(u32 types)
> +{
> +	size_t len = 0;
> +
> +	if (types & VIRTIO_NET_HASH_REPORT_IPv4)
> +		len = max(len,
> +			  sizeof(struct flow_dissector_key_ipv4_addrs));
> +
> +	if (types &
> +	    (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
> +		len = max(len,
> +			  sizeof(struct flow_dissector_key_ipv4_addrs) +
> +			  sizeof(struct flow_dissector_key_ports));
> +
> +	if (types & VIRTIO_NET_HASH_REPORT_IPv6)
> +		len = max(len,
> +			  sizeof(struct flow_dissector_key_ipv6_addrs));
> +
> +	if (types &
> +	    (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
> +		len = max(len,
> +			  sizeof(struct flow_dissector_key_ipv6_addrs) +
> +			  sizeof(struct flow_dissector_key_ports));
> +
> +	return len + 4;

Avoid magic constants. Please use sizeof or something else to signal
what this 4 derives from.
