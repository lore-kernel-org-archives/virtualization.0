Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703D1CA81
	for <virtualization@lists.linux.dev>; Mon,  2 Jun 2025 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748897760; cv=none; b=emoYdA//M2nX7sXKlgKajwM0gnQ0JO70MnwJ3yd0Kvv27UylUtkkUvIEY/5I+FArnG/U7CkblGOLhPxYiCCtGG2Rs1Xs2qRRPxUhBojkOm8JcxQspTW2GGp4MleRuhYjpeH2eSkV9tFIq5oMjfdF7VWfaAtfeMdyEFEYyf51794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748897760; c=relaxed/simple;
	bh=Vou3QBk8eCj7kAYGYLIuIx5eKU76MLI49rsYrAvO++A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UySW8OnrY40si9hndeeAEHFRx7I6/9XaFqt2AOR/VkcW/JG6/Hw1hQGkWksOLh9gniBvGDxGoK7rQNowfN0COy8v4WAS0VEBnnyd6w3UtmEgh1dctWegmsPPWvqlpGiPMBThr3Kek4gLtSSHH8vda3NetNvbLsFG9/1r5Uf4QeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqHDz6be; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqHDz6be"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748897756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ssx2YCHEtNvRXfeWasZ0w/YEgpOyd5gnUB3UrS0ne90=;
	b=aqHDz6be3mduPnRmBCys/zIwiO351Gy61Xn6VfnPr85sq+yJqmBEyMbwdTAhYf26zmtg2c
	P5YuOf7eDZWLxRFqD20RVlZ8rHaZifcK7NxrxBXsQ2zXEI5yCv/Nhq0SkEI04xw1tjki4x
	xxIDDZfuY9DFfj184VasB3aD8JncLgw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-nSlFCmwrNY2-uzAw-j5ZkA-1; Mon, 02 Jun 2025 16:55:55 -0400
X-MC-Unique: nSlFCmwrNY2-uzAw-j5ZkA-1
X-Mimecast-MFC-AGG-ID: nSlFCmwrNY2-uzAw-j5ZkA_1748897754
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f55ea44dso2092527f8f.1
        for <virtualization@lists.linux.dev>; Mon, 02 Jun 2025 13:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748897754; x=1749502554;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ssx2YCHEtNvRXfeWasZ0w/YEgpOyd5gnUB3UrS0ne90=;
        b=ud6jwvvkkITgGupNKlRFmu/QXRshg5cn1MFgaaR2zzOFj49OTXhup4fZjYO5yRVrnk
         j4C8F0WG7pkSbRkuJduOYn7y6dNDXKYu0CwVex4Is7/HtS36ofSz6LqiejshVCYOZcou
         DcMidwUC1xXC8lyW0ppmkDsZhz6IuVt2p1n/IcjPe1o/yRZUGn1+WEYmeRemxLfTBeKE
         pVXVA5212pg9IQLMhPYg52uj7HZwnCNXrAorsjL3decpDRntmvsfn4ozoIrQ42ldD7Cy
         4LmpPQYL3EIL3LBUpmnSXESh6KEdSkfMk6jphjOSPUKcPNHDsiPBHX0ym0cN813OD+ft
         1o/A==
X-Forwarded-Encrypted: i=1; AJvYcCXHUT/P+/7BIKyLvqAEtjLGZgk7/mWdzzAniiAqPf9NbAbxt5D2DNl56Fx6M2MsQ4utE7DsqRVbKF8MOlLJbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxQHNGQw/qUpFVMhPwtYUdhhLIAMy3t964kUdj3FUppPduS9nP
	mjyzV2Z/NJeeZvmfckqE+QaKDj3NqLEhdOaPsmX4N9skz3jtg1wIuovsiCvzEgdXG/AyuaWdzmF
	U8DZiJNgMHu6gwN5MSf4Xn5mEZurWWxmXbxtS/tFtihurlkCpWpNAH1i1LIE8QFVpyt1Q
