Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599239;
	b=xkz17ENv85T/aVPBUXKZctA+Zk2LdFOCN2BYGrNFXcLXGwP5wiAIqDXFb55RbCsLd0uJ
	 9oDaQYzCisvlv3LLyOUTcpyKjOhXR8w5+KdMEQJY+b9MhgI30cbikUZqIq3KEaG04ILaN
	 CYIkiZrwv/qB2Vw3rtnv3pwVx3m5bwuEuPdyrWy98PQ3OqqNkuBMrhcu72cus6ten06KS
	 J5J3q90A2rQ+cjpm1EHNtf18/8xIng3VUV+860NoPKkZX90rMUADNZS7gkDcx1KkwHWad
	 pkFlI23Kj6Ej2daNzQGDgJ2zaI2+n1JOffEaldoge/S41pQuw7NVI26WJQ21MpY3OiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/9nRTsMCBEjGYriwMi6KDbDPDyrebmljKz2z9iwLKU4=;
	b=DQ0OHVugKnciiXgXMAHCEaGSfWMEllWsvPS+Xm4WDdFESIMqA3fwBywTaAb7BWChu57L
	 C0zfXdhCU/I5wB6WuWHSv5K7uQ4hbV1q3IWGfKLorJyADX9GpLPQ0HW4GH5PztT5iSdug
	 rxyKGVtgZnX8yg19E4umnXloDK612EDJnV/njivg+6Xk4YwjDleopf8f2NGKk3WOgQMRI
	 ShTxROOXkk4feXkNpDJ7uJkdBh91sxDNdAkzfBRANg07yOlo/6zT+LD59ATyjC3C+Y2XP
	 8jm2QSdd++a0zZZtc6UJDvhqwtnKltGGom56J80gCW5lTn4Ip3XNaVYJ35KusfB1+lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SwwomubB;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C12606A339
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 16:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4C12606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SwwomubB
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so1641333e0c.1
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792599238; x=1793204038; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/9nRTsMCBEjGYriwMi6KDbDPDyrebmljKz2z9iwLKU4=;
        b=SwwomubBVCXsPT35s4QpB9kN2oj6nVz8/SX8IVmjcFC6+tiRx/0IF1B+2gLoMQiGKn
         wuOUMZi29ste10oBQl4D1S9cQteutUs6ihNRUJPlMVsLiIBZQZ24mEh8WKEzIipjJYhs
         9CnApHhypTCT9bcWGUbJWqI5PM2bCh5eH+2I9FoOm7XEx0j0w1DAnZDpHpMaQsRS0Gq8
         FSrdFyXmiE6leLLUita+M/AsNeeWeLGzw1jj07Gh19ic4iRsNT6jDNUOLV8YpEA2ebFL
         98rD07IgDP5RZZSwWnlP4pfc6u0XX4ekE1iI1U6YNIBhH0zwm6CiGow66njgQkQKAzyo
         gIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792599238; x=1793204038;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/9nRTsMCBEjGYriwMi6KDbDPDyrebmljKz2z9iwLKU4=;
        b=JzHCJ2Nl3j16JiR3XrIDrJTyODPuu2jial5NihkyWQq9oX/YwUMgIzaCFbLP7n0uew
         G2CWeI1K6ZrQx85+PLSrurjBZ1zHAdhQi1xSh3fGbI0cPafAuV3el0HjsPuHIYXU6KBv
         Fhc1rv08UJEsYfQI30IQoxF9WuRcVAkgHKfRkN3J8CVncW+Q5Ny8G/vN6AV93pgW2ct+
         niEINCT/wIDRvX7Tbi9HiByJwz1vLdG+UJt/LP9SrPYJXV9+00ucDEN4CMX5g12qZ/LP
         ljqLKduYdLeuJQvbpw8by+SCE6EhbhafEBj6htOsXeVZH1X7YKH0xrzbPkraPzEDoWvW
         Li2g==
X-Forwarded-Encrypted: i=1; AKwUvBwEMVM2wzCCP08TaBwcdBSnOMfSf2QDj76NC9f2vJ8CZK81XnT5o5BVWRzFfHP3eq9A/o3/cbU71LlinGxhNQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJbXi77NEUgxh1821ofzuZbCW5YpxHUnQJwauz1n4jB2W61yB96
	wQS2Pa6ppNddXmEXG5o26Wsdeg2TIR4utd2Fmr7N2lFty9noQKhH6buw
