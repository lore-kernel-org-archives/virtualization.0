Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758257;
	b=tGcDNrCr+K4q3KNPxEdi5lcquC93bUl07F7v/5LjbGwOyTbpHXJXM9PA1bTdeFp5B57i
	 e01582gpv4XVwiK29B6v9/FT79f+iuFLJWOSrqdcrOZk7ph/BWNqz7XNwTOlINSHy8wE5
	 ogFwPlKCeHSuTFA9+nFNGbyTKe8GSuTT4p2N7eIT6Woru177jtY19Py7V4fUKtPAVDwll
	 m+NMJtAw/pmRllPhL6wmgVwIAreYLRZq0GAap3+0cmswLpOtkLe4Y35YtRXicsnhkXWwO
	 /yxPKn06fXAE6S9FDwwpwzrnXvgEmzzhXUlrmDBL+mMljWl9C7I6lE9Hpy3A6lnC2Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cU876HDDCHMexU03ZAhAifA645G7RjUz/Egex4hmXuI=;
	b=ROFREmgAeUK4BYd7Iv3bELZtoR4GLU1yg/gnORttH6ozqaLeIcl4/VUBmRiaJFKbElo1
	 taRlkd9CcbBR4B1k9PNJEQZQEeXAqO7lrIZ13XVVIQMYZUCkmmhlzvCs0lfF0QCbu3rMA
	 kFlBWup+1N6kHrWHy2WegI3el3wjE0E5QAS5CVJwXu0a48CuCbYqo0LTeVlFp7BelBYCr
	 gMqDkQS+2sDouRn7cgfXGZVDc4/ocivgur4jpQF23E2wQaIwdZCiUtvAJjBkuw9xQhUBk
	 /NNWauf1Dlt76gZtj51j+bjwCiwWk9vKfiDitIeYoyNDrgz01h2W684ktvteJ6u0vjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLRdwoO7;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBE5606A326
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CBE5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLRdwoO7
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91befe703c4so2541356d6.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 18:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758256; x=1794363056; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cU876HDDCHMexU03ZAhAifA645G7RjUz/Egex4hmXuI=;
        b=HLRdwoO750pjvaSnMLuDh0ecKLLW5UbseOrpXYAj/NLjdL6OaIMDh4p2upAtoj3+0H
         WGXp1Ipgxq9S4vvaNKRUTHpCV/UrAVleUsPu9zl7/lsZ1TYrbg7iqG3MAai44i5Ehan/
         db8C7QvqlFZHQNZ9wZhVwXdImVHSfJPPlQgKpyYx8b/1LsbazKW2xWUNx+yUjh2yJoMW
         Y0CubSkD4vjp71O7GDWugqSu39y1XlX6jMCtAJuJz24CB++dE8NTU0dMa+ZqbvrlmSQz
         UEMQdiyOvy8WURtwFViw5Jls5Rfm/7o8nheNQyA20pU8EnCZ10CIUQZBMWTzqdkO1593
         y9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758256; x=1794363056;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cU876HDDCHMexU03ZAhAifA645G7RjUz/Egex4hmXuI=;
        b=P2c2iLYxnM4M3wPcbhXQrQ9r9NonHDju7dLbkfN053Bs+mzXG66C9U9NpXT2SNZHH4
         h96fduhwZ3iZB4ppP8+XOowYHrdOMR08GAiITGFgalnm7tmPcRvuQj6R8zecXiAB8kUC
         0U2BCQrcw+wILZGz3q7guawguWkmjumMMicB3mDi01gH8BCYxUZRbqzpFFXnireGHM0J
         5nZQcyr/eSXWSnvcyozEBXsoKrN8rbsVg88xUG1ntQuG6BoTozPflqfyWwnk8MF6OuIg
         c3Xy6+xAaF4daGZblvg/oRsxxG1HjE08zGSO1FgLVlyHv0vaJGz+JYgS9P4O7GIQVWrQ
         UMdw==
X-Forwarded-Encrypted: i=1; AKwUvBxBgE5BWLCjPYHwnAPLlk9MCtTbeokZptYvZBYAymX3uhv1Y70TsUqa+YYNzMkCG2iaYy7wW3DvBxOqUO2z3w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/xlZy3HQL5/gNqIIkVkOJkF+T4OFwhcjhk6LSBmkqD9wGiVXl9
	As72nGlNYFdWz9F8m16p64glOccGqvxxjLyQGs0WsmepRCYEoMGJ6jnm
