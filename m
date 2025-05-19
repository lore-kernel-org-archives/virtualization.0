Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F1283CBF
	for <virtualization@lists.linux.dev>; Mon, 19 May 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665585; cv=none; b=XIuZDnq17pPgVnf65OsUAZXbyjKeIqNu+I9WMq0yjkMKGc//KzgtKXNKlXhEnzodkHnAyhzEMjVMzWQQoJqH/NIyoSdr2oTL75LRGhMPWqG+92PjtIqKJAsCogYes64dpwE1Uv3yW3uNHpmq4Gw16Xhliq/ids88cIu2msJnm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665585; c=relaxed/simple;
	bh=+V7WOgOUwarlINW6PsgOogxA5QOqBpaFl1gd/bF/jN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKIMPAL42nnZq6/XVpemnRS0JJcbz3lgQnxhWxOYzm6YaOoEmQq9/X/DF0qjnlyF5hSjSZ9tbD7CSO4KMDiY2P1luEUzDUexVUMuCii6HBBNaiEeOeUFi+9USgxSWTZu+RL53o9h70l0wuwI36SVmTMjIpm00LW48DoE04c90I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWEh4tmw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWEh4tmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747665582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fc1XxKKHBxhSvqtmcE/i6SWy2w5XcBTE8wKwLKGtMi4=;
	b=NWEh4tmwR/MTkRGw15bRRwO7OPSQysZXTkWGAUsOy0mPW4JD8/F2Z1HnwlJoj5+tjKBqhb
	21tWGlCFUFRA2Hn5Ay86BWfGT3lga6l6IkLHOLRblrcubmXGxP8o6cuJI6bTi9mBCaYE3U
	4BLuwvm0+nTpTO6gjs4qjNE20CnaHfM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-OQ0FxvoOO9qbYTyDSO336Q-1; Mon, 19 May 2025 10:39:41 -0400
X-MC-Unique: OQ0FxvoOO9qbYTyDSO336Q-1
X-Mimecast-MFC-AGG-ID: OQ0FxvoOO9qbYTyDSO336Q_1747665580
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a35c86b338so2435663f8f.2
        for <virtualization@lists.linux.dev>; Mon, 19 May 2025 07:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747665580; x=1748270380;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fc1XxKKHBxhSvqtmcE/i6SWy2w5XcBTE8wKwLKGtMi4=;
        b=BW6rXiN5ln/KkW00tV61wGdFJcDtoRPRC6GYomcqCXsQlBJtrEwERWlKzrHCUosZOd
         9aDd6he/3irYst49f+zfX8G+861fCkj2cZNSIy/3aWG9Ezz2F68UlhL2doM8C+d+jbn0
         uHTm+2Z5tH8RNwlszadcU9JrEMV7U9Bkk3tKYG0ZRfkq2l9BPoic/7yUyF5N7UDx09Vz
         aqOpSI9EJyhNVYXZu2ee4py/aW6MuqIHDKtiZUJETGD7hy3toMPohlUrQUb3HTzJD7jD
         v7enQQ0fDFgt/7n6KC1zewTUgFpfkFYsZrgGtgNvv+1iF7ANg08tXskj6mhl4R0PtbB0
         3Vpg==
X-Forwarded-Encrypted: i=1; AJvYcCXCQNKZg+72BKXc4Fk1SZm2sB4H7Q6ASNBG0gRydOMnyhwYeXRD1dguZqEsGpgRA6sL7MKFebBa2mCp+ee9DQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YysNYTLfDXvCqxrF13+OoYRY7pGZ+x3mN1mOOj6BriIBS5Pykz+
	HEfdRLPc1njhhTrn0gHPDNK8HkbnBwcwMpwcy5XET+ml8tBTy/tcaqbZq3UXa+87/3kWBBkg47m
	XOAlWK1XxX49r9IBLxI2qhBaO4K+WZB9J45xHITzYrB/px8mGCaHOkgNJkAVRqL68nd2qqvVJ+N
	atUVA=
