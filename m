Return-Path: <SRS0=qgkY=OM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1383C433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 19:02:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F4861156
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 19:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64F4861156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16CC2606FA;
	Wed, 22 Sep 2021 19:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lAA8Rh9uComl; Wed, 22 Sep 2021 19:02:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 89F696068C;
	Wed, 22 Sep 2021 19:02:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CCA3C0011;
	Wed, 22 Sep 2021 19:02:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97C17C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 19:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 735EB407BE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 19:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6VEYLSucNLPC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 19:02:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 397664071D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632337336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YkGM074Sqzm2cnA7q+tjffVmS5yQ7D3vt1VWpyzRhSw=;
 b=QW+4WLKUCfc6bs5o2X33mOSeRtA0Mx8Pttr3DLinbjCQtmIIrtV7dUhJX/zMuyWppctRE5
 yWIJUVU7OQ19+6saV9zSeQP9AnFDdbvfQfaa97wyJQtJVhJQFNxFS+mnX6ics8ooi+/+tj
 UZTMyjfiRgoPhY5ucfGMj9nhR2MnLgk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-2S6ATy1HNJuFP5QuzaS5aw-1; Wed, 22 Sep 2021 15:02:14 -0400
X-MC-Unique: 2S6ATy1HNJuFP5QuzaS5aw-1
Received: by mail-wr1-f71.google.com with SMTP id
 v1-20020adfc401000000b0015e11f71e65so3065116wrf.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 12:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YkGM074Sqzm2cnA7q+tjffVmS5yQ7D3vt1VWpyzRhSw=;
 b=3Liyk9ctFNB/M6ntPDZt91TrZOYfMO+xM+c4oW1L7VN0u8erBt2GXANlcPcaZNkvOt
 +FhX2Q0yPNKW+/wDYsyl9jBtX6iK/ALgo1e9ekvRfT8USNeRg/ni/M9N7wYyEQFCUVvp
 SOn66xgG8KINW8+wHqCohEGBvH2tiIEPZWZn5+pN8eeP95aRuSqL1oz+ZW/1xQbv3KLR
 g6Xakgkho+kwhVdOFsSjifEwzyIANInlbqJVHvtTegxRPjyTvc5T9g6Lci7M9SeBu+Gp
 3bZw5DQ5nkKRDpWsUU3t2qZl+9Nih5EcyLGJYdZlZSWMcQygAFNNtYaq0WNbacqORg5Q
 /AzA==
X-Gm-Message-State: AOAM532NYl0VIFqpOBwrfN8G0T4b63Vb03g7IJhaHGnGSC9qXKsbr03e
 ldl7uCxWY7IqImGkxBFksq1qInAweqImFp+77paux4TCkZUVa58JLpPnplLsuFybfyWY0rqoIHo
 ZCspwvcfcpkQ9KSp8QA/CuqDhGJ1nfXusDUosrXcysw==
X-Received: by 2002:a5d:688a:: with SMTP id h10mr566215wru.331.1632337333591; 
 Wed, 22 Sep 2021 12:02:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1QZokQycw03rSq+x5aZ0qJCIjw+WMM0ILYk/1Fa7uZgHUbxN1UVcifVfv8Bu6EbjHNVe80A==
X-Received: by 2002:a5d:688a:: with SMTP id h10mr566190wru.331.1632337333363; 
 Wed, 22 Sep 2021 12:02:13 -0700 (PDT)
Received: from redhat.com ([2.55.11.56])
 by smtp.gmail.com with ESMTPSA id y8sm2972877wrh.44.2021.09.22.12.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Sep 2021 12:02:10 -0700 (PDT)
