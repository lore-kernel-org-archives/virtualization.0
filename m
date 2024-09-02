Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604117ADFA
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265843; cv=none; b=QVCNFOT9bFyVTYhNs9BDWrMFnp1FFLu924697mqj2mgQalb1vAhaNaFnCfa3/0Bs9b4k/2GzWu6mOsQth6P/sLBy9L0Cc3+o2AJzF+v3YmOfM3nmIrrUG+VV4irct3dgrvaPnLjAfgYHWNe7oiBauylQ7zeDXJAGw69e+fLwulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265843; c=relaxed/simple;
	bh=9vHAiyGu7wlxeSGgxSQcTVnMz2iLnYxwfWHZRuyWtlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijWhf5pVo4zNFsNnLPp/KDUCe+UjeLLmIOhvbc284TgXl1R42XbP/ucgbJsCujAY9/mAQQWLZkC9pptNAf6x/I7a6AZK97Pp2s2f5CgJw/6O17KFGh8OcNxaEhmEczYYX2HbEAiX4YMjN4OZDlH1t3nZDFepq6zQlbX9vCPVgjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByG/JQWW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByG/JQWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725265840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UMKMr6ygrfEHktzrEdnbZxT7N3QfQbrmVJl84ibFDNM=;
	b=ByG/JQWWCYaJJ+inzJThJgckw9bgomIjgfzDoKKbqcEKI2McVvawN0vJTHaXjL9VqMv2zS
	WKAWLQ1WGQ5fAthOPSDLR7TBz1cNsgUkLEJ/oHftxU2bU2HdITW6Lb574K83ewJJe0jI9d
	5iCDNJQACs+gcwpTXoz3FfWcHKyaL3Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-8pQa5l40Mqij9p3C2Ao-Wg-1; Mon, 02 Sep 2024 04:30:39 -0400
X-MC-Unique: 8pQa5l40Mqij9p3C2Ao-Wg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bbe9083d1so24527795e9.3
        for <virtualization@lists.linux.dev>; Mon, 02 Sep 2024 01:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265838; x=1725870638;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UMKMr6ygrfEHktzrEdnbZxT7N3QfQbrmVJl84ibFDNM=;
        b=Tw3yLYKQ99b/+ZZ5yHSLOmsmQCaX3ktkb5nfFw42AfaRI8Qblvhfrg5ofgLOE/CqZw
         ycO2aqrVXyefW6a73n2KOlxa5/Z272OkyDOyTUyyMkiCKBIR/GlYOHHbupqcNqHhw5hx
         XReMzDJPB6c+YwkjmsLLp34bOcx5fEiKcJHOfKRGDyfsHrBOvhurKrbpWAEGq0xPE6KS
         PLJ/ZZq7L9l/hmktYNqJgKjttXTnwloS2uYbiqZ+R8rOa2cT6N7q+X8UNlWbT91aC/2Y
         ACEs2agaNYI7r+OPAaOVqVFPyxN9N15bWDAk7k8EZbqdK0dofhM6f/rZhZcUio2SrUi+
         YcbA==
X-Forwarded-Encrypted: i=1; AJvYcCWMI7I8DSrGJzulzPtSoah/SaggQ0rSC1gIUwD+MAfnZWXhztcGI/qK2vNxsyxhkb+TiuSxtSL3HFqe9MJ8Vw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFuHC6YKNg3Iy7AMEC/WS606j4WWQNsBr/udNSIun8u9mltKs7
	odXzg/g0XMHB+o/Og79G+76OVmU647S1UeDSWFV88K0jFZD0T6b2JaLxLu2S0x58cOYRVylOoaW
	wJZAXhAEI8DjkJEPK5sghpZ7aWcVi46f8v5aE9EvnX56SeYciPDVBDUEYNFJu+DRM
X-Received: by 2002:a05:600c:1c09:b0:423:791:f446 with SMTP id 5b1f17b1804b1-42c7b59e335mr42016365e9.7.1725265838096;
        Mon, 02 Sep 2024 01:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxLyMAKTItYpvBiQGXTJqI9+uusvCz8hKqgJRb6ZU04xvCjNT+uRvLSXNfEP6PJjDmji6YUQ==
X-Received: by 2002:a05:600c:1c09:b0:423:791:f446 with SMTP id 5b1f17b1804b1-42c7b59e335mr42015745e9.7.1725265837178;
        Mon, 02 Sep 2024 01:30:37 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b6a3d27fsm7704671f8f.59.2024.09.02.01.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 01:30:36 -0700 (PDT)
Message-ID: <b2174d62-b226-4ee3-9363-ab3c9a0b51ca@redhat.com>
Date: Mon, 2 Sep 2024 10:30:35 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev, 42.hyeyoo@gmail.com,
 cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
 iamjoonsoo.kim@lge.com, mhocko@suse.com, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev,
 torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, laoar.shao@gmail.com, Xie Yongji <xieyongji@bytedance.com>
