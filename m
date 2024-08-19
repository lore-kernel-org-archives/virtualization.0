Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D3166F3C
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070795; cv=none; b=Q/2WnCcvZT75pJ4Cn35NNXkp/4u7+FiyqQJHj42UxS8Y7Zwt56l3plvMY93zhQTsUkbLcBqrqReYCFDPOR24KuD9Eb48Vbos0McVW1yTdcvspT61A+1Zuk/lWYbAnRwpU06rHrLqC8Ch2jwXwmoNBgPhP2Ec9hc0hfRrNOWJ/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070795; c=relaxed/simple;
	bh=HbjhQl8tMEIT8SotuM5PqdhH0n/+0k24s1HkpnjssT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNg4d01m1KfcnMoxFyijUYwhJImjcU88Ram9mKb9MnTKT50rJR5HV9y3YbTYl1Yo2+i3aSy6ek1SKsFS9Ta98FeyJD7fYyvt/I1T3gHcf0I5hxCTkJHEwqh10K5gn68A28YoDbcN1VqFKrtv16yI+jPdAgVFAOxqniQV98PwTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFdZw4rR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFdZw4rR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724070792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tHWIfoUw+zeE8nk+068tiRWnjl3gahaUPTL+qYuZqOA=;
	b=OFdZw4rR9BjSfRT/9Jvi8EzngIIFbalxa8nv+5vLYItMjmwBar99ikqhq7GEYWIsmIgyDA
	O+/KRd7ziatyRvnvfrrhPhpi1V2MFViATBZjGjYgjqwiK0G6l+BrA42ZgkMYf1OpU2v7b+
	HwAOz7T60I94s2fUDXb0egzU30dNvSo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-a2nraoGrNZ6aUFpMJeHZew-1; Mon, 19 Aug 2024 08:33:11 -0400
X-MC-Unique: a2nraoGrNZ6aUFpMJeHZew-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a80ebde3f94so324780866b.2
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 05:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724070790; x=1724675590;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tHWIfoUw+zeE8nk+068tiRWnjl3gahaUPTL+qYuZqOA=;
        b=c9IbykAMR3Jdxfbb1s1DBag44HaBAKGVvZUXrI+uaWdQGzxPhZqCWPC9wki7/M26cP
         1b9VKMXJEa784mdu/vIOvYRqYv3fKwvw1ShKk+HmrCjovIyaUa/tNYWPqC8xGUK79igT
         u1xe1MzYpbrHLtUfAYNRY8zzZegPxC9pv/uisvREoLAoUScPp9ZA40R/+KFX1hcsVIu2
         nlHbDIHxPetPwZsIN4AGd2SfF9NF6AgOoz6XWNkKeGUgCAfnx4Te1vT4K8aIybxcoIB3
         dzFGSbdBqs3//iMp90MXORiwYehNdWLOK+ldMwW+kY+/hIz0hbcOXOW1v35IbfjG6m30
         DODA==
X-Forwarded-Encrypted: i=1; AJvYcCW72r4+oYYvfOCjpRpyhr/esN0FB/xS2hlcvUCYJsK7bIxrJngLHwr3JQciiLoISnA7LHcvdhZNcQmXvHqEt+71ShjO96tPY5UznyCRUjI=
X-Gm-Message-State: AOJu0YxPTxzAiKuPd54GpvkxP7abfyJNyaktBRo6tYkhsM7EO+89VljN
	LeEJ7S03CA2sbP+5TTGcrL1/2hVr/lGHNF4iLY5z+czMMfSfhvn6SnYkRoOBHXYx2r8/c0WY0Nu
	7kXO07JFiRQz6LPZTXlRrVbjJZmksj9d3c/c6if+jot4Cg83qOEHCqrElPQ6w6JMM
X-Received: by 2002:a17:907:c893:b0:a77:c043:5b5a with SMTP id a640c23a62f3a-a8392951b74mr776478366b.39.1724070789740;
        Mon, 19 Aug 2024 05:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9B9eq2/3GqL/eEvMhJUPfNRzuyp46FHHPpRdcjg9ZTQAlTAWiRAi/BV3iopW3QIQsUoSSdw==
X-Received: by 2002:a17:907:c893:b0:a77:c043:5b5a with SMTP id a640c23a62f3a-a8392951b74mr776475266b.39.1724070789188;
        Mon, 19 Aug 2024 05:33:09 -0700 (PDT)
