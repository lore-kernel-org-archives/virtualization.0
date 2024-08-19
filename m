Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00615D5CA
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060689; cv=none; b=sAwLoJIpewNvSXzqzgLYM1bz23kqvHSVnb4dicpgyahm2jIVj+GZc2wuusDYCTCgIndgxgWq+Bho/BhDDoflaIgucKpBI3fFjGEej22eycg/9oWGoia0pecYbQR9rkRgNOe4zxPVauicJfVGEGLQqoGAk+ViMA60qPNaqTdygPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060689; c=relaxed/simple;
	bh=oFZo8VMWs1L2puSxYnHxymDvtmGw+HQlQEA7PUIHh34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X99qKu3BSArYSLMdKsCj7r6aqWRiFCRyJ/heAqPY5QNTQtKu+5gDt23rNXyVr7HlpiUopMmuAyrvKol3QEAJ2pVtSJi9v23PuEJbIRGBG2TukFs93WvD/24TMy/ciJcHPme87W5x6shHfsQ1sjJkboEN7Ct+BRupY0avNiA9uW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMvUx+s4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMvUx+s4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724060687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X7b+bc2Fo4YhsnAnVepxHT46haDI0ngnxKTuXpjd31Y=;
	b=dMvUx+s4FlAaXkFqZoaEMS5BBtpr3TLqVLD6Tt9Xz+UiO7UMf+wQs7l2r5F17qYexh7+Hq
	PtnmbR+cqd1wB9feNk4pAS2zcw1PKPSLwof+JYPXpLPfSwjfhLI8IE7v0HFOLZ1oR244Mr
	GaJWLYlzabP5BzpyZzuxAe9InhWPItQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-tvkZKRi2N2Oqms5Z7o7Vww-1; Mon, 19 Aug 2024 05:44:44 -0400
X-MC-Unique: tvkZKRi2N2Oqms5Z7o7Vww-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52efce218feso4389428e87.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 02:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724060682; x=1724665482;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X7b+bc2Fo4YhsnAnVepxHT46haDI0ngnxKTuXpjd31Y=;
        b=PlIOfANgXuNdw4YCwpyGiifbI3m2Dkg71nQlzxAmpgtSjXsbU98IRb6EUP1nx7LCdb
         ERgfdthTfmuIY4XT/5tQaJZ3eRx8ZCPBDmSalVLcTYAnIN/W2rTY89ZWaVaqH50isLkf
         4wygREanM8I/t7wxhlPFVdfABywR45cQerdujRaSvKhhXuZTCFTU5TKGV6j9eeNwbD1N
         +LszaazRR89We2s2z5CbDO7IxYUK73fkeZEF9X7IVr+fU+D92NBaOmV8BxNjE+ca6dGa
         4z+jJ75pMTtDIDTg/7vhk8ZKhmVj5Y4OyeA/suOKtdA/QtDdX4Jl44RsR95e/qbzCajy
         u2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXM9TO8aL1FU6tZ21k2BCz6Irq+zxyBmV8zKmclp1P6X3U5JcNaIaBbLcmQOyzDOJhSzaeaWbj9apiGOf2BPmRvVBByGeo4pdT7FAAWPj0=
X-Gm-Message-State: AOJu0YzW/k40othfC1ZV8hilTPVWpf7EEySqolsrVdmbnN9Hcz1nS1XT
	yL4Nnf3cJzh6O4UJliYhZ9Pjshcz7O0Uf8dSxqm54Dul3PZWUqJS6Hk29g71qYhLUwf1ngfGYTR
	gNmrEAV58VQzTDsjkUleBv7pllcTSHevRCQPpH6QT4crTMISnWEZUgg0abte45r/+
X-Received: by 2002:a05:6512:3190:b0:52c:f2e0:db23 with SMTP id 2adb3069b0e04-5331c6e23dbmr7076110e87.40.1724060681645;
        Mon, 19 Aug 2024 02:44:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbYGv1dAC8BOp9d/6TNk5lzGG8ZgJtu5nNzr+cDStN+Hg3fhU03hbsM1RivhzFc0Ut8BK3Ug==
X-Received: by 2002:a05:6512:3190:b0:52c:f2e0:db23 with SMTP id 2adb3069b0e04-5331c6e23dbmr7076080e87.40.1724060681068;
        Mon, 19 Aug 2024 02:44:41 -0700 (PDT)
Received: from [100.81.188.195] (ipb218f908.dynamic.kabel-deutschland.de. [178.24.249.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935710sm609276466b.129.2024.08.19.02.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 02:44:40 -0700 (PDT)
Message-ID: <c27716a2-3e9c-4b16-9c4b-7b7d1bee9ce9@redhat.com>
Date: Mon, 19 Aug 2024 11:44:39 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, mhocko@suse.com,
 penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
 torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, virtualization@lists.linux.dev,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <20240817062449.21164-5-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240817062449.21164-5-21cnbao@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.08.24 08:24, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When users allocate memory with the __GFP_NOFAIL flag, they might
> incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This kind of
> non-blockable __GFP_NOFAIL is not supported and is pointless.  If we
> attempt and still fail to allocate memory for these users, we have two
> choices:
> 
>      1. We could busy-loop and hope that some other direct reclamation or
>      kswapd rescues the current process. However, this is unreliable
>      and could ultimately lead to hard or soft lockups, which might not
>      be well supported by some architectures.
> 
>      2. We could use BUG_ON to trigger a reliable system crash, avoiding
>      exposing NULL dereference.
> 
> Neither option is ideal, but both are improvements over the existing code.
> This patch selects the second option because, with the introduction of
> scoped API and GFP_NOFAIL—capable of enforcing direct reclamation for
> nofail users(which is in my plan), non-blockable nofail allocations will
> no longer be possible.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: Hailong.Liu <hailong.liu@oppo.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   mm/page_alloc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d2c37f8f8d09..fb5850ecd3ae 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4399,11 +4399,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   	 */
>   	if (gfp_mask & __GFP_NOFAIL) {
>   		/*
> -		 * All existing users of the __GFP_NOFAIL are blockable, so warn
> -		 * of any new users that actually require GFP_NOWAIT
> +		 * All existing users of the __GFP_NOFAIL are blockable
> +		 * otherwise we introduce a busy loop with inside the page
> +		 * allocator from non-sleepable contexts
>   		 */
> -		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> -			goto fail;
> +		BUG_ON(!can_direct_reclaim);

No new BUG_ON(), WARN_ON_ONCE() is good enough for something that should 
be found during ordinary testing.

-- 
Cheers,

David / dhildenb