X-Gm-Gg: ASbGncvZ4RVqZVhfzdPkb0tnfFJzsXk24Ph13GYkUxgj8T0NCAHtBfEXjH1BAd1ctjN
	MC2kU3MAKtw48StGMxbTmhpRg74pIfTWAxOK5mDuJlMqFJmcIgMqMxFc7BEdtLwa/WJiuxWYLPT
	E7lTG0ZdTGAzA6NyO0UvD8I6eZZRvqHFGFdmG+PsQlJz9Y4IdLYYISTd+p+jrSo31+TdRL0EAcL
	2QOnSpDOfY04N1xtEnlWdQVRB82B9h0lEwTClydmM/mQvnUbwCqMjgKPBC2+0h6xvMEsjn7bFoj
	J7rCGy9qcCv4GFi841Y7NVihKjXiYCGzm41WrJv/+tiJ28Sn3qJ8u6dBl0rVDvGPJqKH8YgH/WO
	hOpnOrDEPGbDisK/yXgGFdDz6nvoOdAW+/pRuC4k=
X-Received: by 2002:a05:6000:240a:b0:3a4:e609:dc63 with SMTP id ffacd0b85a97d-3a4fe17b861mr7308305f8f.20.1748897754396;
        Mon, 02 Jun 2025 13:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvsIS2jeTMPHNLG046P9WC/4q/oUcDXZFfGZCvFccdUIhX8iJMRM5FRAde0kV+B5eLQbyHOg==
X-Received: by 2002:a05:6000:240a:b0:3a4:e609:dc63 with SMTP id ffacd0b85a97d-3a4fe17b861mr7308276f8f.20.1748897753949;
        Mon, 02 Jun 2025 13:55:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:a300:1c2c:f35e:e8e5:488e? (p200300d82f34a3001c2cf35ee8e5488e.dip0.t-ipconnect.de. [2003:d8:2f34:a300:1c2c:f35e:e8e5:488e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f865sm15983449f8f.81.2025.06.02.13.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 13:55:53 -0700 (PDT)
Message-ID: <acc04c23-d7d6-4ecd-bfeb-6cccfd80e6d9@redhat.com>
Date: Mon, 2 Jun 2025 22:55:52 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/memory_hotplug: PG_offline_skippable for
 offlining memory blocks with PageOffline pages
To: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20250520164216.866543-1-david@redhat.com>
 <20250520164216.866543-2-david@redhat.com>
 <d3336028-174f-4312-864c-2b1e1b736e07@suse.cz>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d3336028-174f-4312-864c-2b1e1b736e07@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s6mweWahn-v2BYjsu80JmteShh_FoWYz4wXmF06wafc_1748897754
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.05.25 18:54, Vlastimil Babka wrote:
> On 5/20/25 18:42, David Hildenbrand wrote:
>> A long-term goal is supporting frozen PageOffline pages, and later
>> PageOffline pages that don't have a refcount at all. Some more work for
> 
> Looking forward to that :)

:) It's definitely ... challenging.