Date: Wed, 22 Sep 2021 15:02:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 1/4] hwrng: virtio - add an internal buffer
Message-ID: <20210922145651-mutt-send-email-mst@kernel.org>
References: <20210922170903.577801-1-lvivier@redhat.com>
 <20210922170903.577801-2-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210922170903.577801-2-lvivier@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Herbert Xu <herbert@gondor.apana.org.au>, amit@kernel.org,
 rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org,
 Matt Mackall <mpm@selenic.com>, akong@redhat.com,
 Dmitriy Vyukov <dvyukov@google.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Sep 22, 2021 at 07:09:00PM +0200, Laurent Vivier wrote:
> hwrng core uses two buffers that can be mixed in the
> virtio-rng queue.
> 
> If the buffer is provided with wait=0 it is enqueued in the
> virtio-rng queue but unused by the caller.
> On the next call, core provides another buffer but the
> first one is filled instead and the new one queued.
> And the caller reads the data from the new one that is not
> updated, and the data in the first one are lost.
> 
> To avoid this mix, virtio-rng needs to use its own unique
> internal buffer at a cost of a data copy to the caller buffer.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index a90001e02bf7..208c547dcac1 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
>  struct virtrng_info {
>  	struct hwrng hwrng;
>  	struct virtqueue *vq;
> -	struct completion have_data;
>  	char name[25];
> -	unsigned int data_avail;
>  	int index;
>  	bool busy;
>  	bool hwrng_register_done;
>  	bool hwrng_removed;
> +	/* data transfer */
> +	struct completion have_data;
> +	unsigned int data_avail;
> +	/* minimal size returned by rng_buffer_size() */
> +#if SMP_CACHE_BYTES < 32
> +	u8 data[32];
> +#else
> +	u8 data[SMP_CACHE_BYTES];
> +#endif

Let's move this logic to a macro in hw_random.h ?

>  };
>  
>  static void random_recv_done(struct virtqueue *vq)
> @@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
>  }
>  
>  /* The host will fill any buffer we give it with sweet, sweet randomness. */
> -static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
> +static void register_buffer(struct virtrng_info *vi)
>  {
>  	struct scatterlist sg;
>  
> -	sg_init_one(&sg, buf, size);
> +	sg_init_one(&sg, vi->data, sizeof(vi->data));

Note that add_early_randomness requests less:
        size_t size = min_t(size_t, 16, rng_buffer_size());

maybe track how much was requested and grow up to sizeof(data)?

>  
>  	/* There should always be room for one buffer. */
> -	virtqueue_add_inbuf(vi->vq, &sg, 1, buf, GFP_KERNEL);
> +	virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);


BTW no longer true if DMA API is in use ... not easy to fix,
I think some changes to virtio API to allow pre-mapping
s/g for DMA might be needed ...

>  
>  	virtqueue_kick(vi->vq);
>  }
> @@ -55,6 +62,8 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
>  {
>  	int ret;
>  	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
> +	unsigned int chunk;
> +	size_t read;
>  
>  	if (vi->hwrng_removed)
>  		return -ENODEV;
> @@ -62,19 +71,33 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
>  	if (!vi->busy) {
>  		vi->busy = true;
>  		reinit_completion(&vi->have_data);
> -		register_buffer(vi, buf, size);
> +		register_buffer(vi);
>  	}
>  
>  	if (!wait)
>  		return 0;
>  
> -	ret = wait_for_completion_killable(&vi->have_data);
> -	if (ret < 0)
> -		return ret;
> +	read = 0;
> +	while (size != 0) {
> +		ret = wait_for_completion_killable(&vi->have_data);
> +		if (ret < 0)
> +			return ret;
> +
> +		chunk = min_t(unsigned int, size, vi->data_avail);
> +		memcpy(buf + read, vi->data, chunk);
> +		read += chunk;
> +		size -= chunk;
> +		vi->data_avail = 0;
> +
> +		if (size != 0) {
> +			reinit_completion(&vi->have_data);
> +			register_buffer(vi);
> +		}
> +	}
>  
>  	vi->busy = false;
>  
> -	return vi->data_avail;
> +	return read;
>  }
>  
>  static void virtio_cleanup(struct hwrng *rng)
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
