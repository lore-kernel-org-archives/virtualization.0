Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D217A318
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231982; cv=none; b=GuaMC6E+WORag2772yx0FnNzzc1WbdJRRXY1i0MtZbn/RNGogBWWiYkf/OrrPw90jDRj+CXWbUma0JSKUROxKzM2rUiCUIHFXGBaPoZw9x1bwbzFaGJNPsG8kwi1+hOlCsWX1iPMne5F1VBT2b+Np/FksjfO/KJTbu8aDe48khA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231982; c=relaxed/simple;
	bh=YeswlfSWLt+8RznvyMpM2MzwdSyoABTr9ECsJb+KjDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1rGI6tRo3PANaE0JV4BUHBg2zd2y82Xpguozixr74LDT4Zj53PGLQzpb/TqhMWHbkZw6fULBlHUufCVGKhc/U92p8+dVIJLD3NNIkRiwEQeQ3n0L7DhEX72Ov6Zr2Od5RjgBkwCdCgPTQXNRp1YxmTdxH687J/PEvQWc7N7W5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKCoVPpa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKCoVPpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747231977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uyuGM515bRHJ1vTWDKZHrHKknD3pFRYBNxR18uwxqOU=;
	b=JKCoVPpazwYS1vMsg0ATDXvMZ+b0IjFCWbyBgO+aGqSk+hUH5AkO7oepzmVx82rbqeRT+x
	V4jAWj7CUFjdpl8dk9ZZNXZWK4198cS6dshjMC4Ze3MhM2E/gwrG3xU2NYAraxtTOI7hnZ
	snLPJFJCZDLzrHKqFdQWsi5qMBiHWaQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-dCArLwRqMyKyeQIm8uBcRA-1; Wed, 14 May 2025 10:12:56 -0400
X-MC-Unique: dCArLwRqMyKyeQIm8uBcRA-1
X-Mimecast-MFC-AGG-ID: dCArLwRqMyKyeQIm8uBcRA_1747231974
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ea256f039so50708915e9.0
        for <virtualization@lists.linux.dev>; Wed, 14 May 2025 07:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747231974; x=1747836774;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uyuGM515bRHJ1vTWDKZHrHKknD3pFRYBNxR18uwxqOU=;
        b=dFLgcu+9bIDiogbDwk06LjYSgk4RjpzjmexDu1bt2xdQbY+mqYZFR1Z0DG6rhnFrGa
         aDLBHQL21zwKvzDONAQ0YZUCM+MTWVY5KjEHfwfWfcYCDVUDa/IM/PaakoEr2M3TnsS6
         cdBlxlhLsHCTid8y6FAWkygtWQeNRXVmEHqe+iL5pmOTlDbjysXkF361K3FOkI0oG0gr
         bB13hTIAmRCYhZ1VWQLiO8IwsdUV//UV/ckiYq74QD5T24xKhd71xJeAuxEyzC2ztg4H
         4T39mSjXvbzL2vUOAC5XkWGoT2thVaPty9DKjfcBj4tds0GdWdkilmBy17g8gYfeRFBA
         HuYA==
X-Forwarded-Encrypted: i=1; AJvYcCUS/DJ3fJYhBjGYCT1nATR+yOP0apZqe/BlTNRjFWDrE4CJCOgSNprJAyVp2KxqKVdDhW82DxSpK+gou8ANpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPqgD8T97cfuRXCHpTvxwIKDurKHmHyHoQIbsfUb3u8GKAdLK3
	urokdTt5iOrp3GX3BCtqvpv20GUpdPMy13OBUdUmJUfMTzOD9g02gh4JW198AU3HwYcdKigMqk6
	ovolOEKa/LkVh9XS7w1rqbR+8bsVGyMHccx9/YyXzJlxnLLt2TYP+2Q9+GvDbriXB
