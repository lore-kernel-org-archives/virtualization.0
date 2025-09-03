Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9A0302778
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904725; cv=none; b=qdT6Mp3+jSNyBa/4cUCKlpcfO2tm0yO1Nl3c6yXPp8eiXN+ezscCgqjjdw72V6VoKSMDtK1/UFUyJXQnrZKvjI6zozWCLDZKrcrlFmutGwq00keDG170uqEnsgN4gBwnNqGHnCxphKtAmBu9zmbnHeVzk25jzwQgYAOBnCluOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904725; c=relaxed/simple;
	bh=wx8Tfq9Xifa0zuCHejFIDyBweEYkpVa68tCxnuiy/sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XNPpVbqHS2eRBh+zH50ZdBYOnNplSUjJMJ+TSGexUOm9V6r56bVs31S8kxGwlQH47UV23jsJu4ShoRplsvh6bCxRxXLDPkBa/Nkg5q6duQ/lgCtLhvB0JvHsQPHkGLsig9CWHH2JaFXtmdkJzgtvEJuLnEaJEmVIciA7nSzzAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtGXdZy1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtGXdZy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756904722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrgPdVi1Tq/sUmSfRfVNUoce7RWoUa2jBaIiUDjya2s=;
	b=TtGXdZy1x77dWaxz7bj+NwRIj/PrAbR2cE4iQ4H6QOMXPtspxSD4zuL2S+mkaZJ1pgYkzM
	tHxMzFs+Mh23AbG7JzskdVPpjopM3snFAcH2e9YEq+HEEzaWoP8ss66pKVjBxqEvXMFFXc
	vHcUEfINhy8U96muIAvAIv2PGSKbtus=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-ZZJGNiJKPpSS--JkrJv4Ig-1; Wed, 03 Sep 2025 09:05:19 -0400
X-MC-Unique: ZZJGNiJKPpSS--JkrJv4Ig-1
X-Mimecast-MFC-AGG-ID: ZZJGNiJKPpSS--JkrJv4Ig_1756904718
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b99c18484so8361345e9.1
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 06:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756904718; x=1757509518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrgPdVi1Tq/sUmSfRfVNUoce7RWoUa2jBaIiUDjya2s=;
        b=vz8GoLnKlSmpf/5ACwk/CTph/v7lU7AF2A9UCyAMCSf21nn1Xi1t1NsRu3G+to1N4Y
         IrT00ndnWNTSzOXzF1vE2mkLDX8e/l+wnYtUgildKklOy682PLmtssVtzrLHCYkwuNzb
         I1x1b00PQr36INq/K+zCFMEC4xI+KF6r2OFhc/2gUsTGMMutTKo6bx0f1UBl1AWjH07c
         wtnsukMGOqB/zK6vCbYqKgAGUw1mM/vPVUyWsuZUcPCiDwTiskuAQRvO9mHLvrDIkb65
         WNODeztlZyA/J2TCRSky+Cv8pXFyQwlyKZJpB/YbGudIlHH5VKJ0VpRNT7NrRFaA6QDR
         TNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCrV3HrwNg3M7axPthJgfGMJ2YcK4SHjsH5uEidMGnaBMhvXzcnUqQ50QJZ7r2dGbXE2YULL/bLQfgX9Wp0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQ8ROlcNeM2DchBd2Gn0kWHjJ2UC8404OhIF0Hktg44osQ6VNu
	Qt07q5QrKdULWcxy1eadHLXbfVUYh3Qso79q4McFRAfq+c/JtZbRL2KzOPd/VGmx2gv0FZMLoyZ
	hIU2U+mJTUnRSFyQWe1M8RS9p2BFOCcf3jnsm1Jj4jN171wjsNMBuSbQOoAdU67I0XhPY
X-Gm-Gg: ASbGnctA7earMDQaYzgINrimYdPNlV5HRxYJukWo+SC8I2Wf9Erdzp9+J4ER9XvMqsX
	EbRwfu/SOSs1/V8+XDrL0vQcEw+iN6mGUNKqfA5xDLMK3c7F4SurpnROKHwu5dyPYW2TTl86Euj
	e8t7uABsQ/Fb8dmTIAaxwVCl15BIKVr9TRZS+vfyQnan3S+PJnMtXDjfXaKjO1ho2p7ni1X7GSN
	xbcZplSOc0Ogr/e987fbTLAGw4p0i0tusbFlg5yetkpBpm++jmdmhMR1v3CdWdTTlBEfp9T4KLL
	Mba9WkPKTpWVg7YMesUgRDrdzi4WnA==
