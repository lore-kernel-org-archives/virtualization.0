Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679872;
	b=bw9PK3lohPaEFZxooNM8iYtT1z5df9CgReE8SbP7/8DfElyoWl5/KzajFf/I7+TorizE
	 xCvEnKcR+mfCy6FyYWkD5uFg5aNnvvyrYxkGEc1BhUR6O6Gp5Z7gmgGZV/OLa+j6m6OKt
	 tr4mEBuEsSQ2gpc1M55ZPAamajiy/RZHN+l01c/0M1j/ntg+gC8ca+Nyltj6LLo9GfrGQ
	 E42DL4Z+jdgNqhLEtES9QtRxxXdm6AQ8pXiYYKjaTF8chP/K9jA0tByzM0+qrZpcUcg00
	 qHeyn6TERwoWpX63M4qCtidFFxCNBTC2GVhwhKoziDgnTl9xaU7V5R9wMllvX8XAJ4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wIEEgL0wnyCgnfYBD3fqLb39KxnaLSOeClNdZ/a2t8c=;
	b=Qcc8E2W8r1r4ZD99ZV9D531iQ2IIVxGj34BV/ghuJ5wCO2jVsYbY+yLQsq7rmgaIqb6b
	 OdmicqDeFHs+aVPuZ0IA70qFgpHjVQnQ2jE+XmYeFOldi1w5ZDVArf+zS7EUcGOvI1xjS
	 stAcXT1XuRESKi/dI6yy62XxniLmUMbQKYlNqLnMk0MiXQ7jz6xUpJ8p+sKe45Sx5ci6D
	 7PG/PxcDN+cXf41XqIJ0y6C2yOH+fD/wYkNji4n0hy5WupATpcECj70mgYhrLFN5oJU54
	 +imr1znjFGWCYif7rPDlcaxXkg94Bhon9FpbNfWEjQdPVP1Rte3s57U+RhHGZwG3tHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ObUqVekP;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE1606A31B
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 14:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79BE1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ObUqVekP
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so1789131e0c.0
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792679871; x=1793284671; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wIEEgL0wnyCgnfYBD3fqLb39KxnaLSOeClNdZ/a2t8c=;
        b=ObUqVekP1GZ29AYZq8SKUeCSwYDVlSSqZka3VWdiF/07aYQLu1rRsjr8QO+79OLY2c
         PZphSTupuQRElSOaSBTZE90P1xUKYGh5yKW/JWtrEhtlI/kM6AWXM6jH94urT0HbiPu2
         atQwLEnVAlAnUGIvFpXK2vpCGOzAO3uqf81aqv2DEhG0AbP70liVz4l+WkCvb4IuWw7j
         GMQyIMKaEG8FjHdXcf7qGyjh2SvSia8YJo23Gb1C3R03gPisk9FyumZTrfNYfaOf6o7Y
         XAF3YMYZNQWnQ021kTIaEji7v3foQiM3AE32vKuNOTL5oJ38omBGAK9rEycJ3G2Rx3Ph
         hpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679871; x=1793284671;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIEEgL0wnyCgnfYBD3fqLb39KxnaLSOeClNdZ/a2t8c=;
        b=0IDUe4gbZSChv7cK1+oETRz5PRBwrcUNcyfKSmqvzTA8cg2n65WRK5+yA7orV4BMxT
         +g8p60MCGYxuypNANuxhYmTmXXu+CxgQKVjh7aMKVLVoEI4AblQOQKrPSFNa+djfTX92
         NKtupadeJxIDzmvFFtVPwgEO8TKVnsbfVltcMGv5oz02MgxkjJQzUHp65ianexD/ulaC
         YclDtRazdLUkMzULKsSwTcjj04zGl93iAeBrpmskGRVg5LC5HfEsEP6oNArOaQLo8ixX
         cGX5DhOzYOiV0HOigbYSHZ02VB8T2o7IhjRjU63e2G+5ECxt23TiwAtcDwvm+CJzlw0d
         y/9Q==
X-Forwarded-Encrypted: i=1; AKwUvByJ08GVlcdBRt5CT8tw23oJeO63J26nXv4I1kpu+gyG+Y8TvgVoHoMrLpSjfEhps7GSmlkdc5GH7o92JG9Rtg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKWQrZePIOQVakr6JCb+DObeqgMjGggJyNqGQ4XCBv6qJ3xkHo2
	pqPPvuWWYyZioHr5wPHumk+/i29GCjfWDimtdZdfxpx2pwDl+ZtXsOPU
X-Gm-Gg: AYBFou2ByHwAG1SxGzohpMr/qcwIGrDkYahLqIH4s7mjfuJ9+5S/uCBn8dtVDzTW7or
	l75C8oM+R1TZwHlV7RWroomHRzbfMgefsF7AZIAqjFGi9mpIw6wsUnWO1m6yOSFah9hY7fjRvvQ
	zqkcpy7sV5rqT9vv+w/oUwWpMDWjPde5M/gBZvxZRCgLQpAUac1v+4K5bKvShNPEBHxccLHgv29
	v9U43kynTATmjQjXIwSTAVtUgohdalJfNlrkLgS8d29O1b+ZejMpYbV1QJcvbeyADhTL9lnR/gf
	XlVqy6OjShyKOWomgV6A2HkDoDNT/jpwkwaCvNiZHzLz/FcmbMoIjCTK02h6qrzRTfsZZhEpAWT
	6aJ4RrBS2F0LOEGMwVc9DG1OdJ/44NofeEgONuWOXjF7Mcj2utloZrKDf+5Npe2GJ+dOHEWhg6A
	/+25BuPiBX2ZazJxhCOYgKzKUNfory90dsuXU5fAR+BOuB1Jk86xC8S/d9dOgF2jc6S3EEdZcKH
	0pzhNAsuz0rrOTCoh9HYeuGD32JaT7Qq+FepSfI0KV5n6GanqhajZQkT3lijsy8/6ap/5Y+b4hi
	a9oxFtsyNJ9MwbLMjK3Qb9QVqfaQ8edNKsHy24Huk7WMKmDBIo9s39JLoRMRBlRTM3LAOKU61Iv
	u31m4djhi9AaqiS/9A80=
X-Received: by 2002:a05:6122:2984:b0:5d0:1207:b693 with SMTP id 71dfb90a1353d-5eaebc25d1bmr2672346e0c.1.1792679871554;
        Thu, 22 Oct 2026 07:37:51 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97be251sm6978325e0c.8.2026.10.22.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:37:51 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:37:50 -0400
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
 Simon Horman <horms@kernel.org>, 
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.27710620cf132@gmail.com>
In-Reply-To: <94796ee3c32e50665ecf70e2b390db1bc2773be9.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
 <94796ee3c32e50665ecf70e2b390db1bc2773be9.1792668082.git.mst@redhat.com>
Subject: Re: [PATCH net v5 1/7] net: account for ingress-resolved virtio net
 hdr state
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
> The following patch will add ingress resolution of uncommon virtio net
> hdr checksum metadata (software checksum completion at ingress) which
> adds performance overhead to the packet processing.
> 
> We should make it visible, so a hypothetical workload relying on
> uncommon metadata can be distinguished from none at all. This way issues
> in the parsing will be reported and not quietly pay the host-CPU
> checksum overhead instead of offload.
> 
> Flip every call to virtio_net_hdr_to_skb to test for negative errno
> only.  The um vector raw transport even ignored the return value
> altogether: rejected packets went on into the stack with their
> metadata unvalidated, so check it there as well.
> 
> Have tun count these events per device as rx_csum_sw, exposed via
> ethtool -S.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
