Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8B2673A9
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457123; cv=none; b=pD6md4oNx7fMMZPUVAfCLfGmBUfV1TXz1HjiYIXxoixvgTNrmLzoHc8WAn3o+wNxIGJ/H9Nvq8fbbqPw8cpcAzniW/RmZ6iBLPX4ly+ji2/H/KSaQwPyXHwB/ZwsS8IKCLY8IKWgaHcfD0gpLz/bBCyLbw/iVTpcT2RYP+EF3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457123; c=relaxed/simple;
	bh=4Va2jVGgDp6vlWAEdmdkPLeKFU1i7MbWo0WqztU3mgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCYp2WSGzfC1Q0vuKOJXJ6LuLasJLgSc4sTpAQeF/Wa/4T+Jku+UAtOy3G7qCXKj9v8VEZBRnbZLdRU/Wiut0gT5ugOxVu15J02U7hDLc9OOtaACbc2JsPtybmFnu7jlFWjDu/H3oSMantvn0vgB10RX1lyYTHPhlORygS5jPB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRxEMetz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRxEMetz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751457120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3SHK2nux4iNGPT20ZdOmVtc3HhHpFaXJCXwhMmqqOYs=;
	b=VRxEMetzLDGsgjdmpMTbXIsSRE6Lq+tLLdeoJUzXr4pMUmslb3aiWW/9gxunyWW1C3STio
	t7qQ0uIJudwuGaf6H8MORCSyqyEDsZqoA8Va6vMlhTrEwldLf7Dx5IOeevqEbaEYXV1mIy
	GaQug0wt6YJk4aV8IzSy17sWblYBWxg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-Eg3qGZCvOkWm_yM2fgU5iA-1; Wed, 02 Jul 2025 07:51:58 -0400
X-MC-Unique: Eg3qGZCvOkWm_yM2fgU5iA-1
X-Mimecast-MFC-AGG-ID: Eg3qGZCvOkWm_yM2fgU5iA_1751457117
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so23921795e9.1
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 04:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751457117; x=1752061917;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3SHK2nux4iNGPT20ZdOmVtc3HhHpFaXJCXwhMmqqOYs=;
        b=SGP52kqlsKFeiTHgB9FzL8+hOZ84oKDB4yWQYIgwlhPQUeIto/zQ0Jw2M3VrL38jje
         qujKun5sNYWnU8LUXgxp5fMQdm/t6xfDAJMzX452ovxGIMLFMJp3CIHhROaOHj0XzqCR
         06JzTL2Hc7ZnEYEICzTAjYawyeKooWNc1l5/12InzXm7Wek2m2CfKMKZ3MnVivgcD+fu
         DNmJFkVZvFEVu1VisIIe3Ug6i7X3DMYKIS9Vo/DFOcqkEM90s13E4LfmeOdPlxmBblFW
         zfXmkAyVSI/THsfXF+Tk4pPPxz0FEiOTEhbB4NH4gGOmG1Nrt6wGKVynUm/FmHv04UD1
         k51A==
X-Forwarded-Encrypted: i=1; AJvYcCUb03VBtGk3gIZFDKpTsenvsVmCoMLhrdxHk1V0okhlY7Hg4ym4F/zEKRJ8W7aTlC3/TdfcmznUzMNTe+VFHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YybyRJ44s28nhjHLaeFCmYVXRBHlgBd4ii4X6WhEY/uFvzmtPJM
	uA/re0XizWEjXcDFqW85abiV71JIkqChYv4OOFETCTEy5I6Gt//mMvjipEYY6Xn591Lj6tBUEUS
	nJuuYl4Ug75VhfNOXWRhz0o6lPsJJ8pUjGkJuzd+0bFz/f9hsfgztCkoNB/XqTZXIsvQ5
X-Gm-Gg: ASbGnct8UGA6FMPgi6wSyxoQHuxowuLhECSAQ/QFm0mZQDuFKrr94umTyH9oAjzuDAR
	/UwD4qgFIwCvuTi7TroWGCvNhwKv4isQyj+2ntoYYdpgLkjjcD8wRq20qcGvc8SspK2XxPOhzTa
	yYAwIp5mSOVoskT+RLlbZg0LR1xYOksFvyatXJoUNYe1CGstnZzc+c7NZeeCE6n6BE8J8Q2m+Jk
	n16Ee3MBqyinStukj7k314iNdb+j5FdGN9UwtLqf8PZl1llLGnJSEQ0u2QjeLaSKFmXRR2WM023
	NmVEQNXyx5WJYogE3Ygx7Gh55iWHOx0sNG3G7/7NO/s4HzzxtX2m3zk=