X-Gm-Gg: ASbGncvWgYtI/btXp0Ps81q5KfMutZuQHaXasDrproOxhiI4D2R497ij9HxZIvHG0GE
	hI6zP8OEjafW6rQSG5d5MXw1ULc83pHr5IXvSXOLhim5uw5ejlJl2MdtSi1h1l23rnkfq//BaLA
	T4l1ZOib8LVKWer6aW94jLhTDyBjeu+Pq/y/HDe4SHSqlQHKEGtCDUMLJ3HVloESiKJIoyZ4Poa
	Ye+vQFpPwG74GH72ZbGz5/UPYcRCedW5u0t2gQoVxRQ4oC0QRREItlCiRG9W+xlPHV5Zo299URz
	BBmA1/ZxvIun0Tgdx1wm1uydGCmAdEw3c5x0Jm0pUhDOxwwhY+lD5nCDDcGagR1JJNPxXwO8rtT
	7TPgmKuyT5cXit8y1Pn46E6NKWqTwUB5KCk18DkU=
X-Received: by 2002:a05:6000:3111:b0:3a3:75fa:a0f6 with SMTP id ffacd0b85a97d-3a375faa340mr1893637f8f.50.1747665580208;
        Mon, 19 May 2025 07:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGbb+jxiMxPn0A7K1u6APHY87dcAiZht4gZaL68Kpwpnj/fmNBc4lbu//e0WBBsOYAYluLMg==
X-Received: by 2002:a05:6000:3111:b0:3a3:75fa:a0f6 with SMTP id ffacd0b85a97d-3a375faa340mr1893594f8f.50.1747665579708;
        Mon, 19 May 2025 07:39:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8cf66sm12807961f8f.87.2025.05.19.07.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 07:39:39 -0700 (PDT)
Message-ID: <85fd0566-30c8-4e1e-8ce9-5b5bb4f1fa84@redhat.com>
Date: Mon, 19 May 2025 16:39:38 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm/memory_hotplug: PG_offline_skippable for
 offlining memory blocks with PageOffline pages
To: Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20250514111544.1012399-1-david@redhat.com>
 <20250514111544.1012399-2-david@redhat.com>
 <7E5BD96D-971F-4AFC-AC09-503310BE8E68@nvidia.com>
 <fb12fab1-f2df-4b4f-ae83-1b45e2a7d6bd@redhat.com>
 <0F0BB46A-F7C2-40BE-A045-C65525956D52@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0F0BB46A-F7C2-40BE-A045-C65525956D52@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aMy0NcdW9S-PrtvegnDH-9M4Etpa2TMZKO4gycocdrM_1747665580
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>> Some thoughts after reading the related code:
>>>
>>> offline_pages() is a little convoluted, since it has two steps to make
>>> sure a range of memory can be offlined:
>>> 1. start_isolate_page_range() checks unmovable (maybe not migratable
>>> is more precise) pages using has_unmovable_pages(), but leaves unmovable
>>> PageOffline() page handling to the driver;
>>
>> Right, it's best-effort. For ZONE_MOVABLE we're skipping the checks completely.
>>
>> I was wondering for a longer time that -- with the isolate flag being a separate bit soon :) -- we could simply isolate the whole range, and then fail if we stumble over
> 
> Talking about that, I will need your input on my change to move_pfn_range_to_zone()
> in online_pages()[1]. Making MIGRATE_ISOLATE a separate bit means if you isolate
> a pageblock without a migratetype, unisolating it will give an unpredictable
> migratetype.

Sorry for my late reply on that. I think, the rule should be that you 
initialize the migratetype once, before any isolation+un-isolation.

So that should only require care when adding new pageblocks (memory 
hotplug).

