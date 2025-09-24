Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7FADF71
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 04:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758686746; cv=none; b=VjP1SqUr18wAcJDf5sfQMdZeP9lZpoUMVJ4BWFNeA+lB22q88bBOfkkohLKzEnmBZYTh8CHdlwdIc9H7DUOC0rfUG2YbS2VUGUF0e8ZGid8pT41gw21AOyShVqYrntndphJuA3tFhCKmvbqYe+rkJWzbmx2Pbymq+5VhR+OPoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758686746; c=relaxed/simple;
	bh=NQPZF9e2c9CtsjhkZliyNOSlNI5BNbDFaXzN53vkEB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYrUhKZHzA1v2tooRJDYqAQ6n4sdr5S0euqilDHyKKfDpUmQDBsE8jdVId7GWRNnVDzj6AXv6wjMvr1sQrzAxH3qH5gDRLdDgg9kgQjtpaf1T8HOCtHPD5V792VG/m7dqInSUZ5AnTRI9X6zLwU9x7Log+SXID9LvBR1u9NNQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XtpcZ/Rv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XtpcZ/Rv"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33292adb180so2262363a91.3
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 21:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758686742; x=1759291542; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hj/VG0+ZBnyrZwY9mojsT9ngdgtjWP1naUzw+Q1A/nE=;
        b=XtpcZ/Rvbgi/K+N4JK/kriC4tgUnPGFhKQYpg0AuOh7ZfjbpDk0uQHeX3sPcIQ/O2h
         GeOGFBers8b8vjUdONPzb/8a9j7Kkna3ij/OxyNAO07ENh6aW54jMUdkUcK4IEfFmTq3
         5/VTgpBlWf2DGcun/jkEYkr0bYZwIXI+twK+KBZKQXKMCt57+55FwXIc3T+nXhT+SGyk
         m4FSD2+L/LJaKXv9GelIcelATxOcHPhohHxjSOdE145wHkmZm59q4jrbSwbNTgBe7eGw
         rxSPlNnvvaOHKHzyFiFWjxliofrHfDSmnxjulSvWVLhWvMq4jizFogJYL7vVK9D3klLc
         e21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758686742; x=1759291542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj/VG0+ZBnyrZwY9mojsT9ngdgtjWP1naUzw+Q1A/nE=;
        b=r/TMjg+65pFuTk3Mrh9Mo5k+8uZZb8vACpplJX2bK4dHnapfRXK3nDku+8V3L7giaB
         UHr0FzJaeVVAvKcC88DO0G57OERw3P3+elTx1+VAn9e1P4h6jo4+AVe9GLtm2MY8z04L
         Hc5Nt468R35Nojpa2jVh84ghWC7Jn4l1SacGOF8ToVtcV81ERrkgwSD/TpUzs7ZFW01V
         cO0lVHocRLniMYBtZmr/Gaj1LFzxTWz8gisFOv4OKDWSWXiRTdtSDSCC6QB2CRk3p4g0
         5ssG8Gf4VZ/9jBXu3gnaBdB3VUrxE1ANRoIiJmWFMmjDx0sU3wVqagD1rzazAzUH6B8V
         q+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcMUA43HhHCOueRUwrsdNq9df+/CdhSwJZBrswdkZaZQSKhk6pclxfoqyZgq7J11oQMtQbZf8HjDnXkBtEyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4xXOkUjyOBumCw0ve7yQUuuD/Cu7y8pVLypalmJwo5Yy5Ns3x
	NgBD6CwzfC+rXlc2ubxLnMJp1S3S3leY4soPpZxOBgEpj06jH+yZvoF9JO+usGLmVvQ=
X-Gm-Gg: ASbGncuDCIpEPSeNOtLG6vvYvc4/OmHfwos47W3tfo0R6zpvtrTgz34koyyfw4toptm
	u145J4EMJOd/hZl9TVJHntUweURyRnX1xQJVVLbkYuMpUmGoComyOXGhK1Bv86vgfos1KBqRhuI
	fMHohdxT1JsVLyaVxpTtXhUXjD7mZ71vOBQOtyesE/DUqHFI6Q+xNAkTd7fQA7LPRpGNNVKnEVM
	IX6+u88i6184Bt8h+roGq41VbHNBZQoZSERM7aJ/IOKE6xTcmWkDeM/+XEYfPO7MbyWIXLZY4DG
	jpAb/KvFavEfV+r9i5qg6u/YXfu2u8x1iUxZAT11fJ32QlltRZJXmOWtTpKsnZoaQsD/7SXSSiU
	VEy0MA1qgMqoORCe39e1kDwjDu6S3ydeUJIZzlUUMq7hHfe7F7TYJBRGlqVhxqE0w/4EflmE=
X-Google-Smtp-Source: AGHT+IGb5iPXT+ZtAJ3FiTP92YXhJI/RPFbN4furn0bB8MFVyoMrlhzBZRruGqdq83PrpiswhpPc8g==
X-Received: by 2002:a17:90b:58c5:b0:32b:dfdb:b276 with SMTP id 98e67ed59e1d1-332a98fc381mr5336158a91.34.1758686742150;
        Tue, 23 Sep 2025 21:05:42 -0700 (PDT)