X-Received: by 2002:adf:e18b:0:b0:3a4:eae1:a79f with SMTP id ffacd0b85a97d-3b20095cf7amr1838669f8f.33.1751457116514;
        Wed, 02 Jul 2025 04:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgEWAxspDk6Q7crly73Lfvk8omExZapeXCZ1dGuKFEhCOxnWKoHtykjsVu0MJ5bKGF2TLWQg==
X-Received: by 2002:adf:e18b:0:b0:3a4:eae1:a79f with SMTP id ffacd0b85a97d-3b20095cf7amr1838610f8f.33.1751457116041;
        Wed, 02 Jul 2025 04:51:56 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234bc1fsm224606175e9.14.2025.07.02.04.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 04:51:55 -0700 (PDT)
Message-ID: <edb588a4-41c1-4108-9d86-fa69e1db5237@redhat.com>
Date: Wed, 2 Jul 2025 13:51:52 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 19/29] mm: stop storing migration_ops in page->mapping
To: Harry Yoo <harry.yoo@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-20-david@redhat.com> <aGULHOwAfVItRNr6@hyeyoo>
 <819b61fb-ebb0-4ded-a104-01ab133b6a41@redhat.com> <aGUbIB34G7pLWKbX@hyeyoo>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aGUbIB34G7pLWKbX@hyeyoo>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bbDmFMamMa7A4DJ33bkpJtjazaUX1hvDhm7nM_6xpB0_1751457117
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.25 13:43, Harry Yoo wrote:
> On Wed, Jul 02, 2025 at 01:04:05PM +0200, David Hildenbrand wrote:
>> On 02.07.25 12:34, Harry Yoo wrote:
>>> On Mon, Jun 30, 2025 at 03:00:00PM +0200, David Hildenbrand wrote:
>>>> ... instead, look them up statically based on the page type. Maybe in the
>>>> future we want a registration interface? At least for now, it can be
>>>> easily handled using the two page types that actually support page
>>>> migration.
>>>>
>>>> The remaining usage of page->mapping is to flag such pages as actually
>>>> being movable (having movable_ops), which we will change next.
>>>>
>>>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>
>>>> +static const struct movable_operations *page_movable_ops(struct page *page)
>>>> +{
>>>> +	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
>>>> +
>>>> +	/*
>>>> +	 * If we enable page migration for a page of a certain type by marking
>>>> +	 * it as movable, the page type must be sticky until the page gets freed
>>>> +	 * back to the buddy.
>>>> +	 */
>>>> +#ifdef CONFIG_BALLOON_COMPACTION
>>>> +	if (PageOffline(page))
>>>> +		/* Only balloon compaction sets PageOffline pages movable. */
>>>> +		return &balloon_mops;
>>>> +#endif /* CONFIG_BALLOON_COMPACTION */
>>>> +#if defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION)
>>>> +	if (PageZsmalloc(page))
>>>> +		return &zsmalloc_mops;
>>>> +#endif /* defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION) */
>>>
>>> What happens if:
>>>     CONFIG_ZSMALLOC=y
>>>     CONFIG_TRANSPARENT_HUGEPAGE=n
>>>     CONFIG_COMPACTION=n
>>>     CONFIG_MIGRATION=y
>>
>> Pages are never allocated from ZONE_MOVABLE/CMA and
> 
> I don't understand how that's true, neither zram nor zsmalloc clears
> __GFP_MOVABLE when CONFIG_COMPACTION=n?
> 
> ...Or perhaps I'm still missing some pieces ;)

You might have found a bug in zsmalloc then :) Without support for compaction, we
must clear __GFP_MOVABLE in alloc_zpdesc() I assume.

Do you have the capacity to look into that and send a fix if really broken?

In balloon compaction code we properly handle that.

>   
>> are not marked as having movable_ops, so we never end up in this function.
> 
> Right.
> 
>> See how zsmalloc.c deals with CONFIG_COMPACTION, especially how
>> SetZsPageMovable() is a NOP without it.
> 
> Right.
> 
> Now I see what I was missing in the previous reply.
> Thanks!
> 
> Please feel free to add:
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Thanks!

-- 
Cheers,

David / dhildenb