> 
> [1] https://lore.kernel.org/linux-mm/20250509200111.3372279-3-ziy@nvidia.com/
> 
>> an unmovable page during migration. That is, get rid of has_unmovable_pages() entirely. Un-doing the isolation would then properly preserve the migratetype -- no harm done?
>>
>> Certainly worth a look. What do you think about that?
> 
> In principle, the method should work and simplifies the code. But it suffers more
> penalty (pages are migrated) when an unmovable page is encountered after the
> isolation, since before nothing will be migrated. To mitigate this,
> we probably would want some retry mechanism. For example, register a callback
> to each unmovable page and once the unmovable page is deallocated,
> alloc_contig_range() can move forward progress.

I was wondering if we could make the isolation code a  bit simpler. For 
example, set all involved pageblocks isolated. If any is already 
isolated, we can easily back off.

Once all are isolated, we could do the has_unmovable_pages() on the 
whole range, not a single pageblock.

Then we could start migrating.

I think the "issue" is, once we drop the zone lock, pages that are 
getting freed end up on the MIGRATE_ISOLATE list -- and I think we also 
must have moved the free pages already to the proper MIGRATE_ISOLATE 
list before we drop the zone lock.

So the possible cleanups might be limited.

> 
>>
>>> 2. scan_movable_pages() and do_migrate_range() migrate pages and handle
>>> different types of PageOffline() pages.
>>
>> Right, migrate what we can, skip these special once, and bail out on any others (at least in this patch, patch #2 restores the pre-virtio-mem behavior).
>>
>>>
>>> It might make the logic cleaner if start_isolate_page_range() can
>>> have a callback to allow driver to handle PageOffline() pages.
>>
>> We have to identify them repeadetly, so start_isolate_page_range() would not be sufficient. Also, callbacks are rather tricky for the case where we cannot really stabilize the page.
> 
> During start_isolate_page_range(), all pageblocks are isolated, so
> free pages cannot be used by anyone else, meaning no new PageOffline()
> pages or any other unmovable pages, right?

Yes, that is correct. Pages (incl. PageOffline) pages could get freed 
back to the buddy.

But we don't want to store per-page callbacks either way.

What would work is a new notifier chain (protected by RCU etc), that we 
can ask for each PageOffline page.

Not sure I prefer that of the approach here that is significantly 
simpler -- and we do have the spare bit for PageOffline pages in the new 
memdec world (for PageOffline, we'll probably need 2/3 flags in the long 
run).

> 
>>
>>>
>>> Hmm, Skippable PageOffline() pages are virtio-mem specific, I wonder
>>> why offline_pages() takes care of them. Shouldn't virtio-mem driver
>>> handle them?
>>> I also realize that the two steps in offline_pages()> are very similar to alloc_contig_range() and virtio-mem is using
>>> alloc_contig_range(). I wonder if the two steps in offline_pages()
>>> can be abstracted out and shared with virtio-mem.Yes, offline_pages()> operates at memory section granularity, different from the granularity,
>>> pageblock size, of alloc_contig_range() used in virtio-mem, but
>>> both are trying to check unmovable pages and migrate movable pages.
>>
>> Not sure I get completely what you mean. virtio-mem really wants to use alloc_contig_range() to allocate ranges it wants to unplug, because it will fail fast and allows for smaller ranges.
>>
>> offline_pages() is primarily also about offlining the memory section, which virtio-mem must do in order to remove the Linux memory block.
> 
> To clarify, I mean the steps of start_isolate_page_range(), scan_movable_pages(),
> do_migrate_range(), dissolve_free_hugetlb_folios() and test_pages_isolated() in
> offline_pages() is very similar to the steps of start_isolate_page_range(),
> __alloc_contig_migrate_range(), replace_free_hugepage_folios(),
> and test_pages_isolate() in alloc_contig_range(). So I wonder if a common
> function routine can be shared.

Ah, yes, I had the same idea a couple of years back, but never got to it.

There are subtle differences (e.g., memory offlining keeps retrying and 
is allowed to dissolve free hugetlb folios), but these could likely be 
modified using a parameter (similar to how we already special-case 
offlining).


Thanks!

-- 
Cheers,

David / dhildenb