> 
>> that is needed -- in particular around non-folio page migration and
>> memory ballooning drivers -- but let's start by handling PageOffline pages
>> that can be skipped during memory offlining differently.
>>
>> Note that PageOffline is used to mark pages that are logically offline
>> in an otherwise online memory block (e.g., 128 MiB). If a memory
>> block is offline, the memmap is considered compeltely uninitialized
>> and stale (see pfn_to_online_page()).
>>
>> Let's introduce a PageOffline specific page flag (PG_offline_skippable)
>> that for now reuses PG_owner_2. In the memdesc future, it will be one of
>> a small number of per-memdesc flags stored alongside the type.
>>
>> By setting PG_offline_skippable, a driver indicates that it can
>> restore the PageOffline state of these specific pages when re-onlining a
>> memory block: it knows that these pages are supposed to be PageOffline()
>> without the information in the vmemmap, so it can filter them out and
>> not expose them to the buddy -> they stay PageOffline().
>>
>> While PG_offline_offlineable might be clearer, it is also super
>> confusing. Alternatives (PG_offline_sticky?) also don't quite feel right.
>> So let's use "skippable" for now.
>>
>> The flag is not supposed to be used for movable PageOffline pages as
>> used for balloon compaction; movable PageOffline() pages can simply be
>> migrated during the memory offlining stage, turning the migration
>> destination page PageOffline() and turning the migration source page
>> into a free buddy page.
>>
>> Let's convert the single user from our MEM_GOING_OFFLINE approach
>> to the new PG_offline_skippable approach: virtio-mem. Fortunately,
>> this simplifies the code quite a lot. The only corner case we have to
>> take care of is when force-unloading the virtio-mem driver: we have to
>> prevent partially-plugged memory blocks from getting offlined by
>> clearing PG_offline_skippable again.
>>
>> What if someone decides to grab a reference on these pages although they
>> really shouldn't? After all, we'll now keep the refcount at 1 (until we
>> can properly stop using the refcount completely).
>>
>> Well, less worse things will happen than would currently: currently,
>> if someone would grab a reference to these pages, in MEM_GOING_OFFLINE
>> we would run into the
>> 		if (WARN_ON(!page_ref_dec_and_test(page)))
>> 			dump_page(page, "fake-offline page referenced");
>>
>> And once that unexpected reference would get dropped, we would end up
>> freeing that page to the buddy: ouch.
>>
>> Now, we'll allow for offlining that memory, and when that unexpected
>> reference would get dropped, we would not end up freeing that page to
>> the buddy. Once we have frozen PageOffline() pages, it will all get a
>> lot cleaner.
> 
> Hmm, a question on that later in the code (assuming I identified the right
> place).
> 
>> Note that we didn't see the existing WARN_ON so far, because nobody
>> should ever be referencing such pages.
> 
> It's mostly a speculative refcount increase from a pfn walker, such as
> compaction scanner, that can happen due to its inherent raciness.

PFN walkers are in general careful to only try grabbing a reference if 
the target page is a possible candidate.

E.g., compaction checks for LRU or movable non-folio pages before 
calling folio_get_nontail_page().

KSM uses MEM_GOING_OFFLINE to pause scanning (and thereby 
folio_try_get()) while memory is getting offlined, so it won't try 
accessing any page in the trees that might now be stale.

> 
>> An alternative might be to have another callback chain from memory hotplug
>> code, where a driver that owns that page could agree to skip the
>> PageOffline() page. However, we would have to repeatedly issue these
>> callbacks for individual PageOffline() pages, which does not sound
>> compelling. As we have spare bits, let's use this simpler approach for
>> now.
>>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz> # page allocator
> 
> I'll leave hotplug to the experts :)
> 
> <snip>
> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index f6482223e28a2..7e4c41e46a911 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7023,12 +7023,12 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
>>   			continue;
>>   		}
>>   		/*
>> -		 * At this point all remaining PageOffline() pages have a
>> -		 * reference count of 0 and can simply be skipped.
>> +		 * At this point all remaining PageOffline() pages must be
>> +		 * "skippable" and have exactly one reference.
>>   		 */
>>   		if (PageOffline(page)) {
>> -			BUG_ON(page_count(page));
>> -			BUG_ON(PageBuddy(page));
>> +			WARN_ON_ONCE(!PageOfflineSkippable(page));
>> +			WARN_ON_ONCE(page_count(page) != 1);
> 
> So is this the part where an unexpected speculative refcount might be
> detected? Should be harmless then as it will then decrease the refcount from
> e.g. 2 to 1 and nothing will happen right.

Yes, unless it would be taken for a longer time, which is not what 
usually happens: speculative references are immediately dropped if the 
target page is of no use.

> That's assuming that once we pass __offline_isolated_pages(), the following
> actions wont modify the refcount or the struct page won't be zeroed, or
> removed completely (vmemmap). Probably something already prevents that...

Right, we'd have similar problems also if the refcount would be 0 and 
someone would do a folio_try_get(), while we are tearing down or 
poisoning the vmemmap.

The idea here is that these folios were PageOffline() already for a 
while (before even starting memory offlining), so any speculative 
references from pre-PageOffline times should long be gone.

It's still racy, but not more racy than our existing 
pfn_to_online_page() race, or the race we already had in the old code.

Thanks!

-- 
Cheers,

David / dhildenb