References: <20240830202823.21478-1-21cnbao@gmail.com>
 <20240830202823.21478-2-21cnbao@gmail.com>
 <0804627b-49da-4ee0-a09a-19b87a7fdc3d@redhat.com>
 <CACGkMEtwmtSKFY2GzoNvEQzFq5wYUasf94GKqjGQKyShoqxo+A@mail.gmail.com>
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
In-Reply-To: <CACGkMEtwmtSKFY2GzoNvEQzFq5wYUasf94GKqjGQKyShoqxo+A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.09.24 09:58, Jason Wang wrote:
> On Mon, Sep 2, 2024 at 3:33 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 30.08.24 22:28, Barry Song wrote:
>>> From: Jason Wang <jasowang@redhat.com>
>>>
>>> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
>>> persisting in providing __GFP_NOFAIL services for non-block users
>>> who cannot perform direct memory reclaim may only result in an
>>> endless busy loop.
>>>
>>> Therefore, in such cases, the current mm-core may directly return
>>> a NULL pointer:
>>>
>>> static inline struct page *
>>> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>>>                                                   struct alloc_context *ac)
>>> {
>>>           ...
>>>           if (gfp_mask & __GFP_NOFAIL) {
>>>                   /*
>>>                    * All existing users of the __GFP_NOFAIL are blockable, so warn
>>>                    * of any new users that actually require GFP_NOWAIT
>>>                    */
>>>                   if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>>>                           goto fail;
>>>                   ...
>>>           }
>>>           ...
>>> fail:
>>>           warn_alloc(gfp_mask, ac->nodemask,
>>>                           "page allocation failure: order:%u", order);
>>> got_pg:
>>>           return page;
>>> }
>>>
>>> Unfortuantely, vpda does that nofail allocation under non-sleepable
>>> lock. A possible way to fix that is to move the pages allocation out
>>> of the lock into the caller, but having to allocate a huge number of
>>> pages and auxiliary page array seems to be problematic as well per
>>> Tetsuon: " You should implement proper error handling instead of
>>> using __GFP_NOFAIL if count can become large."
>>>
>>> So I choose another way, which does not release kernel bounce pages
>>> when user tries to register userspace bounce pages. Then we can
>>> avoid allocating in paths where failure is not expected.(e.g in
>>> the release). We pay this for more memory usage as we don't release
>>> kernel bounce pages but further optimizations could be done on top.
>>>
>>> Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buffer")
>>> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
>>> Tested-by: Xie Yongji <xieyongji@bytedance.com>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> [v-songbaohua@oppo.com: Refine the changelog]
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>    drivers/vdpa/vdpa_user/iova_domain.c | 19 +++++++++++--------
>>>    drivers/vdpa/vdpa_user/iova_domain.h |  1 +
>>>    2 files changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
>>> index 791d38d6284c..58116f89d8da 100644
>>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
>>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
>>> @@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
>>>                                enum dma_data_direction dir)
>>>    {
>>>        struct vduse_bounce_map *map;
>>> +     struct page *page;
>>>        unsigned int offset;
>>>        void *addr;
>>>        size_t sz;
>>> @@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
>>>                            map->orig_phys == INVALID_PHYS_ADDR))
>>>                        return;
>>>
>>> -             addr = kmap_local_page(map->bounce_page);
>>> +             page = domain->user_bounce_pages ?
>>> +                    map->user_bounce_page : map->bounce_page;
>>> +
>>> +             addr = kmap_local_page(page);
>>>                do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
>>>                kunmap_local(addr);
>>>                size -= sz;
>>> @@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
>>>                                memcpy_to_page(pages[i], 0,
>>>                                               page_address(map->bounce_page),
>>>                                               PAGE_SIZE);
>>> -                     __free_page(map->bounce_page);
>>>                }
>>> -             map->bounce_page = pages[i];
>>> +             map->user_bounce_page = pages[i];
>>>                get_page(pages[i]);
>>>        }
>>>        domain->user_bounce_pages = true;
>>> @@ -297,17 +300,17 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
>>>                struct page *page = NULL;
>>>
>>>                map = &domain->bounce_maps[i];
>>> -             if (WARN_ON(!map->bounce_page))
>>> +             if (WARN_ON(!map->user_bounce_page))
>>>                        continue;
>>>
>>>                /* Copy user page to kernel page if it's in use */
>>>                if (map->orig_phys != INVALID_PHYS_ADDR) {
>>> -                     page = alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
>>> +                     page = map->bounce_page;
>>
>> Why don't we need a kmap_local_page(map->bounce_page) here, but we might
>> perform one / have performed one in vduse_domain_bounce?
> 
> I think it's another bug that needs to be fixed.
> 
> Yongji, do you want to fix this?

Or maybe it works because "map->bounce_page" is now always a kernel 
page, and never one from user space that might reside in highmem.

-- 
Cheers,

David / dhildenb