X-Gm-Gg: AYBFou2BQGiSYJfes1YBiqUATW2fPR90ipk3SI6rm/XLC7bc5HG2+kY7vNurNORL5BE
	1u327jbg2udpubWLNhkzDXujyD73yZ0LlsGOj+pybwOKeJhfklfIKPAbWawO+VovxKQRLv7encf
	gH7U165XqjSvCTbqxfaTuj0Ki0eveNEiOCQZ+iMCa8A1bSaNKaF+nqloXaahvfrWkevqpMb/aDR
	t/bZxCMRFMYc2VJmNu2lucjJBY5aTI3jR+6BnhU5GpfFy53BmvtL3mrZV1l2lPzouSof8Sm/uR7
	QCcFdtFidBUybHxVsy8HF9LIu7zEo2+ny8nXNw3GKv3cLx2b5niLSCQ4VhmSkz/YWjRHIKWcluZ
	FYlZA4+jCoOrxh8V0667XrJ8X2I/GysnWrpCx29zcY71AmE0c7fp/zBD1YmtApd5pAmYXRLjPP+
	JfrZmjC4zSvT50AyOT/CaSwbEfG9Z2ETkpN4AsnPWr9ii+hsABYcLf2NyeOW3C6dl8EY1x/rMJ1
	snOXNeAYvjW89jU0iFmuAOwjxTXG4gSxddNmUbmJkR6znjdx0exvRF7s3I6XidCCZYZ1GK/5byr
	f3MtQT40wKLFBGZkmYUd/QJfJQIjpcMmv2jkUxt1+8cSLsRoaoHnvoGW1OKO9+yMi05uif8NSXc
	DmQN9YIl5q5e7xlX3p/XFmh6uedAQJpe07/ZwONKd0kEOots5MyB4GLcYCV/Gi4ei4P9u5rY=
X-Received: by 2002:a05:6214:310f:b0:91c:61e9:7b68 with SMTP id 6a1803df08f44-91ca4b7ad25mr211563366d6.21.1793758256179;
        Tue, 03 Nov 2026 18:10:56 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfdfb5fsm6279506d6.16.2026.11.03.18.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:10:55 -0800 (PST)
Date: Tue, 03 Nov 2026 21:10:54 -0500
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
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.316a1799578d9@gmail.com>
In-Reply-To: <20261103203113.550604-3-edumazet@kernel.org>
References: <20261103203113.550604-1-edumazet@kernel.org>
 <20261103203113.550604-3-edumazet@kernel.org>
Subject: Re: [PATCH net 2/3] selftests: net: tuntap: fix UDP checksum length
 in build_udp_packet_csum()
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
> build_udp_packet_csum() passes udph->len, which is in network byte
> order, as the number of bytes to checksum. On little-endian hosts this
> reads up to 64KB past the UDP header and computes a wrong checksum.
> 
> Existing callers did not crash only because they use packet buffers
> of MAX_VNET_TUNNEL_PACKET_SZ bytes.
> 
> Use ntohs(udph->len), as tap.c does in its own build_udp_packet().
> 
> Fixes: a942fcd72e97 ("selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  tools/testing/selftests/net/tuntap_helpers.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/tuntap_helpers.h b/tools/testing/selftests/net/tuntap_helpers.h
> index d6c0437136ec..ac9b2da57a6d 100644
> --- a/tools/testing/selftests/net/tuntap_helpers.h
> +++ b/tools/testing/selftests/net/tuntap_helpers.h
> @@ -335,7 +335,7 @@ static inline void build_udp_packet_csum(uint8_t *buf, int family,
>  	sum += htons(IPPROTO_UDP) + udph->len;
>  
>  	if (!csum_off)
> -		sum += add_csum(buf, udph->len);
> +		sum += add_csum(buf, ntohs(udph->len));
>  
>  	udph->check = finish_ip_csum(sum);

If respinning: we probably should also do CSUM_MANGLED_0 conversion here.

And to zero udph->check first. All existing callers do. But the calloc in
patch 3/3 does not.

>  }
> -- 
> 2.53.0
> 


