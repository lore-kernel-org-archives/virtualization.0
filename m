Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD036BCDA
	for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209437; cv=none; b=j/aaMPEGP5uZ+lOvf4BUOAvh865R/2iN4/ujn1+qILVEhtteMavhcH7/5aIU5SGIKbYHjkWaues5TAkk/fyeFrFcRGsCwfJ/Z+TYSdzj1olNLaseJT+khYcY7NLIEQevcbPDEupCaBU8fQjHgUI2M38EowLA5qETT9EpyJCeTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209437; c=relaxed/simple;
	bh=l+K6tbrWC9zkTxzTWOaTIp9a1A/M9p538WfrxFmtoRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jeEkvHGBTOg+fF0uZPZzu3ae0hI59vFTW25hHv7i8B9v4LElR8KHIVEaJXS/4NPZeAMLUwsoVkIMmp73SfZiuSsNnh8z36PMB3KUTZo+XZTiVUAnALVYIBru+UVDXqedTry8Tw69I9r5Yk9F5j6x6v3a22FD/p10WS5NMfu8ryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wc3lYWRq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wc3lYWRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782209434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PUmg1owcAXLwOmouoaTEqv3Qxoebnbr/GBcr7oxvN+8=;
	b=Wc3lYWRqoMAsXushs0fCpDxwHps0lfxrKyLnAgKQ9HNZAiKAIvqUafc5MBc5ew53+SpiFS
	raDJB0bhLa9/XqHt1CxfETswXB4DSd1NMo88Stx24EFWmXQygUME9C4zrVXHgeX78JGJM4
	cp5jvU31oSfLH2FUeB2Y999xegiomkM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-P9qdq1ecPGmsfipwmTcsfQ-1; Tue, 23 Jun 2026 06:10:33 -0400
X-MC-Unique: P9qdq1ecPGmsfipwmTcsfQ-1
X-Mimecast-MFC-AGG-ID: P9qdq1ecPGmsfipwmTcsfQ_1782209432
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4924e099a17so12430065e9.1
        for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 03:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209432; x=1782814232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUmg1owcAXLwOmouoaTEqv3Qxoebnbr/GBcr7oxvN+8=;
        b=iAo2nYVpIJomRkmiV6tuFMom2hqWfa9j2ErdxfmCFtI/+xpdlSQI99v6jh/Idl+Gek
         gtyoqxdUXeBXWhaJKcCBxaDDclolxmW3fHPakAkI209BIAL3lRwKxMK3AMJwviahacxa
         MMmZYASGkRj+MDoRZYX9iXpUmRdnDss6Gjamb0UpEGaMh834dFJwb3oifNZx6gj0b7rq
         EQ8wBOU7nqbBX1vvkoEtWjs2tquSnDwOU7G+QXN+wsI8WhSYIYuct0D1N4MUcw2OxW2N
         CxeIlwjVUdkNjpv96wANkTYlMkATRC6v0cjrA8X1W1u5nEEojGm15bopADvfi2Q1tf+h
         gxiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BufVsjwaL0UW938GXNqA0jewM+Ow+pgw3oPDA3lc3hWE8BcEhQXIwbpcuhW2BfPmEmqmqdI8HwJzIJVHUkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPFlJBIeF55XFMQwQq5q8kTwrudlptmB4AArBW/R8iwLLIIrsU
	hjAAazOboyO+7qGk7wEDS0MQ0QiHkFhBfo2w0Btiz+yRFJ5TQwF8usbKJnZNRmkN5AQ6t736vw1
	DFxm7oINKt/hxTjwfSTnLJQRicfIltRPbz4D8Dk6O5MDA5zNM4irn9S7G19A3SQPOroIQ
X-Gm-Gg: AfdE7cli8V2zTlstWGVP9Kj+BZNZmWe5L1jdakc4ubeBO3KZsUv5QCUi+M4rnB+Kn5+
	LSrG6khKpdQcg7d9oDpEZaxFBKEcw6wOrykA2sbrAyuwO/3Yv2oP0UPF8NM1x+PsFR4d8hhY3yR
	M5Oqj5CXqY4vqLsqhO9sb0rlU9jrNW2z0eY73VIw73lLgOfyA/UNvqL3z0DVYLjjGXp6mcf1qA9
	XbfuBVhh25dqM2mI3eahAcyFak+dvGBouZaRNsukRpOqDIMVHG1plwgrPv1JI0Yc93yXL3iqeU7
	3fE555HYiqQ+yQTSqoFL7haAKJ0xquaeubyWq+g/jTxpE6p4cO1W4fSKAYIZ6SA3FStBNyloc3E
	8ak6b01Ogj2H7irDaUGKIEF6wD3fe3Bo3
X-Received: by 2002:a05:600c:203:b0:490:bf1a:ed04 with SMTP id 5b1f17b1804b1-49240e20f3cmr229677845e9.1.1782209432003;
        Tue, 23 Jun 2026 03:10:32 -0700 (PDT)
X-Received: by 2002:a05:600c:203:b0:490:bf1a:ed04 with SMTP id 5b1f17b1804b1-49240e20f3cmr229677425e9.1.1782209431448;
        Tue, 23 Jun 2026 03:10:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57afasm35603312f8f.29.2026.06.23.03.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:10:30 -0700 (PDT)
Date: Tue, 23 Jun 2026 06:10:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: xuanzhuo@linux.alibaba.com, jasowang@redhat.com, edumazet@google.com,
	virtualization@lists.linux.dev, tanglongjun@kylinos.cn
Subject: Re: [PATCH v2] virtio_net: disable cb when NAPI is busy-polled
Message-ID: <20260623055417-mutt-send-email-mst@kernel.org>
References: <20260623091901.118315-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260623091901.118315-1-lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Un1INwqLIue4BEOVdzef_2Avpfr9PjlDOVwLVMJv65g_1782209432
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2026 at 05:19:01PM +0800, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> When busy-poll is active, napi_schedule_prep() returns false in
> virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
> The device may keep firing irqs until reaches virtqueue_napi_complete().
> Under load (received == budget), it will lead to a large number
> of spurious interrupts.
> 
> Fix it by disabling the callback at the virtnet_poll() entry. This keeps
> the callback off while we poll and re-enable by virtqueue_napi_complete()
> when going idle.
> 
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>


Patch is correct


Acked-by: Michael S. Tsirkin <mst@redhat.com>

Ideally, I like to see performance numbers in such cases, to be included with commit log.

> ---
> V1 -> V2: Remain agnostic to busy polling
> ---
>  drivers/net/virtio_net.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..0a11f2b32500 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3008,6 +3008,11 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	unsigned int xdp_xmit = 0;
>  	bool napi_complete;
>  
> +	/* Keep callbacks suppressed for the duration of this poll,
> +	 * busy-poll need.
> +	 */
> +	virtqueue_disable_cb(rq->vq);
> +
>  	virtnet_poll_cleantx(rq, budget);
>  
>  	received = virtnet_receive(rq, budget, &xdp_xmit);
> -- 
> 2.43.0

