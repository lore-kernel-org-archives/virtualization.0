Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720D5592FD
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084773; cv=none; b=DKYZ24U5q/mNl/yMqtg0+OD0kJznvpRy4SAfaWTOs+K0HRhr7tvZCa/ZVklVcq27I8cdkbXXF/6zQitGaxaaWsYIRngWvtH+uLOctSFSYyoi/qsTXtNPmllW5Fa8Wwh/O7RKNVZ9Dq15sGFp8jcRyZqEYhx34BkjL8AbaMQhmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084773; c=relaxed/simple;
	bh=tJoootuQrX0nPjs2wYqXe3DCOdBgRRUX2l69DqK3Z7A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=L5Ny+AKULthbtzteMkKcTaq2BfGlLKomP3JJSlFDYSeUROzu0eW8axpKGacXWX5xlufE37YHwpghFGD2+q5mRn60Mo9EqjcOLO/9dC7C+mNsCObQ6vvL5tdIku+j+pMIcpycNlcj182ZN/VEq3p7c2AKAwyrgSvu4xYyWvFWmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anL61ez2; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anL61ez2"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5d8e5624261so650405e0c.0
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792084764; x=1792689564; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZZvyPedXovvZDXPLa62gGgR2ST9LAGqR+oO13yEpFUg=;
        b=anL61ez2u9WCYCv8PUGdhRSH0abyZl6M8wKG1VMPsuvLl8JnQdCdl6sFuFB9/sw5JQ
         +QAgtPQarO7YYbraBSo1zlV41YQKDkQrT9Q2pIhsub8iLw08BxEU1Jn/caRzdvF/5LSu
         HaXTfpd+NF8nu3wjl2BPragfYl0+JTOXS7yK1L9dCQsirtXTd6L05Ldeoc7CL7nn7JBu
         KU9aWikX0dHVNpiOE3lQ7NZBnsIHJYPSEHN6A6npZj0KgpyGqffQAz0SI3nHNSPRTuGz
         cQgGHKK7MEGOv7TQ4seu6jV/RvSxER4gIv5yzlYKixk2kVxWaQSzqs+nD5rBXu+FAX3F
         inBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084764; x=1792689564;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZvyPedXovvZDXPLa62gGgR2ST9LAGqR+oO13yEpFUg=;
        b=UjX93LdtLt8QdDRZAhzfQpY3BsomZVIjRf/ZoZNFYBUScihqcbkepiK6nFsHuH9vW6
         R5aFJAOsWB06b0vLHYwgwirWD8cRu1Y4ruCPEiFEot+4WW7P6BJ2ILykgvy5YPgVaJG1
         yr5YRBVtTc1QPDkqxo3SVngLJDbu1/bKQ1TFHSRd4JqzVrK8zRu7g1t8IXSXPYM3kdy9
         Qhqa0i0abLK4YtRsSTCthmIHCX4O0REI+3w0thhGC2k1IvEu8SsJfb+P+1GM1aV0bvWA
         LO7V5dPL86ZhY7d5tdKB7fgdP7db4CKmYVLxsx5GHTinZbODmrkLqXJNf6F/oMscrP48
         sMeA==
X-Forwarded-Encrypted: i=1; AKwUvBzxw9ub5Mzhmp9mqp8KGqd3tRX2LBNhIioYw4uMIjRfvahgU5xJ8to5MLj+UhLHByM2oY4hckwZMIf8hqvJXg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIE01Qhp7R5ZC3XaI5xLkKdKiMJhDKYhZ3fT+bblywlWLBnymiy
	wJKgoMO3cGNJ4WdjNEpHxaSrsJZXpC1MSjgtMhBJtyIZU0Ydf+VColY0
X-Gm-Gg: AYBFou2qsO8u1jFE0nmBBX98emPnYpfG3TnVkCI+smmsFEmKHG94HN4mF3VTOdYpMmQ
	T7XtkeSfr1SgjxSBddVBIq/RogZi0OSUYtagAg2oa5w+e7XiOQcPxUSMa0tHMK2Lzdxzqe5votd
	DkdMXlnmKasukd2oEPteljxjOw705qwsWsCnVwLZzZY+LcUqqTqpVgXoneum2mERo+3ZhzgjZ2e
	HiMPQ+qN7A4fK4R7WW2IqtzMly7MKgANNFz+CSu/oxT3zqwYT0UaZg6HTIvFr+W6/mgTvbU5R5b
	oV5NYEOZbgJQjnwG1a5HsDYE33vp9AeG1JoMnMDGX1B0o6eHvK0dwdOS/KV76CwJ7bnwHPoew++
	NOifzO4iQMqS4LAC/98T9HRsFvkguMRcd+gxzuy9dwOEy/9MifUHC6gpyzfiJah+akSZlR9xfa8
	bD7nyxw/l0+TgLg798mTMV/KOOLFxogwk6OSM517BocUBf5RgslLkw3d6DzlyQo/VQbHQvKPAm9
	RVjATq+pzS0YNOEP8IuzZRps79T8L+Yu3VLr6RJexHUBltbWKGyea7DEzE+NcHBzKQbEOMVCGDK
	uGrkSrVzSsSqq+lIz6eHxYn8zPTf9jnc9sVECSeg6kCqz6pN
X-Received: by 2002:a05:6102:370c:b0:7c3:2b19:6266 with SMTP id ada2fe7eead31-7cb3739fd7amr4589811137.22.1792084763651;
        Thu, 15 Oct 2026 10:19:23 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9900490dd07sm12972678241.3.2026.10.15.10.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:19:23 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:19:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.10294d16149b7@gmail.com>
In-Reply-To: <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
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

Should this return 1, like the above?

Not sure whether the verify_header return value is well defined beyond
just boolean.
