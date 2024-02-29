Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058279DBD
	for <virtualization@lists.linux.dev>; Thu, 29 Feb 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203399; cv=none; b=Adv3XQ7n0OgdrGOFOvMWOXLQOLqhX7abHvDnz9+cAFHBkQ3bCvkGs67CbA3N9NR9MWi1gGUMTy3MK6Fndc7M3h90kkLdDJvEOLfiCSntUHKnRf1C6q5cn4pz1FRy4KKNoo+TNI+AfqIQCn5dUdlELU1TRpNpAy0Fzf5u5b44hiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203399; c=relaxed/simple;
	bh=r/YIR6QTp9Qzfw6hUlS11RKo4Uxc3AFmaG9CBoXD9RY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmP5oB4wqt2xuFnhROowVwM4ZRaRW7iHmpoqfs2APa1a+uNLsQlFAv48yQFc63D96wEu1B5hmhspEFzG1C7Aq9UP6Dird3OHwNdPWNWGrEk/bvVFSGz61ZvAnzkuB9hhye3XMfJlj4zfATRNch9VJXcRmLiQ6alKclF9CH+k69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pad41vca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pad41vca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709203395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EkN5KZjflWnZpJdM3EgQLpW0iiE1RFtMgn/imMS/DEA=;
	b=Pad41vcavIggNQiYXsHxPKg4F4hIgpTxoKwL1mhxX6ns7Q6cYf2ThTlGsQGQ9mM/uU+4h3
	iTUm5FdzyV9+rRutjiftDKa1jwI/q0voS6SpDiL1AGz+gHvwDkmm27VqNNL2uWg0KRYR8k
	LoTkl/jLlTNDxe2VdVoEcpFzVh2qeKI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-lHeiCb_eOH6g-FVULgN3tw-1; Thu, 29 Feb 2024 05:43:14 -0500
X-MC-Unique: lHeiCb_eOH6g-FVULgN3tw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d827f1e04so119255f8f.0
        for <virtualization@lists.linux.dev>; Thu, 29 Feb 2024 02:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709203393; x=1709808193;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtYSKVHcGkmiG0WkHJQ0+oofirBnO53PO7FPiruqtKw=;
        b=sSCl1FjZjGtepHxhhKON/6lJj43+DpZsfmS9rcD9RlaHivc0pZTpNIi7tDQ20mgCJ0
         USyBBSOvB/nXv6gkWOe5sMWShCr1mE11gx/guDRagVEe/JOq6s7DFqAEvUNIfl7lJzxO
         LSiZFZFZw6S1y37aXtAq3auxUj3eu4tW8daR5Q7n6cYcaNJ7qTdwldX9qK8UY10Eog8y
         EoGR5QfbB6d0VpxJPg2MiaZpHDpVfvwwLfELLCsji2R4TuO3zt0Jha1XKkq70ApNm31O
         V2fPCwcw2rI2U9qwXbfXpt/oEonGW0H6aVDIpWd4obPIItPfeeZLB1nKrzHYv+FTswDe
         34kA==
X-Forwarded-Encrypted: i=1; AJvYcCVgsQOQxtI+TEFu7ebuNDgzMRFzGslhP6yPiCRdiQumDjgPN6IScNu76v611UmFG3J+Ep4uyxWkUCfXh+XABYN19mSPhc+AKaKRkK6PAI0=
X-Gm-Message-State: AOJu0YymAZ9HEssmPp8avlefZrZg+xQuoRcfpHVATLx4Ew1+8YLh5amE
	B3TSDG5SeFtawVNF9x2P2r3ijV4QahT3Yc3UG7tNYFZNLBUhtHsHZqhcQL1rwKaPoyhcKZiWl4a
	nWWzDNQWrqM9cQsq9XX5odvt2pZoX5DQ55KZzl8JMl8nW2gDxPhTzcwRjkK2JGeW1
X-Received: by 2002:adf:ff8a:0:b0:33e:1102:8fb8 with SMTP id j10-20020adfff8a000000b0033e11028fb8mr703885wrr.6.1709203392987;
        Thu, 29 Feb 2024 02:43:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIsQvtvMXLWTBHNasSdylfrG26iPdNEdTVfkfPJFsqMBAtAbkCZmkCfiQwjA3h4qoQSvlUeA==
X-Received: by 2002:adf:ff8a:0:b0:33e:1102:8fb8 with SMTP id j10-20020adfff8a000000b0033e11028fb8mr703867wrr.6.1709203392618;
        Thu, 29 Feb 2024 02:43:12 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-174.dyn.eolo.it. [146.241.250.174])
        by smtp.gmail.com with ESMTPSA id e5-20020adff345000000b0033b278cf5fesm1393832wrp.102.2024.02.29.02.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:43:12 -0800 (PST)
Message-ID: <75b6f7686c03519a1aaeb461618070747890143b.camel@redhat.com>
Subject: Re: [PATCH net-next v2 1/3] xsk: Remove non-zero 'dma_page' check
 in xp_assign_dev
From: Paolo Abeni <pabeni@redhat.com>
To: Yunjian Wang <wangyunjian@huawei.com>, mst@redhat.com, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  kvm@vger.kernel.org,
 virtualization@lists.linux.dev, xudingke@huawei.com,  liwei395@huawei.com
Date: Thu, 29 Feb 2024 11:43:10 +0100
In-Reply-To: <1709118325-120336-1-git-send-email-wangyunjian@huawei.com>
References: <1709118325-120336-1-git-send-email-wangyunjian@huawei.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-02-28 at 19:05 +0800, Yunjian Wang wrote:
> Now dma mappings are used by the physical NICs. However the vNIC
> maybe do not need them. So remove non-zero 'dma_page' check in
> xp_assign_dev.
>=20
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  net/xdp/xsk_buff_pool.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index ce60ecd48a4d..a5af75b1f43c 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -219,16 +219,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  =09if (err)
>  =09=09goto err_unreg_pool;
> =20
> -=09if (!pool->dma_pages) {
> -=09=09WARN(1, "Driver did not DMA map zero-copy buffers");
> -=09=09err =3D -EINVAL;
> -=09=09goto err_unreg_xsk;
> -=09}

This would unconditionally remove an otherwise valid check for most
NIC. What about let the driver declare it wont need DMA map with a
(pool?) flag.

Cheers,

Paolo

