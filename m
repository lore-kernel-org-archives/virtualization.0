Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3792609E7
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835080; cv=none; b=PvQiUwo5vbyfN67t0C30xUidLDfRI4fFGIqYo/lT+M7gEmqD6eIg6dEUuNVabKGVMED8i7FHsigEQyDyF4ORwdwqh28hIgbUsJl1nfRpHeW3OrR7PfWU7PlvObrddEitST1cdygtBXt7YERIURuEQi44UXp/Xg433CySEDIK5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835080; c=relaxed/simple;
	bh=4VVvRSvSoknHCXGPXjtyoDxdlwETrsjKNpGXzeIveWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNCvhs5e8WSW6V+fc2SYj0Lp+SG75ZiPutJpaGgjpcnHbba6nqbwxrQeyxGBYz3ZGuVcjMiet3blk4PB9yDkVb09I2DXpVWCH7Y9b48f4BxyvcUhiWdDjiPRGtZqwppDviHop/noWbHxBFfQ5QWmq1uB9LcFE4fihYC/wQtGW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8JgMLiZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8JgMLiZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747835077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jPT7ti85BMXvw5SEl5t5/PrduEzVATIbbbTjYqzIvvk=;
	b=E8JgMLiZg3ow1zSSzH2iTEaJ01skVkG6rQpLwvmyTBAHAKNfj33BC/LW2w06QwHbWssVSU
	i/hUII5+kDUIkm8UvSWDJhLlSWlyU4T1XuijxUFfGgKjajzElu3QVR4zYQH4FU47LVZiBi
	JDnKF9qman8lB1/+DsnGU8d86wTxS64=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-Fc23f42lPHOHFwm_GiwrFw-1; Wed, 21 May 2025 09:44:36 -0400
X-MC-Unique: Fc23f42lPHOHFwm_GiwrFw-1
X-Mimecast-MFC-AGG-ID: Fc23f42lPHOHFwm_GiwrFw_1747835075
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b19so54207595e9.2
        for <virtualization@lists.linux.dev>; Wed, 21 May 2025 06:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835075; x=1748439875;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jPT7ti85BMXvw5SEl5t5/PrduEzVATIbbbTjYqzIvvk=;
        b=QGJf+27C9sZ+EkrJPGSkiOIwycr7DCUlfmFR9wLDZ2jYovUJoYHJedG8Tfz5xUNMwb
         yi/sG+Nk/bXCXs0ZGlS7JOz0fLt6na41Q/9zsOac7Kn736S5Lfz5jKv43NZrDjkBtCfp
         Un3T3wdi4fDb2RNay/Bgp3FaSX1qRSU1spLTT0P71goH+6kKP5LHA4YEVAYjwkaa/D1z
         nA6OzxqqXaS76q3XzWGIr2CZfZLBgE45HpwBAVON05NnDrbUhmlUVj+DdI6AS60JCmO5
         VwRv7EI6S+vfgk1DcTmxuw+x7jD1aZxhASLd7LrncUfYO/kWOZrTyDOFgOyRy7dIIZvC
         V24A==
X-Forwarded-Encrypted: i=1; AJvYcCX4Gy9I3dMMBYaDeHOtbXlDIgvwv1fi+tyE60lEkBjnw1qH5hHZxO9OXjfW3TIqFxk+iBHrkuPgo+1ZHIXWtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxT6uRybXV4/uYeYAdGtTXJ1mTXPgukQ4DPQu/GIPj6eBuzlMAp
	1IDjDN5VN3T97LzOfpDY/XOrDTMmmZ7L96FbRvf3e2jHL7yWFnKAtvj3qLBEhomTSeHjgONf7pk
	Ajmg1uijQ+jr/QPQj8N9AQJm1d0vN8cbIyDRFqYSHWQ4M+e3OBAQGf1FNtPfXyBVnB0EP
X-Gm-Gg: ASbGncvKumWqA4ug+OB1lP/IFnIr5Fr0u/1YcH1HPYDK8/2Fg/MVizwrPuJhveOy1qp
	njj//s8427Qnj73d13nStCwcyIBCAGYi2svHboyiMAFd8sD8u2abU0oBkR5Lrb30Fe6Hy41fUZA
	pSvM3e9LM10aFvUPLqHDFSPAe1uFlA/CH1Gkuk3CyPiv9MpTLUKTCTwolz85hKgyRmZoUyUDPh5
	JL3D3IrjcI97ppSx9g7k9EQ2RfzUe5A4qYaGd7D2xgxzWF7BwCg3+36qdakDwFQj3gvQrmtQeu2
	GTQgMNUYz924SKX6qkvdfgShpr5pNYxVMwA9FJTY+2gHRaj7qWnbyNhfOprN0uhCwxnhaszwUj5
	I2NdPzNoRMrSKUnRFLJyOdmMwBlzK3Xo7XUjIuMk=