X-Received: by 2002:a05:600c:3ba9:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-45c6fa9a71amr30616515e9.22.1756904717710;
        Wed, 03 Sep 2025 06:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtX1RsxlJvS5LBnQ6eZx2sJEwHto6VMfJqc79cmA6A9vHdfuL33yrAr/RXggLaExbbjXQUzA==
X-Received: by 2002:a05:600c:3ba9:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-45c6fa9a71amr30616165e9.22.1756904717260;
        Wed, 03 Sep 2025 06:05:17 -0700 (PDT)
Received: from redhat.com ([2a0e:41b:f000:0:c4d3:2073:6af0:f91d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b88007a60sm98473065e9.8.2025.09.03.06.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:05:16 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:05:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH 1/4] ptr_ring_spare: Helper to check if spare capacity of
 size cnt is available
Message-ID: <20250903085610-mutt-send-email-mst@kernel.org>
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-2-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250902080957.47265-2-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XvTPjn14_Q-iQPDbSFNW1PXIlOkdqWAyBRgOcRjtL1s_1756904718
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2025 at 10:09:54AM +0200, Simon Schippers wrote:
> The implementation is inspired by ptr_ring_empty.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 71 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 551329220e4f..6b8cfaecf478 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -243,6 +243,77 @@ static inline bool ptr_ring_empty_bh(struct ptr_ring *r)
>  	return ret;
>  }
>  
> +/*
> + * Check if a spare capacity of cnt is available without taking any locks.

Not sure what "spare" means here. I think you mean

Check if the ring has enough space to produce a given
number of entries.

> + *
> + * If cnt==0 or cnt > r->size it acts the same as __ptr_ring_empty.

Logically, cnt = 0 should always be true, cnt > size should always be
false then?

Why do you want it to act as __ptr_ring_empty?


> + *
> + * The same requirements apply as described for __ptr_ring_empty.


Which is:

 * However, if some other CPU consumes ring entries at the same time, the value
 * returned is not guaranteed to be correct.


but it's not right here yes? consuming entries will just add more
space ...

Also:
 * In this case - to avoid incorrectly detecting the ring
 * as empty - the CPU consuming the ring entries is responsible
 * for either consuming all ring entries until the ring is empty,
 * or synchronizing with some other CPU and causing it to
 * re-test __ptr_ring_empty and/or consume the ring enteries
 * after the synchronization point.

how would you apply this here?


> + */
> +static inline bool __ptr_ring_spare(struct ptr_ring *r, int cnt)
> +{
> +	int size = r->size;
> +	int to_check;
> +
> +	if (unlikely(!size || cnt < 0))
> +		return true;
> +
> +	if (cnt > size)
> +		cnt = 0;
> +
> +	to_check = READ_ONCE(r->consumer_head) - cnt;
> +
> +	if (to_check < 0)
> +		to_check += size;
> +
> +	return !r->queue[to_check];
> +}
> +

I will have to look at how this is used to understand if it's
correct. But I think we need better documentation.


> +static inline bool ptr_ring_spare(struct ptr_ring *r, int cnt)
> +{
> +	bool ret;
> +
> +	spin_lock(&r->consumer_lock);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock(&r->consumer_lock);
> +
> +	return ret;


I don't understand why you take the consumer lock here.
If a producer is running it will make the value wrong,
if consumer is running it will just create more space.


> +}
> +
> +static inline bool ptr_ring_spare_irq(struct ptr_ring *r, int cnt)
> +{
> +	bool ret;
> +
> +	spin_lock_irq(&r->consumer_lock);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock_irq(&r->consumer_lock);
> +
> +	return ret;
> +}
> +
> +static inline bool ptr_ring_spare_any(struct ptr_ring *r, int cnt)
> +{
> +	unsigned long flags;
> +	bool ret;
> +
> +	spin_lock_irqsave(&r->consumer_lock, flags);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock_irqrestore(&r->consumer_lock, flags);
> +
> +	return ret;
> +}
> +
> +static inline bool ptr_ring_spare_bh(struct ptr_ring *r, int cnt)
> +{
> +	bool ret;
> +
> +	spin_lock_bh(&r->consumer_lock);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock_bh(&r->consumer_lock);
> +
> +	return ret;
> +}
> +
>  /* Must only be called after __ptr_ring_peek returned !NULL */
>  static inline void __ptr_ring_discard_one(struct ptr_ring *r)
>  {
> -- 
> 2.43.0

