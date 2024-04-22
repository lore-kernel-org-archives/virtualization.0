Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004E84D599
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772091; cv=none; b=nwo/8GVAOKzC5N7BTo+DKvfUo+DhljRyGkzgtkC5PInUYgQ65+NBzLzk9P3vj+fvXoEcqLkEpTjQQ9B+7qD+JTMDQ9XierSKiTAHu7lyRzM31z8WV9hg4YaWbHA2OVCWVRLMOgr4KnrRU07XqConZq5+6Y46BRuRsHX7vpnGz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772091; c=relaxed/simple;
	bh=+Le8O3y3ZF7b0Pk7d5jUqHASV/4jEPQk7MZuP9/9eyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ts8xhN7iWeudn5lAbw5sW4mtlAJ18HlYoFeKqmo3WHrDh0MExjOMOeTdZJcsLZH4FVO7kEi3EleOCEHvIr2Fo8Ho1O8HgneEDJpz4L30kII8rozusv5oh/yeguDUdXc5nYWfN7xD30wgGHVzVsP6f45EYCoGIaQFyYDUbLmKc7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiVxMNdx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiVxMNdx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713772088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nDhkSI5Nf0QFXxHxJ2ctMYHWbyZi+j/l4h8WJWCXrLI=;
	b=MiVxMNdxYFm7NOiGBfUd6ntvSu6If6xufsoKaXoNkYUHyQ5zodfJh9hGELhQQ9ADtUG0Bj
	K/j/bGpFizb3S/8/wWk/8KajgBj2NdGOteyO67fAzyw+m59cUMmbMuQWfd1YHg7RZAXd/E
	GepCfyn4Ms9iQS08MqJO8RTjRiuJJY8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-cyxief5zPsCsKVwZFaczQg-1; Mon, 22 Apr 2024 03:48:05 -0400
X-MC-Unique: cyxief5zPsCsKVwZFaczQg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-418f8271081so13980695e9.3
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 00:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713772084; x=1714376884;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nDhkSI5Nf0QFXxHxJ2ctMYHWbyZi+j/l4h8WJWCXrLI=;
        b=Kq/Kt/hNRuqpD136qIgo8j5NITfMQlu5zDASzoklwdkUO6S3AMgv0CnHIXR3sofZDp
         npuaYF6L1F/flptQO2uJ116O5KRVwnlWC9ocJI5svfPX7t/6PKhtANxHBittoF07r3jd
         UyXNcXS/OQptAg9Y5cAXEFeNdSN02Qkwy5ogVCbI8Jccy21+y770hKeYiJGsiBHnwz9U
         8i1kHJXaYkONWvKnQzA0/rjR2YV0o9h1G4VrYovnf3yeEoKXS3LJsjY9xTdDB5ZlTYY0
         gWZthJ3NoOYpCpxRH1oSHhc1lq3BNnCRUANYT2fsid+LEi/ryRjc0CUK2Miiz0mk3K7C
         YOBw==
X-Forwarded-Encrypted: i=1; AJvYcCVn3B8v3/eH7CUySyXt64v1zfskFykCkrJ07Yli4MmZ+rr9rfE/phh7ZiAOo0kmPM3IwmnVeIsejXNq2vFcQQipW8Rd7ktgRqHIHpH+x0I=
X-Gm-Message-State: AOJu0Yy6TZ6qMrGeAvE89jo+vl/yczOehx7CjKSRvK5zZrsgFgrWci/7
	qRAUfmZPD4k3POPFW6L+JnK+XyiTnJ2B00aaaHoT+mJaoBiQjn5gd2sXhjk3dRixtZfsPQNQD2T
	ePHjv65xAfOcMH5GiwsDNbhbWQ3agkfWiCoT9lVsMu9l+hUf7VZGAM/NcPydRn8DIhMNc5ebN
X-Received: by 2002:a05:600c:a007:b0:418:d3b3:321f with SMTP id jg7-20020a05600ca00700b00418d3b3321fmr7854785wmb.18.1713772084056;
        Mon, 22 Apr 2024 00:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcznxotJCFnicrgGOoWkdICH6GLFX1EXqfpuJdH6MqUgYPST0gDx1y6PTHJy1Id/nHLXKJgA==
X-Received: by 2002:a05:600c:a007:b0:418:d3b3:321f with SMTP id jg7-20020a05600ca00700b00418d3b3321fmr7854768wmb.18.1713772083676;
        Mon, 22 Apr 2024 00:48:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b0041a1fee2854sm5099171wmq.17.2024.04.22.00.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 00:48:03 -0700 (PDT)
Message-ID: <9d70583a-565f-4523-8707-325c3af9a164@redhat.com>
Date: Mon, 22 Apr 2024 09:48:02 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] virtio_balloon: introduce memory allocation stall
 counter
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
 <20240422074254.1440457-4-pizhenwei@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240422074254.1440457-4-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.04.24 09:42, zhenwei pi wrote:
> Memory allocation stall counter represents the performance/latency of
> memory allocation, expose this counter to the host side by virtio
> balloon device via out-of-bound way.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/virtio/virtio_balloon.c     | 8 ++++++++
>   include/uapi/linux/virtio_balloon.h | 6 ++++--
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 87a1d6fa77fb..ab039e83bc6f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -323,6 +323,8 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
>   #ifdef CONFIG_VM_EVENT_COUNTERS
>   	unsigned long events[NR_VM_EVENT_ITEMS];
>   	unsigned int idx = start;
> +	unsigned int zid;
> +	unsigned long stall = 0;
>   
>   	all_vm_events(events);
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
> @@ -333,6 +335,12 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
>   
> +	/* sum all the stall events */
> +	for (zid = 0; zid < MAX_NR_ZONES; zid++)
> +		stall += events[ALLOCSTALL_NORMAL - ZONE_NORMAL + zid];
> +
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
> +
>   #ifdef CONFIG_HUGETLB_PAGE
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
>   		    events[HTLB_BUDDY_PGALLOC]);
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index b17bbe033697..487b893a160e 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -72,7 +72,8 @@ struct virtio_balloon_config {
>   #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
>   #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
>   #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
> -#define VIRTIO_BALLOON_S_NR       11
> +#define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
> +#define VIRTIO_BALLOON_S_NR       12
>   
>   #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
>   	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
> @@ -85,7 +86,8 @@ struct virtio_balloon_config {
>   	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
>   	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
>   	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
> -	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
> +	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls" \
>   }
>   
>   #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

