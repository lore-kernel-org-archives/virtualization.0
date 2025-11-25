Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2D22DF99
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082931; cv=none; b=XfptRfAs4wWOTbLMCFuCXW1jlP4jyk1cHLgESvJFX1xnwrzS1PKclsKayf4Ivp/D+edp4404KSUb6ED/9I55prrtY2+OiwxIzTPumYN8KksyGyQHierAefGFuQAOomu1pKoz9SkhRhisniEPGIIPFpE6krS6EcZpFA5lgPir6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082931; c=relaxed/simple;
	bh=MA9QsTVtWgsvfIublM08n8V07qfNyZI6ksmu7VUM+Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IKiYrG8yuFcTQp0lQHqJgedBJYQVExinms/1CCtWBJc/UzZXHpel+VBBwkbyTUkutB+5rqWoaq19bgOyQZ/DBYbOp8AehOQdw/FKvmegECYVunZG78vdgsuDaBLrDE4Avs3ap2Lzj4WXnJx/HpRFs6wFhAXKOHOwkx/PXCOKK0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EqIroag1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqIroag1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764082929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09KqEaOP5fl8HujAjQhdvyXU7ffK0wmWeHz1wD48GE4=;
	b=EqIroag19rralZILbIkUISF84q4xBnzJVdAbjiSRNV6g0JY3eNKSe44cCokVZD62gsmckW
	JqhJ0gqXclSzr2pkdOg1msmFmhAGuRxJF/+/1w6UCP7DSxhyetruwE7DeNKJpQFG942t/X
	/VZPqux2wVPhz714iXYg/WFha3xwvoY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-6NzNf8QAPDaCUTVSbFbaEw-1; Tue, 25 Nov 2025 10:02:07 -0500
X-MC-Unique: 6NzNf8QAPDaCUTVSbFbaEw-1
X-Mimecast-MFC-AGG-ID: 6NzNf8QAPDaCUTVSbFbaEw_1764082926
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso58018915e9.2
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 07:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764082926; x=1764687726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09KqEaOP5fl8HujAjQhdvyXU7ffK0wmWeHz1wD48GE4=;
        b=SYnzgxaJnUZguFBsPSEi13iheFtaFL0ka1DhTdADFSXRgDZET3+KGSx9v4+CSFUJVd
         KKe1VHfE1M5gou4CIoG6NS7VpfZsDCYr/W9+Ls+Ynz6Fwq3/sYIbWZ6xMc7C2As0cyCu
         lY76p6hngGdU3Wb+CTb4afQAORZ+RgGshWDfhgB79Caln5ihIj2OnrDJtcIwY+v+JnDi
         tNy3PlUlmJQp7ySlBRPqykw8tSB3R6diyP8rwp+2XcEMoBpDxskvXTUhu407ayBPSWh1
         qhsSVhTL7TlD4bGnViDmbEG9u+Hpa9L14pxw9d5YmAWyez+0SFvwcOzlAixSFZN5eqAD
         s7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVjyFtr7MYBeqcPJ3HX8Am3RY8eMwuKRSOadbWmYM15xUOAgeAV+/qn8cq/pVRbR+D7/od/1W4v5LECgGgEgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoHUnA/X8tYxI4oqOiYuneXkPYh/yuWAZ618WrK3/aVAfuqkPC
	emXqgEJ7XhTu25clPGyWHtEeFnQodLDYYStG9gbYQiF7w919a+92EvSC5xiryXNHtcoVz333549
	/+R7KEfEPoYE8oRZiy1fBYuwl8N4debDD16TV4BoscFlnoTUaDwkDhWeYY//1z0OevW9D
X-Gm-Gg: ASbGncvAMi9pLphIRGFNYbBA9zv1bF7lcP+YrePG0eLav+LAYwtkzeT+5aTgzdwRIdo
	HOs0jhvRF7WRMGwrKuVeGjj5KTxEM+SOe5aoAUXGuXqhOvleuoPltti+IUoqMV0q1A8Sa0LRnou
	1HyVdsrP5Mcq8HNJZ9wPDHZgwtMr6xKdR7OTnLn3w+F4NX8eFB2MQMaLBMHA56wgYADZhm8yfs7
	kUWJm1IxrOTqfXN+YW1QNA+YrK2vddS+++zE+swURrHtpgSYlfUTMg/3uQVIBu02x1tcFPQcASw
	e2+Ft76VVhJ38hDMbVhLrDHwZlziCRci1+wLhG4cEeUx9szeu9fsBvY8UtnxpG/au2QZjHGa6/X
	lCo09gwe8xJfECg3vCoYFW91dsyrsbg==
X-Received: by 2002:a05:600c:4fce:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47904ad9438mr24886175e9.9.1764082926352;
        Tue, 25 Nov 2025 07:02:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnxhF4yC89mPigrHkbVw1gVjo8TuRM3hL5MAajbA1OA7AnNYZFSuV4PRGzcMPXZxxaMN4l+A==
X-Received: by 2002:a05:600c:4fce:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47904ad9438mr24884925e9.9.1764082924414;
        Tue, 25 Nov 2025 07:02:04 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm273353425e9.11.2025.11.25.07.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:02:03 -0800 (PST)
Date: Tue, 25 Nov 2025 10:01:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 2/8] ptr_ring: add helper to check if consume
 created space
Message-ID: <20251125095650-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-3-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251120152914.1127975-3-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QN5MNaiNfS0NOuNcKaxbkT6Ov5B1hfFl0lsFuTn8SwM_1764082926
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 20, 2025 at 04:29:07PM +0100, Simon Schippers wrote:
> Add __ptr_ring_consume_created_space() to check whether the previous
> __ptr_ring_consume() call successfully consumed an element and created
> space in the ring buffer. This enables callers to conditionally notify
> producers when space becomes available.
> 
> The function is only valid immediately after a single consume operation
> and should not be used after calling __ptr_ring_consume_batched().
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Co-developed by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index da141cc8b075..76d6840b45a3 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -453,6 +453,23 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>  	return ret;
>  }
>  
> +/*
> + * Check if the previous consume operation created space

space?

what does this mean?

> + *
> + * Returns true if the last call to __ptr_ring_consume() has created
> + * space in the ring buffer (i.e., an element was consumed).
> + *
> + * Note: This function is only valid immediately after a single call to
> + * __ptr_ring_consume(). If multiple calls to ptr_ring_consume*() have
> + * been made, this check must be performed after each call individually.
> + * Likewise, do not use this function after calling
> + * __ptr_ring_consume_batched().

API-wise, it is a really weird function.  So is 

{
	p = __ptr_ring_consume

	return !!p
}

guaranteed to be equivalent to 

{
	p = __ptr_ring_consume

	return !!__ptr_ring_consume_created_space
}



> + */
> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r)
> +{
> +	return r->consumer_tail >= r->consumer_head;
> +}
> +
>  /* Cast to structure type and call a function without discarding from FIFO.
>   * Function must return a value.
>   * Callers must take consumer_lock.
> -- 
> 2.43.0