Received: from [100.81.188.195] (ipb218f908.dynamic.kabel-deutschland.de. [178.24.249.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396dfddsm628937666b.214.2024.08.19.05.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 05:33:08 -0700 (PDT)
Message-ID: <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com>
Date: Mon, 19 Aug 2024 14:33:06 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
 cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
 iamjoonsoo.kim@lge.com, mhocko@suse.com, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev,
 torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, virtualization@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <20240817062449.21164-4-21cnbao@gmail.com>
 <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com>
 <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com>
 <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com>
 <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.08.24 12:02, Barry Song wrote:
> On Mon, Aug 19, 2024 at 9:55 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 19.08.24 11:47, Barry Song wrote:
>>> On Mon, Aug 19, 2024 at 9:43 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 17.08.24 08:24, Barry Song wrote:
>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>
>>>>> We have cases we still fail though callers might have __GFP_NOFAIL.  Since
>>>>> they don't check the return, we are exposed to the security risks for NULL
>>>>> deference.
>>>>>
>>>>> Though BUG_ON() is not encouraged by Linus, this is an unrecoverable
>>>>> situation.
>>>>>
>>>>> Christoph Hellwig:
>>>>> The whole freaking point of __GFP_NOFAIL is that callers don't handle
>>>>> allocation failures.  So in fact a straight BUG is the right thing
>>>>> here.
>>>>>
>>>>> Vlastimil Babka:
>>>>> It's just not a recoverable situation (WARN_ON is for recoverable
>>>>> situations). The caller cannot handle allocation failure and at the same
>>>>> time asked for an impossible allocation. BUG_ON() is a guaranteed oops
>>>>> with stracktrace etc. We don't need to hope for the later NULL pointer
>>>>> dereference (which might if really unlucky happen from a different
>>>>> context where it's no longer obvious what lead to the allocation failing).
>>>>>
>>>>> Michal Hocko:
>>>>> Linus tends to be against adding new BUG() calls unless the failure is
>>>>> absolutely unrecoverable (e.g. corrupted data structures etc.). I am
>>>>> not sure how he would look at simply incorrect memory allocator usage to
>>>>> blow up the kernel. Now the argument could be made that those failures
>>>>> could cause subtle memory corruptions or even be exploitable which might
>>>>> be a sufficient reason to stop them early.
>>>>>
>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>>> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>> Cc: Christoph Lameter <cl@linux.com>
>>>>> Cc: Pekka Enberg <penberg@kernel.org>
>>>>> Cc: David Rientjes <rientjes@google.com>
>>>>> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>>>>> Cc: Roman Gushchin <roman.gushchin@linux.dev>
>>>>> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>>>> Cc: Kees Cook <kees@kernel.org>
>>>>> Cc: "Eugenio Pérez" <eperezma@redhat.com>
>>>>> Cc: Hailong.Liu <hailong.liu@oppo.com>
>>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>>> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>>> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>> ---
>>>>>     include/linux/slab.h | 4 +++-
>>>>>     mm/page_alloc.c      | 4 +++-
>>>>>     mm/util.c            | 1 +
>>>>>     3 files changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>>>>> index c9cb42203183..4a4d1fdc2afe 100644
>>>>> --- a/include/linux/slab.h
>>>>> +++ b/include/linux/slab.h
>>>>> @@ -827,8 +827,10 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
>>>>>     {
>>>>>         size_t bytes;
>>>>>
>>>>> -     if (unlikely(check_mul_overflow(n, size, &bytes)))
>>>>> +     if (unlikely(check_mul_overflow(n, size, &bytes))) {
>>>>> +             BUG_ON(flags & __GFP_NOFAIL);
>>>>>                 return NULL;
>>>>> +     }
>>>>>
>>>>>         return kvmalloc_node_noprof(bytes, flags, node);
>>>>>     }
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index 60742d057b05..d2c37f8f8d09 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -4668,8 +4668,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
>>>>>          * There are several places where we assume that the order value is sane
>>>>>          * so bail out early if the request is out of bound.
>>>>>          */
>>>>> -     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
>>>>> +     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)) {
>>>>> +             BUG_ON(gfp & __GFP_NOFAIL);
>>>>>                 return NULL;
>>>>> +     }
>>>>>
>>>>>         gfp &= gfp_allowed_mask;
>>>>>         /*
>>>>> diff --git a/mm/util.c b/mm/util.c
>>>>> index ac01925a4179..678c647b778f 100644
>>>>> --- a/mm/util.c
>>>>> +++ b/mm/util.c
>>>>> @@ -667,6 +667,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
>>>>>
>>>>>         /* Don't even allow crazy sizes */
>>>>>         if (unlikely(size > INT_MAX)) {
>>>>> +             BUG_ON(flags & __GFP_NOFAIL);
>>>>
>>>> No new BUG_ON please. WARN_ON_ONCE() + recovery code might be suitable here.
>>>
>>> Hi David,
>>> WARN_ON_ONCE()  might be fine but I don't see how it is possible to recover.
>>
>> Just return NULL? "shit in shit out" :) ?
> 
> Returning NULL is perfectly right if gfp doesn't include __GFP_NOFAIL,
> as it's the caller's responsibility to check the return value. However, with
> __GFP_NOFAIL, users will directly dereference *(p + offset) even when
> p == NULL. It is how __GFP_NOFAIL is supposed to work.

If the caller is not supposed to pass that flag combination (shit in), 
we are not obligated to give a reasonable result (shit out).

My point is that we should let the caller (possibly?) crash -- the one 
that did something that is wrong -- instead of forcing a crash using 
BUG_ON in this code here.

It should all be caught during testing either way. And if some OOT 
module does something nasty, that's not our responsibility.

BUG_ON is not a way to write assertions into the code.

-- 
Cheers,

David / dhildenb