Received: from [10.88.213.9] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd8b206sm756958a91.2.2025.09.23.21.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 21:05:41 -0700 (PDT)
Message-ID: <aed938d0-e70a-4af6-9950-d4d0b7d6a93f@bytedance.com>
Date: Wed, 24 Sep 2025 12:05:36 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page
 size
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 xieyongji@bytedance.com
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEuvT3=a+6LyaFZFmCZzGS5tntPSbSJg=h6FAHdk89pC8g@mail.gmail.com>
 <2739dcc3-7c38-492c-854a-731298396a0c@bytedance.com>
 <CACGkMEv3pUBF3Uv2s3MM0Qn--fP3mwN92SqE9NX4gNuMALBTUg@mail.gmail.com>
Content-Language: en-US
From: Sheng Zhao <sheng.zhao@bytedance.com>
In-Reply-To: <CACGkMEv3pUBF3Uv2s3MM0Qn--fP3mwN92SqE9NX4gNuMALBTUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/24 08:57, Jason Wang wrote:
> On Tue, Sep 23, 2025 at 8:37 PM Sheng Zhao <sheng.zhao@bytedance.com> wrote:
>>
>>
>>
>> On 2025/9/17 16:16, Jason Wang wrote:
>>> On Mon, Sep 15, 2025 at 3:34 PM <sheng.zhao@bytedance.com> wrote:
>>>>
>>>> From: Sheng Zhao <sheng.zhao@bytedance.com>
>>>>
>>>> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
>>>> even small IO requests to occupy an entire bounce page exclusively. The
>>>> kind of memory waste will be more significant on arm64 with 64KB pages.
>>>
>>> Let's tweak the title as there are archs that are using non 4KB pages
>>> other than arm.
>>>
>>
>> Got it. I will modify this in v2.
>>
>>>>
>>>> So, optimize it by using fixed 4KB bounce pages.
>>>>
>>>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
>>>> ---
>>>>    drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++----------
>>>>    drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
>>>>    2 files changed, 83 insertions(+), 42 deletions(-)
>>>>
>>>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
>>>> index 58116f89d8da..768313c80b62 100644
>>>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
>>>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
>>>> @@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_domain *domain,
>>>>    static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
>>>>                                            u64 iova, u64 size, u64 paddr)
>>>>    {
>>>> -       struct vduse_bounce_map *map;
>>>> +       struct vduse_bounce_map *map, *head_map;
>>>> +       struct page *tmp_page;
>>>>           u64 last = iova + size - 1;
>>>>
>>>>           while (iova <= last) {
>>>> -               map = &domain->bounce_maps[iova >> PAGE_SHIFT];
>>>> +               map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
>>>
>>> BOUNCE_PAGE_SIZE is kind of confusing as it's not the size of any page
>>> at all when PAGE_SIZE is not 4K.
>>>
>>
>> How about BOUNCE_MAP_SIZE?
> 
> Fine with me.
> 
>>
>>>>                   if (!map->bounce_page) {
>>>> -                       map->bounce_page = alloc_page(GFP_ATOMIC);
>>>> -                       if (!map->bounce_page)
>>>> -                               return -ENOMEM;
>>>> +                       head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_PAGE_SHIFT];
>>>> +                       if (!head_map->bounce_page) {
>>>> +                               tmp_page = alloc_page(GFP_ATOMIC);
>>>> +                               if (!tmp_page)
>>>> +                                       return -ENOMEM;
>>>> +                               if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
>>>> +                                       __free_page(tmp_page);
>>>
>>> I don't understand why we need cmpxchg() logic.
>>>
>>> Btw, it looks like you want to make multiple bounce_map to point to
>>> the same 64KB page? I wonder what's the advantages of doing this. Can
>>> we simply keep the 64KB page in bounce_map?
>>>
>>> Thanks
>>>
>>
>> That's correct. We use fixed 4KB-sized bounce pages, and there will be a
>> many-to-one relationship between these 4KB bounce pages and the 64KB
>> memory pages.
>>
>> Bounce pages are allocated on demand. As a result, it may occur that
>> multiple bounce pages corresponding to the same 64KB memory page attempt
>> to allocate memory simultaneously, so we use cmpxchg to handle this
>> concurrency.
>>
>> In the current implementation, the bounce_map structure requires no
>> modification. However, if we keep the 64KB page into a single bounce_map
>> while still wanting to implement a similar logic, we may need an
>> additional array to store multiple orig_phys values in order to
>> accommodate the many-to-one relationship.
> 
> Or simply having a bitmap is sufficient per bounce_map?
> 

Yes, using a bitmap can mark the usage status of each 4KB, but it may 
not simplify things overall.

- we will inevitably need to add an additional array per bounce_map to 
store the orig_phys corresponding to each 4KB for subsequent copying 
(vduse_domain_bounce).

- compared to the current commit, this modification may only be a 
structural change and fail to reduce the amount of changes to the code 
logic. For instance, cmpxchg is still required.


Thanks

> Thanks
> 
>>
>> Thanks
>>
> 

