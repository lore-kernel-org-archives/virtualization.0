Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640615;
	b=yvHzSPLqzBRfEpZFPAQkNucX7H6ZJ8tjV5c5TM1DSMkou2BxsuZgM/G59sgqwwG8NDRx
	 7PIqeaN5IalZA+IN2TWOR5cKm2f9NxvindQnW0VgSDt3b5UTMXd6wAvI6QxmAVWlAwXBV
	 D9xmitsl+zN6h35yC6rthw99I9Pt+deFfwj434hQdwkJCJwTOF4FeGL79viCcflS0XgFh
	 IutZGyR42LaYvyjXp4P0uOZZyxxLmCXFYe3RC0U4HKimc6avhqHRgAqOU/5ZzxfgbB6n2
	 HBYx500lAhPBEjPtH6fY0BW38M4PHfxkHD2eMMZhws14EJJfbrCzdVRW6OlIEuC1tjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640615;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
	b=TLIzQqiTaMvluFPEgMuZZSMPLWDs0fnPZm8lawlKDvOceYfpq/OkNOlO9ww0+RlFWq12
	 kouEGjuOQFXil5bjQD6dhAuapczHC6exmZ4xrWr70GIbxfXfRVrHCL2mM/ALK/tXSbMur
	 yh8TN/F7Yrrc5sqCyNDisTavMKBV5+Luf4Ay/nYrT6bCSVr7qrUo97evuIhSuXYJpaXXj
	 OccNyul8/pnx0fFP3b0rdBWkvaN8ppITT07xdZ+zt0fvTEQSWs1rYMAxFPl8q4wghxSbR
	 RiEIJviyP6P3yhaCe+QGbSX9XMDgTll1ut2GWL/Z0HXp1YNTcfudU3JTMYm+Dz7O1JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=frJ5Xkpd;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B6606EE83
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 17:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A59B6606EE83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=frJ5Xkpd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793640613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
	b=frJ5Xkpd9I5BbZhSRFj8o6uCPLCcy9CCoZ+ovT/mIg2L0EIUXKLj+PhD/aFZnaH/8X0SOy
	r2VVMVGRSJZpUyyZNXuU2syuIuBnl3Z55za0YpnA/IL4x/ZFIhuY7ow5WWdgu+VPhpvaCR
	aIp6/y9Rd4mrXpgfEeLbquEduoRRjVc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333--i5Zg_5nMJSp5E_6USefnA-1; Mon, 02 Nov 2026 12:30:10 -0500
X-MC-Unique: -i5Zg_5nMJSp5E_6USefnA-1
X-Mimecast-MFC-AGG-ID: -i5Zg_5nMJSp5E_6USefnA_1793640609
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so2944283f8f.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 09:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640609; x=1794245409;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
        b=oTaZK+yP4GKL6U8bJHOtSanOzp+tzyHgTy7zBzs1q3Q+MPsEGZdfNpSfb9dzDKx0Mg
         Gfu1Y7kvYds0RQHjpjdMy49TT3Vzv1KOqo2kiVhS6dja59vQsK9ZxNtzz6F7h6vbdTEm
         PdSPw92EG4E4Wht7yiBK4rauDxc2JktHEBjl02PYkFgBs9LDEqCnY1HP4/C2dxz+lvsR
         DorQUKReDpQzS53oKMJ2WG+ySoAPSU6OJwHdvXv05N/XSNfsumMrnqCUUWjyykiI79WV
         +jna/051XEMASmCyEzWVsooIj4hxbh0JnM2ooIL638yy3L60Hfx7Hom9gGfJMlv8lVw4
         Vvsw==
X-Forwarded-Encrypted: i=1; AKwUvBwyexgYkJJY45qqCxTwpeJcqpkLgw7eXn/zWZY3ryvyfGScd4/P/8iQASV54CmVQlwabJAWnUnqqidaq15Qzg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIOHmzzFJWTuuM+ANM4h7WT2Q37w6HMbtZ2kl0Tjq0ZBVHBwuGc
	hZTgSIVHy2ymeYtpw3Zplg7IyQYHQLXsPXCk+srA/SK4WodBbxLHQbyKOgGrpvFinSHwylpXFuY
	gSMUE0f+qPr9cPRhQdW2wf2Zd30LxpIvVUzl6NTBDyKc6tOc00QyGj0hhppHZRtk1XDUD
X-Gm-Gg: AYBFou2jj/Nwb0yheOiXhr3qqpMSVFsR8ltTmp0e89U+3YZVIo6mLSOr1zyJSm9j6DJ
	wgp84eo3zeMMUeoLH7hrshQB4p0J+LK9mmYO03zRnd8kyMCWVRuGvqnvWg70FtNiuJicExTwRHj
	lgKZ/9ICb0oB1ihxRWplJzqhfqDcorTPtphRPGXBIMakCO91gTGkqDzsF3VyLk+smeCEJCbKj9f
	6WMiBfg/U1ozxFTRSHIeBhabui8q5gTFmutOPmWL83q2SIuMWm634AKs9oH5FmbfCNx7T1PPN/X
	9Ke35kZEvyzwCl8hVpDdh1EVHZqtEN+iiBf1IQ9CZOHsBJVldqtOz9AKmLREkpMLMr5ed+q70K8
	Vvfp2eqe3xNtTslkTaRrbnykfbBOWywXC9xwASzXNZA==
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4acda922e24mr165297255e9.1.1793640608979;
        Mon, 02 Nov 2026 09:30:08 -0800 (PST)
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4acda922e24mr165296615e9.1.1793640608457;
        Mon, 02 Nov 2026 09:30:08 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a8d60ca0sm1461205e9.7.2026.11.02.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:30:07 -0800 (PST)
Date: Mon, 2 Nov 2026 12:30:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor
 tables
Message-ID: <20261102122942-mutt-send-email-mst@kernel.org>
References: <20261021070242.75009-1-fangxy@xiaopeng.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261021070242.75009-1-fangxy@xiaopeng.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u4RxOmLx4YUeSbkA5ZFRfAj6XBbKjN99JDTX1JM_Pbs_1793640609
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 21, 2026 at 03:02:42PM +0800, Fang Xieyan wrote:
> move_to_indirect() accepts an indirect descriptor with a zero length,
> setting desc_max to 0. __vringh_iov() then reads descs[0] before
> checking the descriptor bounds, resulting in an out-of-bounds read.
> 
> Reject a zero-length indirect table in move_to_indirect() so the
> caller returns -EINVAL before dereferencing the table. Also use the
> converted length in the warning to report invalid lengths correctly
> when the vring byte order differs from the CPU byte order.
> 
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Cc: stable@vger.kernel.org
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>


Isn't this already addressed by
Subject: [PATCH v2] vringh: reject empty / undersized indirect descriptor tables
that you posted previously?

> ---
>  drivers/vhost/vringh.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f12ba1..ce4f5a02c8d2 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -197,8 +197,8 @@ static int move_to_indirect(const struct vringh *vrh,
>  	}
>  
>  	len = vringh32_to_cpu(vrh, desc->len);
> -	if (unlikely(len % sizeof(struct vring_desc))) {
> -		vringh_bad("Strange indirect len %u", desc->len);
> +	if (unlikely(!len || len % sizeof(struct vring_desc))) {
> +		vringh_bad("Strange indirect len %u", len);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.50.1