X-Gm-Gg: ASbGncuxfogTZgGGkxBAt98MqpBM7pE/7wBFM6PpdpVtwG8hKIIR5YSW+D4iMULja7h
	63s4bMMjlYEDj9ZXzByXuL7gT64Z3W+JdNDlzl9TbN2tU7hkOch8GLBWtIAKVBjVpPg5L5QCFJn
	9+SbFFa4rtciV0kVd+uaoAC0p2r2DLWkuY9EwoqlrJ5ZF1Ratv/WLIjXwBEtvRYQQO855sJGPX/
	Z9YFJ/ODA1FET+HYAIVOqL+T669eUF5MvHbtxr1ZZxz9aktLvlh7Km2jMnjXBKaHkPgiD3/HuEZ
	SyVhmJDu8aj9xEpAot+1EhPfKDWXkwSCpDmP06/zp8taPuVg1JPwFSNnzkeZOMZUkJRL9hqQeHx
	5U3gpmhgep54pXUJDWGnsl0w1dEirdv+YWxUys4Q=
X-Received: by 2002:a05:600c:1c14:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-442f210f6f4mr37194095e9.17.1747231974476;
        Wed, 14 May 2025 07:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqcfuHqdvOW1d/TJHeOz+UpJ8OK8pKb7vXqiOZC0mbXJIeEJHtfNoxkEG2tsupNAXfQI7Ujg==
X-Received: by 2002:a05:600c:1c14:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-442f210f6f4mr37193675e9.17.1747231974066;
        Wed, 14 May 2025 07:12:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df? (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb85a8f8sm37556345e9.0.2025.05.14.07.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 07:12:53 -0700 (PDT)
Message-ID: <8ce464e2-1447-4e60-8abe-f4ddd511d7a7@redhat.com>
Date: Wed, 14 May 2025 16:12:52 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] mm/memory_hotplug: introduce and use
 PG_offline_skippable
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
 <4B7FCC74-EAB2-426B-AFE0-4250FE4F7480@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4B7FCC74-EAB2-426B-AFE0-4250FE4F7480@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tQuYq6dkfM2cP1hbhEoA6xI-5QzMUTOQFxltTcDBv0U_1747231974
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.05.25 15:45, Zi Yan wrote:
> On 14 May 2025, at 7:15, David Hildenbrand wrote:
> 
>> This is a requirement for making PageOffline pages not have a refcount
>> in the long future ("frozen"), and for reworking non-folio page migration
>> in the near future.
>>
>> I have patches mostly ready to go to handle the latter. For turning all
>> PageOffline() pages frozen, the non-folio page migration and memory
>> ballooning drivers will have to be reworked first, to no longer rely on
>> the refcount of PageOffline pages.
>>
>> Introduce PG_offline_skippable that only applies to PageOffline() pages --
>> of course, reusing one of the existing PG_ flags for now -- and convert
>> virtio-mem to make use of the new way: to allow for skipping PageOffline
>> pages during memory offlining, treating them as if they would not be
>> allocated.
> 

Thanks for taking a look!

> IIUC, based on Documentation/admin-guide/mm/memory-hotplug.rst,
> to offline a page, the page first needs to be set PageOffline() to be

PageOffline is not mentioned in there. :)

Note that PageOffline() is a bit confusing because it's "Memory block 
online but page is logically offline (e.g., has a memmap that can be 
touched, but the page content should not be touched)".

(memory block offline -> all pages offline and have effectively no state 
because the memmap is stale)

> removed from page allocator.

Usually, all pages are freed back to the buddy (isolated pageblock -> 
put onto the isolated list). Memory offlining code can then simply grab 
these "free" pages from the buddy -- no PageOffline involved.

If something fails during memory offlining, these isolated pages are 
simply put back on the appropriate migratetype list and become ordinary 
free pages that can be allocated immediately.

Some PageOffline pages can be migrated using the non-folio migration: 
this is done for memory ballooning (memory comapction). As they get 
migrated, they are freed back to the buddy, PageOffline() is cleared -- 
they become PageBuddy() -- and the above applies.

Other PageOffline pages can be skipped during memory offlining 
(virtio-mem use case, what we are doing her). We don't want them to ever 
go through the buddy, especially because if memory offlining fails they 
must definitely not be treated like free pages that can be allocated 
immediately.

Next, the page is removed from its memory
> block. When will PG_offline_skippable be used? The second phase when
> the page is being removed from its memory block?

PG_offline_skippable is used during memory offlining, while we look for 
any pages that are not PageBuddy (... or hwpoisoned ...), to migrate 
them off the memory so they get converted to PageBuddy.

PageOffline + PageOfflineSkippable are checked on that phase, such that 
they don't require any migration.

-- 
Cheers,

David / dhildenb