X-Gm-Gg: AYBFou1BefoOzHwZvDX8p4otgJU1I42ZvXGQDPHlZ4Oavj9Ft1ly07oMJ7VIpiY0irK
	eCAhBpm4jnxO01LfGTCM2tlkEQ2nC8MtOcLcSSQARqKOTfXClZrEZjcr0wFiXAvEA6HbWO3mfA2
	nAmWWB9faovuaBpvqTKSZt0IkhGmkHvoC7pxxR0IVYGqimz6dFU/sCypU7jcVFB1o013GHO/mTm
	qu/ZG2PcNnCNJQp2hBKI7cjNY9yOF/PcNq6QKWVuTrcZiIIFuR+QXWAqoU0AeJ+bk3JlRfSlSUZ
	eQ60gxXNwEqi1NTwMDjlyVUxH0+9Uirf0cSZidn8/PMdNjrGMMKnN07XQOWTmYWbuGf5z6byhpI
	uxgORsJR5LzhlIs4oPP7pXSD4J/Q8oUsT/XjVOQqIerpng/+dcXwGlBO521XQirB37OlzbhVvjj
	Miq26QYjgsMr2wAMh/SockcnXayJ/I42hcVWzpHf2S8+M9EpRHsLAq0Z+u9tDLGQlYPwAfCJmnk
	s5/2xs/BNymusvCn2vMcAC7RS1/F7LYnAkez1dGlJaL26utZAkM7i4R+a+OsZtzvr1JNQslAzy7
	IKzaHEbfURjNTebNuhlnaJJOp54ofMEM0C03DG6AavQi8FsS/IfAlEHYQIMr2vq+1RkORcVR3H/
	YnMsX2lkzlaiQrwdQGR3R
X-Received: by 2002:a05:6122:54f:b0:5ea:b598:4547 with SMTP id 71dfb90a1353d-5eaeba065femr915799e0c.0.1792599237596;
        Wed, 21 Oct 2026 09:13:57 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97be251sm3632217e0c.8.2026.10.21.09.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:13:57 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:13:56 -0400
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
 Paulos Yibelo <habte.yibelo@gmail.com>
Message-ID: <willemdebruijn.kernel.2a00482371091@gmail.com>
In-Reply-To: <5de86f1afe1165a1a13ac4ef0615b19f4a10cb7a.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <5de86f1afe1165a1a13ac4ef0615b19f4a10cb7a.1792565282.git.mst@redhat.com>
Subject: Re: [PATCH net v4 4/7] net: resolve uncommon partial checksums at
 ingress
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
> As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
> others, credited below, found more ways the bug can affect users) a
> virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
> If that state is retained, later checksum completion can modify the
> packet after protocol processing has made decisions from it.
> 
> Let's fix that: let's validate csum_start and csum_offset and only keep
> CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> headers.  Complete other non-GSO checksums immediately, before any
> protocol processing runs.
> 
> We can't easily "complete the checksum" for GSO we don't recognize - GSO
> assumes knowledge of the protocol. We could segment ignoring the
> checksum then do whatever csum_start and csum_offset say, but that
> seems like an overkill for something that shouldn't happen.
> 
> There's some risk here:
> - non-gso packets which can't be parsed get checksum calculated in
>   software, adding performance overhead
> - gso packets which can't be parsed get dropped
> 
> To mitigate the risks, the following patch will add a sysctl knob to
> bypass the resolution. This is reasonable if the setup is such that
> there is no protocol processing at all.
> 
> UDP tunnel headers get the same handling on the inner header.
> 
> Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
> 
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
> Tested-by: Chris Arges <carges@cloudflare.com>
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/net/tap.c          |   8 +-
>  drivers/net/tun.c          |   8 +-
>  drivers/net/virtio_net.c   |   3 +-
>  include/linux/virtio_net.h | 276 ++++++++++++++++++++++++++++++++++++-
>  4 files changed, 281 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index d7520622e809..f2a9bb443980 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -653,9 +653,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  			rcu_read_unlock();
>  			drop_reason = SKB_DROP_REASON_DEV_HDR;
>  			goto err_kfree;
> -		}
> -		if (err > 0)
> +		} else if (err > 0) {
>  			atomic64_inc(&tap->rx_csum_sw);
> +		}
>  	}
>  
>  	skb_probe_transport_header(skb);
> @@ -1089,9 +1089,9 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
>  		if (err < 0) {
>  			rcu_read_unlock();
>  			goto err_kfree;
> -		}
> -		if (err > 0)
> +		} else if (err > 0) {
>  			atomic64_inc(&tap->rx_csum_sw);
> +		}

All these belong in patch 1 that introduces these branches

>  	}
>  
>  	skb_probe_transport_header(skb);