X-Received: by 2002:a05:600c:a46:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-442ff031619mr134359005e9.23.1747835075186;
        Wed, 21 May 2025 06:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd3Ojd8iPiq35GYQnoNfvhzqWHrSnAPIoSti+hjHKiLprvvjzCqEHVWl48QW6W2jZvJChrJQ==
X-Received: by 2002:a05:600c:a46:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-442ff031619mr134358625e9.23.1747835074775;
        Wed, 21 May 2025 06:44:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60? (p200300d82f259c00e2c76eb58a511c60.dip0.t-ipconnect.de. [2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7d975f4sm68860085e9.39.2025.05.21.06.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 06:44:33 -0700 (PDT)
Message-ID: <d7b756cc-8a39-4124-ab57-912bb97ed967@redhat.com>
Date: Wed, 21 May 2025 15:44:32 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/memory_hotplug: PG_offline_skippable for
 offlining memory blocks with PageOffline pages
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20250520164216.866543-1-david@redhat.com>
 <20250520164216.866543-2-david@redhat.com>
 <aC3V1Sr7rGqqgLzW@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aC3V1Sr7rGqqgLzW@localhost.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5Rr6yHNwn6MOkt8YFFKCyBi2qD3ibiUlINFtnLz-3hk_1747835075
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Hi David, sorry for jumping in late

Hi,

not late at all :)

> 
>> @@ -1157,6 +1083,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
>>   			SetPageDirty(page);
>>   		else
>>   			__SetPageOffline(page);
>> +		__SetPageOfflineSkippable(page);
>>   		VM_WARN_ON_ONCE(!PageOffline(page));
> 
> I think I am having some issues understanding this, let me see if I get
> it.
> 
> - virtio-mem defines PageOffline pages, which are logically-offlined
>    pages within an onlined memory-block

PageOffline is a more generic concept also e.g., used by memory 
balloning. virtio-mem uses that concept, yes.

> - PageOffline pages have a refcount of '0' once they are properly
>    initialized, meaning that refcount > 0 implies somebody is holding
>    a refcount and that should not really happen

PageOffline pages currently always have a refcount > 0 (except 
temporarily in this special case we are removing here). In the future, 
it won't have a refcount at all.

> - logically-offline pages belonging to onlined memory-blocks are marked PageDirty,
>    while logically-offlined pages we allocated via alloc_contig_range are marked
>    PageOffline (I am getting a bit lost between fake-online, fake-offline, my fault)

No, the code is confusing.

All pages are PageOffline. Only the ones that have not been onlined are 
*in addition* PageDirty.

The relevant bit is documented in page-flags.h:

"When a memory block gets onlined, all pages are initialized with a 
refcount of 1 and PageOffline(). generic_online_page() will take care of 
clearing PageOffline()."

> - If we want to release logically-offline pages belonging to an onlined memory-block,
>    we ClearDirty them and be done

PageOffline gets cleared in both cases: See the comment in 
virtio_mem_clear_fake_offline()

"/* generic_online_page() will clear PageOffline(). */"

I'll note that I am planning on removing that PageDirty() handling 
completely, and also letting handling PageOffline() clearing be always 
performed by memory freeing core (the latter is easier to achieve).

> - If we want to release logically-offlined pages belonging we allocated
>    via alloc_contig_range, we clear PageOffline and be done

Yes, in the future that clearing will be done by the core (so the plan).

 > - PageOfflineSkipabble are unmovable PageOffline pages, which cannot 
be migrated?

Yes, but they can simply be skipped -- consider them memory holes we 
(the driver) can rediscover when re-onlining the memory. See below.

> - So for a PageOffline to be able to be migrated away must be Movable or
>    marked PageOfflineSkipabble, making do_migrate_range ignore it

Yes.

> - PageOfflineSkipabble will be marked PageOffline upon re-onlining? Will
>    still be marked as PageOfflineSkipabble?

When re-onlining, the core will set them all PageOffline, and virtio-mem 
will intercept page onlining using the page_online_cb.

virtio-mem will then online the actually plugged parts (-> 
generic_online_page(), which clears PageOffline and exposes them to the 
buddy) and set the unplugged/hole parts as PageOfflineSkipabble again.

That logic resides in virtio_mem_online_page_cb().

> 
>> +
>> +		/*
>> +		 * Only PageOffline() pages that are marked "skippable" cannot
>> +		 * be migrated but can be skipped when offlining. See
> 
> It is probably me, and nevermind the comment but I somehow find
> "PageOfflineSkipabble are not migrated but skipped when offlining" a bit
> easier.

Definitely. Thanks!

-- 
Cheers,

David / dhildenb

